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

// ? < function statement or function declaration

func getRectangleAreaV1(rectangleWidth int, rectangleLength int) int {
    return (rectangleWidth * rectangleLength)
}
// call the function example: getRectangleAreaV1(7, 5)

// ? function statement or function declaration />



// ? < Passing functions as arguments to other functions

func sayHellloV1(callbackFunction func()) {
    fmt.Println("hello")
    callbackFunction()
}

func sayHowAreYouV1() {
    fmt.Println("how are you?")
}

// ? Passing functions as arguments to other functions />



func addition(a int, b int) int {
    return (a + b)
}



// ? < Returning functions as values from other functions

func multiplyV1(a int) func(b int) int {
    multiplyBy := func(b int) int {
        return (a * b)
    }
    return multiplyBy
}

func multiplyV2(a int) func(b int) int {
    return func(b int) int {
        return (a * b)
    }
}

// ? Returning functions as values from other functions />



func main() {
    // ? function expression

    getRectangleAreaV2 := func(rectangleWidth int, rectangleLength int) int {
        return (rectangleWidth * rectangleLength)
    }
    // call the function example: getRectangleAreaV2(7, 5)

    // ? anonymous function

    // func(rectangleWidth int, rectangleLength int) int {
    //        return (rectangleWidth * rectangleLength)
    // }

    // ? Passing functions as arguments to other functions

    sayHellloV1(sayHowAreYouV1)

    sayHellloV1(func() {
        fmt.Println("how are you?")
    })

    sayHellloV2 := func(callbackFunction func()) {
        fmt.Println("hello")
        callbackFunction()
    }
    
    sayHowAreYouV2 := func() {
        fmt.Println("how are you?")
    }

    sayHellloV2(sayHowAreYouV2)

    sayHellloV2(func() {
        fmt.Println("how are you?")
    })

    // ? Assigning functions to variables or storing them in data structures

    getRectangleAreaV2Copy := func(rectangleWidth int, rectangleLength int) int {
        return (rectangleWidth * rectangleLength)
    }

    myArrayOfGetRectangleAreaFunctions := []func(int, int) int{
        getRectangleAreaV1,
        func(rectangleWidth int, rectangleLength int) int {
            return (rectangleWidth * rectangleLength)
        },
    }
    getRectangleAreaFunctionResult1 := myArrayOfGetRectangleAreaFunctions[0](7, 5)
    getRectangleAreaFunctionResult2 := myArrayOfGetRectangleAreaFunctions[1](7, 5)

    simpleCalculator := map[string]func(int, int) int{
        "addition": addition,
        "subtraction": func(rectangleWidth int, rectangleLength int) int {
            return (rectangleWidth - rectangleLength)
        },
    }
    simpleCalculatorResult1 := simpleCalculator["addition"](9, 3)
    simpleCalculatorResult2 := simpleCalculator["subtraction"](35, 8)

    // ? Returning functions as values from other functions

    multiplyBy2 := multiplyV1(2)
    multiplyBy2Result := multiplyBy2(10) // 20

    multiplyBy3 := multiplyV2(3)
    multiplyBy3Result := multiplyBy3(10) // 30

    multiplyV3 := func(a int) func(b int) int {
        return func(b int) int {
            return (a * b)
        }
    }

    multiplyBy4 := multiplyV3(4)
    multiplyBy4Result := multiplyBy4(10) // 40

    sprint("getRectangleAreaV2(7, 5): ", array{getRectangleAreaV2(7, 5)})
    sprint("getRectangleAreaV2Copy(7, 5): ", array{getRectangleAreaV2Copy(7, 5)})
    sprint("getRectangleAreaFunctionResult1: ", array{getRectangleAreaFunctionResult1})
    sprint("getRectangleAreaFunctionResult2: ", array{getRectangleAreaFunctionResult2})
    sprint("simpleCalculatorResult1: ", array{simpleCalculatorResult1})
    sprint("simpleCalculatorResult2: ", array{simpleCalculatorResult2})
    sprint("multiplyBy2Result: ", array{multiplyBy2Result})
    sprint("multiplyBy3Result: ", array{multiplyBy3Result})
    sprint("multiplyBy4Result: ", array{multiplyBy4Result})
}
