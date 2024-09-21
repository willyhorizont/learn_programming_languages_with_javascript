package main

import (
	"encoding/json"
	"errors"
	"fmt"
	"math"
	"reflect"
	"strings"
)

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

func ternary(trueCondition bool, callbackFunctionIfConditionTrue func() any, callbackFunctionIfConditionFalse func() any) any {
    if (trueCondition == true) {
        return callbackFunctionIfConditionTrue()
    }
    return callbackFunctionIfConditionFalse()
}

func jsonStringify(restArguments ...any) string {
	jsonStringifyInner := func(anythingInner any, prettyInner bool, indentInner string) string {
		if (prettyInner == true) {
			jsonStringifyInnerResult, err := json.MarshalIndent(anythingInner, "", indentInner)
			if (err == nil) {
				return string(jsonStringifyInnerResult)
			}
			return "null"
		}
        jsonStringifyInnerResult, err := json.Marshal(anythingInner)
		if (err == nil) {
			return strings.ReplaceAll(string(jsonStringifyInnerResult), ",", ", ")
		}
		return "null"
    }
    var anything any = restArguments[0]
	prettyDefault := false
	indentDefault := "    "
	var pretty any = prettyDefault
	var indent any = indentDefault
	if (len(restArguments) == 1) {
		return jsonStringifyInner(anything, prettyDefault, indentDefault)
	}
	var optionalArgument any = restArguments[1]
	if (optionalArgument == false) {
		return jsonStringifyInner(anything, prettyDefault, indentDefault)
	}
	if (reflect.TypeOf(optionalArgument).Kind() == reflect.Map) {
		pretty = optionalChaining(optionalArgument, "pretty")
		indent = optionalChaining(optionalArgument, "indent")
		pretty = ternary((pretty == nil), func() any { return prettyDefault }, func() any { return pretty })
		indent = ternary((indent == nil), func() any { return indentDefault }, func() any { return indent })
		return jsonStringifyInner(anything, pretty.(bool), indent.(string))
	}
	if (optionalArgument == true) {
		if (len(restArguments) >= 3) {
			var additionalArgument2 any = restArguments[2]
			if (reflect.TypeOf(additionalArgument2).Kind() == reflect.String) {
				indent = additionalArgument2
			}
		}
		pretty = optionalArgument
		return jsonStringifyInner(anything, pretty.(bool), indent.(string))
	}
	return jsonStringifyInner(anything, prettyDefault, indentDefault)
}

func sprint(restArguments ...any) {
    var newArray = []string{}
    for _, argument := range restArguments {
        argumentType := reflect.TypeOf(argument).Kind()
        if (argumentType == reflect.Slice && (len(argument.(array)) == 1)) {
            newArray = append(newArray, jsonStringify(argument.(array)[0]))
            continue
        }
        if (argumentType == reflect.String) {
			newArray = append(newArray, argument.(string))
            continue
        }
    }
    fmt.Println(strings.Join(newArray, ""))
}

func spreadObject(restArguments ...any) object {
    var newObject = make(object)
    for _, argument := range restArguments {
        argumentType := reflect.TypeOf(argument).Kind()
        if (argumentType == reflect.Map) {
            for objectKey, objectValue := range argument.(object) {
                newObject[objectKey] = objectValue
            }
			continue
        }
        if (argumentType == reflect.Slice) {
            for arrayItemIndex, arrayItem := range argument.(array) {
                newObject[jsonStringify(arrayItemIndex)] = arrayItem
            }
			continue
        }
    }
    return newObject
}

func spreadArray(restArguments ...any) array {
    var newArray = array{}
    for _, argument := range restArguments {
        argumentType := reflect.TypeOf(argument).Kind()
        if (argumentType == reflect.Map) {
            if (len(argument.(object)) == 1) {
                for _, objectValue := range argument.(object) {
                    newArray = append(newArray, objectValue)
                }
                continue
            }
            newArray = append(newArray, argument)
            continue
        }
        if (argumentType == reflect.Slice) {
            newArray = append(newArray, argument.(array)...)
            continue
        }
    }
    return newArray
}

func getFloatV1(anything any) (float64, error) {
    switch anythingNew := anything.(type) {
    case float64:
        return anythingNew, nil
    case float32:
        return float64(anythingNew), nil
    case int64:
        return float64(anythingNew), nil
    case int32: // rune
        return float64(anythingNew), nil
    case int16:
        return float64(anythingNew), nil
    case int8:
        return float64(anythingNew), nil
    case int:
        return float64(anythingNew), nil
    case uint64:
        return float64(anythingNew), nil
    case uint32:
        return float64(anythingNew), nil
    case uint16:
        return float64(anythingNew), nil
    case uint8: // byte
        return float64(anythingNew), nil
    case uint:
        return float64(anythingNew), nil
    case complex128:
        return real(anythingNew), nil
    case complex64:
        return float64(real(anythingNew)), nil
    default:
        return math.NaN(), errors.New("NON-NUMERIC TYPE COULD NOT BE CONVERTED TO FLOAT")
    }
}

func getFloatV2(anything any) (float64, error) {
    value := reflect.ValueOf(anything)
    value = reflect.Indirect(value)
    if (value.Type().ConvertibleTo(reflect.TypeOf(float64(0))) == false) {
        return math.NaN(), fmt.Errorf("CANNOT CONVERT %v TO FLOAT64", value.Type())
    }
    finalValue := value.Convert(reflect.TypeOf(float64(0)))
    return finalValue.Float(), nil
}

func main() {
    numbers := array{36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3}

    numbersTotal := arrayReduce(func(currentResult any, currentNumber any, _ int, _ array) any {
        // currentResultF64, currentResultF64Error := getFloatV2(currentResult)
        // currentNumberF64, currentNumberF64Error := getFloatV2(currentNumber)
        currentResultF64, currentResultF64Error := getFloatV1(currentResult)
        currentNumberF64, currentNumberF64Error := getFloatV1(currentNumber)
        if (currentResultF64Error == nil && currentNumberF64Error == nil) {
            return (currentResultF64 + currentNumberF64)
        }
        return currentResult
    }, numbers, 0.0)
    sprint("total number: ", array{numbersTotal})
    // total number: 635

    var mixedSlice = array{1, 2, 3, "a", "b", "c", true, false, nil}
    fmt.Println(mixedSlice) // Output: [nil nil nil]

	/*
any|array|object
map\[string\](?!interface\{)
\[\](?!interface\{\})
:"
change \" to " and change " to `
	*/
}
