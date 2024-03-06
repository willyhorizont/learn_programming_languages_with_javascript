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

func arrayEveryV1(callbackFunction func(any, int, array) bool, anArray array) bool {
	// JavaScript-like Array.every() function
	isConditionMatch := false
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
		if (isConditionMatch == false) {
			break
		}
	}
	return isConditionMatch
}

func arrayEveryV2(callbackFunction func(any, int, array) bool, anArray array) bool {
	// JavaScript-like Array.every() function
	isConditionMatch := false
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
		if (isConditionMatch == false) {
			return isConditionMatch
		}
	}
	return isConditionMatch
}

func arrayEveryV3(callbackFunction func(any, int, array) bool, anArray array) bool {
	// JavaScript-like Array.every() function
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if (isConditionMatch == false) {
			return false
		}
	}
	return true
}

func arrayEveryV4(callbackFunction func(any, int, array) bool, anArray array) bool {
	// JavaScript-like Array.every() function
	for arrayItemIndex, arrayItem := range anArray {
		if (callbackFunction(arrayItem, arrayItemIndex, anArray) == false) {
			return false
		}
	}
	return true
}

func main() {
	fmt.Println("\n// JavaScript-like Array.every() in Go Slice")

	numbers := array{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettyArrayOfPrimitives(numbers))

	var isAllNumberLessThan500 bool
	var isAllNumberMoreThan500 bool

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

	isAllNumberLessThan500 = arrayEveryV1(func(number any, _ int, _ array) bool {
		return (number.(int) < 500)
	}, numbers)
	fmt.Println("is all number < 500:", prettyJsonStringify(isAllNumberLessThan500))
	// is all number < 500: true

	isAllNumberMoreThan500 = arrayEveryV1(func(number any, _ int, _ array) bool {
		return (number.(int) > 500)
	}, numbers)
	fmt.Println("is all number > 500:", prettyJsonStringify(isAllNumberMoreThan500))
	// is all number > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

	isAllNumberLessThan500 = arrayEveryV2(func(number any, _ int, _ array) bool {
		return (number.(int) < 500)
	}, numbers)
	fmt.Println("is all number < 500:", prettyJsonStringify(isAllNumberLessThan500))
	// is all number < 500: true

	isAllNumberMoreThan500 = arrayEveryV2(func(number any, _ int, _ array) bool {
		return (number.(int) > 500)
	}, numbers)
	fmt.Println("is all number > 500:", prettyJsonStringify(isAllNumberMoreThan500))
	// is all number > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

	isAllNumberLessThan500 = arrayEveryV3(func(number any, _ int, _ array) bool {
		return (number.(int) < 500)
	}, numbers)
	fmt.Println("is all number < 500:", prettyJsonStringify(isAllNumberLessThan500))
	// is all number < 500: true

	isAllNumberMoreThan500 = arrayEveryV3(func(number any, _ int, _ array) bool {
		return (number.(int) > 500)
	}, numbers)
	fmt.Println("is all number > 500:", prettyJsonStringify(isAllNumberMoreThan500))
	// is all number > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV4\"")

	isAllNumberLessThan500 = arrayEveryV4(func(number any, _ int, _ array) bool {
		return (number.(int) < 500)
	}, numbers)
	fmt.Println("is all number < 500:", prettyJsonStringify(isAllNumberLessThan500))
	// is all number < 500: true

	isAllNumberMoreThan500 = arrayEveryV4(func(number any, _ int, _ array) bool {
		return (number.(int) > 500)
	}, numbers)
	fmt.Println("is all number > 500:", prettyJsonStringify(isAllNumberMoreThan500))
	// is all number > 500: false

	fmt.Println("\n// JavaScript-like Array.every() in Slice of Maps")

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

	fmt.Println("products:" + prettyJsonStringify(products))

	var isAllProductPriceLessThan500 bool
	var isAllProductPriceMoreThan500 bool

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

	isAllProductPriceLessThan500 = arrayEveryV1(func(product any, _ int, _ array) bool {
		return (product.(object)["price"].(int) < 500)
	}, products)
	fmt.Println("is all product price < 500:", prettyJsonStringify(isAllProductPriceLessThan500))
	// is all product price < 500: true

	isAllProductPriceMoreThan500 = arrayEveryV1(func(product any, _ int, _ array) bool {
		return (product.(object)["price"].(int) > 500)
	}, products)
	fmt.Println("is all product price > 500:", prettyJsonStringify(isAllProductPriceMoreThan500))
	// is all product price > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

	isAllProductPriceLessThan500 = arrayEveryV2(func(product any, _ int, _ array) bool {
		return (product.(object)["price"].(int) < 500)
	}, products)
	fmt.Println("is all product price < 500:", prettyJsonStringify(isAllProductPriceLessThan500))
	// is all product price < 500: true

	isAllProductPriceMoreThan500 = arrayEveryV2(func(product any, _ int, _ array) bool {
		return (product.(object)["price"].(int) > 500)
	}, products)
	fmt.Println("is all product price > 500:", prettyJsonStringify(isAllProductPriceMoreThan500))
	// is all product price > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

	isAllProductPriceLessThan500 = arrayEveryV3(func(product any, _ int, _ array) bool {
		return (product.(object)["price"].(int) < 500)
	}, products)
	fmt.Println("is all product price < 500:", prettyJsonStringify(isAllProductPriceLessThan500))
	// is all product price < 500: true

	isAllProductPriceMoreThan500 = arrayEveryV3(func(product any, _ int, _ array) bool {
		return (product.(object)["price"].(int) > 500)
	}, products)
	fmt.Println("is all product price > 500:", prettyJsonStringify(isAllProductPriceMoreThan500))
	// is all product price > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV4\"")

	isAllProductPriceLessThan500 = arrayEveryV4(func(product any, _ int, _ array) bool {
		return (product.(object)["price"].(int) < 500)
	}, products)
	fmt.Println("is all product price < 500:", prettyJsonStringify(isAllProductPriceLessThan500))
	// is all product price < 500: true

	isAllProductPriceMoreThan500 = arrayEveryV4(func(product any, _ int, _ array) bool {
		return (product.(object)["price"].(int) > 500)
	}, products)
	fmt.Println("is all product price > 500:", prettyJsonStringify(isAllProductPriceMoreThan500))
	// is all product price > 500: false
}
