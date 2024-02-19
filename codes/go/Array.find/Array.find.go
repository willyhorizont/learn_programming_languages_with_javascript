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
				if arrayItem.(bool) {
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

func arrayFindV1(callbackFunction func(any, int, array) bool, anArray array) any {
	// JavaScript-like Array.find() function
	var dataFound any
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if (isConditionMatch == true) {
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
		if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
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
		if (isConditionMatch == true) {
			return arrayItem
		}
	}
	return dataFound
}

func arrayFindV4(callbackFunction func(any, int, array) bool, anArray array) any {
	// JavaScript-like Array.find() function
	var dataFound any
	for arrayItemIndex, arrayItem := range anArray {
		if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
			return arrayItem
		}
	}
	return dataFound
}

func arrayFindV5(callbackFunction func(any, int, array) bool, anArray array) any {
	// JavaScript-like Array.find() function
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if (isConditionMatch == true) {
			return arrayItem
		}
	}
	return nil
}

func arrayFindV6(callbackFunction func(any, int, array) bool, anArray array) any {
	// JavaScript-like Array.find() function
	for arrayItemIndex, arrayItem := range anArray {
		if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
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

	productToFind := "bubble_gum"
	fmt.Println("product to find:", productToFind)

	var productFound any

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV1\"")

	productFound = arrayFindV1(func(product any, _ int, _ array) bool {
		return (product.(object)["code"] == productToFind)
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV2\"")

	productFound = arrayFindV2(func(product any, _ int, _ array) bool {
		return (product.(object)["code"] == productToFind)
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV3\"")

	productFound = arrayFindV3(func(product any, _ int, _ array) bool {
		return (product.(object)["code"] == productToFind)
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV4\"")

	productFound = arrayFindV4(func(product any, _ int, _ array) bool {
		return (product.(object)["code"] == productToFind)
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV5\"")

	productFound = arrayFindV5(func(product any, _ int, _ array) bool {
		return (product.(object)["code"] == productToFind)
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV6\"")

	productFound = arrayFindV6(func(product any, _ int, _ array) bool {
		return (product.(object)["code"] == productToFind)
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }
}
