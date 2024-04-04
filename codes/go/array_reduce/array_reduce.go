package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"math"
	"reflect"
	"strings"
)

// type any interface{}
type array []any
type object map[string]any

func arrayReduce(callbackFunction func(any, any, int, array) any, anArray array, initialValue any) any {
    // JavaScript-like Array.reduce() function
    result := initialValue
    for arrayItemIndex, arrayItem := range anArray {
        result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
    }
    return result
}

func optionalChaining(anything any, objectPropertiesArray ...any) any {
    anythingType := reflect.TypeOf(anything).Kind()
    if (((anythingType != reflect.Map) && (anythingType != reflect.Slice)) || (len(objectPropertiesArray) == 0)) {
        return anything
    }
    return arrayReduce(func(currentResult any, currentItem any, _ int, _ array) any {
        if (currentResult == nil && (anythingType == reflect.Map) && (reflect.TypeOf(currentItem).Kind() == reflect.String)) {
            return anything.(object)[currentItem.(string)]
        }
        if (currentResult == nil && (anythingType == reflect.Slice) && (reflect.TypeOf(currentItem).Kind() == reflect.Int) && (currentItem.(int) >= 0) && (len(anything.(array)) > currentItem.(int))) {
            return anything.(array)[currentItem.(int)]
        }
        if (reflect.TypeOf(currentResult).Kind() == reflect.Map && (reflect.TypeOf(currentItem).Kind() == reflect.String)) {
            return currentResult.(object)[currentItem.(string)]
        }
        if ((reflect.TypeOf(currentResult).Kind() == reflect.Slice) && (reflect.TypeOf(currentItem).Kind() == reflect.Int) && (currentItem.(int) >= 0) && (len(currentResult.(array)) > currentItem.(int))) {
            return currentResult.(array)[currentItem.(int)]
        }
        return nil
    }, objectPropertiesArray, nil)
}

func jsonStringify(anything any, additionalParameter any) string {
	jsonStringifyDefault := func(anythingInner any) string {
        jsonMarshalled, err := json.Marshal(anythingInner)
		if (err == nil) {
			return strings.ReplaceAll(string(jsonMarshalled), ",", ", ")
		}
		return "null"
    }
	jsonStringifyPrettyDefault := func(anythingInner any, indentInner string) string {
        jsonMarshalled, err := json.MarshalIndent(anythingInner, "", indentInner)
		if (err == nil) {
			return string(jsonMarshalled)
		}
		return "null"
    }
	if (additionalParameter == nil || additionalParameter == false) {
		return jsonStringifyDefault(anything)
	}
	if (additionalParameter == true) {
		return jsonStringifyPrettyDefault(anything, "    ")
	}
	if (reflect.TypeOf(additionalParameter).Kind() == reflect.Map) {
		var pretty any = optionalChaining(additionalParameter, "pretty")
		var indent any = optionalChaining(additionalParameter, "indent")
		if (pretty == true) {
			if (indent == nil) {
				indent = "    "
			}
			return jsonStringifyPrettyDefault(anything, indent.(string))
		}
		return jsonStringifyDefault(anything)
	}
	return jsonStringifyDefault(anything)
}

func sPrintln(parameters ...any) {
    var parametersNew = []string{}
    for _, parameter := range parameters {
        parameterType := reflect.TypeOf(parameter).Kind()
        if (parameterType == reflect.Slice && (len(parameter.(array)) == 1)) {
            parametersNew = append(parametersNew, jsonStringify(parameter.(array)[0], false))
            continue
        }
        if (parameterType == reflect.String) {
			parametersNew = append(parametersNew, parameter.(string))
            continue
        }
    }
    fmt.Println(strings.Join(parametersNew, ""))
}

func getFloat(anything any) (float64, error) {
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

func spreadObject(parameters ...any) object {
    var newObject = make(object)
    for _, parameter := range parameters {
        parameterType := reflect.TypeOf(parameter).Kind()
        if (parameterType == reflect.Map) {
            for objectKey, objectValue := range parameter.(object) {
                newObject[objectKey] = objectValue
            }
			continue
        }
        if (parameterType == reflect.Slice) {
            for arrayItemIndex, arrayItem := range parameter.(array) {
                newObject[jsonStringify(arrayItemIndex, false)] = arrayItem
            }
			continue
        }
    }
    return newObject
}

func spreadArray(parameters ...any) array {
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

func main() {
    fmt.Println("\n// JavaScript-like Array.reduce() in Go Slice")

    numbers := array{36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3}
    sPrintln("numbers: ", jsonStringify(numbers, false))

    fmt.Println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

    numbersTotal := arrayReduce(func(currentResult any, currentNumber any, _ int, _ array) any {
        currentResultF64, currentResultF64Error := getFloat(currentResult)
        currentNumberF64, currentNumberF64Error := getFloat(currentNumber)
        if (currentResultF64Error == nil && currentNumberF64Error == nil) {
            return (currentResultF64 + currentNumberF64)
        }
        return currentResult
    }, numbers, 0.0)
    sPrintln("total number: ", array{numbersTotal})
    // total number: 41.2

    fmt.Println("\n// JavaScript-like Array.reduce() in Go Slice of maps")

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
    sPrintln("products: ", jsonStringify(products, object{"pretty": true}))

    fmt.Println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

    productsGrouped := arrayReduce(func(currentResult any, currentProduct any, _ int, _ array) any {
        if (currentProduct.(object)["price"].(int) > 100) {
            return spreadObject(currentResult, object{"expensive": spreadArray(currentResult.(object)["expensive"], object{"currentProduct": currentProduct})})
        }
        return spreadObject(currentResult, object{"cheap": spreadArray(currentResult.(object)["cheap"], object{"currentProduct": currentProduct})})
    }, products, object{"expensive": array{}, "cheap": array{}})
    sPrintln("grouped products: ", jsonStringify(productsGrouped, object{"pretty": true}))
    // grouped products: {
    //     "expensive": [
    //         {
    //             "code": "pasta",
    //             "price": 321
    //         },
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
    //             "code": "potato_chips",
    //             "price": 5
    //         }
    //     ]
    // }
}
