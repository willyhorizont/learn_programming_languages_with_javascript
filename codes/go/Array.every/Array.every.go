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
	if isNotSliceOfPrimitives {
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
	fmt.Println("\n// JavaScript-like Array.every() in GO Slice")

	numbers := []Any{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettySliceOfPrimitives(numbers))

	var isAllNumbersLessThan500 bool
	var isAllNumbersMoreThan500 bool

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

	isAllNumbersLessThan500 = arrayEveryV1(func(number Any, _ int, _ []Any) bool {
		return number.(int) < 500
	}, numbers)
	fmt.Println("is all numbers < 500: ", prettyJsonStringify(isAllNumbersLessThan500))
	// is all number < 500: true

	isAllNumbersMoreThan500 = arrayEveryV1(func(number Any, _ int, _ []Any) bool {
		return number.(int) > 500
	}, numbers)
	fmt.Println("is all numbers > 500: ", prettyJsonStringify(isAllNumbersMoreThan500))
	// is all number > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

	isAllNumbersLessThan500 = arrayEveryV2(func(number Any, _ int, _ []Any) bool {
		return number.(int) < 500
	}, numbers)
	fmt.Println("is all numbers < 500: ", prettyJsonStringify(isAllNumbersLessThan500))
	// is all number < 500: true

	isAllNumbersMoreThan500 = arrayEveryV2(func(number Any, _ int, _ []Any) bool {
		return number.(int) > 500
	}, numbers)
	fmt.Println("is all numbers > 500: ", prettyJsonStringify(isAllNumbersMoreThan500))
	// is all number > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

	isAllNumbersLessThan500 = arrayEveryV3(func(number Any, _ int, _ []Any) bool {
		return number.(int) < 500
	}, numbers)
	fmt.Println("is all numbers < 500: ", prettyJsonStringify(isAllNumbersLessThan500))
	// is all number < 500: true

	isAllNumbersMoreThan500 = arrayEveryV3(func(number Any, _ int, _ []Any) bool {
		return number.(int) > 500
	}, numbers)
	fmt.Println("is all numbers > 500: ", prettyJsonStringify(isAllNumbersMoreThan500))
	// is all number > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV4\"")

	isAllNumbersLessThan500 = arrayEveryV4(func(number Any, _ int, _ []Any) bool {
		return number.(int) < 500
	}, numbers)
	fmt.Println("is all numbers < 500: ", prettyJsonStringify(isAllNumbersLessThan500))
	// is all number < 500: true

	isAllNumbersMoreThan500 = arrayEveryV4(func(number Any, _ int, _ []Any) bool {
		return number.(int) > 500
	}, numbers)
	fmt.Println("is all numbers > 500: ", prettyJsonStringify(isAllNumbersMoreThan500))
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

	var isAllProductsPriceLessThan500 bool
	var isAllProductsPriceMoreThan500 bool

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

	isAllProductsPriceLessThan500 = arrayEveryV1(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) < 500
	}, products)
	fmt.Println("is all products price < 500:", prettyJsonStringify(isAllProductsPriceLessThan500))
	// is all products price < 500: true

	isAllProductsPriceMoreThan500 = arrayEveryV1(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) > 500
	}, products)
	fmt.Println("is all products price > 500:", prettyJsonStringify(isAllProductsPriceMoreThan500))
	// is all products price > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

	isAllProductsPriceLessThan500 = arrayEveryV2(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) < 500
	}, products)
	fmt.Println("is all products price < 500:", prettyJsonStringify(isAllProductsPriceLessThan500))
	// is all products price < 500: true

	isAllProductsPriceMoreThan500 = arrayEveryV2(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) > 500
	}, products)
	fmt.Println("is all products price > 500:", prettyJsonStringify(isAllProductsPriceMoreThan500))
	// is all products price > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

	isAllProductsPriceLessThan500 = arrayEveryV3(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) < 500
	}, products)
	fmt.Println("is all products price < 500:", prettyJsonStringify(isAllProductsPriceLessThan500))
	// is all products price < 500: true

	isAllProductsPriceMoreThan500 = arrayEveryV3(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) > 500
	}, products)
	fmt.Println("is all products price > 500:", prettyJsonStringify(isAllProductsPriceMoreThan500))
	// is all products price > 500: false

	fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV4\"")

	isAllProductsPriceLessThan500 = arrayEveryV4(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) < 500
	}, products)
	fmt.Println("is all products price < 500:", prettyJsonStringify(isAllProductsPriceLessThan500))
	// is all products price < 500: true

	isAllProductsPriceMoreThan500 = arrayEveryV4(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["price"].(int) > 500
	}, products)
	fmt.Println("is all products price > 500:", prettyJsonStringify(isAllProductsPriceMoreThan500))
	// is all products price > 500: false
}
