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

func arrayFilterV1(callbackFunction func(any, int, array) bool, anArray array) array {
	// JavaScript-like Array.filter() function
	dataFiltered := array{}
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			dataFiltered = append(dataFiltered, arrayItem)
		}
	}
	return dataFiltered
}

func arrayFilterV2(callbackFunction func(any, int, array) bool, anArray array) array {
	// JavaScript-like Array.filter() function
	dataFiltered := array{}
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == true {
			dataFiltered = append(dataFiltered, arrayItem)
		}
	}
	return dataFiltered
}

func main() {
	fmt.Println("\n// JavaScript-like Array.filter() in Go Slice")

	numbers := array{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettyArrayOfPrimitives(numbers))

	var numbersEven array
	var numbersOdd array

	fmt.Println("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

	numbersEven = arrayFilterV1(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) == 0)
	}, numbers)
	fmt.Println("even numbers only: ", prettyArrayOfPrimitives(numbersEven))
	// even numbers only: [12, 34, 36, 4, 254]

	numbersOdd = arrayFilterV1(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) != 0)
	}, numbers)
	fmt.Println("odd numbers only: ", prettyArrayOfPrimitives(numbersOdd))
	// odd numbers only: [27, 23, 65, 93, 87]

	fmt.Println("// using JavaScript-like Array.filter() function \"arrayFilterV2\"")

	numbersEven = arrayFilterV2(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) == 0)
	}, numbers)
	fmt.Println("even numbers only: ", prettyArrayOfPrimitives(numbersEven))
	// even numbers only: [12, 34, 36, 4, 254]

	numbersOdd = arrayFilterV2(func(number any, _ int, _ array) bool {
		return ((number.(int) % 2) != 0)
	}, numbers)
	fmt.Println("odd numbers only: ", prettyArrayOfPrimitives(numbersOdd))
	// odd numbers only: [27, 23, 65, 93, 87]

	fmt.Println("\n// JavaScript-like Array.filter() in Slice of Maps")

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

	var productsBelow100 array
	var productsAbove100 array

	fmt.Println("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

	productsBelow100 = arrayFilterV1(func(product any, _ int, _ array) bool {
		return product.(object)["price"].(int) <= 100
	}, products)
	fmt.Println("products with price <= 100 only:", prettyJsonStringify(productsBelow100))
	// products with price <= 100 only: [
	//     {
	//         "code": "potato_chips",
	//         "price": 5
	//     }
	// ]

	productsAbove100 = arrayFilterV1(func(product any, _ int, _ array) bool {
		return product.(object)["price"].(int) >= 100
	}, products)
	fmt.Println("products with price >= 100 only:", prettyJsonStringify(productsAbove100))
	// products with price >= 100 only: [
	//     {
	//         "code": "pasta",
	//         "price": 321
	//     },
	//     {
	//         "code": "bubble_gum",
	//         "price": 233
	//     },
	//     {
	//         "code": "towel",
	//         "price": 499
	//     }
	// ]

	fmt.Println("// using JavaScript-like Array.filter() function \"arrayFilterV2\"")

	productsBelow100 = arrayFilterV2(func(product any, _ int, _ array) bool {
		return product.(object)["price"].(int) <= 100
	}, products)
	fmt.Println("products with price <= 100 only:", prettyJsonStringify(productsBelow100))
	// products with price <= 100 only: [
	//     {
	//         "code": "potato_chips",
	//         "price": 5
	//     }
	// ]

	productsAbove100 = arrayFilterV2(func(product any, _ int, _ array) bool {
		return product.(object)["price"].(int) >= 100
	}, products)
	fmt.Println("products with price >= 100 only:", prettyJsonStringify(productsAbove100))
	// products with price >= 100 only: [
	//     {
	//         "code": "pasta",
	//         "price": 321
	//     },
	//     {
	//         "code": "bubble_gum",
	//         "price": 233
	//     },
	//     {
	//         "code": "towel",
	//         "price": 499
	//     }
	// ]
}
