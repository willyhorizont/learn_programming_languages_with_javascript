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

func arrayEveryV1(callbackFunction func(any, int, array) bool, anArray array) bool {
    // JavaScript-like Array.every() function
    isConditionMatch := false
    for arrayItemIndex, arrayItem := range anArray {
        isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == false) {
            break
        }
    }
    return isConditionMatch
}

func arrayEveryV2(callbackFunction func(any, int, array) bool, anArray array) bool {
    // JavaScript-like Array.every() function
    isConditionMatch := false
    for arrayItemIndex, arrayItem := range anArray {
        isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == false) {
            return isConditionMatch
        }
    }
    return isConditionMatch
}

func arrayEveryV3(callbackFunction func(any, int, array) bool, anArray array) bool {
    // JavaScript-like Array.every() function
    for arrayItemIndex, arrayItem := range anArray {
        isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == false) {
            return false
        }
    }
    return true
}

func arrayEveryV4(callbackFunction func(any, int, array) bool, anArray array) bool {
    // JavaScript-like Array.every() function
    for arrayItemIndex, arrayItem := range anArray {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == false) {
            return false
        }
    }
    return true
}

func main() {
    fmt.Println("\n// JavaScript-like Array.every() in Go Slice")

    numbers := array{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
    sprint("numbers: ", jsonStringify(numbers))

    var isAllNumberLessThan500 bool
    var isAllNumberMoreThan500 bool

    fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

    isAllNumberLessThan500 = arrayEveryV1(func(number any, _ int, _ array) bool {
        return (number.(int) < 500)
    }, numbers)
    sprint("is all number < 500: ", jsonStringify(isAllNumberLessThan500))
    // is all number < 500: true

    isAllNumberMoreThan500 = arrayEveryV1(func(number any, _ int, _ array) bool {
        return (number.(int) > 500)
    }, numbers)
    sprint("is all number > 500: ", jsonStringify(isAllNumberMoreThan500))
    // is all number > 500: false

    fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

    isAllNumberLessThan500 = arrayEveryV2(func(number any, _ int, _ array) bool {
        return (number.(int) < 500)
    }, numbers)
    sprint("is all number < 500: ", jsonStringify(isAllNumberLessThan500))
    // is all number < 500: true

    isAllNumberMoreThan500 = arrayEveryV2(func(number any, _ int, _ array) bool {
        return (number.(int) > 500)
    }, numbers)
    sprint("is all number > 500: ", jsonStringify(isAllNumberMoreThan500))
    // is all number > 500: false

    fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

    isAllNumberLessThan500 = arrayEveryV3(func(number any, _ int, _ array) bool {
        return (number.(int) < 500)
    }, numbers)
    sprint("is all number < 500: ", jsonStringify(isAllNumberLessThan500))
    // is all number < 500: true

    isAllNumberMoreThan500 = arrayEveryV3(func(number any, _ int, _ array) bool {
        return (number.(int) > 500)
    }, numbers)
    sprint("is all number > 500: ", jsonStringify(isAllNumberMoreThan500))
    // is all number > 500: false

    fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV4\"")

    isAllNumberLessThan500 = arrayEveryV4(func(number any, _ int, _ array) bool {
        return (number.(int) < 500)
    }, numbers)
    sprint("is all number < 500: ", jsonStringify(isAllNumberLessThan500))
    // is all number < 500: true

    isAllNumberMoreThan500 = arrayEveryV4(func(number any, _ int, _ array) bool {
        return (number.(int) > 500)
    }, numbers)
    sprint("is all number > 500: ", jsonStringify(isAllNumberMoreThan500))
    // is all number > 500: false

    fmt.Println("\n// JavaScript-like Array.every() in Go Slice of maps")

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

    var isAllProductPriceLessThan500 bool
    var isAllProductPriceMoreThan500 bool

    fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

    isAllProductPriceLessThan500 = arrayEveryV1(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) < 500)
    }, products)
    sprint("is all product price < 500: ", jsonStringify(isAllProductPriceLessThan500))
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = arrayEveryV1(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 500)
    }, products)
    sprint("is all product price > 500: ", jsonStringify(isAllProductPriceMoreThan500))
    // is all product price > 500: false

    fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

    isAllProductPriceLessThan500 = arrayEveryV2(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) < 500)
    }, products)
    sprint("is all product price < 500: ", jsonStringify(isAllProductPriceLessThan500))
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = arrayEveryV2(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 500)
    }, products)
    sprint("is all product price > 500: ", jsonStringify(isAllProductPriceMoreThan500))
    // is all product price > 500: false

    fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

    isAllProductPriceLessThan500 = arrayEveryV3(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) < 500)
    }, products)
    sprint("is all product price < 500: ", jsonStringify(isAllProductPriceLessThan500))
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = arrayEveryV3(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 500)
    }, products)
    sprint("is all product price > 500: ", jsonStringify(isAllProductPriceMoreThan500))
    // is all product price > 500: false

    fmt.Println("// using JavaScript-like Array.every() function \"arrayEveryV4\"")

    isAllProductPriceLessThan500 = arrayEveryV4(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) < 500)
    }, products)
    sprint("is all product price < 500: ", jsonStringify(isAllProductPriceLessThan500))
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = arrayEveryV4(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 500)
    }, products)
    sprint("is all product price > 500: ", jsonStringify(isAllProductPriceMoreThan500))
    // is all product price > 500: false
}
