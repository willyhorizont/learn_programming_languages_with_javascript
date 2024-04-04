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

func spreadObject(parameters ...any) object {
    var newObject = make(object)
    for _, parameter := range parameters {
        parameterType := reflect.TypeOf(parameter).Kind()
        if (parameterType == reflect.Map) {
            for objectKey, objectValue := range parameter.(object) {
                newObject[objectKey] = objectValue
            }
			continue
        }
        if (parameterType == reflect.Slice) {
            for arrayItemIndex, arrayItem := range parameter.(array) {
                newObject[jsonStringify(arrayItemIndex, false)] = arrayItem
            }
			continue
        }
    }
    return newObject
}

func spreadArray(parameters ...any) array {
    var newArray = array{}
    for _, parameter := range parameters {
        parameterType := reflect.TypeOf(parameter).Kind()
        if (parameterType == reflect.Map) {
            if (len(parameter.(object)) == 1) {
                for _, objectValue := range parameter.(object) {
                    newArray = append(newArray, objectValue)
                }
                continue
            }
            newArray = append(newArray, parameter)
            continue
        }
        if (parameterType == reflect.Slice) {
            newArray = append(newArray, parameter.(array)...)
            continue
        }
    }
    return newArray
}

func main() {
    fmt.Println("\n// JavaScript-like Spread Syntax (...) in Go")

    fruits := array{"Mango", "Melon", "Banana"}
    sPrintln("fruits: ", jsonStringify(fruits, false))

    vegetables := array{"Carrot", "Tomato"}
    sPrintln("vegetables: ", jsonStringify(vegetables, false))

    countryCapitalsInAsia := object{
        "Thailand": "Bangkok",
        "China": "Beijing",
        "Japan": "Tokyo",
    }
    sPrintln("countryCapitalsInAsia: ", jsonStringify(countryCapitalsInAsia, object{"pretty": true}))

    countryCapitalsInEurope := object{
        "France": "Paris",
        "England": "London",
    }
    sPrintln("countryCapitalsInEurope: ", jsonStringify(countryCapitalsInEurope, object{"pretty": true}))

    fmt.Println("// [...array1, ...array2]:")

    combination1 := spreadArray(fruits, vegetables)
    sPrintln("combination1: ", jsonStringify(combination1, object{"pretty": true}))
    // combination1: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Carrot",
    //     "Tomato"
    // ]

    combination2 := spreadArray(fruits, array{"Cucumber", "Cabbage"})
    sPrintln("combination2: ", jsonStringify(combination2, object{"pretty": true}))
    // combination2: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Cucumber",
    //     "Cabbage"
    // ]

    fmt.Println("// { ...object1, ...object2 }:")

    combination3 := spreadObject(countryCapitalsInAsia, countryCapitalsInEurope)
    sPrintln("combination3: ", jsonStringify(combination3, object{"pretty": true}))
    // combination3: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "France": "Paris",
    //     "England": "London"
    // }

    combination4 := spreadObject(countryCapitalsInAsia, object{"Germany": "Berlin", "Italy": "Rome"})
    sPrintln("combination4: ", jsonStringify(combination4, object{"pretty": true}))
    // combination4: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "Germany": "Berlin",
    //     "Italy": "Rome"
    // }

    fmt.Println("// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:")

    combination5 := spreadArray(fruits, object{"vegetables": vegetables})
    sPrintln("combination5: ", jsonStringify(combination5, object{"pretty": true}))
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
    sPrintln("combination6: ", jsonStringify(combination6, object{"pretty": true}))
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
    sPrintln("combination7: ", jsonStringify(combination7, object{"pretty": true}))
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
    sPrintln("combination8: ", jsonStringify(combination8, object{"pretty": true}))
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
    sPrintln("combination9: ", jsonStringify(combination9, object{"pretty": true}))
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
    sPrintln("combination10: ", jsonStringify(combination10, object{"pretty": true}))
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
    sPrintln("combination11: ", jsonStringify(combination11, object{"pretty": true}))
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
    sPrintln("combination12: ", jsonStringify(combination12, object{"pretty": true}))
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
    sPrintln("combination13: ", jsonStringify(combination13, object{"pretty": true}))
    // combination13: {
    //    "Thailand" : "Bangkok",
    //    "China" : "Beijing",
    //    "Japan" : "Tokyo",
    //    "0" : "Carrot",
    //    "1" : "Tomato"
    // }

    combination14 := spreadObject(countryCapitalsInAsia, array{"Cucumber", "Cabbage"})
    sPrintln("combination14: ", jsonStringify(combination14, object{"pretty": true}))
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
    // sPrintln("combinationErrorInJavaScript1: ", jsonStringify(combinationErrorInJavaScript1, object{"pretty": true}))

    // this combination throw an error in JavaScript
    // combinationErrorInJavaScript2 := spreadObject(fruits, object{"Germany": "Berlin", "Italy": "Rome"})
    // sPrintln("combinationErrorInJavaScript2: ", jsonStringify(combinationErrorInJavaScript2, object{"pretty": true}))
}
