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

func arraySomeV1(callbackFunction func(any, int, array) bool, anArray array) bool {
    // JavaScript-like Array.some() function
    isConditionMatch := false
    for arrayItemIndex, arrayItem := range anArray {
        isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            break
        }
    }
    return isConditionMatch
}

func arraySomeV2(callbackFunction func(any, int, array) bool, anArray array) bool {
    // JavaScript-like Array.some() function
    isConditionMatch := false
    for arrayItemIndex, arrayItem := range anArray {
        isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            return isConditionMatch
        }
    }
    return isConditionMatch
}

func arraySomeV3(callbackFunction func(any, int, array) bool, anArray array) bool {
    // JavaScript-like Array.some() function
    for arrayItemIndex, arrayItem := range anArray {
        isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            return true
        }
    }
    return false
}

func arraySomeV4(callbackFunction func(any, int, array) bool, anArray array) bool {
    // JavaScript-like Array.some() function arraySomeV4
    for arrayItemIndex, arrayItem := range anArray {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
            return true
        }
    }
    return false
}

func main() {
    fmt.Println("\n// JavaScript-like Array.some() in Go Slice")

    numbers := array{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
    sprint("numbers: ", jsonStringify(numbers))

    var isAnyNumberLessThan500 bool
    var isAnyNumberMoreThan500 bool

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV1\"")

    isAnyNumberLessThan500 = arraySomeV1(func(number any, _ int, _ array) bool {
        return (number.(int) < 500)
    }, numbers)
    sprint("is any number < 500: ", array{isAnyNumberLessThan500})
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV1(func(number any, _ int, _ array) bool {
        return (number.(int) > 500)
    }, numbers)
    sprint("is any number > 500: ", array{isAnyNumberMoreThan500})
    // is any number > 500: false

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV2\"")

    isAnyNumberLessThan500 = arraySomeV2(func(number any, _ int, _ array) bool {
        return (number.(int) < 500)
    }, numbers)
    sprint("is any number < 500: ", array{isAnyNumberLessThan500})
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV2(func(number any, _ int, _ array) bool {
        return (number.(int) > 500)
    }, numbers)
    sprint("is any number > 500: ", array{isAnyNumberMoreThan500})
    // is any number > 500: false

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV3\"")

    isAnyNumberLessThan500 = arraySomeV3(func(number any, _ int, _ array) bool {
        return (number.(int) < 500)
    }, numbers)
    sprint("is any number < 500: ", array{isAnyNumberLessThan500})
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV3(func(number any, _ int, _ array) bool {
        return (number.(int) > 500)
    }, numbers)
    sprint("is any number > 500: ", array{isAnyNumberMoreThan500})
    // is any number > 500: false

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV4\"")

    isAnyNumberLessThan500 = arraySomeV4(func(number any, _ int, _ array) bool {
        return (number.(int) < 500)
    }, numbers)
    sprint("is any number < 500: ", array{isAnyNumberLessThan500})
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV4(func(number any, _ int, _ array) bool {
        return (number.(int) > 500)
    }, numbers)
    sprint("is any number > 500: ", array{isAnyNumberMoreThan500})
    // is any number > 500: false

    fmt.Println("\n// JavaScript-like Array.some() in Go Slice of maps")

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

    var isAnyProductPriceLessThan500 bool
    var isAnyProductPriceMoreThan500 bool

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV1\"")

    isAnyProductPriceLessThan500 = arraySomeV1(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) < 500)
    }, products)
    sprint("is any product price < 500: ", array{isAnyProductPriceLessThan500})
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV1(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 500)
    }, products)
    sprint("is any product price > 500: ", array{isAnyProductPriceMoreThan500})
    // is any product price > 500: false

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV2\"")

    isAnyProductPriceLessThan500 = arraySomeV2(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) < 500)
    }, products)
    sprint("is any product price < 500: ", array{isAnyProductPriceLessThan500})
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV2(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 500)
    }, products)
    sprint("is any product price > 500: ", array{isAnyProductPriceMoreThan500})
    // is any product price > 500: false

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV3\"")

    isAnyProductPriceLessThan500 = arraySomeV3(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) < 500)
    }, products)
    sprint("is any product price < 500: ", array{isAnyProductPriceLessThan500})
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV3(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 500)
    }, products)
    sprint("is any product price > 500: ", array{isAnyProductPriceMoreThan500})
    // is any product price > 500: false

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV4\"")

    isAnyProductPriceLessThan500 = arraySomeV4(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) < 500)
    }, products)
    sprint("is any product price < 500: ", array{isAnyProductPriceLessThan500})
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV4(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 500)
    }, products)
    sprint("is any product price > 500: ", array{isAnyProductPriceMoreThan500})
    // is any product price > 500: false
}
