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

func jsonStringify(anything any, additionalParameter any) string {
	jsonStringifyDefault := func(anythingInner any) string {
        jsonMarshalled, err := json.Marshal(anythingInner)
		if (err == nil) {
			return strings.ReplaceAll(string(jsonMarshalled), ",", ", ")
		}
		return "null"
    }
	jsonStringifyPrettyDefault := func(anythingInner any, indentInner string) string {
        jsonMarshalled, err := json.MarshalIndent(anythingInner, "", indentInner)
		if (err == nil) {
			return string(jsonMarshalled)
		}
		return "null"
    }
	if (additionalParameter == nil || additionalParameter == false) {
		return jsonStringifyDefault(anything)
	}
	if (additionalParameter == true) {
		return jsonStringifyPrettyDefault(anything, "    ")
	}
	if (reflect.TypeOf(additionalParameter).Kind() == reflect.Map) {
		var pretty any = optionalChaining(additionalParameter, "pretty")
		var indent any = optionalChaining(additionalParameter, "indent")
		if (pretty == true) {
			if (indent == nil) {
				indent = "    "
			}
			return jsonStringifyPrettyDefault(anything, indent.(string))
		}
		return jsonStringifyDefault(anything)
	}
	return jsonStringifyDefault(anything)
}

func sPrintln(parameters ...any) {
    var parametersNew = []string{}
    for _, parameter := range parameters {
        parameterType := reflect.TypeOf(parameter).Kind()
        if (parameterType == reflect.Slice && (len(parameter.(array)) == 1)) {
            parametersNew = append(parametersNew, jsonStringify(parameter.(array)[0], false))
            continue
        }
        if (parameterType == reflect.String) {
			parametersNew = append(parametersNew, parameter.(string))
            continue
        }
    }
    fmt.Println(strings.Join(parametersNew, ""))
}

func spreadObject(parameters ...any) object {
    var newObject = make(object)
    for _, parameter := range parameters {
        parameterType := reflect.TypeOf(parameter).Kind()
        if (parameterType == reflect.Map) {
            for objectKey, objectValue := range parameter.(object) {
                newObject[objectKey] = objectValue
            }
			continue
        }
        if (parameterType == reflect.Slice) {
            for arrayItemIndex, arrayItem := range parameter.(array) {
                newObject[jsonStringify(arrayItemIndex, false)] = arrayItem
            }
			continue
        }
    }
    return newObject
}

func spreadArray(parameters ...any) array {
    var newArray = array{}
    for _, parameter := range parameters {
        parameterType := reflect.TypeOf(parameter).Kind()
        if (parameterType == reflect.Map) {
            if (len(parameter.(object)) == 1) {
                for _, objectValue := range parameter.(object) {
                    newArray = append(newArray, objectValue)
                }
                continue
            }
            newArray = append(newArray, parameter)
            continue
        }
        if (parameterType == reflect.Slice) {
            newArray = append(newArray, parameter.(array)...)
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
    sPrintln("total number: ", array{numbersTotal})
    // total number: 635

    var mixedSlice = array{1, 2, 3, "a", "b", "c", true, false, nil}
    fmt.Println(mixedSlice) // Output: [nil nil nil]
}
