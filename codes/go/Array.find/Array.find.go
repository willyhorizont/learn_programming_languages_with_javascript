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

func arrayFindV1(callbackFunction func(Any, int, []Any) bool, anArray []Any) Any {
	// JavaScript-like Array.find() function
	var dataFound Any
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			dataFound = arrayItem
			break
		}
	}
	return dataFound
}

func arrayFindV2(callbackFunction func(Any, int, []Any) bool, anArray []Any) Any {
	// JavaScript-like Array.find() function
	var dataFound Any
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == true {
			dataFound = arrayItem
			break
		}
	}
	return dataFound
}

func arrayFindV3(callbackFunction func(Any, int, []Any) bool, anArray []Any) Any {
	// JavaScript-like Array.find() function
	var dataFound Any
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			return arrayItem
		}
	}
	return dataFound
}

func arrayFindV4(callbackFunction func(Any, int, []Any) bool, anArray []Any) Any {
	// JavaScript-like Array.find() function
	var dataFound Any
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == true {
			return arrayItem
		}
	}
	return dataFound
}

func arrayFindV5(callbackFunction func(Any, int, []Any) bool, anArray []Any) Any {
	// JavaScript-like Array.find() function
	for arrayItemIndex, arrayItem := range anArray {
		isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
		if isConditionMatch == true {
			return arrayItem
		}
	}
	return nil
}

func arrayFindV6(callbackFunction func(Any, int, []Any) bool, anArray []Any) Any {
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

	numbers := []Any{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettySliceOfPrimitives(numbers))

	var evenNumberFound Any
	var oddNumberFound Any

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV1\"")

	evenNumberFound = arrayFindV1(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("even number found:", evenNumberFound)
	// even number found: 12

	oddNumberFound = arrayFindV1(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 != 0
	}, numbers)
	fmt.Println("odd number found:", oddNumberFound)
	// odd number found: 27

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV2\"")

	evenNumberFound = arrayFindV2(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("even number found:", evenNumberFound)
	// even number found: 12

	oddNumberFound = arrayFindV2(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 != 0
	}, numbers)
	fmt.Println("odd number found:", oddNumberFound)
	// odd number found: 27

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV3\"")

	evenNumberFound = arrayFindV3(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("even number found:", evenNumberFound)
	// even number found: 12

	oddNumberFound = arrayFindV3(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 != 0
	}, numbers)
	fmt.Println("odd number found:", oddNumberFound)
	// odd number found: 27

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV4\"")

	evenNumberFound = arrayFindV4(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("even number found:", evenNumberFound)
	// even number found: 12

	oddNumberFound = arrayFindV4(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 != 0
	}, numbers)
	fmt.Println("odd number found:", oddNumberFound)
	// odd number found: 27

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV5\"")

	evenNumberFound = arrayFindV5(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("even number found:", evenNumberFound)
	// even number found: 12

	oddNumberFound = arrayFindV5(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 != 0
	}, numbers)
	fmt.Println("odd number found:", oddNumberFound)
	// odd number found: 27

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV6\"")

	evenNumberFound = arrayFindV6(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 == 0
	}, numbers)
	fmt.Println("even number found:", evenNumberFound)
	// even number found: 12

	oddNumberFound = arrayFindV6(func(number Any, _ int, _ []Any) bool {
		return number.(int)%2 != 0
	}, numbers)
	fmt.Println("odd number found:", oddNumberFound)
	// odd number found: 27

	fmt.Println("\n// JavaScript-like Array.find() in Slice of Maps")

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

	var productFound Any

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV1\"")

	productFound = arrayFindV1(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == "bubble_gu"
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV2\"")

	productFound = arrayFindV2(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == "bubble_gum"
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV3\"")

	productFound = arrayFindV3(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == "bubble_gum"
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV4\"")

	productFound = arrayFindV4(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == "bubble_gum"
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV5\"")

	productFound = arrayFindV5(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == "bubble_gum"
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }

	fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV6\"")

	productFound = arrayFindV6(func(product Any, _ int, _ []Any) bool {
		return product.(Object)["code"] == "bubble_gum"
	}, products)
	fmt.Println("product found:", prettyJsonStringify(productFound))
	// product found: {
	//     "code":"bubble_gum",
	//     "price": 233
	// }
}
