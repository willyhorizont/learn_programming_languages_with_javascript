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

func arrayFilterV1(callbackFunction func(any, int, array) bool, anArray array) array {
    // JavaScript-like Array.filter() function
    dataFiltered := array{}
    for arrayItemIndex, arrayItem := range anArray {
        isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            dataFiltered = append(dataFiltered, arrayItem)
        }
    }
    return dataFiltered
}

func arrayFilterV2(callbackFunction func(any, int, array) bool, anArray array) array {
    // JavaScript-like Array.filter() function
    dataFiltered := array{}
    for arrayItemIndex, arrayItem := range anArray {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
            dataFiltered = append(dataFiltered, arrayItem)
        }
    }
    return dataFiltered
}

func main() {
    fmt.Println("\n// JavaScript-like Array.filter() in Go Slice")

    numbers := array{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
    sPrintln("numbers: ", jsonStringify(numbers, false))

    var numbersEven array
    var numbersOdd array

    fmt.Println("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

    numbersEven = arrayFilterV1(func(number any, _ int, _ array) bool {
        return ((number.(int) % 2) == 0)
    }, numbers)
    sPrintln("even numbers only: ", jsonStringify(numbersEven, false))
    // even numbers only: [12, 34, 36, 4, 254]

    numbersOdd = arrayFilterV1(func(number any, _ int, _ array) bool {
        return ((number.(int) % 2) != 0)
    }, numbers)
    sPrintln("odd numbers only: ", jsonStringify(numbersOdd, false))
    // odd numbers only: [27, 23, 65, 93, 87]

    fmt.Println("// using JavaScript-like Array.filter() function \"arrayFilterV2\"")

    numbersEven = arrayFilterV2(func(number any, _ int, _ array) bool {
        return ((number.(int) % 2) == 0)
    }, numbers)
    sPrintln("even numbers only: ", jsonStringify(numbersEven, false))
    // even numbers only: [12, 34, 36, 4, 254]

    numbersOdd = arrayFilterV2(func(number any, _ int, _ array) bool {
        return ((number.(int) % 2) != 0)
    }, numbers)
    sPrintln("odd numbers only: ", jsonStringify(numbersOdd, false))
    // odd numbers only: [27, 23, 65, 93, 87]

    fmt.Println("\n// JavaScript-like Array.filter() in Go Slice of maps")

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

    var productsBelow100 array
    var productsAbove100 array

    fmt.Println("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

    productsBelow100 = arrayFilterV1(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) <= 100)
    }, products)
    sPrintln("products with price <= 100 only: ", jsonStringify(productsBelow100, object{"pretty": true}))
    // products with price <= 100 only: [
    //     {
    //         "code": "potato_chips",
    //         "price": 5
    //     }
    // ]

    productsAbove100 = arrayFilterV1(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 100)
    }, products)
    sPrintln("products with price > 100 only: ", jsonStringify(productsAbove100, object{"pretty": true}))
    // products with price > 100 only: [
    //     {
    //         "code": "pasta",
    //         "price": 321
    //     },
    //     {
    //         "code": "bubble_gum",
    //         "price": 233
    //     },
    //     {
    //         "code": "towel",
    //         "price": 499
    //     }
    // ]

    fmt.Println("// using JavaScript-like Array.filter() function \"arrayFilterV2\"")

    productsBelow100 = arrayFilterV2(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) <= 100)
    }, products)
    sPrintln("products with price <= 100 only: ", jsonStringify(productsBelow100, object{"pretty": true}))
    // products with price <= 100 only: [
    //     {
    //         "code": "potato_chips",
    //         "price": 5
    //     }
    // ]

    productsAbove100 = arrayFilterV2(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 100)
    }, products)
    sPrintln("products with price > 100 only: ", jsonStringify(productsAbove100, object{"pretty": true}))
    // products with price > 100 only: [
    //     {
    //         "code": "pasta",
    //         "price": 321
    //     },
    //     {
    //         "code": "bubble_gum",
    //         "price": 233
    //     },
    //     {
    //         "code": "towel",
    //         "price": 499
    //     }
    // ]
}
