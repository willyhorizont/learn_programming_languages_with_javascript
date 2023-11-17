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
		switch arrayItemType := reflect.TypeOf(arrayItem).Kind(); arrayItemType {
		case reflect.String:
			result += "\"" + arrayItem.(string) + "\""
		case reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64, reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64, reflect.Float32, reflect.Float64, reflect.Complex64, reflect.Complex128:
			result += fmt.Sprint(arrayItem)
		default:
			continue
		}
		if ((arrayItemIndex + 1) != len(anArray)) {
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
		if (parameterType == reflect.Map) {
			for objectKey, objectValue := range parameter.(object) {
				newObject[objectKey] = objectValue
			}
		}
		if (parameterType == reflect.Slice) {
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
		if (parameterType == reflect.Map) {
			if (len(parameter.(object)) == 1) {
				for _, objectValue := range parameter.(object) {
					newArray = append(newArray, objectValue)
				}
				continue
			}
			newArray = append(newArray, parameter)
			continue
		}
		if (parameterType == reflect.Slice) {
			newArray = append(newArray, parameter.(array)...)
			continue
		}
	}
	return newArray
}

func arrayReduce(callbackFunction func(any, any, int, array) any, anArray array, initialValue any) any {
	// JavaScript-like Array.reduce() function
	result := initialValue
	for arrayItemIndex, arrayItem := range anArray {
		result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
	}
	return result
}

func main() {
	fmt.Println("\n// JavaScript-like Array.reduce() in Go Slice")

	numbers := array{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettyArrayOfPrimitives(numbers))

	fmt.Println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

	numbersTotal := arrayReduce(func(currentResult any, currentNumber any, _ int, _ array) any {
		return (currentResult.(int) + currentNumber.(int))
	}, numbers, 0)
	fmt.Println("total numbers:", prettyJsonStringify(numbersTotal))
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
		if (currentProduct.(object)["price"].(int) > 100) {
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
