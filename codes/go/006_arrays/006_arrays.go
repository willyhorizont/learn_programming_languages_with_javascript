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

func main() {
    // in Go, JavaScript-like Array is called (Slice)

    fruits := array{"apple", "mango", "orange"}
    sPrintln("fruits: ", jsonStringify(fruits, false))

    sPrintln("fruits, length: ", array{len(fruits)})
    // fruits, length: 3

    sPrintln("fruits, get mango: ", fruits[1])
    // fruits, get mango: mango

    sPrintln("fruits, first element: ", fruits[0])
    // fruits, first element: apple

    sPrintln("fruits, last element: ", fruits[len(fruits)-1])
    // fruits, last element: orange

    for arrayItemIndex, arrayItem := range fruits {
        sPrintln("fruits, for loop, index: ", array{arrayItemIndex}, ", value: ", arrayItem)
    }
    // fruits, for loop, index: 0, value: apple
    // fruits, for loop, index: 1, value: mango
    // fruits, for loop, index: 2, value: orange

    // in Go, JavaScript-like Array of Objects is called Slice of maps

    products := array{
        object{
            "id": "P1",
            "name": "bubble gum",
        },
        object{
            "id": "P2",
            "name": "potato chips",
        },
    }
    sPrintln("products: ", jsonStringify(products, object{"pretty": true}))

    for arrayItemIndex, arrayItem := range products {
        objectIterationIndex := 0
        for objectKey, objectValue := range arrayItem.(object) {
            sPrintln("products, for loop, array item index: ", array{arrayItemIndex}, ", object iteration/entry index: ", array{objectIterationIndex}, ", key: ", objectKey, ", value: ", objectValue)
            objectIterationIndex += 1
        }
    }
    // products, for loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
    // products, for loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
    // products, for loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
    // products, for loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
}
