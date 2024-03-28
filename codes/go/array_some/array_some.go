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
    // JavaScript-like Array.some() function
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
    fmt.Println("numbers:", prettyArrayOfPrimitives(numbers))

    var isAnyNumberLessThan500 bool
    var isAnyNumberMoreThan500 bool

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV1\"")

    isAnyNumberLessThan500 = arraySomeV1(func(number any, _ int, _ array) bool {
        return (number.(int) < 500)
    }, numbers)
    fmt.Println("is any number < 500:", prettyJsonStringify(isAnyNumberLessThan500))
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV1(func(number any, _ int, _ array) bool {
        return (number.(int) > 500)
    }, numbers)
    fmt.Println("is any number > 500:", prettyJsonStringify(isAnyNumberMoreThan500))
    // is any number > 500: false

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV2\"")

    isAnyNumberLessThan500 = arraySomeV2(func(number any, _ int, _ array) bool {
        return (number.(int) < 500)
    }, numbers)
    fmt.Println("is any number < 500:", prettyJsonStringify(isAnyNumberLessThan500))
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV2(func(number any, _ int, _ array) bool {
        return (number.(int) > 500)
    }, numbers)
    fmt.Println("is any number > 500:", prettyJsonStringify(isAnyNumberMoreThan500))
    // is any number > 500: false

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV3\"")

    isAnyNumberLessThan500 = arraySomeV3(func(number any, _ int, _ array) bool {
        return (number.(int) < 500)
    }, numbers)
    fmt.Println("is any number < 500:", prettyJsonStringify(isAnyNumberLessThan500))
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV3(func(number any, _ int, _ array) bool {
        return (number.(int) > 500)
    }, numbers)
    fmt.Println("is any number > 500:", prettyJsonStringify(isAnyNumberMoreThan500))
    // is any number > 500: false

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV4\"")

    isAnyNumberLessThan500 = arraySomeV4(func(number any, _ int, _ array) bool {
        return (number.(int) < 500)
    }, numbers)
    fmt.Println("is any number < 500:", prettyJsonStringify(isAnyNumberLessThan500))
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV4(func(number any, _ int, _ array) bool {
        return (number.(int) > 500)
    }, numbers)
    fmt.Println("is any number > 500:", prettyJsonStringify(isAnyNumberMoreThan500))
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

    fmt.Println("products:" + prettyJsonStringify(products))

    var isAnyProductPriceLessThan500 bool
    var isAnyProductPriceMoreThan500 bool

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV1\"")

    isAnyProductPriceLessThan500 = arraySomeV1(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) < 500)
    }, products)
    fmt.Println("is any product price < 500:", prettyJsonStringify(isAnyProductPriceLessThan500))
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV1(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 500)
    }, products)
    fmt.Println("is any product price > 500:", prettyJsonStringify(isAnyProductPriceMoreThan500))
    // is any product price > 500: false

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV2\"")

    isAnyProductPriceLessThan500 = arraySomeV2(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) < 500)
    }, products)
    fmt.Println("is any product price < 500:", prettyJsonStringify(isAnyProductPriceLessThan500))
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV2(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 500)
    }, products)
    fmt.Println("is any product price > 500:", prettyJsonStringify(isAnyProductPriceMoreThan500))
    // is any product price > 500: false

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV3\"")

    isAnyProductPriceLessThan500 = arraySomeV3(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) < 500)
    }, products)
    fmt.Println("is any product price < 500:", prettyJsonStringify(isAnyProductPriceLessThan500))
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV3(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 500)
    }, products)
    fmt.Println("is any product price > 500:", prettyJsonStringify(isAnyProductPriceMoreThan500))
    // is any product price > 500: false

    fmt.Println("// using JavaScript-like Array.some() function \"arraySomeV4\"")

    isAnyProductPriceLessThan500 = arraySomeV4(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) < 500)
    }, products)
    fmt.Println("is any product price < 500:", prettyJsonStringify(isAnyProductPriceLessThan500))
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV4(func(product any, _ int, _ array) bool {
        return (product.(object)["price"].(int) > 500)
    }, products)
    fmt.Println("is any product price > 500:", prettyJsonStringify(isAnyProductPriceMoreThan500))
    // is any product price > 500: false
}
