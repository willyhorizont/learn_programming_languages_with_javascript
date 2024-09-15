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

func main() {
    /*
       Relational Operators / Comparison Operators:
       equal to (==)
       not equal to (!=)
       greater than (>)
       less than (<)
       greater than or equal to (>=)
       less than or equal to (<=)

       Logical Operators:
       Logical AND (&&)
       Logical OR (||)
       Logical NOT (!)
    */
    CORRECT_ANSWER := 100

    var myAnswer int
    var myAge int
    var hasDrivingLicense bool
    var canDrive bool

    fmt.Println("\n// basic conditional control flow\n")

    myAge = 10
    sprint("myAge: ", array{myAge})
    if (myAge > 24) {
        fmt.Println("you are old")
    } else if (myAge > 17) {
        fmt.Println("you are young")
    } else {
        fmt.Println("you are under age")
    }

    fmt.Println("\n// equal to (==)\n")

    myAnswer = 100
    sprint("myAnswer: ", array{myAnswer})
    sprint("CORRECT_ANSWER: ", array{CORRECT_ANSWER})
    fmt.Println("(myAnswer == CORRECT_ANSWER):")
    if (myAnswer == CORRECT_ANSWER) {
        fmt.Println("Your answer is correct")
    } else {
        fmt.Println("Your answer is wrong")
    }

    fmt.Println("\n// not equal to (!=)\n")

    myAnswer = 25
    sprint("myAnswer: ", array{myAnswer})
    sprint("CORRECT_ANSWER: ", array{CORRECT_ANSWER})
    fmt.Println("(myAnswer != CORRECT_ANSWER):")
    if (myAnswer != CORRECT_ANSWER) {
        fmt.Println("Your answer is correct")
    } else {
        fmt.Println("Your answer is wrong")
    }

    fmt.Println("\n// greater than (>)\n")

    myAge = 70
    sprint("myAge: ", array{myAge})
    fmt.Println("(myAge > 50):")
    if (myAge > 50) {
        fmt.Println("You are old")
    }

    fmt.Println("\n// less than (<)\n")

    myAge = 16
    sprint("myAge: ", array{myAge})
    fmt.Println("(myAge < 20):")
    if (myAge < 20) {
        fmt.Println("You are young")
    }

    fmt.Println("\n// greater than or equal to (>=)\n")

    myAge = 73
    sprint("myAge: ", array{myAge})
    fmt.Println("(myAge >= 65):")
    if (myAge >= 65) {
        fmt.Println("You are allowed to retire")
    }

    fmt.Println("\n// less than or equal to (<=)\n")

    myAge = 14
    sprint("myAge: ", array{myAge})
    fmt.Println("(myAge <= 16):")
    if (myAge <= 16) {
        fmt.Println("You are not allowed to drive")
    }

    fmt.Println("\n// Logical AND (&&)\n")

    myAge = 17
    sprint("myAge: ", array{myAge})
    hasDrivingLicense = false
    sprint("hasDrivingLicense: ", array{hasDrivingLicense})
    fmt.Println("((myAge >= 17) && (hasDrivingLicense == true)):")
    if ((myAge >= 17) && (hasDrivingLicense == true)) {
        fmt.Println("You are allowed to drive")
    } else {
        fmt.Println("You are not allowed to drive")
    }

    myAge = 17
    sprint("myAge: ", array{myAge})
    hasDrivingLicense = true
    sprint("hasDrivingLicense: ", array{hasDrivingLicense})
    fmt.Println("((myAge >= 17) && (hasDrivingLicense == true)):")
    if ((myAge >= 17) && (hasDrivingLicense == true)) {
        fmt.Println("You are allowed to drive")
    } else {
        fmt.Println("You are not allowed to drive")
    }

    fmt.Println("\n// Logical OR (||)\n")

    myAge = 2
    sprint("myAge: ", array{myAge})
    fmt.Println("((myAge <= 3) || (myAge >= 65)):")
    if ((myAge <= 3) || (myAge >= 65)) {
        fmt.Println("You should stay home")
    }

    myAge = 89
    sprint("myAge: ", array{myAge})
    fmt.Println("((myAge <= 3) || (myAge >= 65)):")
    if ((myAge <= 3) || (myAge >= 65)) {
        fmt.Println("You should stay home")
    }

    fmt.Println("\n// Logical NOT (!)\n")

    canDrive = false
    sprint("canDrive: ", array{canDrive})
    sprint("!canDrive: ", array{!canDrive})

    canDrive = true
    sprint("canDrive: ", array{canDrive})
    sprint("!canDrive: ", array{!canDrive})
}
