package main

import (
	"encoding/json"
	"fmt"
	"reflect"
)

const EMPTY_STRING = ""
const TAB = "    "

type Any interface{}
type Object map[string]Any

func prettyJsonStringify(anything Any) string {
	marshalledJson, err := json.MarshalIndent(anything, EMPTY_STRING, TAB)
	if err == nil {
		return string(marshalledJson)
	}

	return "undefined"
}

func prettyArrayOfPrimitives(anArray []Any) string {
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

func arrayFindIndexV1(callbackFunction func(Any, int, []Any) bool, anArray []Any) int {
	// JavaScript-like Array.findIndex() function
	itemIndex := -1
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			itemIndex = arrayItemIndex
			break
		}
	}
	return itemIndex
}

func arrayFindIndexV2(callbackFunction func(Any, int, []Any) bool, anArray []Any) int {
	// JavaScript-like Array.findIndex() function
	itemIndex := -1
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == true {
			itemIndex = arrayItemIndex
			break
		}
	}
	return itemIndex
}

func arrayFindIndexV3(callbackFunction func(Any, int, []Any) bool, anArray []Any) int {
	// JavaScript-like Array.findIndex() function
	itemIndex := -1
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			return arrayItemIndex
		}
	}
	return itemIndex
}

func arrayFindIndexV4(callbackFunction func(Any, int, []Any) bool, anArray []Any) int {
	// JavaScript-like Array.findIndex() function
	itemIndex := -1
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == true {
			return arrayItemIndex
		}
	}
	return itemIndex
}

func arrayFindIndexV5(callbackFunction func(Any, int, []Any) bool, anArray []Any) int {
	// JavaScript-like Array.findIndex() function
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			return arrayItemIndex
		}
	}
	return -1
}

func arrayFindIndexV6(callbackFunction func(Any, int, []Any) bool, anArray []Any) int {
	// JavaScript-like Array.findIndex() function
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == true {
			return arrayItemIndex
		}
	}
	return -1
}

func main() {
	fmt.Println("\n// JavaScript-like Array.findIndex() in Go Slice")

	numbers := []Any{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettyArrayOfPrimitives(numbers))

	numberToFind := 27
	fmt.Println("number to find:", numberToFind)

	var numberFoundIndex int

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

	numberFoundIndex = arrayFindIndexV1(func(number Any, _ int, _ []Any) bool {
		return number.(int) == numberToFind
	}, numbers)
	fmt.Println("number found index:", numberFoundIndex)
	// number found index: 2

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

	numberFoundIndex = arrayFindIndexV2(func(number Any, _ int, _ []Any) bool {
		return number.(int) == numberToFind
	}, numbers)
	fmt.Println("number found index:", numberFoundIndex)
	// number found index: 2

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"")

	numberFoundIndex = arrayFindIndexV3(func(number Any, _ int, _ []Any) bool {
		return number.(int) == numberToFind
	}, numbers)
	fmt.Println("number found index:", numberFoundIndex)
	// number found index: 2

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"")

	numberFoundIndex = arrayFindIndexV4(func(number Any, _ int, _ []Any) bool {
		return number.(int) == numberToFind
	}, numbers)
	fmt.Println("number found index:", numberFoundIndex)
	// number found index: 2

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV5\"")

	numberFoundIndex = arrayFindIndexV5(func(number Any, _ int, _ []Any) bool {
		return number.(int) == numberToFind
	}, numbers)
	fmt.Println("number found index:", numberFoundIndex)
	// number found index: 2

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV6\"")

	numberFoundIndex = arrayFindIndexV6(func(number Any, _ int, _ []Any) bool {
		return number.(int) == numberToFind
	}, numbers)
	fmt.Println("number found index:", numberFoundIndex)
	// number found index: 2

	fmt.Println("\n// JavaScript-like Array.findIndex() in Slice of Maps")

	products := []Any{
		Object{
			"code":  "pasta",
			"price": 321,
		},
		Object{
			"code":  "bubble_gum",
			"price": 233,
		},
		Object{
			"code":  "potato_chips",
			"price": 5,
		},
		Object{
			"code":  "towel",
			"price": 499,
		},
	}
	fmt.Println("products:", prettyJsonStringify(products))

	productToFind := "pasta"
	fmt.Println("product to find:", productToFind)

	var productFoundIndex int

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

	productFoundIndex = arrayFindIndexV1(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == productToFind
	}, products)
	fmt.Println("product found index:", productFoundIndex)
	// product found index: 0

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

	productFoundIndex = arrayFindIndexV2(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == productToFind
	}, products)
	fmt.Println("product found index:", productFoundIndex)
	// product found index: 0

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"")

	productFoundIndex = arrayFindIndexV3(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == productToFind
	}, products)
	fmt.Println("product found index:", productFoundIndex)
	// product found index: 0

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"")

	productFoundIndex = arrayFindIndexV4(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == productToFind
	}, products)
	fmt.Println("product found index:", productFoundIndex)
	// product found index: 0

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV5\"")

	productFoundIndex = arrayFindIndexV5(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == productToFind
	}, products)
	fmt.Println("product found index:", productFoundIndex)
	// product found index: 0

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV6\"")

	productFoundIndex = arrayFindIndexV6(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == productToFind
	}, products)
	fmt.Println("product found index:", productFoundIndex)
	// product found index: 0
}
