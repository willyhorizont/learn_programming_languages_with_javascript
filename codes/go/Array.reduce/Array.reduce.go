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
	if err == nil {
		return string(marshalledJson)
	}

	return "undefined"
}

func prettyArrayOfPrimitives(anArray array) string {
	result := "["
	for arrayItemIndex, arrayItem := range anArray {
		arrayItemType := reflect.TypeOf(arrayItem).Kind()
		if arrayItemType != reflect.Float32 &&
			arrayItemType != reflect.Float64 &&
			arrayItemType != reflect.Int &&
			arrayItemType != reflect.Int8 &&
			arrayItemType != reflect.Int16 &&
			arrayItemType != reflect.Int32 &&
			arrayItemType != reflect.Int64 &&
			arrayItemType != reflect.Uint &&
			arrayItemType != reflect.Uint8 &&
			arrayItemType != reflect.Uint16 &&
			arrayItemType != reflect.Uint32 &&
			arrayItemType != reflect.Uint64 &&
			arrayItemType != reflect.String {
			continue
		}
		if arrayItemType == reflect.String {
			stringArrayItem := arrayItem.(string)
			result = result + "\"" + stringArrayItem + "\""
		}
		if arrayItemType == reflect.Float32 {
			stringArrayItem := fmt.Sprint(arrayItem.(float32))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Float64 {
			stringArrayItem := fmt.Sprint(arrayItem.(float64))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Int {
			stringArrayItem := fmt.Sprint(arrayItem.(int))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Int8 {
			stringArrayItem := fmt.Sprint(arrayItem.(int8))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Int16 {
			stringArrayItem := fmt.Sprint(arrayItem.(int16))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Int32 {
			stringArrayItem := fmt.Sprint(arrayItem.(int32))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Int64 {
			stringArrayItem := fmt.Sprint(arrayItem.(int64))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Uint {
			stringArrayItem := fmt.Sprint(arrayItem.(uint))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Uint8 {
			stringArrayItem := fmt.Sprint(arrayItem.(uint8))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Uint16 {
			stringArrayItem := fmt.Sprint(arrayItem.(uint16))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Uint32 {
			stringArrayItem := fmt.Sprint(arrayItem.(uint32))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Int64 {
			stringArrayItem := fmt.Sprint(arrayItem.(uint64))
			result = result + stringArrayItem
		}
		if (arrayItemIndex + 1) != len(anArray) {
			result = result + ", "
		}
	}
	result = result + "]"
	return result
}

func spreadSyntaxObject(parameters ...any) object {
	var newObject = make(object)
	for _, parameter := range parameters {
		parameterType := reflect.TypeOf(parameter).Kind()
		if parameterType == reflect.Map {
			for objectKey, objectValue := range parameter.(object) {
				newObject[objectKey] = objectValue
			}
		}
		if parameterType == reflect.Slice {
			for arrayItemIndex, arrayItem := range parameter.(array) {
				newObject[prettyJsonStringify(arrayItemIndex)] = arrayItem
			}
		}
	}
	return newObject
}

func spreadSyntaxArray(parameters ...any) array {
	var newArray = array{}
	for _, parameter := range parameters {
		parameterType := reflect.TypeOf(parameter).Kind()
		if parameterType == reflect.Map {
			if len(parameter.(object)) == 1 {
				for _, objectValue := range parameter.(object) {
					newArray = append(newArray, objectValue)
				}
				continue
			}
			newArray = append(newArray, parameter)
			continue
		}
		if parameterType == reflect.Slice {
			if len(parameter.(array)) == 0 {
				continue
			}
			newArray = append(newArray, parameter.(array)...)
			continue
		}
	}
	return newArray
}

func arrayReduce(callbackFunction func(any, any, int, array) any, anArray array, initialValue any) any {
	// JavaScript-like Array.reduce() function
	var result any
	for arrayItemIndex, arrayItem := range anArray {
		if arrayItemIndex == 0 {
			result = callbackFunction(initialValue, arrayItem, arrayItemIndex, anArray)
		} else {
			result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
		}
	}
	return result
}

func main() {
	fmt.Println("\n// JavaScript-like Array.reduce() in Go Slice")

	numbers := array{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettyArrayOfPrimitives(numbers))

	fmt.Println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

	numbersTotal := arrayReduce(func(currentResult any, currentNumber any, _ int, _ array) any {
		return currentResult.(int) + currentNumber.(int)
	}, numbers, 0)
	fmt.Println("total numbers: ", prettyJsonStringify(numbersTotal))
	// total number: 635

	fmt.Println("\n// JavaScript-like Array.reduce() in Slice of Maps")

	products := array{
		object{
			"code":  "pasta",
			"price": 321,
		},
		object{
			"code":  "bubble_gum",
			"price": 233,
		},
		object{
			"code":  "potato_chips",
			"price": 5,
		},
		object{
			"code":  "towel",
			"price": 499,
		},
	}
	fmt.Println("products:", prettyJsonStringify(products))

	fmt.Println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

	productsGrouped := arrayReduce(func(currentResult any, currentProduct any, _ int, _ array) any {
		if currentProduct.(object)["price"].(int) > 100 {
			return spreadSyntaxObject(currentResult, object{"expensive": spreadSyntaxArray(currentResult.(object)["expensive"], object{"currentProduct": currentProduct})})
		}
		return spreadSyntaxObject(currentResult, object{"cheap": spreadSyntaxArray(currentResult.(object)["cheap"], object{"currentProduct": currentProduct})})
	}, products, object{"expensive": array{}, "cheap": array{}})
	fmt.Println("grouped products:", prettyJsonStringify(productsGrouped))
	// grouped products: {
	// 	"expensive": [
	// 		{
	// 			"code": "pasta",
	// 			"price": 321
	// 		},
	// 		{
	// 			"code": "bubble_gum",
	// 			"price": 233
	// 		},
	// 		{
	// 			"code": "towel",
	// 			"price": 499
	// 		}
	// 	],
	// 	"cheap": [
	// 		{
	// 			"code": "potato_chips",
	// 			"price": 5
	// 		}
	// 	]
	// }
}
