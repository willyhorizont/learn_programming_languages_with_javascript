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
				if (arrayItem.(bool) == true) {
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

func spreadSyntaxObject(parameters ...any) object {
	var newObject = make(object)
	for _, parameter := range parameters {
		parameterType := reflect.TypeOf(parameter).Kind()
		if (parameterType == reflect.Map) {
			for objectKey, objectValue := range parameter.(object) {
				newObject[objectKey] = objectValue
			}
		}
		if (parameterType == reflect.Slice) {
			for arrayItemIndex, arrayItem := range parameter.(array) {
				newObject[prettyJsonStringify(arrayItemIndex)] = arrayItem
			}
		}
	}
	return newObject
}

func arrayMapV1(callbackFunction func(any, int, array) any, anArray array) array {
	// JavaScript-like Array.map() function
	newArray := array{}
	for arrayItemIndex, arrayItem := range anArray {
		newArrayItem := callbackFunction(arrayItem, arrayItemIndex, anArray)
		newArray = append(newArray, newArrayItem)
	}
	return newArray
}

func arrayMapV2(callbackFunction func(any, int, array) any, anArray array) array {
	// JavaScript-like Array.map() function
	newArray := array{}
	for arrayItemIndex, arrayItem := range anArray {
		newArray = append(newArray, callbackFunction(arrayItem, arrayItemIndex, anArray))
	}
	return newArray
}

func main() {
	fmt.Println("\n// JavaScript-like Array.map() in Go Slice")

	numbers := array{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
	fmt.Println("numbers:", prettyArrayOfPrimitives(numbers))

	var numbersLabeled array

	fmt.Println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

	numbersLabeled = arrayMapV1(func(number any, _ int, _ array) any {
		if (number.(int)%2 == 0) {
			return object{
				prettyJsonStringify(number): "even",
			}
		}
		return object{
			prettyJsonStringify(number): "odd",
		}
	}, numbers)
	fmt.Println("labeled numbers:", prettyJsonStringify(numbersLabeled))
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

	numbersLabeled = arrayMapV2(func(number any, _ int, _ array) any {
		if (number.(int)%2 == 0) {
			return object{
				prettyJsonStringify(number): "even",
			}
		}
		return object{
			prettyJsonStringify(number): "odd",
		}
	}, numbers)
	fmt.Println("labeled numbers:", prettyJsonStringify(numbersLabeled))
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

	fmt.Println("\n// JavaScript-like Array.map() in Go Slice of maps")

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
	fmt.Println("products:", prettyJsonStringify(products))

	var productsLabeled array

	fmt.Println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

	productsLabeled = arrayMapV1(func(product any, _ int, _ array) any {
		if (product.(object)["price"].(int) > 100) {
			return spreadSyntaxObject(product, object{"label": "expensive"})
		}
		return spreadSyntaxObject(product, object{"label": "cheap"})
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

	productsLabeled = arrayMapV2(func(product any, _ int, _ array) any {
		if (product.(object)["price"].(int) > 100) {
			return spreadSyntaxObject(product, object{"label": "expensive"})
		}
		return spreadSyntaxObject(product, object{"label": "cheap"})
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
