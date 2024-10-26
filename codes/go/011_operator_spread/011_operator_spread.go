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
	}{ Null: "Null", Boolean: "Boolean", String: "String", Numeric: "Numeric", Object: "Object", Array: "Array", Function: "Function" }
	var ternary interface{} = func(restArguments ...interface{}) interface{} {
		var trueCondition interface{} = restArguments[0]
		var callbackFunctionIfConditionTrue interface{} = restArguments[1]
		var callbackFunctionIfConditionFalse interface{} = restArguments[2]
		if (trueCondition == true) {
			return (callbackFunctionIfConditionTrue.(func(...interface{}) interface{}))()
		}
		return (callbackFunctionIfConditionFalse.(func(...interface{}) interface{}))()
	}
	var arraySome interface{} = func(restArguments ...interface{}) interface{} {
		// JavaScript-like Array.some() function arraySomeV4
		var callbackFunction interface{} = restArguments[0]
		var anArray interface{} = restArguments[1]
		var arrayItemIndex interface{}
		var arrayItem interface{}
		for arrayItemIndex, arrayItem = range (anArray.([]interface{})) {
			if (((callbackFunction.(func(...interface{}) interface{}))(arrayItem, arrayItemIndex, anArray)) == true) {
				return true
			}
		}
		return false
	}
	var isLikeJsNull interface{} = func(restArguments ...interface{}) interface{} {
		var anything interface{} = restArguments[0]
		return (anything == nil)
	}
	var isLikeJsBoolean interface{} = func(restArguments ...interface{}) interface{} {
		var anything interface{} = restArguments[0]
		return ((reflect.TypeOf(anything).Kind() == reflect.Bool) && ((anything == true) || (anything == false)))
	}
	var isLikeJsString interface{} = func(restArguments ...interface{}) interface{} {
		var anything interface{} = restArguments[0]
		return (reflect.TypeOf(anything).Kind() == reflect.String)
	}
	var isLikeJsNumeric interface{} = func(restArguments ...interface{}) interface{} {
		var anything interface{} = restArguments[0]
		var anythingGoTypeKind interface{} = reflect.TypeOf(anything).Kind()
		return ((arraySome.(func(...interface{}) interface{}))((interface{}(func(restArgumentsArraySomeCallback ...interface{}) interface{} {
			var numericGoTypeKind interface{} = restArgumentsArraySomeCallback[0]
			return (anythingGoTypeKind == numericGoTypeKind)
		})), ([]interface{}{reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64, reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64, reflect.Float32, reflect.Float64, reflect.Complex64, reflect.Complex128})))
	}
	var isLikeJsObject interface{} = func(restArguments ...interface{}) interface{} {
		var anything interface{} = restArguments[0]
		anythingGoType := reflect.TypeOf(anything)
		return ((anythingGoType.Kind() == reflect.Map) || ((anythingGoType.Kind() == reflect.Map) && (anythingGoType.Key().Kind() == reflect.String) && (anythingGoType.Elem().Kind() == reflect.Interface)) || (anythingGoType == reflect.TypeOf(map[string]interface{}{})) || (anythingGoType.String() == "map[string]interface {}") || (anythingGoType.String() == "map[string]interface {  }"))
	}
	var isLikeJsArray interface{} = func(restArguments ...interface{}) interface{} {
		var anything interface{} = restArguments[0]
		anythingGoType := reflect.TypeOf(anything)
		return ((anythingGoType.Kind() == reflect.Slice) || (anythingGoType == reflect.TypeOf([]interface{}{})) || (anythingGoType.String() == "[]interface {}") || (anythingGoType.String() == "[]interface {  }"))
	}
	var isLikeJsFunction interface{} = func(restArguments ...interface{}) interface{} {
		var anything interface{} = restArguments[0]
		return (reflect.TypeOf(anything).Kind() == reflect.Func)
	}
	var getType interface{} = func(restArguments ...interface{}) interface{} {
		var anything interface{} = restArguments[0]
		if (((isLikeJsNull.(func(...interface{}) interface{}))(anything)) == true) {
			return jsLikeType.Null
		}
		if (((isLikeJsBoolean.(func(...interface{}) interface{}))(anything)) == true) {
			return jsLikeType.Boolean
		}
		if (((isLikeJsString.(func(...interface{}) interface{}))(anything)) == true) {
			return jsLikeType.String
		}
		if (((isLikeJsNumeric.(func(...interface{}) interface{}))(anything)) == true) {
			return jsLikeType.Numeric
		}
		if (((isLikeJsObject.(func(...interface{}) interface{}))(anything)) == true) {
			return jsLikeType.Object
		}
		if (((isLikeJsArray.(func(...interface{}) interface{}))(anything)) == true) {
			return jsLikeType.Array
		}
		if (((isLikeJsFunction.(func(...interface{}) interface{}))(anything)) == true) {
			return jsLikeType.Function
		}
		return reflect.TypeOf(anything).String()
	}
	var anyToString interface{} = func(restArguments ...interface{}) interface{} {
		var anything interface{} = restArguments[0]
		anythingGoValue := reflect.ValueOf(anything)
		if (anythingGoValue.Kind() == reflect.String) {
			return anythingGoValue.String()
		}
		if (anythingGoValue.Kind() == reflect.Bool) {
			return fmt.Sprintf("%t", anythingGoValue.Bool())
		}
		if (((arraySome.(func(...interface{}) interface{}))((interface{}(func(restArgumentsArraySomeCallback ...interface{}) interface{} {
			var numericIntType interface{} = restArgumentsArraySomeCallback[0]
			return (anythingGoValue.Kind() == numericIntType)
		})), ([]interface{}{reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64}))) == true) {
			return fmt.Sprintf("%d", anythingGoValue.Int())
		}
		if (((arraySome.(func(...interface{}) interface{}))((interface{}(func(restArgumentsArraySomeCallback ...interface{}) interface{} {
			var numericUintType interface{} = restArgumentsArraySomeCallback[0]
			return (anythingGoValue.Kind() == numericUintType)
		})), ([]interface{}{reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64}))) == true) {
			return fmt.Sprintf("%d", anythingGoValue.Uint())
		}
		if (((arraySome.(func(...interface{}) interface{}))((interface{}(func(restArgumentsArraySomeCallback ...interface{}) interface{} {
			var numericFloatType interface{} = restArgumentsArraySomeCallback[0]
			return (anythingGoValue.Kind() == numericFloatType)
		})), ([]interface{}{reflect.Float32, reflect.Float64}))) == true) {
			return fmt.Sprintf("%f", anythingGoValue.Float())
		}
		if (((arraySome.(func(...interface{}) interface{}))((interface{}(func(restArgumentsArraySomeCallback ...interface{}) interface{} {
			var numericComplexType interface{} = restArgumentsArraySomeCallback[0]
			return (anythingGoValue.Kind() == numericComplexType)
		})), ([]interface{}{reflect.Complex64, reflect.Complex128}))) == true) {
			return fmt.Sprintf("%g", anythingGoValue.Complex())
		}
		return `"` + anythingGoValue.String() + `"`
	}
	var arrayReduce interface{} = func(restArguments ...interface{}) interface{} {
		// JavaScript-like Array.reduce() function
		var callbackFunction interface{} = restArguments[0]
		var anArray interface{} = restArguments[1]
		var initialValue interface{} = restArguments[2]
		var result interface{} = initialValue
		var arrayItemIndex interface{}
		var arrayItem interface{}
		for arrayItemIndex, arrayItem = range (anArray.([]interface{})) {
			result = (callbackFunction.(func(...interface{}) interface{}))(result, arrayItem, arrayItemIndex, anArray)
		}
		return result
	}
	var optionalChaining interface{} = func(restArguments ...interface{}) interface{} {
		var anything interface{} = restArguments[0]
		var restArgumentsNew interface{} = restArguments[1:]
		var anythingType interface{} = ((getType.(func(...interface{}) interface{}))(anything))
		if (anythingType == jsLikeType.Function) {
			return ((anything.(func(...interface{}) interface{}))((restArgumentsNew.([]interface{}))...))
		}
		if (((anythingType != jsLikeType.Object) && (anythingType != jsLikeType.Array)) || (len((restArgumentsNew.([]interface{}))) == 0)) {
			return anything
		}
		return ((arrayReduce.(func(...interface{}) interface{}))((interface{}(func(restArgumentsArrayReduceCallback ...interface{}) interface{} {
			var currentResult interface{} = restArgumentsArrayReduceCallback[0]
			var currentItem interface{} = restArgumentsArrayReduceCallback[1]
			var currentResultJsLikeType interface{} = ((getType.(func(...interface{}) interface{}))(currentResult))
			var currentItemJsLikeType interface{} = ((getType.(func(...interface{}) interface{}))(currentItem))
			if ((currentResultJsLikeType == jsLikeType.Null) && (anythingType == jsLikeType.Object) && (currentItemJsLikeType == jsLikeType.String)) {
				return (anything.(map[string]interface{}))[(currentItem.(string))]
			}
			if ((currentResultJsLikeType == jsLikeType.Null) && (anythingType == jsLikeType.Array) && (reflect.TypeOf(currentItem).Kind() == reflect.Int) && ((currentItem.(int)) >= 0) && (len(anything.([]interface{})) > (currentItem.(int)))) {
				return (anything.([]interface{}))[(currentItem.(int))]
			}
			if ((currentResultJsLikeType == jsLikeType.Object) && (currentItemJsLikeType == jsLikeType.String)) {
				return (currentResult.(map[string]interface{}))[(currentItem.(string))]
			}
			if ((currentResultJsLikeType == jsLikeType.Array) && (reflect.TypeOf(currentItem).Kind() == reflect.Int) && ((currentItem.(int)) >= 0) && (len(currentResult.([]interface{})) > (currentItem.(int)))) {
				return (currentResult.([]interface{}))[(currentItem.(int))]
			}
			return nil
		})), (restArgumentsNew.([]interface{})), nil))
	}
	var nullishCoalescing interface{} = func(restArguments ...interface{}) interface{} {
		var anything interface{} = restArguments[0]
		var defaultValue interface{} = restArguments[1]
		if (anything == nil) {
			return defaultValue
		} else {
			return anything
		}
	}
	var jsonStringify interface{} = func(restArguments ...interface{}) interface{} {
		var prettyDefault interface{} = false
		var anything interface{} = restArguments[0]
		var pretty interface{} = (nullishCoalescing.(func(...interface{}) interface{}))((optionalChaining.(func(...interface{}) interface{}))(((optionalChaining.(func(...interface{}) interface{}))(restArguments, 1)), "pretty"), prettyDefault)
		var indentDefault interface{} = strings.Repeat(" ", 4)
		var indentLevel interface{} = 0
		var jsonStringifyInner interface{}
		jsonStringifyInner = func(restArgumentsJsonStringifyInner ...interface{}) interface{} {
			var anythingInner interface{} = restArgumentsJsonStringifyInner[0]
			var anythingInnerType interface{} = ((getType.(func(...interface{}) interface{}))(anythingInner).(string))
			if (anythingInnerType == jsLikeType.Null) {
				return "null"
			}
			if (anythingInnerType == jsLikeType.String) {
				return `"` + (anythingInner.(string)) + `"`
			}
			if ((anythingInnerType == jsLikeType.Numeric) || (anythingInnerType == jsLikeType.Boolean)) {
				return ((anyToString.(func(...interface{}) interface{}))(anythingInner))
			}
			if (anythingInnerType == jsLikeType.Object) {
				if (len(anythingInner.(map[string]interface{})) == 0) {
					return "{}"
				}
				indentLevel = (indentLevel.(int)) + 1
				var result interface{} = ((ternary.(func(...interface{}) interface{}))((interface{}(pretty == true)), (interface{}(func(_ ...interface{}) interface{} {
					return ("{\n" + strings.Repeat((indentDefault.(string)), (indentLevel.(int))))
				})), (interface{}(func(_ ...interface{}) interface{} {
					return "{ "
				}))).(string))
				var objectEntryIndex interface{} = 0
				var objectKey interface{}
				var objectValue interface{}
				for objectKey, objectValue = range (anythingInner.(map[string]interface{})) {
					result = ((result.(string)) + (`"` + (objectKey.(string)) + `": ` + ((jsonStringifyInner.(func(...interface{}) interface{}))(objectValue).(string))))
					if (((objectEntryIndex.(int)) + 1) != len(anythingInner.(map[string]interface{}))) {
						result = ((result.(string)) + ((ternary.(func(...interface{}) interface{}))((interface{}(pretty == true)), (interface{}(func(_ ...interface{}) interface{} {
							return ",\n" + strings.Repeat((indentDefault.(string)), (indentLevel.(int)))
						})), (interface{}(func(_ ...interface{}) interface{} {
							return ", "
						}))).(string)))
					}
					objectEntryIndex = (objectEntryIndex.(int)) + 1
				}
				indentLevel = (indentLevel.(int)) - 1
				result = ((result.(string)) + ((ternary.(func(...interface{}) interface{}))((interface{}(pretty == true)), (interface{}(func(_ ...interface{}) interface{} {
					return "\n" + strings.Repeat((indentDefault.(string)), (indentLevel.(int))) + "}"
				})), (interface{}(func(_ ...interface{}) interface{} {
					return " }"
				}))).(string)))
				return result
			}
			if (anythingInnerType == jsLikeType.Array) {
				if (len(anythingInner.([]interface{})) == 0) {
					return "[]"
				}
				indentLevel = (indentLevel.(int)) + 1
				var result interface{} = ((ternary.(func(...interface{}) interface{}))((interface{}(pretty == true)), (interface{}(func(_ ...interface{}) interface{} {
					return ("[\n" + strings.Repeat((indentDefault.(string)), (indentLevel.(int))))
				})), (interface{}(func(_ ...interface{}) interface{} {
					return "["
				}))).(string))
				var arrayItemIndex interface{}
				var arrayItem interface{}
				for arrayItemIndex, arrayItem = range (anythingInner.([]interface{})) {
					result = ((result.(string)) + ((jsonStringifyInner.(func(...interface{}) interface{}))(arrayItem).(string)))
					if (((arrayItemIndex.(int)) + 1) != len(anythingInner.([]interface{}))) {
						result = ((result.(string)) + ((ternary.(func(...interface{}) interface{}))((interface{}(pretty == true)), (interface{}(func(_ ...interface{}) interface{} {
							return ",\n" + strings.Repeat((indentDefault.(string)), (indentLevel.(int)))
						})), (interface{}(func(_ ...interface{}) interface{} {
							return ", "
						}))).(string)))
					}
				}
				indentLevel = (indentLevel.(int)) - 1
				result = ((result.(string)) + ((ternary.(func(...interface{}) interface{}))((interface{}(pretty == true)), (interface{}(func(_ ...interface{}) interface{} {
					return "\n" + strings.Repeat((indentDefault.(string)), (indentLevel.(int))) + "]"
				})), (interface{}(func(_ ...interface{}) interface{} {
					return "]"
				}))).(string)))
				return result
			}
			if (anythingInnerType == jsLikeType.Function) {
				return "[object Function]"
			}
			return anythingInnerType
		}
		return ((jsonStringifyInner.(func(...interface{}) interface{}))(anything))
	}
	var stringInterpolation interface{} = func(restArguments ...interface{}) interface{} {
		return ((arrayReduce.(func(...interface{}) interface{}))((interface{}(func(restArgumentsArrayReduceCallback ...interface{}) interface{} {
			var currentResult interface{} = restArgumentsArrayReduceCallback[0]
			var currentArgument interface{} = restArgumentsArrayReduceCallback[1]
			var currentArgumentType interface{} = (getType.(func(...interface{}) interface{}))(currentArgument)
			return (currentResult.(string) + (ternary.(func(...interface{}) interface{}))(
				(interface{}(currentArgumentType == jsLikeType.String)),
				(interface{}(func(_ ...interface{}) interface{} {
					return (currentArgument.(string))
				})),
				(interface{}(func(_ ...interface{}) interface{} {
					return ((ternary.(func(...interface{}) interface{}))(
						(interface{}((currentArgumentType == jsLikeType.Array) && (len(currentArgument.([]interface{})) == 1))),
						(interface{}(func(_ ...interface{}) interface{} {
							return ((jsonStringify.(func(...interface{}) interface{}))(currentArgument.([]interface{})[0]))
						})),
						(interface{}(func(_ ...interface{}) interface{} {
							return ((jsonStringify.(func(...interface{}) interface{}))(currentArgument))
						})),
					).(string))
				})),
			).(string))
		})), restArguments, "").(string))
	}
	var consoleLog interface{} = func(restArguments ...interface{}) interface{} {
		fmt.Println((((stringInterpolation.(func(...interface{}) interface{}))(restArguments...)).(string)))
		return nil
	}
	var spreadObject interface{} = func(restArguments ...interface{}) interface{} {
		var newObject interface{} = map[string]interface{}{}
		var argument interface{}
		for _, argument = range restArguments {
			var argumentJsLikeType interface{} = (getType.(func(...interface{}) interface{}))(argument)
			if (argumentJsLikeType == jsLikeType.Object) {
				var objectKey interface{}
				var objectValue interface{}
				for objectKey, objectValue = range argument.(map[string]interface{}) {
					(newObject.(map[string]interface{}))[(objectKey.(string))] = objectValue
				}
				continue
			}
			if (argumentJsLikeType == jsLikeType.Array) {
				var arrayItemIndex interface{}
				var arrayItem interface{}
				for arrayItemIndex, arrayItem = range argument.([]interface{}) {
					(newObject.(map[string]interface{}))[(jsonStringify.(func(...interface{}) interface{}))(arrayItemIndex).(string)] = arrayItem
				}
				continue
			}
		}
		return newObject
	}
	var spreadArray interface{} = func(restArguments ...interface{}) interface{} {
		var newArray interface{} = []interface{}{}
		var argument interface{}
		for _, argument = range restArguments {
			var argumentJsLikeType interface{} = (getType.(func(...interface{}) interface{}))(argument)
			if (argumentJsLikeType == jsLikeType.Object) {
				if (len(argument.(map[string]interface{})) == 1) {
					var objectValue interface{}
					for _, objectValue = range argument.(map[string]interface{}) {
						newArray = append((newArray.([]interface{})), objectValue)
					}
					continue
				}
				newArray = append((newArray.([]interface{})), argument)
				continue
			}
			if (argumentJsLikeType == jsLikeType.Array) {
				newArray = append((newArray.([]interface{})), argument.([]interface{})...)
				continue
			}
		}
		return newArray
	}

    (consoleLog.(func(...interface{}) interface{}))("\n// JavaScript-like Spread Syntax (...) in Go")

    var fruits interface{} = []interface{}{"Mango", "Melon", "Banana"}
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("fruits: ", (jsonStringify.(func(...interface{}) interface{}))(fruits)))

    var vegetables interface{} = []interface{}{"Carrot", "Tomato"}
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("vegetables: ", (jsonStringify.(func(...interface{}) interface{}))(vegetables)))

    var countryCapitalsInAsia interface{} = map[string]interface{}{
        "Thailand": "Bangkok",
        "China": "Beijing",
        "Japan": "Tokyo",
    }
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("countryCapitalsInAsia: ", (jsonStringify.(func(...interface{}) interface{}))(countryCapitalsInAsia, map[string]interface{}{"pretty": true})))

    var countryCapitalsInEurope interface{} = map[string]interface{}{
        "France": "Paris",
        "England": "London",
    }
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("countryCapitalsInEurope: ", (jsonStringify.(func(...interface{}) interface{}))(countryCapitalsInEurope, map[string]interface{}{"pretty": true})))

    (consoleLog.(func(...interface{}) interface{}))("// [...array1, ...array2]:")

    var combination1 interface{} = (spreadArray.(func(...interface{}) interface{}))(fruits, vegetables)
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination1: ", (jsonStringify.(func(...interface{}) interface{}))(combination1, map[string]interface{}{"pretty": true})))
    // combination1: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Carrot",
    //     "Tomato"
    // ]

    var combination2 interface{} = (spreadArray.(func(...interface{}) interface{}))(fruits, []interface{}{"Cucumber", "Cabbage"})
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination2: ", (jsonStringify.(func(...interface{}) interface{}))(combination2, map[string]interface{}{"pretty": true})))
    // combination2: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     "Cucumber",
    //     "Cabbage"
    // ]

    (consoleLog.(func(...interface{}) interface{}))("// { ...object1, ...object2 }:")

    var combination3 interface{} = (spreadObject.(func(...interface{}) interface{}))(countryCapitalsInAsia, countryCapitalsInEurope)
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination3: ", (jsonStringify.(func(...interface{}) interface{}))(combination3, map[string]interface{}{"pretty": true})))
    // combination3: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "France": "Paris",
    //     "England": "London"
    // }

    var combination4 interface{} = (spreadObject.(func(...interface{}) interface{}))(countryCapitalsInAsia, map[string]interface{}{"Germany": "Berlin", "Italy": "Rome"})
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination4: ", (jsonStringify.(func(...interface{}) interface{}))(combination4, map[string]interface{}{"pretty": true})))
    // combination4: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "Germany": "Berlin",
    //     "Italy": "Rome"
    // }

    (consoleLog.(func(...interface{}) interface{}))("// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:")

    var combination5 interface{} = (spreadArray.(func(...interface{}) interface{}))(fruits, map[string]interface{}{"vegetables": vegetables})
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination5: ", (jsonStringify.(func(...interface{}) interface{}))(combination5, map[string]interface{}{"pretty": true})))
    // combination5: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     [
    //         "Carrot",
    //         "Tomato"
    //     ]
    // ]

    var combination6 interface{} = (spreadArray.(func(...interface{}) interface{}))(fruits, map[string]interface{}{"vegetables": []interface{}{"Cucumber", "Cabbage"}})
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination6: ", (jsonStringify.(func(...interface{}) interface{}))(combination6, map[string]interface{}{"pretty": true})))
    // combination6: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     [
    //         "Cucumber",
    //         "Cabbage"
    //     ]
    // ]

    (consoleLog.(func(...interface{}) interface{}))("// [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:")

    var combination7 interface{} = (spreadArray.(func(...interface{}) interface{}))(fruits, map[string]interface{}{"countryCapitalsInAsia": countryCapitalsInAsia})
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination7: ", (jsonStringify.(func(...interface{}) interface{}))(combination7, map[string]interface{}{"pretty": true})))
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

    var combination8 interface{} = (spreadArray.(func(...interface{}) interface{}))(fruits, map[string]interface{}{"Germany": "Berlin", "Italy": "Rome"})
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination8: ", (jsonStringify.(func(...interface{}) interface{}))(combination8, map[string]interface{}{"pretty": true})))
    // combination8: [
    //     "Mango",
    //     "Melon",
    //     "Banana",
    //     {
    //         "Germany": "Berlin",
    //         "Italy": "Rome"
    //     }
    // ]

    (consoleLog.(func(...interface{}) interface{}))("// { ...object1, object2 } || { ...object1, objectKey: objectValue }:")

    var combination9 interface{} = (spreadObject.(func(...interface{}) interface{}))(countryCapitalsInAsia, map[string]interface{}{"countryCapitalsInEurope": countryCapitalsInEurope})
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination9: ", (jsonStringify.(func(...interface{}) interface{}))(combination9, map[string]interface{}{"pretty": true})))
    // combination9: {
    //    "Thailand" : "Bangkok",
    //    "China" : "Beijing",
    //    "Japan" : "Tokyo",
    //    "countryCapitalsInEurope" : {
    //       "France" : "Paris",
    //       "England" : "London"
    //    }
    // }

    var combination10 interface{} = (spreadObject.(func(...interface{}) interface{}))(countryCapitalsInAsia, map[string]interface{}{"countryCapitalsInEurope": map[string]interface{}{"Germany": "Berlin", "Italy": "Rome"}})
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination10: ", (jsonStringify.(func(...interface{}) interface{}))(combination10, map[string]interface{}{"pretty": true})))
    //combination10: {
    //    "Thailand": "Bangkok",
    //    "China": "Beijing",
    //    "Japan": "Tokyo",
    //    "countryCapitalsInEurope": {
    //        "Germany": "Berlin",
    //        "Italy": "Rome"
    //    }
    //}

    (consoleLog.(func(...interface{}) interface{}))("// { ...object1, array2 } || { ...object1, objectKey: objectValue }:")

    var combination11 interface{} = (spreadObject.(func(...interface{}) interface{}))(countryCapitalsInAsia, map[string]interface{}{"vegetables": vegetables})
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination11: ", (jsonStringify.(func(...interface{}) interface{}))(combination11, map[string]interface{}{"pretty": true})))
    // combination11: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "vegetables": [
    //         "Carrot",
    //         "Tomato"
    //     ]
    // }

    var combination12 interface{} = (spreadObject.(func(...interface{}) interface{}))(countryCapitalsInAsia, map[string]interface{}{"vegetables": []interface{}{"Cucumber", "Cabbage"}})
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination12: ", (jsonStringify.(func(...interface{}) interface{}))(combination12, map[string]interface{}{"pretty": true})))
    // combination12: {
    //     "Thailand": "Bangkok",
    //     "China": "Beijing",
    //     "Japan": "Tokyo",
    //     "vegetables": [
    //         "Cucumber",
    //         "Cabbage"
    //     ]
    // }

    (consoleLog.(func(...interface{}) interface{}))("// { ...object1, ...array2 }:")

    var combination13 interface{} = (spreadObject.(func(...interface{}) interface{}))(countryCapitalsInAsia, vegetables)
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination13: ", (jsonStringify.(func(...interface{}) interface{}))(combination13, map[string]interface{}{"pretty": true})))
    // combination13: {
    //    "Thailand" : "Bangkok",
    //    "China" : "Beijing",
    //    "Japan" : "Tokyo",
    //    "0" : "Carrot",
    //    "1" : "Tomato"
    // }

    var combination14 interface{} = (spreadObject.(func(...interface{}) interface{}))(countryCapitalsInAsia, []interface{}{"Cucumber", "Cabbage"})
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combination14: ", (jsonStringify.(func(...interface{}) interface{}))(combination14, map[string]interface{}{"pretty": true})))
    // combination14: {
    //    "Thailand" : "Bangkok",
    //    "China" : "Beijing",
    //    "Japan" : "Tokyo",
    //    "0" : "Cucumber",
    //    "1" : "Cabbage"
    // }

    // (consoleLog.(func(...interface{}) interface{}))("// [...array1, ...object1]: // this combination throw an error in JavaScript")

    // this combination throw an error in JavaScript
    // var combinationErrorInJavaScript1 interface{} = (spreadObject.(func(...interface{}) interface{}))(fruits, countryCapitalsInAsia)
    // (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combinationErrorInJavaScript1: ", (jsonStringify.(func(...interface{}) interface{}))(combinationErrorInJavaScript1, map[string]interface{}{"pretty": true})))

    // this combination throw an error in JavaScript
    // var combinationErrorInJavaScript2 interface{} = (spreadObject.(func(...interface{}) interface{}))(fruits, map[string]interface{}{"Germany": "Berlin", "Italy": "Rome"})
    // (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("combinationErrorInJavaScript2: ", (jsonStringify.(func(...interface{}) interface{}))(combinationErrorInJavaScript2, map[string]interface{}{"pretty": true})))
}
