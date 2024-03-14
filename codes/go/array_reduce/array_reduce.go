package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"math"
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

func getFloatV1(anything any) (float64, error) {
    switch anythingNew := anything.(type) {
    case float64:
        return anythingNew, nil
    case float32:
        return float64(anythingNew), nil
    case int64:
        return float64(anythingNew), nil
    case int32: // rune
        return float64(anythingNew), nil
    case int16:
        return float64(anythingNew), nil
    case int8:
        return float64(anythingNew), nil
    case int:
        return float64(anythingNew), nil
    case uint64:
        return float64(anythingNew), nil
    case uint32:
        return float64(anythingNew), nil
    case uint16:
        return float64(anythingNew), nil
    case uint8: // byte
        return float64(anythingNew), nil
    case uint:
        return float64(anythingNew), nil
    case complex128:
        return real(anythingNew), nil
    case complex64:
        return float64(real(anythingNew)), nil
    default:
        return math.NaN(), errors.New("NON-NUMERIC TYPE COULD NOT BE CONVERTED TO FLOAT")
    }
}

func getFloatV2(anything any) (float64, error) {
    value := reflect.ValueOf(anything)
    value = reflect.Indirect(value)
    if (value.Type().ConvertibleTo(reflect.TypeOf(float64(0))) == false) {
        return math.NaN(), fmt.Errorf("CANNOT CONVERT %v TO FLOAT64", value.Type())
    }
    finalValue := value.Convert(reflect.TypeOf(float64(0)))
    return finalValue.Float(), nil
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

func spreadSyntaxArray(parameters ...any) array {
	var newArray = array{}
	for _, parameter := range parameters {
		parameterType := reflect.TypeOf(parameter).Kind()
		if (parameterType == reflect.Map) {
			if (len(parameter.(object)) == 1) {
				for _, objectValue := range parameter.(object) {
					newArray = append(newArray, objectValue)
				}
				continue
			}
			newArray = append(newArray, parameter)
			continue
		}
		if (parameterType == reflect.Slice) {
			newArray = append(newArray, parameter.(array)...)
			continue
		}
	}
	return newArray
}

func arrayReduce(callbackFunction func(any, any, int, array) any, anArray array, initialValue any) any {
	// JavaScript-like Array.reduce() function
	result := initialValue
	for arrayItemIndex, arrayItem := range anArray {
		result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
	}
	return result
}

func main() {
	fmt.Println("\n// JavaScript-like Array.reduce() in Go Slice")

	numbers := array{36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3}
	fmt.Println("numbers:", prettyArrayOfPrimitives(numbers))

	fmt.Println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

	numbersTotal := arrayReduce(func(currentResult any, currentNumber any, _ int, _ array) any {
		// currentResultF64, currentResultF64Error := getFloatV2(currentResult)
		// currentNumberF64, currentNumberF64Error := getFloatV2(currentNumber)
		currentResultF64, currentResultF64Error := getFloatV1(currentResult)
		currentNumberF64, currentNumberF64Error := getFloatV1(currentNumber)
		if (currentResultF64Error == nil && currentNumberF64Error == nil) {
			return (currentResultF64 + currentNumberF64)
		}
		return currentResult
	}, numbers, 0.0)
	fmt.Println("total number:", prettyJsonStringify(numbersTotal))
	// total number: 41.2

	fmt.Println("\n// JavaScript-like Array.reduce() in Slice of Maps")

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

	fmt.Println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

	productsGrouped := arrayReduce(func(currentResult any, currentProduct any, _ int, _ array) any {
		if (currentProduct.(object)["price"].(int) > 100) {
			return spreadSyntaxObject(currentResult, object{"expensive": spreadSyntaxArray(currentResult.(object)["expensive"], object{"currentProduct": currentProduct})})
		}
		return spreadSyntaxObject(currentResult, object{"cheap": spreadSyntaxArray(currentResult.(object)["cheap"], object{"currentProduct": currentProduct})})
	}, products, object{"expensive": array{}, "cheap": array{}})
	fmt.Println("grouped products:", prettyJsonStringify(productsGrouped))
	// grouped products: {
	// 	"expensive": [
	// 		{
	// 			"code": "pasta",
	// 			"price": 321
	// 		},
	// 		{
	// 			"code": "bubble_gum",
	// 			"price": 233
	// 		},
	// 		{
	// 			"code": "towel",
	// 			"price": 499
	// 		}
	// 	],
	// 	"cheap": [
	// 		{
	// 			"code": "potato_chips",
	// 			"price": 5
	// 		}
	// 	]
	// }
}
