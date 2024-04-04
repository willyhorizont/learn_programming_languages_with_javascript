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
    sPrintln("myAge: ", array{myAge})
    if (myAge > 24) {
        fmt.Println("you are old")
    } else if (myAge > 17) {
        fmt.Println("you are young")
    } else {
        fmt.Println("you are under age")
    }

    fmt.Println("\n// equal to (==)\n")

    myAnswer = 100
    sPrintln("myAnswer: ", array{myAnswer})
    sPrintln("CORRECT_ANSWER: ", array{CORRECT_ANSWER})
    fmt.Println("(myAnswer == CORRECT_ANSWER):")
    if (myAnswer == CORRECT_ANSWER) {
        fmt.Println("Your answer is correct")
    } else {
        fmt.Println("Your answer is wrong")
    }

    fmt.Println("\n// not equal to (!=)\n")

    myAnswer = 25
    sPrintln("myAnswer: ", array{myAnswer})
    sPrintln("CORRECT_ANSWER: ", array{CORRECT_ANSWER})
    fmt.Println("(myAnswer != CORRECT_ANSWER):")
    if (myAnswer != CORRECT_ANSWER) {
        fmt.Println("Your answer is correct")
    } else {
        fmt.Println("Your answer is wrong")
    }

    fmt.Println("\n// greater than (>)\n")

    myAge = 70
    sPrintln("myAge: ", array{myAge})
    fmt.Println("(myAge > 50):")
    if (myAge > 50) {
        fmt.Println("You are old")
    }

    fmt.Println("\n// less than (<)\n")

    myAge = 16
    sPrintln("myAge: ", array{myAge})
    fmt.Println("(myAge < 20):")
    if (myAge < 20) {
        fmt.Println("You are young")
    }

    fmt.Println("\n// greater than or equal to (>=)\n")

    myAge = 73
    sPrintln("myAge: ", array{myAge})
    fmt.Println("(myAge >= 65):")
    if (myAge >= 65) {
        fmt.Println("You are allowed to retire")
    }

    fmt.Println("\n// less than or equal to (<=)\n")

    myAge = 14
    sPrintln("myAge: ", array{myAge})
    fmt.Println("(myAge <= 16):")
    if (myAge <= 16) {
        fmt.Println("You are not allowed to drive")
    }

    fmt.Println("\n// Logical AND (&&)\n")

    myAge = 17
    sPrintln("myAge: ", array{myAge})
    hasDrivingLicense = false
    sPrintln("hasDrivingLicense: ", array{hasDrivingLicense})
    fmt.Println("((myAge >= 17) && (hasDrivingLicense == true)):")
    if ((myAge >= 17) && (hasDrivingLicense == true)) {
        fmt.Println("You are allowed to drive")
    } else {
        fmt.Println("You are not allowed to drive")
    }

    myAge = 17
    sPrintln("myAge: ", array{myAge})
    hasDrivingLicense = true
    sPrintln("hasDrivingLicense: ", array{hasDrivingLicense})
    fmt.Println("((myAge >= 17) && (hasDrivingLicense == true)):")
    if ((myAge >= 17) && (hasDrivingLicense == true)) {
        fmt.Println("You are allowed to drive")
    } else {
        fmt.Println("You are not allowed to drive")
    }

    fmt.Println("\n// Logical OR (||)\n")

    myAge = 2
    sPrintln("myAge: ", array{myAge})
    fmt.Println("((myAge <= 3) || (myAge >= 65)):")
    if ((myAge <= 3) || (myAge >= 65)) {
        fmt.Println("You should stay home")
    }

    myAge = 89
    sPrintln("myAge: ", array{myAge})
    fmt.Println("((myAge <= 3) || (myAge >= 65)):")
    if ((myAge <= 3) || (myAge >= 65)) {
        fmt.Println("You should stay home")
    }

    fmt.Println("\n// Logical NOT (!)\n")

    canDrive = false
    sPrintln("canDrive: ", array{canDrive})
    sPrintln("!canDrive: ", array{!canDrive})

    canDrive = true
    sPrintln("canDrive: ", array{canDrive})
    sPrintln("!canDrive: ", array{!canDrive})
}
