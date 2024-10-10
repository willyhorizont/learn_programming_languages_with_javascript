package main

import (
	"errors"
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
	var arrayFindIndexV1 interface{} = func(restArguments ...interface{}) interface{} {
		// JavaScript-like Array.findIndex() function
		var callbackFunction interface{} = restArguments[0]
		var anArray interface{} = restArguments[1]
		var dataFoundIndex interface{} = -1
		var arrayItemIndex interface{}
		var arrayItem interface{}
		for arrayItemIndex, arrayItem = range (anArray.([]interface{})) {
			var isConditionMatch interface{} = ((callbackFunction.(func(...interface{}) interface{}))(arrayItem, arrayItemIndex, anArray))
			if (isConditionMatch == true) {
				dataFoundIndex = arrayItemIndex
				break
			}
		}
		return dataFoundIndex
	}
	var arrayFindIndexV2 interface{} = func(restArguments ...interface{}) interface{} {
		// JavaScript-like Array.findIndex() function
		var callbackFunction interface{} = restArguments[0]
		var anArray interface{} = restArguments[1]
		var dataFoundIndex interface{} = -1
		var arrayItemIndex interface{}
		var arrayItem interface{}
		for arrayItemIndex, arrayItem = range (anArray.([]interface{})) {
			if (((callbackFunction.(func(...interface{}) interface{}))(arrayItem, arrayItemIndex, anArray)) == true) {
				dataFoundIndex = arrayItemIndex
				break
			}
		}
		return dataFoundIndex
	}
	var arrayFindIndexV3 interface{} = func(restArguments ...interface{}) interface{} {
		// JavaScript-like Array.findIndex() function
		var callbackFunction interface{} = restArguments[0]
		var anArray interface{} = restArguments[1]
		var arrayItemIndex interface{}
		var arrayItem interface{}
		for arrayItemIndex, arrayItem = range (anArray.([]interface{})) {
			var isConditionMatch interface{} = ((callbackFunction.(func(...interface{}) interface{}))(arrayItem, arrayItemIndex, anArray))
			if (isConditionMatch == true) {
				return arrayItemIndex
			}
		}
		return -1
	}
	var arrayFindIndexV4 interface{} = func(restArguments ...interface{}) interface{} {
		// JavaScript-like Array.findIndex() function
		var callbackFunction interface{} = restArguments[0]
		var anArray interface{} = restArguments[1]
		var arrayItemIndex interface{}
		var arrayItem interface{}
		for arrayItemIndex, arrayItem = range (anArray.([]interface{})) {
			if (((callbackFunction.(func(...interface{}) interface{}))(arrayItem, arrayItemIndex, anArray)) == true) {
				return arrayItemIndex
			}
		}
		return -1
	}

    (consoleLog.(func(...interface{}) interface{}))("\n// JavaScript-like Array.findIndex() in Go Slice")

    var numbers interface{} = []interface{}{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("numbers: ", []interface{}{numbers}))

    var numberToFind interface{} = 27
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("number to find: ", []interface{}{numberToFind}))

    (consoleLog.(func(...interface{}) interface{}))(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV1"`)

    {
		var numberFoundIndex interface{} = (arrayFindIndexV1.(func(...interface{}) interface{}))(func(restArguments ...interface{}) interface{} {
			var anyNumber interface{} = int(((getFloat64.(func(...interface{}) interface{}))(restArguments[0]).(float64)))
			return (anyNumber == numberToFind)
		}, numbers)
		(consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("number found index: ", []interface{}{numberFoundIndex}))
		// number found index: 2
	}

    (consoleLog.(func(...interface{}) interface{}))(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV2"`)

    {
		var numberFoundIndex interface{} = (arrayFindIndexV2.(func(...interface{}) interface{}))(func(restArguments ...interface{}) interface{} {
			var anyNumber interface{} = int(((getFloat64.(func(...interface{}) interface{}))(restArguments[0]).(float64)))
			return (anyNumber == numberToFind)
		}, numbers)
		(consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("number found index: ", []interface{}{numberFoundIndex}))
		// number found index: 2
	}

    (consoleLog.(func(...interface{}) interface{}))(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV3"`)

    {
		var numberFoundIndex interface{} = (arrayFindIndexV3.(func(...interface{}) interface{}))(func(restArguments ...interface{}) interface{} {
			var anyNumber interface{} = int(((getFloat64.(func(...interface{}) interface{}))(restArguments[0]).(float64)))
			return (anyNumber == numberToFind)
		}, numbers)
		(consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("number found index: ", []interface{}{numberFoundIndex}))
		// number found index: 2
	}

    (consoleLog.(func(...interface{}) interface{}))(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV4"`)

    {
		var numberFoundIndex interface{} = (arrayFindIndexV4.(func(...interface{}) interface{}))(func(restArguments ...interface{}) interface{} {
			var anyNumber interface{} = int(((getFloat64.(func(...interface{}) interface{}))(restArguments[0]).(float64)))
			return (anyNumber == numberToFind)
		}, numbers)
		(consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("number found index: ", []interface{}{numberFoundIndex}))
		// number found index: 2
	}

    (consoleLog.(func(...interface{}) interface{}))("\n// JavaScript-like Array.findIndex() in Go Slice of maps")

    var products interface{} = []interface{}{
        map[string]interface{}{
            "code": "pasta",
            "price": 321,
        },
        map[string]interface{}{
            "code": "bubble_gum",
            "price": 233,
        },
        map[string]interface{}{
            "code": "potato_chips",
            "price": 5,
        },
        map[string]interface{}{
            "code": "towel",
            "price": 499,
        },
    }
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("products: ", (jsonStringify.(func(...interface{}) interface{}))(products, map[string]interface{}{"pretty": true})))

	var productToFind interface{} = "pasta"
	(consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("product to find: ", productToFind))

    (consoleLog.(func(...interface{}) interface{}))(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV1"`)

    {
		var productFoundIndex interface{} = (arrayFindIndexV1.(func(...interface{}) interface{}))(func(restArguments ...interface{}) interface{} {
			var anyProduct interface{} = restArguments[0]
			var productCode interface{} = (optionalChaining.(func(...interface{}) interface{}))(anyProduct, "code")
			return (productCode == productToFind)
		}, products)
		(consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("product found index: ", []interface{}{productFoundIndex}))
		// product found index: 0
	}

    (consoleLog.(func(...interface{}) interface{}))(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV2"`)

    {
		var productFoundIndex interface{} = (arrayFindIndexV2.(func(...interface{}) interface{}))(func(restArguments ...interface{}) interface{} {
			var anyProduct interface{} = restArguments[0]
			var productCode interface{} = (optionalChaining.(func(...interface{}) interface{}))(anyProduct, "code")
			return (productCode == productToFind)
		}, products)
		(consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("product found index: ", []interface{}{productFoundIndex}))
		// product found index: 0
	}

    (consoleLog.(func(...interface{}) interface{}))(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV3"`)

    {
		var productFoundIndex interface{} = (arrayFindIndexV3.(func(...interface{}) interface{}))(func(restArguments ...interface{}) interface{} {
			var anyProduct interface{} = restArguments[0]
			var productCode interface{} = (optionalChaining.(func(...interface{}) interface{}))(anyProduct, "code")
			return (productCode == productToFind)
		}, products)
		(consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("product found index: ", []interface{}{productFoundIndex}))
		// product found index: 0
	}

    (consoleLog.(func(...interface{}) interface{}))(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV4"`)

    {
		var productFoundIndex interface{} = (arrayFindIndexV4.(func(...interface{}) interface{}))(func(restArguments ...interface{}) interface{} {
			var anyProduct interface{} = restArguments[0]
			var productCode interface{} = (optionalChaining.(func(...interface{}) interface{}))(anyProduct, "code")
			return (productCode == productToFind)
		}, products)
		(consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("product found index: ", []interface{}{productFoundIndex}))
		// product found index: 0
	}
}
