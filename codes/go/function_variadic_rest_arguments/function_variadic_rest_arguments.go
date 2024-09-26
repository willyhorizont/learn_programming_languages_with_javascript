package main

import (
	"encoding/json"
	"fmt"
	"reflect"
	"strings"
)

func main() {
	jsLikeType := struct {
		Null string
		Boolean string
		String string
		Numeric string
		Object string
		Array string
	}{
		Null: "Null",
		Boolean: "Boolean",
		String: "String",
		Numeric: "Numeric",
		Object: "Object",
		Array: "Array",
	}
	ternary := func(trueCondition bool, callbackFunctionIfConditionTrue func() interface{}, callbackFunctionIfConditionFalse func() interface{}) interface{} {
		if (trueCondition == true) {
			return callbackFunctionIfConditionTrue()
		}
		return callbackFunctionIfConditionFalse()
	}
	arraySome := func(callbackFunction func(interface{}, int, []interface{}) bool, anArray []interface{}) bool {
		// JavaScript-like Array.some() function arraySomeV4
		for arrayItemIndex, arrayItem := range anArray {
			if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
				return true
			}
		}
		return false
	}
	isLikeJsNull := func(anything interface{}) bool {
		return (anything == nil)
    }
	isLikeJsBoolean := func(anything interface{}) bool {
        return ((reflect.TypeOf(anything).Kind() == reflect.Bool) && ((anything == true) || (anything == false)))
    }
	isLikeJsString := func(anything interface{}) bool {
        return (reflect.TypeOf(anything).Kind() == reflect.String)
    }
	isLikeJsNumeric := func(anything interface{}) bool {
        return (arraySome(func(numericType interface{}, _ int, _ []interface{}) bool {
			return (reflect.TypeOf(anything).Kind() == numericType)
		}, []interface{}{reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64, reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64, reflect.Float32, reflect.Float64, reflect.Complex64, reflect.Complex128}))
    }
	isLikeJsObject := func(anything interface{}) bool {
		return ((reflect.TypeOf(anything).Kind() == reflect.Map) || ((reflect.TypeOf(anything).Kind() == reflect.Map) && (reflect.TypeOf(anything).Key().Kind() == reflect.String) && (reflect.TypeOf(anything).Elem().Kind() == reflect.Interface)) || (reflect.TypeOf(anything) == reflect.TypeOf(map[string]interface{}{})) || (reflect.TypeOf(anything).String() == "map[string]interface {}") || (reflect.TypeOf(anything).String() == "map[string]interface {  }"))
    }
	isLikeJsArray := func(anything interface{}) bool {
        return ((reflect.TypeOf(anything).Kind() == reflect.Slice) || (reflect.TypeOf(anything) == reflect.TypeOf([]interface{}{})) || (reflect.TypeOf(anything).String() == "[]interface {}") || (reflect.TypeOf(anything).String() == "[]interface {  }"))
    }
	getType := func(anything interface{}) string {
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
		return reflect.TypeOf(anything).String()
    }
	arrayReduce := func(callbackFunction func(interface{}, interface{}, int, []interface{}) interface{}, anArray []interface{}, initialValue interface{}) interface{} {
		// JavaScript-like Array.reduce() function
		result := initialValue
		for arrayItemIndex, arrayItem := range anArray {
			result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
		}
		return result
	}
	optionalChaining := func(anything interface{}, restArguments ...interface{}) interface{} {
		if (((getType(anything) != jsLikeType.Object) && (getType(anything) != jsLikeType.Array)) || (len(restArguments) == 0)) {
			return anything
		}
		return arrayReduce(func(currentResult interface{}, currentItem interface{}, _ int, _ []interface{}) interface{} {
			if ((getType(currentResult) == jsLikeType.Null) && (getType(anything) == jsLikeType.Object) && (getType(currentItem) == jsLikeType.String)) {
				return anything.(map[string]interface{})[currentItem.(string)]
			}
			if ((getType(currentResult) == jsLikeType.Null) && (getType(anything) == jsLikeType.Array) && (reflect.TypeOf(currentItem).Kind() == reflect.Int) && (currentItem.(int) >= 0) && (len(anything.([]interface{})) > currentItem.(int))) {
				return anything.([]interface{})[currentItem.(int)]
			}
			if ((getType(currentResult) == jsLikeType.Object) && (getType(currentItem) == jsLikeType.String)) {
				return currentResult.(map[string]interface{})[currentItem.(string)]
			}
			if ((getType(currentResult) == jsLikeType.Array) && (reflect.TypeOf(currentItem).Kind() == reflect.Int) && (currentItem.(int) >= 0) && (len(currentResult.([]interface{})) > currentItem.(int))) {
				return currentResult.([]interface{})[currentItem.(int)]
			}
			return nil
		}, restArguments, nil)
	}
	nullishCoalescing := func(anything interface{}, defaultValue interface{}) interface{} {
		if (anything == nil) {
			return defaultValue
		} else {
			return anything
		}
	}
	jsonStringify := func(restArguments ...interface{}) string {
		prettyDefault := false
		indentDefault := "    "
		var anything interface{} = restArguments[0]
		var pretty interface{} = nullishCoalescing(optionalChaining((optionalChaining(restArguments, 1)), "pretty"), prettyDefault)
		jsonStringifyInner := func(anythingInner interface{}) string {
			if (pretty == true) {
				jsonStringifyInnerResult, err := json.MarshalIndent(anythingInner, "", indentDefault)
				if (err == nil) {
					return string(jsonStringifyInnerResult)
				}
				return "null"
			}
			jsonStringifyInnerResult, err := json.Marshal(anythingInner)
			if (err == nil) {
				return (strings.ReplaceAll(string(strings.ReplaceAll(string(strings.ReplaceAll(string(strings.ReplaceAll(string(jsonStringifyInnerResult), "{", "{ ")), "}", " }")), ":", ": ")), ",", ", "))
			}
			return "null"
		}
		return jsonStringifyInner(anything)
	}
	stringInterpolation := func(restArguments ...interface{}) string {
        return (arrayReduce(func(currentResult interface{}, currentArgument interface{}, _ int, _ []interface{}) interface{} {
			return (currentResult.(string) + ternary(
				(getType(currentArgument) == jsLikeType.String),
				(func() interface{} {
					return currentArgument.(string)
				}),
				(func() interface{} {
					return (ternary(
						((getType(currentArgument) == jsLikeType.Array) && (len(currentArgument.([]interface{})) == 1)),
						(func() interface{} {
							return jsonStringify(currentArgument.([]interface{})[0])
						}),
						(func() interface{} {
							return jsonStringify(currentArgument)
						}),
					).(string))
				}),
			).(string))
		}, restArguments, "").(string))
    }
	consoleLog := func(restArguments ...interface{}) {
        fmt.Println(stringInterpolation(restArguments...))
    }

	consoleLog("// Variadic Function Rest Arguments in Go")
	functionVariadic := func(restArguments ...interface{}) {
		consoleLog(stringInterpolation("function variadic rest arguments: ", []interface{}{restArguments}))
    }
	functionVariadic(1, 2, 3, 4)
}
