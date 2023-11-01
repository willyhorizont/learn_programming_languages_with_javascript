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
	fmt.Println("numbers:", prettySliceOfPrimitives(numbers))

	myLuckyNumber := 27
	fmt.Println("my lucky number:", myLuckyNumber)

	myLuckyNumberIndex := -1

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

	myLuckyNumberIndex = arrayFindIndexV1(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("my lucky number is at index:", myLuckyNumberIndex)
	// my lucky number is at index: 2

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

	myLuckyNumberIndex = arrayFindIndexV2(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("my lucky number is at index:", myLuckyNumberIndex)
	// my lucky number is at index: 2

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"")

	myLuckyNumberIndex = arrayFindIndexV3(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("my lucky number is at index:", myLuckyNumberIndex)
	// my lucky number is at index: 2

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"")

	myLuckyNumberIndex = arrayFindIndexV4(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("my lucky number is at index:", myLuckyNumberIndex)
	// my lucky number is at index: 2

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV5\"")

	myLuckyNumberIndex = arrayFindIndexV5(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("my lucky number is at index:", myLuckyNumberIndex)
	// my lucky number is at index: 2

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV6\"")

	myLuckyNumberIndex = arrayFindIndexV6(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("my lucky number is at index:", myLuckyNumberIndex)
	// my lucky number is at index: 2

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

	productToBuy := "pasta"
	fmt.Println("product to buy:", productToBuy)

	productToBuyIndex := -1

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

	productToBuyIndex = arrayFindIndexV1(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == productToBuy
	}, products)
	fmt.Println("product to buy is at index:", productToBuyIndex)
	// product to buy is at index: 0

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

	productToBuyIndex = arrayFindIndexV2(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == productToBuy
	}, products)
	fmt.Println("product to buy is at index:", productToBuyIndex)
	// product to buy is at index: 0

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"")

	productToBuyIndex = arrayFindIndexV3(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == productToBuy
	}, products)
	fmt.Println("product to buy is at index:", productToBuyIndex)
	// product to buy is at index: 0

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"")

	productToBuyIndex = arrayFindIndexV4(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == productToBuy
	}, products)
	fmt.Println("product to buy is at index:", productToBuyIndex)
	// product to buy is at index: 0

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV5\"")

	productToBuyIndex = arrayFindIndexV5(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == productToBuy
	}, products)
	fmt.Println("product to buy is at index:", productToBuyIndex)
	// product to buy is at index: 0

	fmt.Println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV6\"")

	productToBuyIndex = arrayFindIndexV6(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == productToBuy
	}, products)
	fmt.Println("product to buy is at index:", productToBuyIndex)
	// product to buy is at index: 0
}
