package main

import (
	"errors"
	"fmt"
	"math"
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
		var anythingJsLikeType interface{} = ((getType.(func(...interface{}) interface{}))(anything))
		if (anythingJsLikeType == jsLikeType.Function) {
			return ((anything.(func(...interface{}) interface{}))((restArgumentsNew.([]interface{}))...))
		}
		if (((anythingJsLikeType != jsLikeType.Object) && (anythingJsLikeType != jsLikeType.Array)) || (len((restArgumentsNew.([]interface{}))) == 0)) {
			return anything
		}
		return ((arrayReduce.(func(...interface{}) interface{}))((interface{}(func(restArgumentsArrayReduceCallback ...interface{}) interface{} {
			var currentResult interface{} = restArgumentsArrayReduceCallback[0]
			var currentItem interface{} = restArgumentsArrayReduceCallback[1]
			var currentResultJsLikeType interface{} = ((getType.(func(...interface{}) interface{}))(currentResult))
			var currentItemJsLikeType interface{} = ((getType.(func(...interface{}) interface{}))(currentItem))
			if ((currentResultJsLikeType == jsLikeType.Null) && (anythingJsLikeType == jsLikeType.Object) && (currentItemJsLikeType == jsLikeType.String)) {
				return (anything.(map[string]interface{}))[(currentItem.(string))]
			}
			if ((currentResultJsLikeType == jsLikeType.Null) && (anythingJsLikeType == jsLikeType.Array) && (reflect.TypeOf(currentItem).Kind() == reflect.Int) && ((currentItem.(int)) >= 0) && (len(anything.([]interface{})) > (currentItem.(int)))) {
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
			var anythingInnerJsLikeType interface{} = ((getType.(func(...interface{}) interface{}))(anythingInner).(string))
			if (anythingInnerJsLikeType == jsLikeType.Null) {
				return "null"
			}
			if (anythingInnerJsLikeType == jsLikeType.String) {
				return `"` + (anythingInner.(string)) + `"`
			}
			if ((anythingInnerJsLikeType == jsLikeType.Numeric) || (anythingInnerJsLikeType == jsLikeType.Boolean)) {
				return ((anyToString.(func(...interface{}) interface{}))(anythingInner))
			}
			if (anythingInnerJsLikeType == jsLikeType.Object) {
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
			if (anythingInnerJsLikeType == jsLikeType.Array) {
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
			if (anythingInnerJsLikeType == jsLikeType.Function) {
				return `"[object Function]"`
			}
			return (`"` + (anythingInnerJsLikeType.(string)) + `"`)
		}
		return ((jsonStringifyInner.(func(...interface{}) interface{}))(anything))
	}
	var stringInterpolation interface{} = func(restArguments ...interface{}) interface{} {
		return ((arrayReduce.(func(...interface{}) interface{}))((interface{}(func(restArgumentsArrayReduceCallback ...interface{}) interface{} {
			var currentResult interface{} = restArgumentsArrayReduceCallback[0]
			var currentArgument interface{} = restArgumentsArrayReduceCallback[1]
			var currentArgumentJsLikeType interface{} = (getType.(func(...interface{}) interface{}))(currentArgument)
			return (currentResult.(string) + (ternary.(func(...interface{}) interface{}))(
				(interface{}(currentArgumentJsLikeType == jsLikeType.String)),
				(interface{}(func(_ ...interface{}) interface{} {
					return (currentArgument.(string))
				})),
				(interface{}(func(_ ...interface{}) interface{} {
					return ((ternary.(func(...interface{}) interface{}))(
						(interface{}((currentArgumentJsLikeType == jsLikeType.Array) && (len(currentArgument.([]interface{})) == 1))),
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
	var getFloat64 interface{} = func(restArguments ...interface{}) interface{} {
		var anything interface{} = restArguments[0]
		switch anythingNew := anything.(type) {
		case float64:
			return anythingNew
		case float32:
			return float64(anythingNew)
		case int64:
			return float64(anythingNew)
		case int32: // rune
			return float64(anythingNew)
		case int16:
			return float64(anythingNew)
		case int8:
			return float64(anythingNew)
		case int:
			return float64(anythingNew)
		case uint64:
			return float64(anythingNew)
		case uint32:
			return float64(anythingNew)
		case uint16:
			return float64(anythingNew)
		case uint8: // byte
			return float64(anythingNew)
		case uint:
			return float64(anythingNew)
		default:
			return errors.New("excpected float64-convertible value")
		}
	}
	var pipe interface{} = func(restArguments ...interface{}) interface{} {
        var pipeLastResult interface{} = nil
		var pipeResult interface{} = (arrayReduce.(func(...interface{}) interface{}))((interface{}(func(restArgumentsArrayReduceCallback ...interface{}) interface{} {
			var currentResult interface{} = restArgumentsArrayReduceCallback[0]
			var currentArgument interface{} = restArgumentsArrayReduceCallback[1]
			pipeLastResult = currentResult
			if (((getType.(func(...interface{}) interface{}))(currentResult)) == jsLikeType.Null) {
				return currentArgument
			}
			if (((getType.(func(...interface{}) interface{}))(currentArgument)) == jsLikeType.Function) {
				return ((currentArgument.(func(...interface{}) interface{}))(currentResult))
			}
			return nil
		})), restArguments, nil)
		if (((getType.(func(...interface{}) interface{}))(pipeResult)) == jsLikeType.Function) {
			return ((pipeResult.(func(...interface{}) interface{}))(pipeLastResult))
		}
		return pipeResult
    }

	(consoleLog.(func(...interface{}) interface{}))("// Pipe Function in PHP")

	var plus25 interface{} = func(restArguments ...interface{}) interface{} {
		var aNumber interface{} = restArguments[0]
        return (int((getFloat64.(func(...interface{}) interface{}))(aNumber).(float64)) + 25)
    }

	var multiplyBy10 interface{} = func(restArguments ...interface{}) interface{} {
		var aNumber interface{} = restArguments[0]
        return (int((getFloat64.(func(...interface{}) interface{}))(aNumber).(float64)) * 10)
    }

	(consoleLog.(func(...interface{}) interface{}))((multiplyBy10.(func(...interface{}) interface{}))((plus25.(func(...interface{}) interface{}))(17))) // read from inside to outside

	(pipe.(func(...interface{}) interface{}))(17, plus25, multiplyBy10, func(restArguments ...interface{}) interface{} {
		var x interface{} = restArguments[0]
		(consoleLog.(func(...interface{}) interface{}))(x)
		return nil
	}) // read from left to right

	(pipe.(func(...interface{}) interface{}))(
		17,
		plus25,
		multiplyBy10,
		func(restArguments ...interface{}) interface{} {
			var x interface{} = restArguments[0]
			(consoleLog.(func(...interface{}) interface{}))(x)
			return nil
		},
	) // read from left to right

	(consoleLog.(func(...interface{}) interface{}))((pipe.(func(...interface{}) interface{}))(17, plus25, multiplyBy10)) // read from left to right

	var makeNumbersEasyToSay interface{} = func(restArguments ...interface{}) interface{} {
		var aNumber interface{} = restArguments[0]
        return ((stringInterpolation.(func(...interface{}) interface{}))(int((getFloat64.(func(...interface{}) interface{}))(aNumber).(float64)), ".something"))
    }

	var getCircleAreaInSquareCm interface{} = func(restArguments ...interface{}) interface{} {
		var radiusInCm interface{} = restArguments[0]
        return (3.14 * (math.Pow((getFloat64.(func(...interface{}) interface{}))(radiusInCm).(float64), 2)))
    }

	var getCylinderVolumeInMlOrCubicCm interface{} = func(restArguments ...interface{}) interface{} {
		var circleAreaInSquareCm interface{} = restArguments[0]
		var heightInCm interface{} = restArguments[1]
        return ((getFloat64.(func(...interface{}) interface{}))(circleAreaInSquareCm).(float64) * (getFloat64.(func(...interface{}) interface{}))(heightInCm).(float64))
    }

	var getMassInMlOrCubicCm interface{} = func(restArguments ...interface{}) interface{} {
		var volumeInMlOrCubicCm interface{} = restArguments[0]
		var densityInGramPerMlOrCubicCm interface{} = restArguments[1]
        return ((getFloat64.(func(...interface{}) interface{}))(volumeInMlOrCubicCm).(float64) * (getFloat64.(func(...interface{}) interface{}))(densityInGramPerMlOrCubicCm).(float64))
    }

	(consoleLog.(func(...interface{}) interface{}))((makeNumbersEasyToSay.(func(...interface{}) interface{}))((getMassInMlOrCubicCm.(func(...interface{}) interface{}))((getCylinderVolumeInMlOrCubicCm.(func(...interface{}) interface{}))((getCircleAreaInSquareCm.(func(...interface{}) interface{}))(7), 10), 0.72587))) // read from inside to outside

	(pipe.(func(...interface{}) interface{}))(7, getCircleAreaInSquareCm, func(restArguments ...interface{}) interface{} {
		var x interface{} = restArguments[0]
		return (getCylinderVolumeInMlOrCubicCm.(func(...interface{}) interface{}))(x, 10)
	}, func(restArguments ...interface{}) interface{} {
		var x interface{} = restArguments[0]
		return (getMassInMlOrCubicCm.(func(...interface{}) interface{}))(x, 0.72587)
	}, makeNumbersEasyToSay, func(restArguments ...interface{}) interface{} {
		var x interface{} = restArguments[0]
		(consoleLog.(func(...interface{}) interface{}))(x)
		return nil
	}) // read from left to right

	(pipe.(func(...interface{}) interface{}))(
		7,
		getCircleAreaInSquareCm,
		func(restArguments ...interface{}) interface{} {
			var x interface{} = restArguments[0]
			return (getCylinderVolumeInMlOrCubicCm.(func(...interface{}) interface{}))(x, 10)
		},
		func(restArguments ...interface{}) interface{} {
			var x interface{} = restArguments[0]
			return (getMassInMlOrCubicCm.(func(...interface{}) interface{}))(x, 0.72587)
		},
		makeNumbersEasyToSay,
		func(restArguments ...interface{}) interface{} {
			var x interface{} = restArguments[0]
			(consoleLog.(func(...interface{}) interface{}))(x)
			return nil
		},
	) // read from left to right

	(consoleLog.(func(...interface{}) interface{}))((pipe.(func(...interface{}) interface{}))(7, getCircleAreaInSquareCm, func(restArguments ...interface{}) interface{} {
		var x interface{} = restArguments[0]
		return (getCylinderVolumeInMlOrCubicCm.(func(...interface{}) interface{}))(x, 10)
	}, func(restArguments ...interface{}) interface{} {
		var x interface{} = restArguments[0]
		return (getMassInMlOrCubicCm.(func(...interface{}) interface{}))(x, 0.72587)
	}, makeNumbersEasyToSay)) // read from left to right

	(consoleLog.(func(...interface{}) interface{}))((pipe.(func(...interface{}) interface{}))(
		7,
		getCircleAreaInSquareCm,
		func(restArguments ...interface{}) interface{} {
			var x interface{} = restArguments[0]
			return (getCylinderVolumeInMlOrCubicCm.(func(...interface{}) interface{}))(x, 10)
		},
		func(restArguments ...interface{}) interface{} {
			var x interface{} = restArguments[0]
			return (getMassInMlOrCubicCm.(func(...interface{}) interface{}))(x, 0.72587)
		},
		makeNumbersEasyToSay,
	)) // read from left to right
}
