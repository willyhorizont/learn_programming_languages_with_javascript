package main

import (
	"encoding/json"
	"fmt"
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
    sPrintln("numbers: ", jsonStringify(numbers, false))

    var numbersLabeled array

    fmt.Println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

    numbersLabeled = arrayMapV1(func(number any, _ int, _ array) any {
        if (number.(int)%2 == 0) {
            return object{
                jsonStringify(number, false): "even",
            }
        }
        return object{
            jsonStringify(number, false): "odd",
        }
    }, numbers)
    sPrintln("labeled numbers: ", jsonStringify(numbersLabeled, object{"pretty": true}))
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
                jsonStringify(number, false): "even",
            }
        }
        return object{
            jsonStringify(number, false): "odd",
        }
    }, numbers)
    sPrintln("labeled numbers: ", jsonStringify(numbersLabeled, object{"pretty": true}))
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
    sPrintln("products: ", jsonStringify(products, object{"pretty": true}))

    var productsLabeled array

    fmt.Println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

    productsLabeled = arrayMapV1(func(product any, _ int, _ array) any {
        if (product.(object)["price"].(int) > 100) {
            return spreadObject(product, object{"label": "expensive"})
        }
        return spreadObject(product, object{"label": "cheap"})
    }, products)
    sPrintln("labeled products: ", jsonStringify(productsLabeled, object{"pretty": true}))
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
            return spreadObject(product, object{"label": "expensive"})
        }
        return spreadObject(product, object{"label": "cheap"})
    }, products)
    sPrintln("labeled products: ", jsonStringify(productsLabeled, object{"pretty": true}))
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
