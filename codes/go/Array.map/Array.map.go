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

func spreadSyntaxObject(parameters ...Any) Object {
	var newObject = make(Object)
	for _, parameter := range parameters {
		parameterType := reflect.TypeOf(parameter).Kind()
		if parameterType == reflect.Map {
			for objectKey, objectValue := range parameter.(Object) {
				newObject[objectKey] = objectValue
			}
		}
		if parameterType == reflect.Slice {
			for arrayItemIndex, arrayItem := range parameter.([]Any) {
				newObject[prettyJsonStringify(arrayItemIndex)] = arrayItem
			}
		}
	}
	return newObject
}

func arrayMapV1(callbackFunction func(Any, int, []Any) Any, anArray []Any) []Any {
	// JavaScript-like Array.map() function
	newArray := []Any{}
	for arrayItemIndex, arrayItem := range anArray {
		newArrayItem := callbackFunction(arrayItem, arrayItemIndex, anArray)
		newArray = append(newArray, newArrayItem)
	}
	return newArray
}

func arrayMapV2(callbackFunction func(Any, int, []Any) Any, anArray []Any) []Any {
	// JavaScript-like Array.map() function
	newArray := []Any{}
	for arrayItemIndex, arrayItem := range anArray {
		newArray = append(newArray, callbackFunction(arrayItem, arrayItemIndex, anArray))
	}
	return newArray
}

func main() {
	fmt.Println("\n// JavaScript-like Array.map() in Go Slice")

	numbers := []Any{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettyArrayOfPrimitives(numbers))

	var numbersLabeled []Any

	fmt.Println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

	numbersLabeled = arrayMapV1(func(number Any, _ int, _ []Any) Any {
		var objectValue Any
		if number.(int)%2 == 0 {
			objectValue = "even"
		} else {
			objectValue = "odd"
		}
		return Object{
			prettyJsonStringify(number): objectValue,
		}
	}, numbers)
	fmt.Println("labeled numbers: ", prettyJsonStringify(numbersLabeled))
	// labeled numbers: [
	//     {
	//         "12": "even"
	//     },
	//     {
	//         "34": "even"
	//     },
	//     {
	//         "27": "odd"
	//     },
	//     {
	//         "23": "odd"
	//     },
	//     {
	//         "65": "odd"
	//     },
	//     {
	//         "93": "odd"
	//     },
	//     {
	//         "36": "even"
	//     },
	//     {
	//         "87": "odd"
	//     },
	//     {
	//         "4": "even"
	//     },
	//     {
	//         "254": "even"
	//     }
	// ]

	fmt.Println("// using JavaScript-like Array.map() function \"arrayMapV2\"")

	numbersLabeled = arrayMapV2(func(number Any, _ int, _ []Any) Any {
		var objectValue Any
		if number.(int)%2 == 0 {
			objectValue = "even"
		} else {
			objectValue = "odd"
		}
		return Object{
			prettyJsonStringify(number): objectValue,
		}
	}, numbers)
	fmt.Println("labeled numbers: ", prettyJsonStringify(numbersLabeled))
	// labeled numbers: [
	//     {
	//         "12": "even"
	//     },
	//     {
	//         "34": "even"
	//     },
	//     {
	//         "27": "odd"
	//     },
	//     {
	//         "23": "odd"
	//     },
	//     {
	//         "65": "odd"
	//     },
	//     {
	//         "93": "odd"
	//     },
	//     {
	//         "36": "even"
	//     },
	//     {
	//         "87": "odd"
	//     },
	//     {
	//         "4": "even"
	//     },
	//     {
	//         "254": "even"
	//     }
	// ]

	fmt.Println("\n// JavaScript-like Array.map() in Slice of Maps")

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

	var productsLabeled []Any

	fmt.Println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

	productsLabeled = arrayMapV1(func(product Any, _ int, _ []Any) Any {
		var objectValue Any
		if product.(Object)["price"].(int) > 100 {
			objectValue = "expensive"
		} else {
			objectValue = "cheap"
		}
		return spreadSyntaxObject(product, Object{"label": objectValue})
	}, products)
	fmt.Println("labeled products:", prettyJsonStringify(productsLabeled))
	// labeled products: [
	//     {
	//         "code": "pasta",
	//         "price": 321,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "bubble_gum",
	//         "price": 233,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "potato_chips",
	//         "price": 5,
	//         "label": "cheap"
	//     },
	//     {
	//         "code": "towel",
	//         "price": 499,
	//         "label": "expensive"
	//     }
	// ]

	fmt.Println("// using JavaScript-like Array.map() function \"arrayMapV2\"")

	productsLabeled = arrayMapV2(func(product Any, _ int, _ []Any) Any {
		var objectValue Any
		if product.(Object)["price"].(int) > 100 {
			objectValue = "expensive"
		} else {
			objectValue = "cheap"
		}
		return spreadSyntaxObject(product, Object{"label": objectValue})
	}, products)
	fmt.Println("labeled products:", prettyJsonStringify(productsLabeled))
	// labeled products: [
	//     {
	//         "code": "pasta",
	//         "price": 321,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "bubble_gum",
	//         "price": 233,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "potato_chips",
	//         "price": 5,
	//         "label": "cheap"
	//     },
	//     {
	//         "code": "towel",
	//         "price": 499,
	//         "label": "expensive"
	//     }
	// ]
}
