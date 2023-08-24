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
	fmt.Println("\n// JavaScript-like Array.map() in GO Slice")

	numbers := []Any{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettySliceOfPrimitives(numbers))

	var labeledNumbers []Any

	fmt.Println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

	labeledNumbers = arrayMapV1(func(number Any, _ int, _ []Any) Any {
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
	fmt.Println("labeled numbers: ", prettyJsonStringify(labeledNumbers))
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

	labeledNumbers = arrayMapV2(func(number Any, _ int, _ []Any) Any {
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
	fmt.Println("labeled numbers: ", prettyJsonStringify(labeledNumbers))
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

	var labeledProducts []Any

	fmt.Println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

	labeledProducts = arrayMapV1(func(product Any, _ int, _ []Any) Any {
		var objectValue Any
		if product.(Object)["price"].(int) > 100 {
			objectValue = "expensive"
		} else {
			objectValue = "cheap"
		}
		return spreadSyntaxObject(product, Object{"label": objectValue})
	}, products)
	fmt.Println("labeled products:", prettyJsonStringify(labeledProducts))
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

	labeledProducts = arrayMapV2(func(product Any, _ int, _ []Any) Any {
		var objectValue Any
		if product.(Object)["price"].(int) > 100 {
			objectValue = "expensive"
		} else {
			objectValue = "cheap"
		}
		return spreadSyntaxObject(product, Object{"label": objectValue})
	}, products)
	fmt.Println("labeled products:", prettyJsonStringify(labeledProducts))
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
