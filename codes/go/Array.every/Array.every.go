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

func arrayEveryV1(callbackFunction func(Any, int, []Any) bool, anArray []Any) bool {
	// JavaScript-like Array.every() function
	isConditionMatch := false
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == false {
			break
		}
	}
	return isConditionMatch
}

func arrayEveryV2(callbackFunction func(Any, int, []Any) bool, anArray []Any) bool {
	// JavaScript-like Array.every() function
	isConditionMatch := false
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == false {
			return isConditionMatch
		}
	}
	return isConditionMatch
}

func arrayEveryV3(callbackFunction func(Any, int, []Any) bool, anArray []Any) bool {
	// JavaScript-like Array.every() function
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == false {
			return false
		}
	}
	return true
}

func arrayEveryV4(callbackFunction func(Any, int, []Any) bool, anArray []Any) bool {
	// JavaScript-like Array.every() function
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == false {
			return false
		}
	}
	return true
}

func main() {
	fmt.Println("\n// JavaScript-like Array.every() in Go Slice")

	numbers := []Any{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettySliceOfPrimitives(numbers))

	var isAllNumberLessThan500 bool
	var isAllNumberMoreThan500 bool

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

	isAllNumberLessThan500 = arrayEveryV1(func(number Any, _ int, _ []Any) bool {
		return number.(int) < 500
	}, numbers)
	fmt.Println("is all number < 500: ", prettyJsonStringify(isAllNumberLessThan500))
	// is all number < 500: true

	isAllNumberMoreThan500 = arrayEveryV1(func(number Any, _ int, _ []Any) bool {
		return number.(int) > 500
	}, numbers)
	fmt.Println("is all number > 500: ", prettyJsonStringify(isAllNumberMoreThan500))
	// is all number > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

	isAllNumberLessThan500 = arrayEveryV2(func(number Any, _ int, _ []Any) bool {
		return number.(int) < 500
	}, numbers)
	fmt.Println("is all number < 500: ", prettyJsonStringify(isAllNumberLessThan500))
	// is all number < 500: true

	isAllNumberMoreThan500 = arrayEveryV2(func(number Any, _ int, _ []Any) bool {
		return number.(int) > 500
	}, numbers)
	fmt.Println("is all number > 500: ", prettyJsonStringify(isAllNumberMoreThan500))
	// is all number > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

	isAllNumberLessThan500 = arrayEveryV3(func(number Any, _ int, _ []Any) bool {
		return number.(int) < 500
	}, numbers)
	fmt.Println("is all number < 500: ", prettyJsonStringify(isAllNumberLessThan500))
	// is all number < 500: true

	isAllNumberMoreThan500 = arrayEveryV3(func(number Any, _ int, _ []Any) bool {
		return number.(int) > 500
	}, numbers)
	fmt.Println("is all number > 500: ", prettyJsonStringify(isAllNumberMoreThan500))
	// is all number > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV4\"")

	isAllNumberLessThan500 = arrayEveryV4(func(number Any, _ int, _ []Any) bool {
		return number.(int) < 500
	}, numbers)
	fmt.Println("is all number < 500: ", prettyJsonStringify(isAllNumberLessThan500))
	// is all number < 500: true

	isAllNumberMoreThan500 = arrayEveryV4(func(number Any, _ int, _ []Any) bool {
		return number.(int) > 500
	}, numbers)
	fmt.Println("is all number > 500: ", prettyJsonStringify(isAllNumberMoreThan500))
	// is all number > 500: false

	fmt.Println("\n// JavaScript-like Array.every() in Slice of Maps")

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

	var isAllProductPriceLessThan500 bool
	var isAllProductPriceMoreThan500 bool

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

	isAllProductPriceLessThan500 = arrayEveryV1(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) < 500
	}, products)
	fmt.Println("is all product price < 500:", prettyJsonStringify(isAllProductPriceLessThan500))
	// is all product price < 500: true

	isAllProductPriceMoreThan500 = arrayEveryV1(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) > 500
	}, products)
	fmt.Println("is all product price > 500:", prettyJsonStringify(isAllProductPriceMoreThan500))
	// is all product price > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

	isAllProductPriceLessThan500 = arrayEveryV2(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) < 500
	}, products)
	fmt.Println("is all product price < 500:", prettyJsonStringify(isAllProductPriceLessThan500))
	// is all product price < 500: true

	isAllProductPriceMoreThan500 = arrayEveryV2(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) > 500
	}, products)
	fmt.Println("is all product price > 500:", prettyJsonStringify(isAllProductPriceMoreThan500))
	// is all product price > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

	isAllProductPriceLessThan500 = arrayEveryV3(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) < 500
	}, products)
	fmt.Println("is all product price < 500:", prettyJsonStringify(isAllProductPriceLessThan500))
	// is all product price < 500: true

	isAllProductPriceMoreThan500 = arrayEveryV3(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) > 500
	}, products)
	fmt.Println("is all product price > 500:", prettyJsonStringify(isAllProductPriceMoreThan500))
	// is all product price > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV4\"")

	isAllProductPriceLessThan500 = arrayEveryV4(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) < 500
	}, products)
	fmt.Println("is all product price < 500:", prettyJsonStringify(isAllProductPriceLessThan500))
	// is all product price < 500: true

	isAllProductPriceMoreThan500 = arrayEveryV4(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) > 500
	}, products)
	fmt.Println("is all product price > 500:", prettyJsonStringify(isAllProductPriceMoreThan500))
	// is all product price > 500: false
}
