package main

import (
	"encoding/json"
	"fmt"
	"reflect"
	"strings"
)

// type any interface{}
type array []any
type object map[string]any

func arrayReduce(callbackFunction func(any, any, int, array) any, anArray array, initialValue any) any {
    // JavaScript-like Array.reduce() function
    result := initialValue
    for arrayItemIndex, arrayItem := range anArray {
        result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
    }
    return result
}

func optionalChaining(anything any, objectPropertiesArray ...any) any {
    anythingType := reflect.TypeOf(anything).Kind()
    if (((anythingType != reflect.Map) && (anythingType != reflect.Slice)) || (len(objectPropertiesArray) == 0)) {
        return anything
    }
    return arrayReduce(func(currentResult any, currentItem any, _ int, _ array) any {
        if (currentResult == nil && (anythingType == reflect.Map) && (reflect.TypeOf(currentItem).Kind() == reflect.String)) {
            return anything.(object)[currentItem.(string)]
        }
        if (currentResult == nil && (anythingType == reflect.Slice) && (reflect.TypeOf(currentItem).Kind() == reflect.Int) && (currentItem.(int) >= 0) && (len(anything.(array)) > currentItem.(int))) {
            return anything.(array)[currentItem.(int)]
        }
        if (reflect.TypeOf(currentResult).Kind() == reflect.Map && (reflect.TypeOf(currentItem).Kind() == reflect.String)) {
            return currentResult.(object)[currentItem.(string)]
        }
        if ((reflect.TypeOf(currentResult).Kind() == reflect.Slice) && (reflect.TypeOf(currentItem).Kind() == reflect.Int) && (currentItem.(int) >= 0) && (len(currentResult.(array)) > currentItem.(int))) {
            return currentResult.(array)[currentItem.(int)]
        }
        return nil
    }, objectPropertiesArray, nil)
}

func jsonStringify(anything any, additionalParameter any) string {
	jsonStringifyDefault := func(anythingInner any) string {
        jsonMarshalled, err := json.Marshal(anythingInner)
		if (err == nil) {
			return strings.ReplaceAll(string(jsonMarshalled), ",", ", ")
		}
		return "null"
    }
	jsonStringifyPrettyDefault := func(anythingInner any, indentInner string) string {
        jsonMarshalled, err := json.MarshalIndent(anythingInner, "", indentInner)
		if (err == nil) {
			return string(jsonMarshalled)
		}
		return "null"
    }
	if (additionalParameter == nil || additionalParameter == false) {
		return jsonStringifyDefault(anything)
	}
	if (additionalParameter == true) {
		return jsonStringifyPrettyDefault(anything, "    ")
	}
	if (reflect.TypeOf(additionalParameter).Kind() == reflect.Map) {
		var pretty any = optionalChaining(additionalParameter, "pretty")
		var indent any = optionalChaining(additionalParameter, "indent")
		if (pretty == true) {
			if (indent == nil) {
				indent = "    "
			}
			return jsonStringifyPrettyDefault(anything, indent.(string))
		}
		return jsonStringifyDefault(anything)
	}
	return jsonStringifyDefault(anything)
}

func sPrintln(parameters ...any) {
    var parametersNew = []string{}
    for _, parameter := range parameters {
        parameterType := reflect.TypeOf(parameter).Kind()
        if (parameterType == reflect.Slice && (len(parameter.(array)) == 1)) {
            parametersNew = append(parametersNew, jsonStringify(parameter.(array)[0], false))
            continue
        }
        if (parameterType == reflect.String) {
			parametersNew = append(parametersNew, parameter.(string))
            continue
        }
    }
    fmt.Println(strings.Join(parametersNew, ""))
}

func arrayIncludesV1(searchElement any, anArray array) bool {
    // JavaScript-like Array.includes() function
    isElementFound := false
    for _, arrayItem := range anArray {
        if (arrayItem == searchElement) {
            isElementFound = true
            break
        }
    }
    return isElementFound
}

func arrayIncludesV2(searchElement any, anArray array) bool {
    // JavaScript-like Array.includes() function
    for _, arrayItem := range anArray {
        if (arrayItem == searchElement) {
            return true
        }
    }
    return false
}

func main() {
    fmt.Println("\n// JavaScript-like Array.includes() in Go")

    myFriends := array{"Alisa", "Trivia"}
    fmt.Println("my friends:", jsonStringify(myFriends, false))

    var aName any
    var isMyFriend any

    fmt.Println("// using JavaScript-like Array.includes() function \"arrayIncludesV1\"")

    aName = "Alisa"
    isMyFriend = arrayIncludesV1(aName, myFriends)
    sPrintln("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Alisa": true

    aName = "Trivia"
    isMyFriend = arrayIncludesV1(aName, myFriends)
    sPrintln("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Trivia": true

    aName = "Tony"
    isMyFriend = arrayIncludesV1(aName, myFriends)
    sPrintln("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Tony": false

    aName = "Ezekiel"
    isMyFriend = arrayIncludesV1(aName, myFriends)
    sPrintln("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Ezekiel": false

    fmt.Println("// using JavaScript-like Array.includes() function \"arrayIncludesV2\"")

    aName = "Alisa"
    isMyFriend = arrayIncludesV2(aName, myFriends)
    sPrintln("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Alisa": true

    aName = "Trivia"
    isMyFriend = arrayIncludesV2(aName, myFriends)
    sPrintln("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Trivia": true

    aName = "Tony"
    isMyFriend = arrayIncludesV2(aName, myFriends)
    sPrintln("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Tony": false

    aName = "Ezekiel"
    isMyFriend = arrayIncludesV2(aName, myFriends)
    sPrintln("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Ezekiel": false
}
