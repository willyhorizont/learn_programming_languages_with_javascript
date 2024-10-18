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

    var CORRECT_ANSWER interface{} = 100
    var myAnswer interface{}
    var myAge interface{}
    var hasDrivingLicense interface{}
    var canDrive interface{}

    (consoleLog.(func(...interface{}) interface{}))("\n// basic conditional control flow\n")

    myAge = 10
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("myAge: ", []interface{}{myAge}))
    if ((myAge.(int)) > 24) {
        (consoleLog.(func(...interface{}) interface{}))("you are old")
    } else if ((myAge.(int)) > 17) {
        (consoleLog.(func(...interface{}) interface{}))("you are young")
    } else {
        (consoleLog.(func(...interface{}) interface{}))("you are under age")
    }

    (consoleLog.(func(...interface{}) interface{}))("\n// equal to (==)\n")

    myAnswer = 100
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("myAnswer: ", []interface{}{myAnswer}))
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("CORRECT_ANSWER: ", []interface{}{CORRECT_ANSWER}))
    (consoleLog.(func(...interface{}) interface{}))("(myAnswer == CORRECT_ANSWER):")
    if (myAnswer == CORRECT_ANSWER) {
        (consoleLog.(func(...interface{}) interface{}))("Your answer is correct")
    } else {
        (consoleLog.(func(...interface{}) interface{}))("Your answer is wrong")
    }

    (consoleLog.(func(...interface{}) interface{}))("\n// not equal to (!=)\n")

    myAnswer = 25
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("myAnswer: ", []interface{}{myAnswer}))
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("CORRECT_ANSWER: ", []interface{}{CORRECT_ANSWER}))
    (consoleLog.(func(...interface{}) interface{}))("(myAnswer != CORRECT_ANSWER):")
    if (myAnswer != CORRECT_ANSWER) {
        (consoleLog.(func(...interface{}) interface{}))("Your answer is correct")
    } else {
        (consoleLog.(func(...interface{}) interface{}))("Your answer is wrong")
    }

    (consoleLog.(func(...interface{}) interface{}))("\n// greater than (>)\n")

    myAge = 70
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("myAge: ", []interface{}{myAge}))
    (consoleLog.(func(...interface{}) interface{}))("(myAge > 50):")
    if ((myAge.(int)) > 50) {
        (consoleLog.(func(...interface{}) interface{}))("You are old")
    }

    (consoleLog.(func(...interface{}) interface{}))("\n// less than (<)\n")

    myAge = 16
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("myAge: ", []interface{}{myAge}))
    (consoleLog.(func(...interface{}) interface{}))("(myAge < 20):")
    if ((myAge.(int)) < 20) {
        (consoleLog.(func(...interface{}) interface{}))("You are young")
    }

    (consoleLog.(func(...interface{}) interface{}))("\n// greater than or equal to (>=)\n")

    myAge = 73
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("myAge: ", []interface{}{myAge}))
    (consoleLog.(func(...interface{}) interface{}))("(myAge >= 65):")
    if ((myAge.(int)) >= 65) {
        (consoleLog.(func(...interface{}) interface{}))("You are allowed to retire")
    }

    (consoleLog.(func(...interface{}) interface{}))("\n// less than or equal to (<=)\n")

    myAge = 14
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("myAge: ", []interface{}{myAge}))
    (consoleLog.(func(...interface{}) interface{}))("(myAge <= 16):")
    if ((myAge.(int)) <= 16) {
        (consoleLog.(func(...interface{}) interface{}))("You are not allowed to drive")
    }

    (consoleLog.(func(...interface{}) interface{}))("\n// Logical AND (&&)\n")

    myAge = 17
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("myAge: ", []interface{}{myAge}))
    hasDrivingLicense = false
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("hasDrivingLicense: ", []interface{}{hasDrivingLicense}))
    (consoleLog.(func(...interface{}) interface{}))("((myAge >= 17) && (hasDrivingLicense == true)):")
    if (((myAge.(int)) >= 17) && (hasDrivingLicense == true)) {
        (consoleLog.(func(...interface{}) interface{}))("You are allowed to drive")
    } else {
        (consoleLog.(func(...interface{}) interface{}))("You are not allowed to drive")
    }

    myAge = 17
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("myAge: ", []interface{}{myAge}))
    hasDrivingLicense = true
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("hasDrivingLicense: ", []interface{}{hasDrivingLicense}))
    (consoleLog.(func(...interface{}) interface{}))("((myAge >= 17) && (hasDrivingLicense == true)):")
    if (((myAge.(int)) >= 17) && (hasDrivingLicense == true)) {
        (consoleLog.(func(...interface{}) interface{}))("You are allowed to drive")
    } else {
        (consoleLog.(func(...interface{}) interface{}))("You are not allowed to drive")
    }

    (consoleLog.(func(...interface{}) interface{}))("\n// Logical OR (||)\n")

    myAge = 2
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("myAge: ", []interface{}{myAge}))
    (consoleLog.(func(...interface{}) interface{}))("((myAge <= 3) || (myAge >= 65)):")
    if (((myAge.(int)) <= 3) || ((myAge.(int)) >= 65)) {
        (consoleLog.(func(...interface{}) interface{}))("You should stay home")
    }

    myAge = 89
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("myAge: ", []interface{}{myAge}))
    (consoleLog.(func(...interface{}) interface{}))("((myAge <= 3) || (myAge >= 65)):")
    if (((myAge.(int)) <= 3) || ((myAge.(int)) >= 65)) {
        (consoleLog.(func(...interface{}) interface{}))("You should stay home")
    }

    (consoleLog.(func(...interface{}) interface{}))("\n// Logical NOT (!)\n")

    canDrive = false
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("canDrive: ", []interface{}{canDrive}))
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("!canDrive: ", []interface{}{!(canDrive.(bool))}))

    canDrive = true
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("canDrive: ", []interface{}{canDrive}))
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("!canDrive: ", []interface{}{!(canDrive.(bool))}))
}
