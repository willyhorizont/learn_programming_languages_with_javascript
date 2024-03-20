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

func prettyArrayOfPrimitives(anArray array) string {
	result := "["
	for arrayItemIndex, arrayItem := range anArray {
		if (arrayItem == nil) {
			result += "nil"
		}
		if (arrayItem != nil) {
			switch arrayItemType := reflect.TypeOf(arrayItem).Kind(); arrayItemType {
			case reflect.String:
				result += "\"" + arrayItem.(string) + "\""
			case reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64, reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64, reflect.Float32, reflect.Float64, reflect.Complex64, reflect.Complex128:
				result += fmt.Sprint(arrayItem)
			case reflect.Bool:
				if (arrayItem.(bool) == true) {
					result += "true"
				} else {
					result += "false"
				}
			case reflect.Invalid:
				result += "nil"
			default:
				continue
			}
		}
		if ((arrayItemIndex + 1) != len(anArray)) {
			result = result + ", "
		}
	}
	result = result + "]"
	return result
}

func arrayFindIndexV1(callbackFunction func(any, int, array) bool, anArray array) int {
	// JavaScript-like Array.findIndex() function
	dataFoundIndex := -1
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if (isConditionMatch == true) {
			dataFoundIndex = arrayItemIndex
			break
		}
	}
	return dataFoundIndex
}

func arrayFindIndexV2(callbackFunction func(any, int, array) bool, anArray array) int {
	// JavaScript-like Array.findIndex() function
	dataFoundIndex := -1
	for arrayItemIndex, arrayItem := range anArray {
		if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
			dataFoundIndex = arrayItemIndex
			break
		}
	}
	return dataFoundIndex
}

func arrayFindIndexV3(callbackFunction func(any, int, array) bool, anArray array) int {
	// JavaScript-like Array.findIndex() function
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if (isConditionMatch == true) {
			return arrayItemIndex
		}
	}
	return -1
}

func arrayFindIndexV4(callbackFunction func(any, int, array) bool, anArray array) int {
	// JavaScript-like Array.findIndex() function
	for arrayItemIndex, arrayItem := range anArray {
		if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
			return arrayItemIndex
		}
	}
	return -1
}

func main() {
	fmt.Println("\n// JavaScript-like Array.findIndex() in Go Slice")

	numbers := array{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettyArrayOfPrimitives(numbers))

	numberToFind := 27
	fmt.Println("number to find:", numberToFind)

	var numberFoundIndex int

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

	numberFoundIndex = arrayFindIndexV1(func(number any, _ int, _ array) bool {
		return (number.(int) == numberToFind)
	}, numbers)
	fmt.Println("number found index:", numberFoundIndex)
	// number found index: 2

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

	numberFoundIndex = arrayFindIndexV2(func(number any, _ int, _ array) bool {
		return (number.(int) == numberToFind)
	}, numbers)
	fmt.Println("number found index:", numberFoundIndex)
	// number found index: 2

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"")

	numberFoundIndex = arrayFindIndexV3(func(number any, _ int, _ array) bool {
		return (number.(int) == numberToFind)
	}, numbers)
	fmt.Println("number found index:", numberFoundIndex)
	// number found index: 2

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"")

	numberFoundIndex = arrayFindIndexV4(func(number any, _ int, _ array) bool {
		return (number.(int) == numberToFind)
	}, numbers)
	fmt.Println("number found index:", numberFoundIndex)
	// number found index: 2

	fmt.Println("\n// JavaScript-like Array.findIndex() in Go Slice of maps")

	products := array{
		object{
			"code": "pasta",
			"price": 321,
		},
		object{
			"code": "bubble_gum",
			"price": 233,
		},
		object{
			"code": "potato_chips",
			"price": 5,
		},
		object{
			"code": "towel",
			"price": 499,
		},
	}
	fmt.Println("products:", prettyJsonStringify(products))
	
		productToFind := "pasta"
		fmt.Println("product to find:", productToFind)
	
	var productFoundIndex int

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

	productFoundIndex = arrayFindIndexV1(func(product any, _ int, _ array) bool {
		return (product.(object)["code"] == productToFind)
	}, products)
	fmt.Println("product found index:", productFoundIndex)
	// product found index: 0

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

	productFoundIndex = arrayFindIndexV2(func(product any, _ int, _ array) bool {
		return (product.(object)["code"] == productToFind)
	}, products)
	fmt.Println("product found index:", productFoundIndex)
	// product found index: 0

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"")

	productFoundIndex = arrayFindIndexV3(func(product any, _ int, _ array) bool {
		return (product.(object)["code"] == productToFind)
	}, products)
	fmt.Println("product found index:", productFoundIndex)
	// product found index: 0

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"")

	productFoundIndex = arrayFindIndexV4(func(product any, _ int, _ array) bool {
		return (product.(object)["code"] == productToFind)
	}, products)
	fmt.Println("product found index:", productFoundIndex)
	// product found index: 0
}
