package main

import (
	"encoding/json"
	"errors"
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
		Function string
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

	getFloat64 := func(restArguments ...interface{}) interface{} {
		anything := restArguments[0]
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

	jsonStringifyV1 := func(restArguments ...interface{}) interface{} {
		prettyDefault := false
		indentDefault := "    "
		anything := restArguments[0]
		pretty := nullishCoalescing(optionalChaining((optionalChaining(restArguments, 1)), "pretty"), prettyDefault)
		jsonStringifyInner := func(restArgumentsJsonStringifyInner ...interface{}) interface{} {
			anythingInner := restArgumentsJsonStringifyInner[0]
			if (pretty == true) {
				jsonStringifyInnerResult, anError := json.MarshalIndent(anythingInner, "", indentDefault)
				if (anError == nil) {
					return string(jsonStringifyInnerResult)
				}
				return anError
			}
			jsonStringifyInnerResult, anError := json.Marshal(anythingInner)
			if (anError == nil) {
				return (strings.ReplaceAll(string(strings.ReplaceAll(string(strings.ReplaceAll(string(strings.ReplaceAll(string(jsonStringifyInnerResult), "{", "{ ")), "}", " }")), ":", ": ")), ",", ", "))
			}
			return anError
		}
		return jsonStringifyInner(anything)
	}

	jsonStringifyV2 := func(restArguments ...interface{}) interface{} {
		prettyDefault := false
		indentDefault := "    "
		anything := restArguments[0]
		pretty := nullishCoalescing(optionalChaining((optionalChaining(restArguments, 1)), "pretty"), prettyDefault)
		var jsonStringifyInner func(...interface{}) interface{}
		jsonStringifyInner = func(restArgumentsJsonStringifyInner ...interface{}) interface{} {
			anythingInner := restArgumentsJsonStringifyInner[0]
			anythingInnerType := getType(anythingInner)
			if ((anythingInnerType == jsLikeType.Null) || (anythingInnerType == jsLikeType.String) || (anythingInnerType == jsLikeType.Numeric) || (anythingInnerType == jsLikeType.Boolean)) {
				return anythingInner
			}
			if (anythingInnerType == jsLikeType.Object) {
				var newObject = map[string]interface{}{}
				objectEntryIndex := 0
				for objectKey, objectValue := range anythingInner.(map[string]interface{}) {
					newObject[objectKey] = jsonStringifyInner(objectValue)
					objectEntryIndex += 1
				}
				return newObject
			}
			if (anythingInnerType == jsLikeType.Array) {
				var newArray = []interface{}{}
				for _, arrayItem := range anythingInner.([]interface{}) {
					newArray = append(newArray, jsonStringifyInner(arrayItem))
				}
				return newArray
			}
			if (anythingInnerType == jsLikeType.Function) {
				return "[object Function]"
			}
			return anythingInnerType
		}
		jsonStringifyInnerResult := jsonStringifyInner(anything)
		return (ternary((pretty == true), func(_ ...interface{}) interface{} {
			jsonStringifyInnerResultPretty, anError := json.MarshalIndent(jsonStringifyInnerResult, "", indentDefault)
			if (anError == nil) {
				return string(jsonStringifyInnerResultPretty)
			}
			return anError
		}, func(_ ...interface{}) interface{} {
			jsonStringifyInnerResultDefault, anError := json.Marshal(jsonStringifyInnerResult)
			if (anError == nil) {
				return strings.ReplaceAll(string(strings.ReplaceAll(string(strings.ReplaceAll(string(strings.ReplaceAll(string(jsonStringifyInnerResultDefault), "{", "{ ")), "}", " }")), ":", ": ")), ",", ", ")
			}
			return anError
		}).(string))
	}

	jsonStringifyV3 := func(restArguments ...interface{}) interface{} {
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

	consoleLog("// JavaScript-like JSON.stringify() in Go")

	myArray := []interface{}{
        func(restArguments ...interface{}) interface{} {
			a := getFloat64(restArguments[0]).(float64)
			b := getFloat64(restArguments[1]).(float64)
			return (int(a + b))
		},
        "foo",
        123,
        true,
        nil,
        []interface{}{1, 2, 3},
        map[string]interface{}{"foo": "bar"},
    }
	consoleLog(stringInterpolation("jsonStringifyV1(myArray): ", jsonStringifyV1(myArray))) // return an error if array contains any functions
	consoleLog(stringInterpolation("jsonStringifyV2(myArray): ", jsonStringifyV2(myArray)))
	// ⭐⭐⭐⭐⭐
	consoleLog(stringInterpolation("jsonStringifyV3(myArray): ", jsonStringifyV3(myArray)))
	// ⭐⭐⭐⭐⭐
	consoleLog(stringInterpolation("jsonStringify(myArray): ", jsonStringify(myArray)))
	consoleLog(stringInterpolation(`jsonStringifyV1(myArray, map[string]interface{}{"pretty": true}): `, jsonStringifyV1(myArray, map[string]interface{}{"pretty": true}))) // return an error if array contains any functions
	consoleLog(stringInterpolation(`jsonStringifyV2(myArray, map[string]interface{}{"pretty": true}): `, jsonStringifyV2(myArray, map[string]interface{}{"pretty": true})))
	// ⭐⭐⭐⭐⭐
	consoleLog(stringInterpolation(`jsonStringifyV3(myArray, map[string]interface{}{"pretty": true}): `, jsonStringifyV3(myArray, map[string]interface{}{"pretty": true})))
	// ⭐⭐⭐⭐⭐
	consoleLog(stringInterpolation(`jsonStringify(myArray, map[string]interface{}{"pretty": true}): `, jsonStringify(myArray, map[string]interface{}{"pretty": true})))

	myObject := map[string]interface{}{
        "my_function": func(restArguments ...interface{}) interface{} {
			a := getFloat64(restArguments[0]).(float64)
			b := getFloat64(restArguments[1]).(float64)
			return (int(a + b))
		},
        "my_string": "foo",
        "my_number": 123,
        "my_bool": true,
        "my_null": nil,
        "my_array": []interface{}{1, 2, 3},
        "my_object": map[string]interface{}{
            "foo": "bar",
        },
    }
	consoleLog(stringInterpolation("jsonStringifyV1(myObject): ", jsonStringifyV1(myObject))) // return an error if array contains any functions
	consoleLog(stringInterpolation("jsonStringifyV2(myObject): ", jsonStringifyV2(myObject)))
	// ⭐⭐⭐⭐⭐
	consoleLog(stringInterpolation("jsonStringifyV3(myObject): ", jsonStringifyV3(myObject)))
	// ⭐⭐⭐⭐⭐
	consoleLog(stringInterpolation("jsonStringify(myObject): ", jsonStringify(myObject)))
	consoleLog(stringInterpolation(`jsonStringifyV1(myObject, map[string]interface{}{"pretty": true})`, jsonStringifyV1(myObject, map[string]interface{}{"pretty": true}))) // return an error if array contains any functions
	consoleLog(stringInterpolation(`jsonStringifyV2(myObject, map[string]interface{}{"pretty": true})`, jsonStringifyV2(myObject, map[string]interface{}{"pretty": true})))
	// ⭐⭐⭐⭐⭐
	consoleLog(stringInterpolation(`jsonStringifyV3(myObject, map[string]interface{}{"pretty": true})`, jsonStringifyV3(myObject, map[string]interface{}{"pretty": true})))
	// ⭐⭐⭐⭐⭐
	consoleLog(stringInterpolation(`jsonStringify(myObject, map[string]interface{}{"pretty": true})`, jsonStringify(myObject, map[string]interface{}{"pretty": true})))
}
