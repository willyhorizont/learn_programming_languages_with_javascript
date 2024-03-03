package main

import (
	"encoding/json"
	"fmt"
	"reflect"
)

const EMPTY_STRING = ""
const TAB = "    "

// type any interface{}
type array []any
type object map[string]any

func prettyJsonStringify(anything any) string {
	marshalledJson, err := json.MarshalIndent(anything, EMPTY_STRING, TAB)
	if (err == nil) {
		return string(marshalledJson)
	}
	return "undefined"
}

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
		var currentItemTypeString any = nil
		switch currentItemType := reflect.TypeOf(currentItem).Kind(); currentItemType {
		case reflect.String:
			currentItemTypeString = "String"
		case reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64, reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64, reflect.Float32, reflect.Float64, reflect.Complex64, reflect.Complex128:
			currentItemTypeString = "Number"
		default:
			currentItemTypeString = nil
		}
		if (currentItemTypeString == nil) {
			return nil
		}
		if (currentResult == nil && (anythingType == reflect.Map) && (currentItemTypeString == "String")) {
			return anything.(object)[currentItem.(string)]
		}
		if (currentResult == nil && (anythingType == reflect.Slice) && (currentItemTypeString == "Number")) {
			return anything.(array)[currentItem.(int)]
		}
		currentResultType := reflect.TypeOf(currentResult).Kind()
		if (currentResultType == reflect.Map && (currentItemTypeString == "String")) {
			return currentResult.(object)[currentItem.(string)]
		}
		if ((currentResultType == reflect.Slice) && (currentItemTypeString == "Number") && (currentItem.(int) >= 0) && (currentItem.(int) < len(currentResult.(array)))) {
			return currentResult.(array)[currentItem.(int)]
		}
		return nil
	}, objectPropertiesArray, nil)
}

func nullishCoalescing(anything any, defaultValue any) any {
	if (anything == nil) {
		return defaultValue
	} else {
		return anything
	}
}

func main() {
	fmt.Println("\n// JavaScript-like Nullish Coalescing Operator (??) in Go")

	// There's no JavaScript-like Nullish Coalescing Operator (??) in Go.
	// But, we can create our own function to mimic it in Go.

	JSON_OBJECT := object{
		"foo": object{
			"bar": "baz",
		},
		"fruits": array{"apple", "mango", "banana"},
	}
	fmt.Println("JSON_OBJECT:", prettyJsonStringify(JSON_OBJECT))

	fmt.Println("JSON_OBJECT?.foo?.bar ?? \"not found\":", prettyJsonStringify(nullishCoalescing(optionalChaining(JSON_OBJECT, "foo", "bar"), "not found")))
	// JSON_OBJECT?.foo?.bar ?? \"not found\": "baz"

	fmt.Println("JSON_OBJECT?.foo?.baz ?? \"not found\":", prettyJsonStringify(nullishCoalescing(optionalChaining(JSON_OBJECT, "foo", "baz"), "not found")))
	// JSON_OBJECT?.foo?.baz ?? \"not found\": "not found"

	fmt.Println("JSON_OBJECT?.fruits?.[2] ?? \"not found\":", prettyJsonStringify(nullishCoalescing(optionalChaining(JSON_OBJECT, "fruits", 2), "not found")))
	// JSON_OBJECT?.fruits?.[2] ?? \"not found\": "banana"

	fmt.Println("JSON_OBJECT?.fruits?.[5] ?? \"not found\":", prettyJsonStringify(nullishCoalescing(optionalChaining(JSON_OBJECT, "fruits", 5), "not found")))
	// JSON_OBJECT?.fruits?.[5] ?? \"not found\": "not found"
}
