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

func arraySomeV1(callbackFunction func(Any, int, []Any) bool, anArray []Any) bool {
	// JavaScript-like Array.some() function
	isConditionMatch := false
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			break
		}
	}
	return isConditionMatch
}

func arraySomeV2(callbackFunction func(Any, int, []Any) bool, anArray []Any) bool {
	// JavaScript-like Array.some() function
	isConditionMatch := false
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			return isConditionMatch
		}
	}
	return isConditionMatch
}

func arraySomeV3(callbackFunction func(Any, int, []Any) bool, anArray []Any) bool {
	// JavaScript-like Array.some() function
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			return true
		}
	}
	return false
}

func arraySomeV4(callbackFunction func(Any, int, []Any) bool, anArray []Any) bool {
	// JavaScript-like Array.some() function
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == true {
			return true
		}
	}
	return false
}

func main() {
	fmt.Println("\n// JavaScript-like Array.some() in Go Slice")

	numbers := []Any{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettyArrayOfPrimitives(numbers))

	var isAnyNumberLessThan500 bool
	var isAnyNumberMoreThan500 bool

	fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV1\"")

	isAnyNumberLessThan500 = arraySomeV1(func(number Any, _ int, _ []Any) bool {
		return number.(int) < 500
	}, numbers)
	fmt.Println("is any number < 500: ", prettyJsonStringify(isAnyNumberLessThan500))
	// is any number < 500: true

	isAnyNumberMoreThan500 = arraySomeV1(func(number Any, _ int, _ []Any) bool {
		return number.(int) > 500
	}, numbers)
	fmt.Println("is any number > 500: ", prettyJsonStringify(isAnyNumberMoreThan500))
	// is any number > 500: false

	fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV2\"")

	isAnyNumberLessThan500 = arraySomeV2(func(number Any, _ int, _ []Any) bool {
		return number.(int) < 500
	}, numbers)
	fmt.Println("is any number < 500: ", prettyJsonStringify(isAnyNumberLessThan500))
	// is any number < 500: true

	isAnyNumberMoreThan500 = arraySomeV2(func(number Any, _ int, _ []Any) bool {
		return number.(int) > 500
	}, numbers)
	fmt.Println("is any number > 500: ", prettyJsonStringify(isAnyNumberMoreThan500))
	// is any number > 500: false

	fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV3\"")

	isAnyNumberLessThan500 = arraySomeV3(func(number Any, _ int, _ []Any) bool {
		return number.(int) < 500
	}, numbers)
	fmt.Println("is any number < 500: ", prettyJsonStringify(isAnyNumberLessThan500))
	// is any number < 500: true

	isAnyNumberMoreThan500 = arraySomeV3(func(number Any, _ int, _ []Any) bool {
		return number.(int) > 500
	}, numbers)
	fmt.Println("is any number > 500: ", prettyJsonStringify(isAnyNumberMoreThan500))
	// is any number > 500: false

	fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV4\"")

	isAnyNumberLessThan500 = arraySomeV4(func(number Any, _ int, _ []Any) bool {
		return number.(int) < 500
	}, numbers)
	fmt.Println("is any number < 500: ", prettyJsonStringify(isAnyNumberLessThan500))
	// is any number < 500: true

	isAnyNumberMoreThan500 = arraySomeV4(func(number Any, _ int, _ []Any) bool {
		return number.(int) > 500
	}, numbers)
	fmt.Println("is any number > 500: ", prettyJsonStringify(isAnyNumberMoreThan500))
	// is any number > 500: false

	fmt.Println("\n// JavaScript-like Array.some() in Slice of Maps")

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

	fmt.Println("products:" + prettyJsonStringify(products))

	var isAnyProductPriceLessThan500 bool
	var isAnyProductPriceMoreThan500 bool

	fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV1\"")

	isAnyProductPriceLessThan500 = arraySomeV1(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) < 500
	}, products)
	fmt.Println("is any product price < 500:", prettyJsonStringify(isAnyProductPriceLessThan500))
	// is any product price < 500: true

	isAnyProductPriceMoreThan500 = arraySomeV1(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) > 500
	}, products)
	fmt.Println("is any product price > 500:", prettyJsonStringify(isAnyProductPriceMoreThan500))
	// is any product price > 500: false

	fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV2\"")

	isAnyProductPriceLessThan500 = arraySomeV2(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) < 500
	}, products)
	fmt.Println("is any product price < 500:", prettyJsonStringify(isAnyProductPriceLessThan500))
	// is any product price < 500: true

	isAnyProductPriceMoreThan500 = arraySomeV2(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) > 500
	}, products)
	fmt.Println("is any product price > 500:", prettyJsonStringify(isAnyProductPriceMoreThan500))
	// is any product price > 500: false

	fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV3\"")

	isAnyProductPriceLessThan500 = arraySomeV3(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) < 500
	}, products)
	fmt.Println("is any product price < 500:", prettyJsonStringify(isAnyProductPriceLessThan500))
	// is any product price < 500: true

	isAnyProductPriceMoreThan500 = arraySomeV3(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) > 500
	}, products)
	fmt.Println("is any product price > 500:", prettyJsonStringify(isAnyProductPriceMoreThan500))
	// is any product price > 500: false

	fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV4\"")

	isAnyProductPriceLessThan500 = arraySomeV4(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) < 500
	}, products)
	fmt.Println("is any product price < 500:", prettyJsonStringify(isAnyProductPriceLessThan500))
	// is any product price < 500: true

	isAnyProductPriceMoreThan500 = arraySomeV4(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) > 500
	}, products)
	fmt.Println("is any product price > 500:", prettyJsonStringify(isAnyProductPriceMoreThan500))
	// is any product price > 500: false
}
