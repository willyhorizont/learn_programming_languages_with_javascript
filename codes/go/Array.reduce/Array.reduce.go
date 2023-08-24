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

func spreadSyntaxObject(args ...Any) Object {
	var newObject = make(Object)
	for _, arg := range args {
		argType := reflect.TypeOf(arg).Kind()
		if argType == reflect.Map {
			for objectKey, objectValue := range arg.(Object) {
				newObject[objectKey] = objectValue
			}
		}
		if argType == reflect.Slice {
			for arrayItemIndex, arrayItem := range arg.([]Any) {
				newObject[prettyJsonStringify(arrayItemIndex)] = arrayItem
			}
		}
	}
	return newObject
}

func spreadSyntaxArray(arrayOfArray ...[]Any) []Any {
	var newArray = []Any{}
	for _, arrayOfArrayItem := range arrayOfArray {
		newArray = append(newArray, arrayOfArrayItem...)
	}
	return newArray
}

func arrayReduce(callbackFunction func(Any, Any, int, []Any) Any, anArray []Any, initialValue Any) Any {
	// JavaScript-like Array.reduce() function
	var result Any
	for arrayItemIndex, arrayItem := range anArray {
		if result == nil {
			result = initialValue
		}
		initialValueType := reflect.TypeOf(initialValue).Kind()
		if initialValueType == reflect.Array {
			if result == nil {
				result = []Any{}
			}
			result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
			continue
		}
		if initialValueType == reflect.Map {
			if result == nil {
				result = Object{}
			}
			result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
			continue
		}
		if initialValueType == reflect.Int || initialValueType == reflect.Int8 || initialValueType == reflect.Int16 || initialValueType == reflect.Int32 || initialValueType == reflect.Int64 || initialValueType == reflect.Float32 || initialValueType == reflect.Float64 {
			if result == nil {
				result = 0
			}
			result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
			continue
		}
		if initialValueType == reflect.String {
			if result == nil {
				result = ""
			}
			result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
			continue
		}
		if initialValueType == reflect.Bool {
			if result == nil {
				result = false
			}
			result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
			continue
		}
		if initialValue == nil {
			if result == nil {
				result = nil
			}
			result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
			continue
		}
	}
	return result
}

func main() {
	fmt.Println("\n// JavaScript-like Array.reduce() in GO Slice")

	numbers := []Any{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettySliceOfPrimitives(numbers))

	fmt.Println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

	totalNumber := arrayReduce(func(currentTotalNumber Any, currentNumber Any, _ int, _ []Any) Any {
		return currentTotalNumber.(int) + currentNumber.(int)
	}, numbers, 0)
	fmt.Println("labeled numbers: ", prettyJsonStringify(totalNumber))
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

	labeledProducts := arrayReduce(func(currentGroupedProducts Any, currentProduct Any, _ int, _ []Any) Any {
		if currentProduct.(Object)["price"].(int) > 100 {
			return spreadSyntaxObject(currentGroupedProducts, Object{"expensive": spreadSyntaxObject(currentGroupedProducts.(Object)["expensive"], currentProduct)})
		}
		return spreadSyntaxObject(currentGroupedProducts, Object{"cheap": spreadSyntaxObject(currentGroupedProducts.(Object)["cheap"], currentProduct)})
	}, products, Object{"expensive": Object{}, "cheap": Object{}})
	fmt.Println("labeled products:", prettyJsonStringify(labeledProducts))
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
