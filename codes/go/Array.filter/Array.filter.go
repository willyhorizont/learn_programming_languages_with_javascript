package main

import (
	"encoding/json"
	"fmt"
	"reflect"
	"strings"
)

const EMPTY_STRING = ""
const TAB = "    "

type Any interface{}
type Object map[string]Any

func prettyJsonStringify(anythingLikeJson Any) string {
	marshalledJson, err := json.MarshalIndent(anythingLikeJson, EMPTY_STRING, TAB)
	if err == nil {
		return string(marshalledJson)
	}

	return "undefined"
}

func arrayEvery(callbackFunction func(Any, int, []Any) bool, anArray []Any) bool {
	// JavaScript-like Array.every() function
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == false {
			return false
		}
	}
	return true
}

func prettySliceOfPrimitives(anArray []Any) string {
	isNotSliceOfPrimitives := arrayEvery(func(something Any, _ int, _ []Any) bool {
		somethingType := reflect.TypeOf(something).Kind()
		return somethingType != reflect.Int && somethingType != reflect.Int8 && somethingType != reflect.Int16 && somethingType != reflect.Int32 && somethingType != reflect.Int64 && somethingType != reflect.String && somethingType != reflect.Bool && somethingType != reflect.Float32 && somethingType != reflect.Float64
	}, anArray)
	if isNotSliceOfPrimitives == true {
		return "undefined"
	}
	stringSlice := []string{}
	for arrayItemIndex, arrayItem := range anArray {
		arrayItemType := reflect.TypeOf(arrayItem).Kind()
		if arrayItemType == reflect.Float32 {
			stringArrayItem := fmt.Sprint(arrayItem.(float32))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Float64 {
			stringArrayItem := fmt.Sprint(arrayItem.(float64))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Int {
			stringArrayItem := fmt.Sprint(arrayItem.(int))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Int8 {
			stringArrayItem := fmt.Sprint(arrayItem.(int8))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Int16 {
			stringArrayItem := fmt.Sprint(arrayItem.(int16))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Int32 {
			stringArrayItem := fmt.Sprint(arrayItem.(int32))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Int64 {
			stringArrayItem := fmt.Sprint(arrayItem.(int64))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Bool {
			stringArrayItem := prettyJsonStringify(arrayItem)
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		stringArrayItem := "\"" + arrayItem.(string) + "\""
		if arrayItemIndex != len(anArray)-1 {
			stringArrayItem += ", "
		}
		stringSlice = append(stringSlice, stringArrayItem)
	}
	return "[" + strings.Join(stringSlice, EMPTY_STRING) + "]"
}

func arrayFilterV1(callbackFunction func(Any, int, []Any) bool, anArray []Any) []Any {
	// JavaScript-like Array.filter() function
	dataFiltered := []Any{}
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			dataFiltered = append(dataFiltered, arrayItem)
		}
	}
	return dataFiltered
}

func arrayFilterV2(callbackFunction func(Any, int, []Any) bool, anArray []Any) []Any {
	// JavaScript-like Array.filter() function
	dataFiltered := []Any{}
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == true {
			dataFiltered = append(dataFiltered, arrayItem)
		}
	}
	return dataFiltered
}

func main() {
	fmt.Println("\n// JavaScript-like Array.filter() in Go Slice")

	numbers := []Any{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettySliceOfPrimitives(numbers))

	var numbersEven []Any
	var numbersOdd []Any

	fmt.Println("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

	numbersEven = arrayFilterV1(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("even numbers only: ", prettySliceOfPrimitives(numbersEven))
	// even numbers only: [12, 34, 36, 4, 254]

	numbersOdd = arrayFilterV1(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 != 0
	}, numbers)
	fmt.Println("odd numbers only: ", prettySliceOfPrimitives(numbersOdd))
	// odd numbers only: [27, 23, 65, 93, 87]

	fmt.Println("// using JavaScript-like Array.filter() function \"arrayFilterV2\"")

	numbersEven = arrayFilterV2(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("even numbers only: ", prettySliceOfPrimitives(numbersEven))
	// even numbers only: [12, 34, 36, 4, 254]

	numbersOdd = arrayFilterV2(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 != 0
	}, numbers)
	fmt.Println("odd numbers only: ", prettySliceOfPrimitives(numbersOdd))
	// odd numbers only: [27, 23, 65, 93, 87]

	fmt.Println("\n// JavaScript-like Array.filter() in Slice of Maps")

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

	var productsBelow100 []Any
	var productsAbove100 []Any

	fmt.Println("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

	productsBelow100 = arrayFilterV1(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) <= 100
	}, products)
	fmt.Println("products with price <= 100 only:", prettyJsonStringify(productsBelow100))
	// products with price <= 100 only: [
	//     {
	//         "code": "potato_chips",
	//         "price": 5
	//     }
	// ]

	productsAbove100 = arrayFilterV1(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) >= 100
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

	productsBelow100 = arrayFilterV2(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) <= 100
	}, products)
	fmt.Println("products with price <= 100 only:", prettyJsonStringify(productsBelow100))
	// products with price <= 100 only: [
	//     {
	//         "code": "potato_chips",
	//         "price": 5
	//     }
	// ]

	productsAbove100 = arrayFilterV2(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) >= 100
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
