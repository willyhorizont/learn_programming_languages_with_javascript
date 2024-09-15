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

func arrayFindV1(callbackFunction func(any, int, array) bool, anArray array) any {
    // JavaScript-like Array.find() function
    var dataFound any
    for arrayItemIndex, arrayItem := range anArray {
        isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            dataFound = arrayItem
            break
        }
    }
    return dataFound
}

func arrayFindV2(callbackFunction func(any, int, array) bool, anArray array) any {
    // JavaScript-like Array.find() function
    var dataFound any
    for arrayItemIndex, arrayItem := range anArray {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
            dataFound = arrayItem
            break
        }
    }
    return dataFound
}

func arrayFindV3(callbackFunction func(any, int, array) bool, anArray array) any {
    // JavaScript-like Array.find() function
    for arrayItemIndex, arrayItem := range anArray {
        isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            return arrayItem
        }
    }
    return nil
}

func arrayFindV4(callbackFunction func(any, int, array) bool, anArray array) any {
    // JavaScript-like Array.find() function
    for arrayItemIndex, arrayItem := range anArray {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
            return arrayItem
        }
    }
    return nil
}

func main() {
    fmt.Println("\n// JavaScript-like Array.find() in Go Slice")

    numbers := array{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
    sprint("numbers: ", jsonStringify(numbers))

    var evenNumberFound any
    var oddNumberFound any

    fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV1\"")

    evenNumberFound = arrayFindV1(func(number any, _ int, _ array) bool {
        return ((number.(int) % 2) == 0)
    }, numbers)
    sprint("even number found: ", evenNumberFound)
    // even number found: 12

    oddNumberFound = arrayFindV1(func(number any, _ int, _ array) bool {
        return ((number.(int) % 2) != 0)
    }, numbers)
    sprint("odd number found: ", oddNumberFound)
    // odd number found: 27

    fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV2\"")

    evenNumberFound = arrayFindV2(func(number any, _ int, _ array) bool {
        return ((number.(int) % 2) == 0)
    }, numbers)
    sprint("even number found: ", evenNumberFound)
    // even number found: 12

    oddNumberFound = arrayFindV2(func(number any, _ int, _ array) bool {
        return ((number.(int) % 2) != 0)
    }, numbers)
    sprint("odd number found: ", oddNumberFound)
    // odd number found: 27

    fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV3\"")

    evenNumberFound = arrayFindV3(func(number any, _ int, _ array) bool {
        return ((number.(int) % 2) == 0)
    }, numbers)
    sprint("even number found: ", evenNumberFound)
    // even number found: 12

    oddNumberFound = arrayFindV3(func(number any, _ int, _ array) bool {
        return ((number.(int) % 2) != 0)
    }, numbers)
    sprint("odd number found: ", oddNumberFound)
    // odd number found: 27

    fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV4\"")

    evenNumberFound = arrayFindV4(func(number any, _ int, _ array) bool {
        return ((number.(int) % 2) == 0)
    }, numbers)
    sprint("even number found: ", evenNumberFound)
    // even number found: 12

    oddNumberFound = arrayFindV4(func(number any, _ int, _ array) bool {
        return ((number.(int) % 2) != 0)
    }, numbers)
    sprint("odd number found: ", oddNumberFound)
    // odd number found: 27

    fmt.Println("\n// JavaScript-like Array.find() in Go Slice of maps")

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

    productToFind := "bubble_gum"
    sprint("product to find: ", productToFind)

    var productFound any

    fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV1\"")

    productFound = arrayFindV1(func(product any, _ int, _ array) bool {
        return (product.(object)["code"] == productToFind)
    }, products)
    sprint("product found: ", jsonStringify(productFound, object{"pretty": true}))
    // product found: {
    //     "code":"bubble_gum",
    //     "price": 233
    // }

    fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV2\"")

    productFound = arrayFindV2(func(product any, _ int, _ array) bool {
        return (product.(object)["code"] == productToFind)
    }, products)
    sprint("product found: ", jsonStringify(productFound, object{"pretty": true}))
    // product found: {
    //     "code":"bubble_gum",
    //     "price": 233
    // }

    fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV3\"")

    productFound = arrayFindV3(func(product any, _ int, _ array) bool {
        return (product.(object)["code"] == productToFind)
    }, products)
    sprint("product found: ", jsonStringify(productFound, object{"pretty": true}))
    // product found: {
    //     "code":"bubble_gum",
    //     "price": 233
    // }

    fmt.Println("// using JavaScript-like Array.find() function \"arrayFindV4\"")

    productFound = arrayFindV4(func(product any, _ int, _ array) bool {
        return (product.(object)["code"] == productToFind)
    }, products)
    sprint("product found: ", jsonStringify(productFound, object{"pretty": true}))
    // product found: {
    //     "code":"bubble_gum",
    //     "price": 233
    // }
}
