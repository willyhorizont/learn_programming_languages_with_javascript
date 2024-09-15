package main

import (
	"encoding/json"
	"fmt"
	"reflect"
	"strings"
)

// There's no JavaScript-like Spread Syntax (...) in Go.
// But, we can create our own function to mimic it in Go.

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

func spreadArray(restArguments ...any) array {
    var newArray = array{}
    for _, argument := range restArguments {
        argumentType := reflect.TypeOf(argument).Kind()
        if (argumentType == reflect.Map) {
            if (len(argument.(object)) == 1) {
                for _, objectValue := range argument.(object) {
                    newArray = append(newArray, objectValue)
                }
                continue
            }
            newArray = append(newArray, argument)
            continue
        }
        if (argumentType == reflect.Slice) {
            newArray = append(newArray, argument.(array)...)
            continue
        }
    }
    return newArray
}

func main() {
    fmt.Println("\n// JavaScript-like Spread Syntax (...) in Go")

    fruits := array{"Mango", "Melon", "Banana"}
    sprint("fruits: ", jsonStringify(fruits))

    vegetables := array{"Carrot", "Tomato"}
    sprint("vegetables: ", jsonStringify(vegetables))

    countryCapitalsInAsia := object{
        "Thailand": "Bangkok",
        "China": "Beijing",
        "Japan": "Tokyo",
    }
    sprint("countryCapitalsInAsia: ", jsonStringify(countryCapitalsInAsia, object{"pretty": true}))

    countryCapitalsInEurope := object{
        "France": "Paris",
        "England": "London",
    }
    sprint("countryCapitalsInEurope: ", jsonStringify(countryCapitalsInEurope, object{"pretty": true}))

    fmt.Println("// [...array1, ...array2]:")

    combination1 := spreadArray(fruits, vegetables)
    sprint("combination1: ", jsonStringify(combination1, object{"pretty": true}))
    // combination1: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Carrot",
    //     "Tomato"
    // ]

    combination2 := spreadArray(fruits, array{"Cucumber", "Cabbage"})
    sprint("combination2: ", jsonStringify(combination2, object{"pretty": true}))
    // combination2: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Cucumber",
    //     "Cabbage"
    // ]

    fmt.Println("// { ...object1, ...object2 }:")

    combination3 := spreadObject(countryCapitalsInAsia, countryCapitalsInEurope)
    sprint("combination3: ", jsonStringify(combination3, object{"pretty": true}))
    // combination3: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "France": "Paris",
    //     "England": "London"
    // }

    combination4 := spreadObject(countryCapitalsInAsia, object{"Germany": "Berlin", "Italy": "Rome"})
    sprint("combination4: ", jsonStringify(combination4, object{"pretty": true}))
    // combination4: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "Germany": "Berlin",
    //     "Italy": "Rome"
    // }

    fmt.Println("// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:")

    combination5 := spreadArray(fruits, object{"vegetables": vegetables})
    sprint("combination5: ", jsonStringify(combination5, object{"pretty": true}))
    // combination5: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     [
    //         "Carrot",
    //         "Tomato"
    //     ]
    // ]

    combination6 := spreadArray(fruits, object{"vegetables": array{"Cucumber", "Cabbage"}})
    sprint("combination6: ", jsonStringify(combination6, object{"pretty": true}))
    // combination6: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     [
    //         "Cucumber",
    //         "Cabbage"
    //     ]
    // ]

    fmt.Println("// [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:")

    combination7 := spreadArray(fruits, object{"countryCapitalsInAsia": countryCapitalsInAsia})
    sprint("combination7: ", jsonStringify(combination7, object{"pretty": true}))
    // combination7: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     {
    //         "Thailand": "Bangkok",
    //         "China": "Beijing",
    //         "Japan": "Tokyo"
    //     }
    // ]

    combination8 := spreadArray(fruits, object{"Germany": "Berlin", "Italy": "Rome"})
    sprint("combination8: ", jsonStringify(combination8, object{"pretty": true}))
    // combination8: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     {
    //         "Germany": "Berlin",
    //         "Italy": "Rome"
    //     }
    // ]

    fmt.Println("// { ...object1, object2 } || { ...object1, objectKey: objectValue }:")

    combination9 := spreadObject(countryCapitalsInAsia, object{"countryCapitalsInEurope": countryCapitalsInEurope})
    sprint("combination9: ", jsonStringify(combination9, object{"pretty": true}))
    // combination9: {
    //    "Thailand" : "Bangkok",
    //    "China" : "Beijing",
    //    "Japan" : "Tokyo",
    //    "countryCapitalsInEurope" : {
    //       "France" : "Paris",
    //       "England" : "London"
    //    }
    // }

    combination10 := spreadObject(countryCapitalsInAsia, object{"countryCapitalsInEurope": object{"Germany": "Berlin", "Italy": "Rome"}})
    sprint("combination10: ", jsonStringify(combination10, object{"pretty": true}))
    //combination10: {
    //    "Thailand": "Bangkok",
    //    "China": "Beijing",
    //    "Japan": "Tokyo",
    //    "countryCapitalsInEurope": {
    //        "Germany": "Berlin",
    //        "Italy": "Rome"
    //    }
    //}

    fmt.Println("// { ...object1, array2 } || { ...object1, objectKey: objectValue }:")

    combination11 := spreadObject(countryCapitalsInAsia, object{"vegetables": vegetables})
    sprint("combination11: ", jsonStringify(combination11, object{"pretty": true}))
    // combination11: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "vegetables": [
    //         "Carrot",
    //         "Tomato"
    //     ]
    // }

    combination12 := spreadObject(countryCapitalsInAsia, object{"vegetables": array{"Cucumber", "Cabbage"}})
    sprint("combination12: ", jsonStringify(combination12, object{"pretty": true}))
    // combination12: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "vegetables": [
    //         "Cucumber",
    //         "Cabbage"
    //     ]
    // }

    fmt.Println("// { ...object1, ...array2 }:")

    combination13 := spreadObject(countryCapitalsInAsia, vegetables)
    sprint("combination13: ", jsonStringify(combination13, object{"pretty": true}))
    // combination13: {
    //    "Thailand" : "Bangkok",
    //    "China" : "Beijing",
    //    "Japan" : "Tokyo",
    //    "0" : "Carrot",
    //    "1" : "Tomato"
    // }

    combination14 := spreadObject(countryCapitalsInAsia, array{"Cucumber", "Cabbage"})
    sprint("combination14: ", jsonStringify(combination14, object{"pretty": true}))
    // combination14: {
    //    "Thailand" : "Bangkok",
    //    "China" : "Beijing",
    //    "Japan" : "Tokyo",
    //    "0" : "Cucumber",
    //    "1" : "Cabbage"
    // }

    // fmt.Println("// [...array1, ...object1]: // this combination throw an error in JavaScript")

    // this combination throw an error in JavaScript
    // combinationErrorInJavaScript1 := spreadObject(fruits, countryCapitalsInAsia)
    // sprint("combinationErrorInJavaScript1: ", jsonStringify(combinationErrorInJavaScript1, object{"pretty": true}))

    // this combination throw an error in JavaScript
    // combinationErrorInJavaScript2 := spreadObject(fruits, object{"Germany": "Berlin", "Italy": "Rome"})
    // sprint("combinationErrorInJavaScript2: ", jsonStringify(combinationErrorInJavaScript2, object{"pretty": true}))
}
