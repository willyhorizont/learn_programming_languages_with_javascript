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

func arrayFindV1(callbackFunction func(any, int, array) bool, anArray array) any {
	// JavaScript-like Array.find() function
	var dataFound any
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			dataFound = arrayItem
			break
		}
	}
	return dataFound
}

func arrayFindV2(callbackFunction func(any, int, array) bool, anArray array) any {
	// JavaScript-like Array.find() function
	var dataFound any
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == true {
			dataFound = arrayItem
			break
		}
	}
	return dataFound
}

func arrayFindV3(callbackFunction func(any, int, array) bool, anArray array) any {
	// JavaScript-like Array.find() function
	var dataFound any
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			return arrayItem
		}
	}
	return dataFound
}

func arrayFindV4(callbackFunction func(any, int, array) bool, anArray array) any {
	// JavaScript-like Array.find() function
	var dataFound any
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == true {
			return arrayItem
		}
	}
	return dataFound
}

func arrayFindV5(callbackFunction func(any, int, array) bool, anArray array) any {
	// JavaScript-like Array.find() function
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			return arrayItem
		}
	}
	return nil
}

func arrayFindV6(callbackFunction func(any, int, array) bool, anArray array) any {
	// JavaScript-like Array.find() function
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == true {
			return arrayItem
		}
	}
	return nil
}

func main() {
	fmt.Println("\n// JavaScript-like Array.find() in Go Slice")

	numbers := array{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettyArrayOfPrimitives(numbers))

	var evenNumberFound any
	var oddNumberFound any

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV1\"")

	evenNumberFound = arrayFindV1(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) == 0)
	}, numbers)
	fmt.Println("even number found:", evenNumberFound)
	// even number found: 12

	oddNumberFound = arrayFindV1(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) != 0)
	}, numbers)
	fmt.Println("odd number found:", oddNumberFound)
	// odd number found: 27

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV2\"")

	evenNumberFound = arrayFindV2(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) == 0)
	}, numbers)
	fmt.Println("even number found:", evenNumberFound)
	// even number found: 12

	oddNumberFound = arrayFindV2(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) != 0)
	}, numbers)
	fmt.Println("odd number found:", oddNumberFound)
	// odd number found: 27

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV3\"")

	evenNumberFound = arrayFindV3(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) == 0)
	}, numbers)
	fmt.Println("even number found:", evenNumberFound)
	// even number found: 12

	oddNumberFound = arrayFindV3(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) != 0)
	}, numbers)
	fmt.Println("odd number found:", oddNumberFound)
	// odd number found: 27

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV4\"")

	evenNumberFound = arrayFindV4(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) == 0)
	}, numbers)
	fmt.Println("even number found:", evenNumberFound)
	// even number found: 12

	oddNumberFound = arrayFindV4(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) != 0)
	}, numbers)
	fmt.Println("odd number found:", oddNumberFound)
	// odd number found: 27

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV5\"")

	evenNumberFound = arrayFindV5(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) == 0)
	}, numbers)
	fmt.Println("even number found:", evenNumberFound)
	// even number found: 12

	oddNumberFound = arrayFindV5(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) != 0)
	}, numbers)
	fmt.Println("odd number found:", oddNumberFound)
	// odd number found: 27

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV6\"")

	evenNumberFound = arrayFindV6(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) == 0)
	}, numbers)
	fmt.Println("even number found:", evenNumberFound)
	// even number found: 12

	oddNumberFound = arrayFindV6(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) != 0)
	}, numbers)
	fmt.Println("odd number found:", oddNumberFound)
	// odd number found: 27

	fmt.Println("\n// JavaScript-like Array.find() in Slice of Maps")

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

	var productFound any

	productToFind := "bubble_gum"
	fmt.Println("product to find:", prettyJsonStringify(productToFind))

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV1\"")

	productFound = arrayFindV1(func(product any, _ int, _ array) bool {
		return product.(object)["code"] == productToFind
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV2\"")

	productFound = arrayFindV2(func(product any, _ int, _ array) bool {
		return product.(object)["code"] == productToFind
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV3\"")

	productFound = arrayFindV3(func(product any, _ int, _ array) bool {
		return product.(object)["code"] == productToFind
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV4\"")

	productFound = arrayFindV4(func(product any, _ int, _ array) bool {
		return product.(object)["code"] == productToFind
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV5\"")

	productFound = arrayFindV5(func(product any, _ int, _ array) bool {
		return product.(object)["code"] == productToFind
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV6\"")

	productFound = arrayFindV6(func(product any, _ int, _ array) bool {
		return product.(object)["code"] == productToFind
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }
}
