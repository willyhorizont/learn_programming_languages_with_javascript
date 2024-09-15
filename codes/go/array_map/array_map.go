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

func ternary(trueCondition bool, callbackFunctionIfConditionTrue func() any, callbackFunctionIfConditionFalse func() any) any {
    if (trueCondition == true) {
        return callbackFunctionIfConditionTrue()
    }
    return callbackFunctionIfConditionFalse()
}

func jsonStringify(restArguments ...any) string {
	jsonStringifyInner := func(anythingInner any, prettyInner bool, indentInner string) string {
		if (prettyInner == true) {
			jsonStringifyInnerResult, err := json.MarshalIndent(anythingInner, "", indentInner)
			if (err == nil) {
				return string(jsonStringifyInnerResult)
			}
			return "null"
		}
        jsonStringifyInnerResult, err := json.Marshal(anythingInner)
		if (err == nil) {
			return strings.ReplaceAll(string(jsonStringifyInnerResult), ",", ", ")
		}
		return "null"
    }
    var anything any = restArguments[0]
	prettyDefault := false
	indentDefault := "    "
	var pretty any = prettyDefault
	var indent any = indentDefault
	if (len(restArguments) == 1) {
		return jsonStringifyInner(anything, prettyDefault, indentDefault)
	}
	var optionalArgument any = restArguments[1]
	if (optionalArgument == false) {
		return jsonStringifyInner(anything, prettyDefault, indentDefault)
	}
	if (reflect.TypeOf(optionalArgument).Kind() == reflect.Map) {
		pretty = optionalChaining(optionalArgument, "pretty")
		indent = optionalChaining(optionalArgument, "indent")
		pretty = ternary((pretty == nil), func() any { return prettyDefault }, func() any { return pretty })
		indent = ternary((indent == nil), func() any { return indentDefault }, func() any { return indent })
		return jsonStringifyInner(anything, pretty.(bool), indent.(string))
	}
	if (optionalArgument == true) {
		if (len(restArguments) >= 3) {
			var additionalArgument2 any = restArguments[2]
			if (reflect.TypeOf(additionalArgument2).Kind() == reflect.String) {
				indent = additionalArgument2
			}
		}
		pretty = optionalArgument
		return jsonStringifyInner(anything, pretty.(bool), indent.(string))
	}
	return jsonStringifyInner(anything, prettyDefault, indentDefault)
}

func sprint(restArguments ...any) {
    var newArray = []string{}
    for _, argument := range restArguments {
        argumentType := reflect.TypeOf(argument).Kind()
        if (argumentType == reflect.Slice && (len(argument.(array)) == 1)) {
            newArray = append(newArray, jsonStringify(argument.(array)[0]))
            continue
        }
        if (argumentType == reflect.String) {
			newArray = append(newArray, argument.(string))
            continue
        }
    }
    fmt.Println(strings.Join(newArray, ""))
}

func spreadObject(restArguments ...any) object {
    var newObject = make(object)
    for _, argument := range restArguments {
        argumentType := reflect.TypeOf(argument).Kind()
        if (argumentType == reflect.Map) {
            for objectKey, objectValue := range argument.(object) {
                newObject[objectKey] = objectValue
            }
			continue
        }
        if (argumentType == reflect.Slice) {
            for arrayItemIndex, arrayItem := range argument.(array) {
                newObject[jsonStringify(arrayItemIndex)] = arrayItem
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
    sprint("numbers: ", jsonStringify(numbers))

    var numbersLabeled array

    fmt.Println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

    numbersLabeled = arrayMapV1(func(number any, _ int, _ array) any {
        if (number.(int)%2 == 0) {
            return object{
                jsonStringify(number): "even",
            }
        }
        return object{
            jsonStringify(number): "odd",
        }
    }, numbers)
    sprint("labeled numbers: ", jsonStringify(numbersLabeled, object{"pretty": true}))
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
                jsonStringify(number): "even",
            }
        }
        return object{
            jsonStringify(number): "odd",
        }
    }, numbers)
    sprint("labeled numbers: ", jsonStringify(numbersLabeled, object{"pretty": true}))
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
    sprint("products: ", jsonStringify(products, object{"pretty": true}))

    var productsLabeled array

    fmt.Println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

    productsLabeled = arrayMapV1(func(product any, _ int, _ array) any {
        if (product.(object)["price"].(int) > 100) {
            return spreadObject(product, object{"label": "expensive"})
        }
        return spreadObject(product, object{"label": "cheap"})
    }, products)
    sprint("labeled products: ", jsonStringify(productsLabeled, object{"pretty": true}))
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
    sprint("labeled products: ", jsonStringify(productsLabeled, object{"pretty": true}))
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
