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
		anythingType := reflect.TypeOf(anything)
        return (arraySome(func(numericType interface{}, _ int, _ []interface{}) bool {
			return (anythingType.Kind() == numericType)
		}, []interface{}{reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64, reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64, reflect.Float32, reflect.Float64, reflect.Complex64, reflect.Complex128}))
    }
	isLikeJsObject := func(anything interface{}) bool {
		anythingType := reflect.TypeOf(anything)
		return ((anythingType.Kind() == reflect.Map) || ((anythingType.Kind() == reflect.Map) && (anythingType.Key().Kind() == reflect.String) && (anythingType.Elem().Kind() == reflect.Interface)) || (anythingType == reflect.TypeOf(map[string]interface{}{})) || (anythingType.String() == "map[string]interface {}") || (anythingType.String() == "map[string]interface {  }"))
    }
	isLikeJsArray := func(anything interface{}) bool {
		anythingType := reflect.TypeOf(anything)
        return ((anythingType.Kind() == reflect.Slice) || (anythingType == reflect.TypeOf([]interface{}{})) || (anythingType.String() == "[]interface {}") || (anythingType.String() == "[]interface {  }"))
    }
	isLikeJsFunction := func(anything interface{}) bool {
        return (reflect.TypeOf(anything).Kind() == reflect.Func)
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
		if (isLikeJsFunction(anything) == true) {
			return jsLikeType.Function
		}
		return reflect.TypeOf(anything).String()
    }
	anyToString := func(anything interface{}) string {
		anythingValue := reflect.ValueOf(anything)
		if (anythingValue.Kind() == reflect.String) {
			return anythingValue.String()
		}
		if (anythingValue.Kind() == reflect.Bool) {
			return fmt.Sprintf("%t", anythingValue.Bool())
		}
		if ((arraySome(func(numericType interface{}, _ int, _ []interface{}) bool {
			return (anythingValue.Kind() == numericType)
		}, []interface{}{reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64}))) {
			return fmt.Sprintf("%d", anythingValue.Int())
		}
		if ((arraySome(func(numericType interface{}, _ int, _ []interface{}) bool {
			return (anythingValue.Kind() == numericType)
		}, []interface{}{reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64}))) {
			return fmt.Sprintf("%d", anythingValue.Uint())
		}
		if ((arraySome(func(numericType interface{}, _ int, _ []interface{}) bool {
			return (anythingValue.Kind() == numericType)
		}, []interface{}{reflect.Float32, reflect.Float64}))) {
			return fmt.Sprintf("%f", anythingValue.Float())
		}
		if ((arraySome(func(numericType interface{}, _ int, _ []interface{}) bool {
			return (anythingValue.Kind() == numericType)
		}, []interface{}{reflect.Complex64, reflect.Complex128}))) {
			return fmt.Sprintf("%g", anythingValue.Complex())
		}
		return `"` + anythingValue.String() + `"`
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
		if (getType(anything) == jsLikeType.Function) {
			return anything.(func(...interface{}) interface{})(restArguments...)
		}
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
		indentLevel := 0
		var jsonStringifyInner func(interface{}) string
		jsonStringifyInner = func(anythingInner interface{}) string {
			if (getType(anythingInner) == jsLikeType.Null) {
				return "null"
			}
			if (getType(anythingInner) == jsLikeType.String) {
				return `"` + anythingInner.(string) + `"`
			}
			if ((getType(anythingInner) == jsLikeType.Numeric) || (getType(anythingInner) == jsLikeType.Boolean)) {
				return anyToString(anythingInner)
			}
			if (getType(anythingInner) == jsLikeType.Object) {
				if (len(anythingInner.(map[string]interface{})) == 0) {
					return "{}"
				}
				indentLevel += 1
				result := (ternary((pretty == true), func() interface{} {
					return "{\n" + strings.Repeat(indentDefault, indentLevel)
				}, func() interface{} {
					return "{ "
				}).(string))
				objectEntryIndex := 0
				for objectKey, objectValue := range anythingInner.(map[string]interface{}) {
					result += `"` + objectKey + `": ` + jsonStringifyInner(objectValue)
					if ((objectEntryIndex + 1) != len(anythingInner.(map[string]interface{}))) {
						result += (ternary((pretty == true), func() interface{} {
							return ",\n" + strings.Repeat(indentDefault, indentLevel)
						}, func() interface{} {
							return ", "
						}).(string))
					}
					objectEntryIndex += 1
				}
				indentLevel -= 1
				result += (ternary((pretty == true), func() interface{} {
					return "\n" + strings.Repeat(indentDefault, indentLevel) + "}"
				}, func() interface{} {
					return " }"
				}).(string))
				return result
			}
			if (getType(anythingInner) == jsLikeType.Array) {
				if (len(anythingInner.([]interface{})) == 0) {
					return "[]"
				}
				indentLevel += 1
				result := (ternary((pretty == true), func() interface{} {
					return "[\n" + strings.Repeat(indentDefault, indentLevel)
				}, func() interface{} {
					return "["
				}).(string))
				for arrayItemIndex, arrayItem := range anythingInner.([]interface{}) {
					result += jsonStringifyInner(arrayItem)
					if ((arrayItemIndex + 1) != len(anythingInner.([]interface{}))) {
						result += (ternary((pretty == true), func() interface{} {
							return ",\n" + strings.Repeat(indentDefault, indentLevel)
						}, func() interface{} {
							return ", "
						}).(string))
					}
				}
				indentLevel -= 1
				result += (ternary((pretty == true), func() interface{} {
					return "\n" + strings.Repeat(indentDefault, indentLevel) + "]"
				}, func() interface{} {
					return "]"
				}).(string))
				return result
			}
			if (getType(anythingInner) == jsLikeType.Function) {
				return `"[object Function]"`
			}
			return `"` + getType(anythingInner) + `"`
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

	jsonStringifyV1 := func(restArguments ...interface{}) string {
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

	jsonStringifyV2 := func(restArguments ...interface{}) string {
		prettyDefault := false
		indentDefault := "    "
		var anything interface{} = restArguments[0]
		var pretty interface{} = nullishCoalescing(optionalChaining((optionalChaining(restArguments, 1)), "pretty"), prettyDefault)
		var jsonStringifyInner func(interface{}) interface{}
		jsonStringifyInner = func(anythingInner interface{}) interface{} {
			if ((getType(anythingInner) == jsLikeType.Null) || (getType(anythingInner) == jsLikeType.String) || (getType(anythingInner) == jsLikeType.Numeric) || (getType(anythingInner) == jsLikeType.Boolean)) {
				return anythingInner
			}
			if (getType(anythingInner) == jsLikeType.Object) {
				var newObject = map[string]interface{}{}
				objectEntryIndex := 0
				for objectKey, objectValue := range anythingInner.(map[string]interface{}) {
					newObject[objectKey] = jsonStringifyInner(objectValue)
					objectEntryIndex += 1
				}
				return newObject
			}
			if (getType(anythingInner) == jsLikeType.Array) {
				var newArray = []interface{}{}
				for _, arrayItem := range anythingInner.([]interface{}) {
					newArray = append(newArray, jsonStringifyInner(arrayItem))
				}
				return newArray
			}
			if (getType(anythingInner) == jsLikeType.Function) {
				return "[object Function]"
			}
			return getType(anythingInner)
		}
		jsonStringifyInnerResult := jsonStringifyInner(anything)
		return (ternary((pretty == true), func() interface{} {
			jsonStringifyInnerPrettyResult, err := json.MarshalIndent(jsonStringifyInnerResult, "", indentDefault)
			if (err == nil) {
				return string(jsonStringifyInnerPrettyResult)
			}
			return "null"
		}, func() interface{} {
			jsonStringifyInnerDefaultResult, err := json.Marshal(jsonStringifyInnerResult)
			if (err == nil) {
				return strings.ReplaceAll(string(strings.ReplaceAll(string(strings.ReplaceAll(string(strings.ReplaceAll(string(jsonStringifyInnerDefaultResult), "{", "{ ")), "}", " }")), ":", ": ")), ",", ", ")
			}
			return "null"
		}).(string))
	}

	jsonStringifyV3 := func(restArguments ...interface{}) string {
		prettyDefault := false
		indentDefault := "    "
		var anything interface{} = restArguments[0]
		var pretty interface{} = nullishCoalescing(optionalChaining((optionalChaining(restArguments, 1)), "pretty"), prettyDefault)
		indentLevel := 0
		var jsonStringifyInner func(interface{}) string
		jsonStringifyInner = func(anythingInner interface{}) string {
			if (getType(anythingInner) == jsLikeType.Null) {
				return "null"
			}
			if (getType(anythingInner) == jsLikeType.String) {
				return `"` + anythingInner.(string) + `"`
			}
			if ((getType(anythingInner) == jsLikeType.Numeric) || (getType(anythingInner) == jsLikeType.Boolean)) {
				return anyToString(anythingInner)
			}
			if (getType(anythingInner) == jsLikeType.Object) {
				if (len(anythingInner.(map[string]interface{})) == 0) {
					return "{}"
				}
				indentLevel += 1
				result := (ternary((pretty == true), func() interface{} {
					return "{\n" + strings.Repeat(indentDefault, indentLevel)
				}, func() interface{} {
					return "{ "
				}).(string))
				objectEntryIndex := 0
				for objectKey, objectValue := range anythingInner.(map[string]interface{}) {
					result += `"` + objectKey + `": ` + jsonStringifyInner(objectValue)
					if ((objectEntryIndex + 1) != len(anythingInner.(map[string]interface{}))) {
						result += (ternary((pretty == true), func() interface{} {
							return ",\n" + strings.Repeat(indentDefault, indentLevel)
						}, func() interface{} {
							return ", "
						}).(string))
					}
					objectEntryIndex += 1
				}
				indentLevel -= 1
				result += (ternary((pretty == true), func() interface{} {
					return "\n" + strings.Repeat(indentDefault, indentLevel) + "}"
				}, func() interface{} {
					return " }"
				}).(string))
				return result
			}
			if (getType(anythingInner) == jsLikeType.Array) {
				if (len(anythingInner.([]interface{})) == 0) {
					return "[]"
				}
				indentLevel += 1
				result := (ternary((pretty == true), func() interface{} {
					return "[\n" + strings.Repeat(indentDefault, indentLevel)
				}, func() interface{} {
					return "["
				}).(string))
				for arrayItemIndex, arrayItem := range anythingInner.([]interface{}) {
					result += jsonStringifyInner(arrayItem)
					if ((arrayItemIndex + 1) != len(anythingInner.([]interface{}))) {
						result += (ternary((pretty == true), func() interface{} {
							return ",\n" + strings.Repeat(indentDefault, indentLevel)
						}, func() interface{} {
							return ", "
						}).(string))
					}
				}
				indentLevel -= 1
				result += (ternary((pretty == true), func() interface{} {
					return "\n" + strings.Repeat(indentDefault, indentLevel) + "]"
				}, func() interface{} {
					return "]"
				}).(string))
				return result
			}
			if (getType(anythingInner) == jsLikeType.Function) {
				return `"[object Function]"`
			}
			return `"` + getType(anythingInner) + `"`
		}
		return jsonStringifyInner(anything)
	}

	consoleLog("// JavaScript-like JSON.stringify() in Go")

	myArray := []interface{}{
        func(a int, b int) int {
            return (a * b)
        },
        "foo",
        123,
        true,
        nil,
        []interface{}{1, 2, 3},
        map[string]interface{}{"foo": "bar"},
    }
	consoleLog(stringInterpolation("jsonStringifyV1(myArray): ", jsonStringifyV1(myArray))) // return "null" if array contains any functions
	consoleLog(stringInterpolation("jsonStringifyV2(myArray): ", jsonStringifyV2(myArray)))
	consoleLog(stringInterpolation("jsonStringifyV3(myArray): ", jsonStringifyV3(myArray)))
	consoleLog(stringInterpolation("jsonStringify(myArray): ", jsonStringify(myArray)))
	consoleLog(stringInterpolation("jsonStringifyV1(myArray): ", jsonStringifyV1(myArray, map[string]interface{}{"pretty": true}))) // return "null" if array contains any functions
	consoleLog(stringInterpolation("jsonStringifyV2(myArray): ", jsonStringifyV2(myArray, map[string]interface{}{"pretty": true})))
	consoleLog(stringInterpolation("jsonStringifyV3(myArray): ", jsonStringifyV3(myArray, map[string]interface{}{"pretty": true})))
	consoleLog(stringInterpolation("jsonStringify(myArray): ", jsonStringify(myArray, map[string]interface{}{"pretty": true})))

	myObject := map[string]interface{}{
        "my_function": func(a int, b int) int {
            return (a * b)
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
	consoleLog(stringInterpolation("jsonStringifyV1(myObject): ", jsonStringifyV1(myObject))) // return "null" if array contains any functions
	consoleLog(stringInterpolation("jsonStringifyV2(myObject): ", jsonStringifyV2(myObject)))
	consoleLog(stringInterpolation("jsonStringifyV3(myObject): ", jsonStringifyV3(myObject)))
	consoleLog(stringInterpolation("jsonStringify(myObject): ", jsonStringify(myObject)))
	consoleLog(stringInterpolation("jsonStringifyV1(myObject): ", jsonStringifyV1(myObject, map[string]interface{}{"pretty": true}))) // return "null" if array contains any functions
	consoleLog(stringInterpolation("jsonStringifyV2(myObject): ", jsonStringifyV2(myObject, map[string]interface{}{"pretty": true})))
	consoleLog(stringInterpolation("jsonStringifyV3(myObject): ", jsonStringifyV3(myObject, map[string]interface{}{"pretty": true})))
	consoleLog(stringInterpolation("jsonStringify(myObject): ", jsonStringify(myObject, map[string]interface{}{"pretty": true})))
}
