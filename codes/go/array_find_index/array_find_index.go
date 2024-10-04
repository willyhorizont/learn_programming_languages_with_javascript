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

	arrayFindIndexV1 := func(restArguments ...interface{}) interface{} {
		// JavaScript-like Array.findIndex() function
		callbackFunction := restArguments[0].(func(...interface{}) interface{})
		anArray := restArguments[1].([]interface{})
		dataFoundIndex := -1
		for arrayItemIndex, arrayItem := range anArray {
			isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
			if (isConditionMatch == true) {
				dataFoundIndex = arrayItemIndex
				break
			}
		}
		return dataFoundIndex
	}
	
	arrayFindIndexV2 := func(restArguments ...interface{}) interface{} {
		// JavaScript-like Array.findIndex() function
		callbackFunction := restArguments[0].(func(...interface{}) interface{})
		anArray := restArguments[1].([]interface{})
		dataFoundIndex := -1
		for arrayItemIndex, arrayItem := range anArray {
			if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
				dataFoundIndex = arrayItemIndex
				break
			}
		}
		return dataFoundIndex
	}
	
	arrayFindIndexV3 := func(restArguments ...interface{}) interface{} {
		// JavaScript-like Array.findIndex() function
		callbackFunction := restArguments[0].(func(...interface{}) interface{})
		anArray := restArguments[1].([]interface{})
		for arrayItemIndex, arrayItem := range anArray {
			isConditionMatch := callbackFunction(arrayItem, arrayItemIndex, anArray)
			if (isConditionMatch == true) {
				return arrayItemIndex
			}
		}
		return -1
	}
	
	arrayFindIndexV4 := func(restArguments ...interface{}) interface{} {
		// JavaScript-like Array.findIndex() function
		callbackFunction := restArguments[0].(func(...interface{}) interface{})
		anArray := restArguments[1].([]interface{})
		for arrayItemIndex, arrayItem := range anArray {
			if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
				return arrayItemIndex
			}
		}
		return -1
	}

    consoleLog("\n// JavaScript-like Array.findIndex() in Go Slice")

    numbers := []interface{}{12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
    consoleLog(stringInterpolation("numbers: ", []interface{}{numbers}))

    numberToFind := 27
    consoleLog(stringInterpolation("number to find: ", []interface{}{numberToFind}))

    consoleLog(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV1"`)

    {
		numberFoundIndex := arrayFindIndexV1(func(restArguments ...interface{}) interface{} {
			anyNumber := int((getFloat64(restArguments[0]).(float64)))
			return (anyNumber == numberToFind)
		}, numbers)
		consoleLog(stringInterpolation("number found index: ", []interface{}{numberFoundIndex}))
		// number found index: 2
	}

    consoleLog(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV2"`)

    {
		numberFoundIndex := arrayFindIndexV2(func(restArguments ...interface{}) interface{} {
			anyNumber := int((getFloat64(restArguments[0]).(float64)))
			return (anyNumber == numberToFind)
		}, numbers)
		consoleLog(stringInterpolation("number found index: ", []interface{}{numberFoundIndex}))
		// number found index: 2
	}

    consoleLog(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV3"`)

    {
		numberFoundIndex := arrayFindIndexV3(func(restArguments ...interface{}) interface{} {
			anyNumber := int((getFloat64(restArguments[0]).(float64)))
			return (anyNumber == numberToFind)
		}, numbers)
		consoleLog(stringInterpolation("number found index: ", []interface{}{numberFoundIndex}))
		// number found index: 2
	}

    consoleLog(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV4"`)

    {
		numberFoundIndex := arrayFindIndexV4(func(restArguments ...interface{}) interface{} {
			anyNumber := int((getFloat64(restArguments[0]).(float64)))
			return (anyNumber == numberToFind)
		}, numbers)
		consoleLog(stringInterpolation("number found index: ", []interface{}{numberFoundIndex}))
		// number found index: 2
	}

    consoleLog("\n// JavaScript-like Array.findIndex() in Go Slice of maps")

    products := []interface{}{
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
    consoleLog(stringInterpolation("products: ", jsonStringify(products, map[string]interface{}{"pretty": true})))

	productToFind := "pasta"
	consoleLog(stringInterpolation("product to find: ", productToFind))

    consoleLog(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV1"`)

    {
		productFoundIndex := arrayFindIndexV1(func(restArguments ...interface{}) interface{} {
			anyProduct := restArguments[0]
			productCode := optionalChaining(anyProduct, "code")
			return (productCode == productToFind)
		}, products)
		consoleLog(stringInterpolation("product found index: ", []interface{}{productFoundIndex}))
		// product found index: 0
	}

    consoleLog(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV2"`)

    {
		productFoundIndex := arrayFindIndexV2(func(restArguments ...interface{}) interface{} {
			anyProduct := restArguments[0]
			productCode := optionalChaining(anyProduct, "code")
			return (productCode == productToFind)
		}, products)
		consoleLog(stringInterpolation("product found index: ", []interface{}{productFoundIndex}))
		// product found index: 0
	}

    consoleLog(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV3"`)

    {
		productFoundIndex := arrayFindIndexV3(func(restArguments ...interface{}) interface{} {
			anyProduct := restArguments[0]
			productCode := optionalChaining(anyProduct, "code")
			return (productCode == productToFind)
		}, products)
		consoleLog(stringInterpolation("product found index: ", []interface{}{productFoundIndex}))
		// product found index: 0
	}

    consoleLog(`// using JavaScript-like Array.findIndex() function "arrayFindIndexV4"`)

    {
		productFoundIndex := arrayFindIndexV4(func(restArguments ...interface{}) interface{} {
			anyProduct := restArguments[0]
			productCode := optionalChaining(anyProduct, "code")
			return (productCode == productToFind)
		}, products)
		consoleLog(stringInterpolation("product found index: ", []interface{}{productFoundIndex}))
		// product found index: 0
	}
}
