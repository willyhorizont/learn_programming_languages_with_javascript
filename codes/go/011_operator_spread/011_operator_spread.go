package main

import (
	"fmt"
	"reflect"
	"strings"
)

func main() {
	jsLikeType := struct {
		Null interface{}
		Boolean interface{}
		String interface{}
		Numeric interface{}
		Object interface{}
		Array interface{}
		Function interface{}
	}{
		Null: "Null",
		Boolean: "Boolean",
		String: "String",
		Numeric: "Numeric",
		Object: "Object",
		Array: "Array",
		Function: "Function",
	}
	ternary := func(restArguments ...interface{}) interface{} {
		trueCondition := restArguments[0].(bool)
		callbackFunctionIfConditionTrue := restArguments[1].(func(...interface{}) interface{})
		callbackFunctionIfConditionFalse := restArguments[2].(func(...interface{}) interface{})
		if (trueCondition == true) {
			return callbackFunctionIfConditionTrue()
		}
		return callbackFunctionIfConditionFalse()
	}
	arraySome := func(restArguments ...interface{}) interface{} {
		// JavaScript-like Array.some() function arraySomeV4
		callbackFunction := restArguments[0].(func(...interface{}) interface{})
		anArray := restArguments[1].([]interface{})
		for arrayItemIndex, arrayItem := range anArray {
			if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
				return true
			}
		}
		return false
	}
	isLikeJsNull := func(restArguments ...interface{}) interface{} {
		anything := restArguments[0]
		return (anything == nil)
	}
	isLikeJsBoolean := func(restArguments ...interface{}) interface{} {
		anything := restArguments[0]
		return ((reflect.TypeOf(anything).Kind() == reflect.Bool) && ((anything == true) || (anything == false)))
	}
	isLikeJsString := func(restArguments ...interface{}) interface{} {
		anything := restArguments[0]
		return (reflect.TypeOf(anything).Kind() == reflect.String)
	}
	isLikeJsNumeric := func(restArguments ...interface{}) interface{} {
		anything := restArguments[0]
		anythingJsLikeType := reflect.TypeOf(anything)
		return (arraySome(func(restArgumentsArraySomeCallback ...interface{}) interface{} {
			numericType := restArgumentsArraySomeCallback[0]
			return (anythingJsLikeType.Kind() == numericType)
		}, []interface{}{reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64, reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64, reflect.Float32, reflect.Float64, reflect.Complex64, reflect.Complex128}))
	}
	isLikeJsObject := func(restArguments ...interface{}) interface{} {
		anything := restArguments[0]
		anythingJsLikeType := reflect.TypeOf(anything)
		return ((anythingJsLikeType.Kind() == reflect.Map) || ((anythingJsLikeType.Kind() == reflect.Map) && (anythingJsLikeType.Key().Kind() == reflect.String) && (anythingJsLikeType.Elem().Kind() == reflect.Interface)) || (anythingJsLikeType == reflect.TypeOf(map[string]interface{}{})) || (anythingJsLikeType.String() == "map[string]interface {}") || (anythingJsLikeType.String() == "map[string]interface {  }"))
	}
	isLikeJsArray := func(restArguments ...interface{}) interface{} {
		anything := restArguments[0]
		anythingJsLikeType := reflect.TypeOf(anything)
		return ((anythingJsLikeType.Kind() == reflect.Slice) || (anythingJsLikeType == reflect.TypeOf([]interface{}{})) || (anythingJsLikeType.String() == "[]interface {}") || (anythingJsLikeType.String() == "[]interface {  }"))
	}
	isLikeJsFunction := func(restArguments ...interface{}) interface{} {
		anything := restArguments[0]
		return (reflect.TypeOf(anything).Kind() == reflect.Func)
	}
	getType := func(restArguments ...interface{}) interface{} {
		anything := restArguments[0]
		if (isLikeJsNull(anything) == true) {
			return jsLikeType.Null
		}
		if (isLikeJsBoolean(anything) == true) {
			return jsLikeType.Boolean
		}
		if (isLikeJsString(anything) == true) {
			return jsLikeType.String
		}
		if (isLikeJsNumeric(anything) == true) {
			return jsLikeType.Numeric
		}
		if (isLikeJsObject(anything) == true) {
			return jsLikeType.Object
		}
		if (isLikeJsArray(anything) == true) {
			return jsLikeType.Array
		}
		if (isLikeJsFunction(anything) == true) {
			return jsLikeType.Function
		}
		return reflect.TypeOf(anything).String()
	}
	anyToString := func(restArguments ...interface{}) interface{} {
		anything := restArguments[0]
		anythingGoValue := reflect.ValueOf(anything)
		if (anythingGoValue.Kind() == reflect.String) {
			return anythingGoValue.String()
		}
		if (anythingGoValue.Kind() == reflect.Bool) {
			return fmt.Sprintf("%t", anythingGoValue.Bool())
		}
		if ((arraySome(func(restArgumentsArraySomeCallback ...interface{}) interface{} {
			numericIntType := restArgumentsArraySomeCallback[0]
			return (anythingGoValue.Kind() == numericIntType)
		}, []interface{}{reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64})).(bool) == true) {
			return fmt.Sprintf("%d", anythingGoValue.Int())
		}
		if ((arraySome(func(restArgumentsArraySomeCallback ...interface{}) interface{} {
			numericUintType := restArgumentsArraySomeCallback[0]
			return (anythingGoValue.Kind() == numericUintType)
		}, []interface{}{reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64})).(bool) == true) {
			return fmt.Sprintf("%d", anythingGoValue.Uint())
		}
		if ((arraySome(func(restArgumentsArraySomeCallback ...interface{}) interface{} {
			numericFloatType := restArgumentsArraySomeCallback[0]
			return (anythingGoValue.Kind() == numericFloatType)
		}, []interface{}{reflect.Float32, reflect.Float64})).(bool) == true) {
			return fmt.Sprintf("%f", anythingGoValue.Float())
		}
		if ((arraySome(func(restArgumentsArraySomeCallback ...interface{}) interface{} {
			numericComplexType := restArgumentsArraySomeCallback[0]
			return (anythingGoValue.Kind() == numericComplexType)
		}, []interface{}{reflect.Complex64, reflect.Complex128})).(bool) == true) {
			return fmt.Sprintf("%g", anythingGoValue.Complex())
		}
		return `"` + anythingGoValue.String() + `"`
	}
	arrayReduce := func(restArguments ...interface{}) interface{} {
		// JavaScript-like Array.reduce() function
		callbackFunction := restArguments[0].(func(...interface{}) interface{})
		anArray := restArguments[1].([]interface{})
		initialValue := restArguments[2]
		result := initialValue
		for arrayItemIndex, arrayItem := range anArray {
			result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
		}
		return result
	}
	optionalChaining := func(restArguments ...interface{}) interface{} {
		anything := restArguments[0]
		restArgumentsNew := restArguments[1:]
		anythingJsLikeType := getType(anything)
		if (anythingJsLikeType == jsLikeType.Function) {
			return anything.(func(...interface{}) interface{})(restArgumentsNew...)
		}
		if (((anythingJsLikeType != jsLikeType.Object) && (anythingJsLikeType != jsLikeType.Array)) || (len(restArgumentsNew) == 0)) {
			return anything
		}
		return (arrayReduce(func(restArgumentsArrayReduceCallback ...interface{}) interface{} {
			currentResult := restArgumentsArrayReduceCallback[0]
			currentItem := restArgumentsArrayReduceCallback[1]
			currentResultJsLikeType := getType(currentResult)
			currentItemJsLikeType := getType(currentItem)
			if ((currentResultJsLikeType == jsLikeType.Null) && (anythingJsLikeType == jsLikeType.Object) && (currentItemJsLikeType == jsLikeType.String)) {
				return anything.(map[string]interface{})[currentItem.(string)]
			}
			if ((currentResultJsLikeType == jsLikeType.Null) && (anythingJsLikeType == jsLikeType.Array) && (reflect.TypeOf(currentItem).Kind() == reflect.Int) && (currentItem.(int) >= 0) && (len(anything.([]interface{})) > currentItem.(int))) {
				return anything.([]interface{})[currentItem.(int)]
			}
			if ((currentResultJsLikeType == jsLikeType.Object) && (currentItemJsLikeType == jsLikeType.String)) {
				return currentResult.(map[string]interface{})[currentItem.(string)]
			}
			if ((currentResultJsLikeType == jsLikeType.Array) && (reflect.TypeOf(currentItem).Kind() == reflect.Int) && (currentItem.(int) >= 0) && (len(currentResult.([]interface{})) > currentItem.(int))) {
				return currentResult.([]interface{})[currentItem.(int)]
			}
			return nil
		}, restArgumentsNew, nil))
	}
	nullishCoalescing := func(restArguments ...interface{}) interface{} {
		anything := restArguments[0]
		defaultValue := restArguments[1]
		if (anything == nil) {
			return defaultValue
		} else {
			return anything
		}
	}
	jsonStringify := func(restArguments ...interface{}) interface{} {
		prettyDefault := false
		indentDefault := "    "
		anything := restArguments[0]
		pretty := nullishCoalescing(optionalChaining((optionalChaining(restArguments, 1)), "pretty"), prettyDefault)
		indentLevel := 0
		var jsonStringifyInner func(...interface{}) interface{}
		jsonStringifyInner = func(restArgumentsJsonStringifyInner ...interface{}) interface{} {
			anythingInner := restArgumentsJsonStringifyInner[0]
			anythingInnerJsLikeType := getType(anythingInner).(string)
			if (anythingInnerJsLikeType == jsLikeType.Null) {
				return "null"
			}
			if (anythingInnerJsLikeType == jsLikeType.String) {
				return `"` + anythingInner.(string) + `"`
			}
			if ((anythingInnerJsLikeType == jsLikeType.Numeric) || (anythingInnerJsLikeType == jsLikeType.Boolean)) {
				return anyToString(anythingInner)
			}
			if (anythingInnerJsLikeType == jsLikeType.Object) {
				if (len(anythingInner.(map[string]interface{})) == 0) {
					return "{}"
				}
				indentLevel += 1
				result := (ternary((pretty == true), func(_ ...interface{}) interface{} {
					return "{\n" + strings.Repeat(indentDefault, indentLevel)
				}, func(_ ...interface{}) interface{} {
					return "{ "
				}).(string))
				objectEntryIndex := 0
				for objectKey, objectValue := range anythingInner.(map[string]interface{}) {
					result += `"` + objectKey + `": ` + jsonStringifyInner(objectValue).(string)
					if ((objectEntryIndex + 1) != len(anythingInner.(map[string]interface{}))) {
						result += (ternary((pretty == true), func(_ ...interface{}) interface{} {
							return ",\n" + strings.Repeat(indentDefault, indentLevel)
						}, func(_ ...interface{}) interface{} {
							return ", "
						}).(string))
					}
					objectEntryIndex += 1
				}
				indentLevel -= 1
				result += (ternary((pretty == true), func(_ ...interface{}) interface{} {
					return "\n" + strings.Repeat(indentDefault, indentLevel) + "}"
				}, func(_ ...interface{}) interface{} {
					return " }"
				}).(string))
				return result
			}
			if (anythingInnerJsLikeType == jsLikeType.Array) {
				if (len(anythingInner.([]interface{})) == 0) {
					return "[]"
				}
				indentLevel += 1
				result := (ternary((pretty == true), func(_ ...interface{}) interface{} {
					return "[\n" + strings.Repeat(indentDefault, indentLevel)
				}, func(_ ...interface{}) interface{} {
					return "["
				}).(string))
				for arrayItemIndex, arrayItem := range anythingInner.([]interface{}) {
					result += jsonStringifyInner(arrayItem).(string)
					if ((arrayItemIndex + 1) != len(anythingInner.([]interface{}))) {
						result += (ternary((pretty == true), func(_ ...interface{}) interface{} {
							return ",\n" + strings.Repeat(indentDefault, indentLevel)
						}, func(_ ...interface{}) interface{} {
							return ", "
						}).(string))
					}
				}
				indentLevel -= 1
				result += (ternary((pretty == true), func(_ ...interface{}) interface{} {
					return "\n" + strings.Repeat(indentDefault, indentLevel) + "]"
				}, func(_ ...interface{}) interface{} {
					return "]"
				}).(string))
				return result
			}
			if (anythingInnerJsLikeType == jsLikeType.Function) {
				return `"[object Function]"`
			}
			return `"` + anythingInnerJsLikeType + `"`
		}
		return jsonStringifyInner(anything)
	}
	stringInterpolation := func(restArguments ...interface{}) interface{} {
		return (arrayReduce(func(restArgumentsArrayReduceCallback ...interface{}) interface{} {
			currentResult := restArgumentsArrayReduceCallback[0]
			currentArgument := restArgumentsArrayReduceCallback[1]
			currentArgumentJsLikeType := getType(currentArgument)
			return (currentResult.(string) + ternary(
				(currentArgumentJsLikeType == jsLikeType.String),
				(func(_ ...interface{}) interface{} {
					return currentArgument.(string)
				}),
				(func(_ ...interface{}) interface{} {
					return (ternary(
						((currentArgumentJsLikeType == jsLikeType.Array) && (len(currentArgument.([]interface{})) == 1)),
						(func(_ ...interface{}) interface{} {
							return jsonStringify(currentArgument.([]interface{})[0])
						}),
						(func(_ ...interface{}) interface{} {
							return jsonStringify(currentArgument)
						}),
					).(string))
				}),
			).(string))
		}, restArguments, "").(string))
	}
	consoleLog := func(restArguments ...interface{}) interface{} {
		fmt.Println(stringInterpolation(restArguments...).(string))
		return nil
	}

	spreadObject := func(restArguments ...interface{}) interface{} {
		var newObject = map[string]interface{}{}
		for _, argument := range restArguments {
			argumentJsLikeType := getType(argument)
			if (argumentJsLikeType == jsLikeType.Object) {
				for objectKey, objectValue := range argument.(map[string]interface{}) {
					newObject[objectKey] = objectValue
				}
				continue
			}
			if (argumentJsLikeType == jsLikeType.Array) {
				for arrayItemIndex, arrayItem := range argument.([]interface{}) {
					newObject[jsonStringify(arrayItemIndex).(string)] = arrayItem
				}
				continue
			}
		}
		return newObject
	}
	
	spreadArray := func(restArguments ...interface{}) interface{} {
		var newArray = []interface{}{}
		for _, argument := range restArguments {
			argumentJsLikeType := getType(argument)
			if (argumentJsLikeType == jsLikeType.Object) {
				if (len(argument.(map[string]interface{})) == 1) {
					for _, objectValue := range argument.(map[string]interface{}) {
						newArray = append(newArray, objectValue)
					}
					continue
				}
				newArray = append(newArray, argument)
				continue
			}
			if (argumentJsLikeType == jsLikeType.Array) {
				newArray = append(newArray, argument.([]interface{})...)
				continue
			}
		}
		return newArray
	}

    consoleLog("\n// JavaScript-like Spread Syntax (...) in Go")

    fruits := []interface{}{"Mango", "Melon", "Banana"}
    consoleLog(stringInterpolation("fruits: ", jsonStringify(fruits)))

    vegetables := []interface{}{"Carrot", "Tomato"}
    consoleLog(stringInterpolation("vegetables: ", jsonStringify(vegetables)))

    countryCapitalsInAsia := map[string]interface{}{
        "Thailand": "Bangkok",
        "China": "Beijing",
        "Japan": "Tokyo",
    }
    consoleLog(stringInterpolation("countryCapitalsInAsia: ", jsonStringify(countryCapitalsInAsia, map[string]interface{}{"pretty": true})))

    countryCapitalsInEurope := map[string]interface{}{
        "France": "Paris",
        "England": "London",
    }
    consoleLog(stringInterpolation("countryCapitalsInEurope: ", jsonStringify(countryCapitalsInEurope, map[string]interface{}{"pretty": true})))

    consoleLog("// [...array1, ...array2]:")

    combination1 := spreadArray(fruits, vegetables)
    consoleLog(stringInterpolation("combination1: ", jsonStringify(combination1, map[string]interface{}{"pretty": true})))
    // combination1: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Carrot",
    //     "Tomato"
    // ]

    combination2 := spreadArray(fruits, []interface{}{"Cucumber", "Cabbage"})
    consoleLog(stringInterpolation("combination2: ", jsonStringify(combination2, map[string]interface{}{"pretty": true})))
    // combination2: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Cucumber",
    //     "Cabbage"
    // ]

    consoleLog("// { ...object1, ...object2 }:")

    combination3 := spreadObject(countryCapitalsInAsia, countryCapitalsInEurope)
    consoleLog(stringInterpolation("combination3: ", jsonStringify(combination3, map[string]interface{}{"pretty": true})))
    // combination3: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "France": "Paris",
    //     "England": "London"
    // }

    combination4 := spreadObject(countryCapitalsInAsia, map[string]interface{}{"Germany": "Berlin", "Italy": "Rome"})
    consoleLog(stringInterpolation("combination4: ", jsonStringify(combination4, map[string]interface{}{"pretty": true})))
    // combination4: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "Germany": "Berlin",
    //     "Italy": "Rome"
    // }

    consoleLog("// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:")

    combination5 := spreadArray(fruits, map[string]interface{}{"vegetables": vegetables})
    consoleLog(stringInterpolation("combination5: ", jsonStringify(combination5, map[string]interface{}{"pretty": true})))
    // combination5: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     [
    //         "Carrot",
    //         "Tomato"
    //     ]
    // ]

    combination6 := spreadArray(fruits, map[string]interface{}{"vegetables": []interface{}{"Cucumber", "Cabbage"}})
    consoleLog(stringInterpolation("combination6: ", jsonStringify(combination6, map[string]interface{}{"pretty": true})))
    // combination6: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     [
    //         "Cucumber",
    //         "Cabbage"
    //     ]
    // ]

    consoleLog("// [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:")

    combination7 := spreadArray(fruits, map[string]interface{}{"countryCapitalsInAsia": countryCapitalsInAsia})
    consoleLog(stringInterpolation("combination7: ", jsonStringify(combination7, map[string]interface{}{"pretty": true})))
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

    combination8 := spreadArray(fruits, map[string]interface{}{"Germany": "Berlin", "Italy": "Rome"})
    consoleLog(stringInterpolation("combination8: ", jsonStringify(combination8, map[string]interface{}{"pretty": true})))
    // combination8: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     {
    //         "Germany": "Berlin",
    //         "Italy": "Rome"
    //     }
    // ]

    consoleLog("// { ...object1, object2 } || { ...object1, objectKey: objectValue }:")

    combination9 := spreadObject(countryCapitalsInAsia, map[string]interface{}{"countryCapitalsInEurope": countryCapitalsInEurope})
    consoleLog(stringInterpolation("combination9: ", jsonStringify(combination9, map[string]interface{}{"pretty": true})))
    // combination9: {
    //    "Thailand" : "Bangkok",
    //    "China" : "Beijing",
    //    "Japan" : "Tokyo",
    //    "countryCapitalsInEurope" : {
    //       "France" : "Paris",
    //       "England" : "London"
    //    }
    // }

    combination10 := spreadObject(countryCapitalsInAsia, map[string]interface{}{"countryCapitalsInEurope": map[string]interface{}{"Germany": "Berlin", "Italy": "Rome"}})
    consoleLog(stringInterpolation("combination10: ", jsonStringify(combination10, map[string]interface{}{"pretty": true})))
    //combination10: {
    //    "Thailand": "Bangkok",
    //    "China": "Beijing",
    //    "Japan": "Tokyo",
    //    "countryCapitalsInEurope": {
    //        "Germany": "Berlin",
    //        "Italy": "Rome"
    //    }
    //}

    consoleLog("// { ...object1, array2 } || { ...object1, objectKey: objectValue }:")

    combination11 := spreadObject(countryCapitalsInAsia, map[string]interface{}{"vegetables": vegetables})
    consoleLog(stringInterpolation("combination11: ", jsonStringify(combination11, map[string]interface{}{"pretty": true})))
    // combination11: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "vegetables": [
    //         "Carrot",
    //         "Tomato"
    //     ]
    // }

    combination12 := spreadObject(countryCapitalsInAsia, map[string]interface{}{"vegetables": []interface{}{"Cucumber", "Cabbage"}})
    consoleLog(stringInterpolation("combination12: ", jsonStringify(combination12, map[string]interface{}{"pretty": true})))
    // combination12: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "vegetables": [
    //         "Cucumber",
    //         "Cabbage"
    //     ]
    // }

    consoleLog("// { ...object1, ...array2 }:")

    combination13 := spreadObject(countryCapitalsInAsia, vegetables)
    consoleLog(stringInterpolation("combination13: ", jsonStringify(combination13, map[string]interface{}{"pretty": true})))
    // combination13: {
    //    "Thailand" : "Bangkok",
    //    "China" : "Beijing",
    //    "Japan" : "Tokyo",
    //    "0" : "Carrot",
    //    "1" : "Tomato"
    // }

    combination14 := spreadObject(countryCapitalsInAsia, []interface{}{"Cucumber", "Cabbage"})
    consoleLog(stringInterpolation("combination14: ", jsonStringify(combination14, map[string]interface{}{"pretty": true})))
    // combination14: {
    //    "Thailand" : "Bangkok",
    //    "China" : "Beijing",
    //    "Japan" : "Tokyo",
    //    "0" : "Cucumber",
    //    "1" : "Cabbage"
    // }

    // consoleLog("// [...array1, ...object1]: // this combination throw an error in JavaScript")

    // this combination throw an error in JavaScript
    // combinationErrorInJavaScript1 := spreadObject(fruits, countryCapitalsInAsia)
    // consoleLog(stringInterpolation("combinationErrorInJavaScript1: ", jsonStringify(combinationErrorInJavaScript1, map[string]interface{}{"pretty": true})))

    // this combination throw an error in JavaScript
    // combinationErrorInJavaScript2 := spreadObject(fruits, map[string]interface{}{"Germany": "Berlin", "Italy": "Rome"})
    // consoleLog(stringInterpolation("combinationErrorInJavaScript2: ", jsonStringify(combinationErrorInJavaScript2, map[string]interface{}{"pretty": true})))
}
