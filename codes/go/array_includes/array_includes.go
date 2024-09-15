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

func ternary(trueCondition bool, callbackFunctionIfConditionTrue func() any, callbackFunctionIfConditionFalse func() any) any {
    if (trueCondition == true) {
        return callbackFunctionIfConditionTrue()
    }
    return callbackFunctionIfConditionFalse()
}

func jsonStringify(restArguments ...any) string {
	jsonStringifyInner := func(anythingInner any, prettyInner bool, indentInner string) string {
		if (prettyInner == true) {
			jsonStringifyInnerResult, err := json.MarshalIndent(anythingInner, "", indentInner)
			if (err == nil) {
				return string(jsonStringifyInnerResult)
			}
			return "null"
		}
        jsonStringifyInnerResult, err := json.Marshal(anythingInner)
		if (err == nil) {
			return strings.ReplaceAll(string(jsonStringifyInnerResult), ",", ", ")
		}
		return "null"
    }
    var anything any = restArguments[0]
	prettyDefault := false
	indentDefault := "    "
	var pretty any = prettyDefault
	var indent any = indentDefault
	if (len(restArguments) == 1) {
		return jsonStringifyInner(anything, prettyDefault, indentDefault)
	}
	var optionalArgument any = restArguments[1]
	if (optionalArgument == false) {
		return jsonStringifyInner(anything, prettyDefault, indentDefault)
	}
	if (reflect.TypeOf(optionalArgument).Kind() == reflect.Map) {
		pretty = optionalChaining(optionalArgument, "pretty")
		indent = optionalChaining(optionalArgument, "indent")
		pretty = ternary((pretty == nil), func() any { return prettyDefault }, func() any { return pretty })
		indent = ternary((indent == nil), func() any { return indentDefault }, func() any { return indent })
		return jsonStringifyInner(anything, pretty.(bool), indent.(string))
	}
	if (optionalArgument == true) {
		if (len(restArguments) >= 3) {
			var additionalArgument2 any = restArguments[2]
			if (reflect.TypeOf(additionalArgument2).Kind() == reflect.String) {
				indent = additionalArgument2
			}
		}
		pretty = optionalArgument
		return jsonStringifyInner(anything, pretty.(bool), indent.(string))
	}
	return jsonStringifyInner(anything, prettyDefault, indentDefault)
}

func sprint(restArguments ...any) {
    var newArray = []string{}
    for _, argument := range restArguments {
        argumentType := reflect.TypeOf(argument).Kind()
        if (argumentType == reflect.Slice && (len(argument.(array)) == 1)) {
            newArray = append(newArray, jsonStringify(argument.(array)[0]))
            continue
        }
        if (argumentType == reflect.String) {
			newArray = append(newArray, argument.(string))
            continue
        }
    }
    fmt.Println(strings.Join(newArray, ""))
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
    fmt.Println("my friends:", jsonStringify(myFriends))

    var aName any
    var isMyFriend any

    fmt.Println("// using JavaScript-like Array.includes() function \"arrayIncludesV1\"")

    aName = "Alisa"
    isMyFriend = arrayIncludesV1(aName, myFriends)
    sprint("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Alisa": true

    aName = "Trivia"
    isMyFriend = arrayIncludesV1(aName, myFriends)
    sprint("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Trivia": true

    aName = "Tony"
    isMyFriend = arrayIncludesV1(aName, myFriends)
    sprint("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Tony": false

    aName = "Ezekiel"
    isMyFriend = arrayIncludesV1(aName, myFriends)
    sprint("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Ezekiel": false

    fmt.Println("// using JavaScript-like Array.includes() function \"arrayIncludesV2\"")

    aName = "Alisa"
    isMyFriend = arrayIncludesV2(aName, myFriends)
    sprint("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Alisa": true

    aName = "Trivia"
    isMyFriend = arrayIncludesV2(aName, myFriends)
    sprint("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Trivia": true

    aName = "Tony"
    isMyFriend = arrayIncludesV2(aName, myFriends)
    sprint("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Tony": false

    aName = "Ezekiel"
    isMyFriend = arrayIncludesV2(aName, myFriends)
    sprint("is my friends includes ", array{aName}, ": ", array{isMyFriend})
    // is my friends includes "Ezekiel": false
}
