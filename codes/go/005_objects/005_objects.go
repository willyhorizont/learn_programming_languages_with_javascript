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

func main() {
    // in Go, JavaScript-like Object is called map

    friend := object{
        "name": "Alisa",
        "country": "Finland",
        "age": 25,
    }
    sprint("friend: ", jsonStringify(friend, object{"pretty": true}))

	sprint("friend, get total object keys: ", array{len(friend)})
	// friend, get total object keys: 3

    sprint("friend, get country: ", friend["country"])
    // friend, get country: Finland

	// iterate over and get each key-value pair
    for objectKey, objectValue := range friend {
        sprint("friend, for loop, key: ", objectKey, ", value: ", objectValue)
    }
    // fruits, for loop, key: name, value: Alisa
    // fruits, for loop, key: country, value: Finland
    // fruits, for loop, key: age, value: 25

    // iterate over and get each key-value pair and object iteration/entry index
    objectIterationIndex := 0
    for objectKey, objectValue := range friend {
        sprint("friend, for loop, object iteration/entry index: ", array{objectIterationIndex}, ", key: ", objectKey, ", value: ", objectValue)
        objectIterationIndex += 1
    }
    // friend, for loop, object iteration/entry index: 0 ,key: name, value: Alisa
    // friend, for loop, object iteration/entry index: 1 ,key: country, value: Finland
    // friend, for loop, object iteration/entry index: 2 ,key: age, value: 25

	friend["age"] = 27
	sprint("friend: ", jsonStringify(friend, object{"pretty": true}))

	friend["gender"] = "Female"
	sprint("friend: ", jsonStringify(friend, object{"pretty": true}))

	delete(friend, "country")
	sprint("friend: ", jsonStringify(friend, object{"pretty": true}))

	// Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
	deliveryResponseKeyMessage := "message"
	deliveryResponse := object{
        deliveryResponseKeyMessage: "ok",
    }
    sprint("deliveryResponse: ", jsonStringify(deliveryResponse, object{"pretty": true}))
	deliveryResponseKeyStatus := "status"
	deliveryResponse[deliveryResponseKeyStatus] = 200
    sprint("deliveryResponse: ", jsonStringify(deliveryResponse, object{"pretty": true}))
}
