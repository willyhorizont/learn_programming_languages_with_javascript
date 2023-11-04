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

func prettyJsonStringify(anythingLikeJson Any) string {
	marshalledJson, err := json.MarshalIndent(anythingLikeJson, EMPTY_STRING, TAB)
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

func arrayReduce(callbackFunction func(Any, Any, int, []Any) Any, anArray []Any, initialValue Any) Any {
	// JavaScript-like Array.reduce() function
	var result Any
	for arrayItemIndex, arrayItem := range anArray {
		if arrayItemIndex == 0 {
			result = callbackFunction(initialValue, arrayItem, arrayItemIndex, anArray)
		} else {
			result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
		}
	}
	return result
}

func main() {
	fmt.Println("\n// JavaScript-like Array.reduce() in Go Slice")

	numbers := []Any{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettyArrayOfPrimitives(numbers))

	fmt.Println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

	numbersTotal := arrayReduce(func(currentResult Any, currentNumber Any, _ int, _ []Any) Any {
		return currentResult.(int) + currentNumber.(int)
	}, numbers, 0)
	fmt.Println("total numbers: ", prettyJsonStringify(numbersTotal))
	// total number: 635

	fmt.Println("\n// JavaScript-like Array.reduce() in Slice of Maps")

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

	fmt.Println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

	productsGrouped := arrayReduce(func(currentResult Any, currentProduct Any, _ int, _ []Any) Any {
		if currentProduct.(Object)["price"].(int) > 100 {
			return spreadSyntaxObject(currentResult, Object{"expensive": spreadSyntaxObject(currentResult.(Object)["expensive"], currentProduct)})
		}
		return spreadSyntaxObject(currentResult, Object{"cheap": spreadSyntaxObject(currentResult.(Object)["cheap"], currentProduct)})
	}, products, Object{"expensive": Object{}, "cheap": Object{}})
	fmt.Println("grouped products:", prettyJsonStringify(productsGrouped))
	// grouped products: {
	//     "expensive": [
	//         {
	//             "code": "bubble_gum",
	//             "price": 233
	//         },
	//         {
	//             "code": "towel",
	//             "price": 499
	//         }
	//     ],
	//     "cheap": [
	//         {
	//             "code": "pasta",
	//             "price": 30
	//         },
	//         {
	//             "code": "potato_chips",
	//             "price": 5
	//         }
	//     ]
	// }
}
