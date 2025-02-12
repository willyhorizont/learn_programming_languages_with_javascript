package main

import (
	"errors"
	"fmt"
	"reflect"
	"strings"
)

var jsLikeType = struct {
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

func ternary(isConditionTrue bool, callbackFunctionIfConditionTrue func(...interface{}) interface{}, callbackFunctionIfConditionFalse func(...interface{}) interface{}) interface{} {
	if (isConditionTrue == true) {
		return callbackFunctionIfConditionTrue()
	}
	return callbackFunctionIfConditionFalse()
}

func arraySome(callbackFunction func(...interface{}) bool, anyArray interface{}) bool {
	// JavaScript-like Array.some() function arraySomeV4
	for arrayItemIndex, arrayItem := range anyArray.([]interface{}) {
		if (callbackFunction(arrayItem, arrayItemIndex, anyArray) == true) {
			return true
		}
	}
	return false
}

func isLikeJsNull(anything interface{}) bool {
	return (anything == nil)
}

func isLikeJsBoolean(anything interface{}) bool {
	return ((reflect.TypeOf(anything).Kind() == reflect.Bool) && ((anything == true) || (anything == false)))
}

func isLikeJsString(anything interface{}) bool {
	return (reflect.TypeOf(anything).Kind() == reflect.String)
}

func isLikeJsNumeric(anything interface{}) bool {
	anythingGoKind := reflect.TypeOf(anything).Kind()
	return (arraySome(func(restArgumentsArraySomeCallback ...interface{}) bool {
		numericGoKind := restArgumentsArraySomeCallback[0]
		return (anythingGoKind == numericGoKind)
	}, ([]interface{}{reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64, reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64, reflect.Float32, reflect.Float64, reflect.Complex64, reflect.Complex128})))
}

func isLikeJsObject(anything interface{}) bool {
	anythingGoType := reflect.TypeOf(anything)
	return ((anythingGoType.Kind() == reflect.Map) || ((anythingGoType.Kind() == reflect.Map) && (anythingGoType.Key().Kind() == reflect.String) && (anythingGoType.Elem().Kind() == reflect.Interface)) || (anythingGoType == reflect.TypeOf(map[string]interface{}{})) || (anythingGoType.String() == "map[string]interface {}") || (anythingGoType.String() == "map[string]interface {  }"))
}

func isLikeJsArray(anything interface{}) bool {
	anythingGoType := reflect.TypeOf(anything)
	return ((anythingGoType.Kind() == reflect.Slice) || (anythingGoType == reflect.TypeOf([]interface{}{})) || (anythingGoType.String() == "[]interface {}") || (anythingGoType.String() == "[]interface {  }"))
}

func isLikeJsFunction(anything interface{}) bool {
	return (reflect.TypeOf(anything).Kind() == reflect.Func)
}

func getType(anything interface{}) string {
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

func anyToString(anything interface{}) string {
	anythingGoValue := reflect.ValueOf(anything)
	if (anythingGoValue.Kind() == reflect.String) {
		return anythingGoValue.String()
	}
	if (anythingGoValue.Kind() == reflect.Bool) {
		return fmt.Sprintf("%t", anythingGoValue.Bool())
	}
	if ((arraySome((func(restArgumentsArraySomeCallback ...interface{}) bool {
		numericGoKindInt := restArgumentsArraySomeCallback[0]
		return (anythingGoValue.Kind() == numericGoKindInt)
	}), ([]interface{}{reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64}))) == true) {
		return fmt.Sprintf("%d", anythingGoValue.Int())
	}
	if ((arraySome((func(restArgumentsArraySomeCallback ...interface{}) bool {
		numericGoKindUint := restArgumentsArraySomeCallback[0]
		return (anythingGoValue.Kind() == numericGoKindUint)
	}), ([]interface{}{reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64}))) == true) {
		return fmt.Sprintf("%d", anythingGoValue.Uint())
	}
	if ((arraySome((func(restArgumentsArraySomeCallback ...interface{}) bool {
		numericGoKindFloat := restArgumentsArraySomeCallback[0]
		return (anythingGoValue.Kind() == numericGoKindFloat)
	}), ([]interface{}{reflect.Float32, reflect.Float64}))) == true) {
		return fmt.Sprintf("%f", anythingGoValue.Float())
	}
	if ((arraySome((func(restArgumentsArraySomeCallback ...interface{}) bool {
		numericGoKindComplex := restArgumentsArraySomeCallback[0]
		return (anythingGoValue.Kind() == numericGoKindComplex)
	}), ([]interface{}{reflect.Complex64, reflect.Complex128}))) == true) {
		return fmt.Sprintf("%g", anythingGoValue.Complex())
	}
	return (`"` + anythingGoValue.String() + `"`)
}

func arrayReduce(callbackFunction func(...interface{}) interface{}, anyArray interface{}, initialValue interface{}) interface{} {
	// JavaScript-like Array.reduce() function
	result := initialValue
	for arrayItemIndex, arrayItem := range anyArray.([]interface{}) {
		result = callbackFunction(result, arrayItem, arrayItemIndex, anyArray)
	}
	return result
}

func optionalChaining(anything interface{}, restArguments ...interface{}) interface{} {
	anythingType := getType(anything)
	if (anythingType == jsLikeType.Function) {
		anythingAsFunction := anything.(func(...interface{}) interface{})
		return anythingAsFunction(restArguments...)
	}
	if (((anythingType != jsLikeType.Object) && (anythingType != jsLikeType.Array)) || (len(restArguments) == 0)) {
		return anything
	}
	return arrayReduce((func(restArgumentsArrayReduceCallback ...interface{}) interface{} {
		currentResult := restArgumentsArrayReduceCallback[0]
		currentItem := restArgumentsArrayReduceCallback[1]
		currentResultJsLikeType := getType(currentResult)
		currentItemJsLikeType := getType(currentItem)
		if ((currentResultJsLikeType == jsLikeType.Null) && (anythingType == jsLikeType.Object) && (currentItemJsLikeType == jsLikeType.String)) {
			anythingAsObject := anything.(map[string]interface{})
			return anythingAsObject[currentItem.(string)]
		}
		if ((currentResultJsLikeType == jsLikeType.Null) && (anythingType == jsLikeType.Array) && (reflect.TypeOf(currentItem).Kind() == reflect.Int) && ((currentItem.(int)) >= 0) && (len(anything.([]interface{})) > (currentItem.(int)))) {
			anythingAsArray := anything.([]interface{})
			return anythingAsArray[currentItem.(int)]
		}
		if ((currentResultJsLikeType == jsLikeType.Object) && (currentItemJsLikeType == jsLikeType.String)) {
			currentResultAsObject := currentResult.(map[string]interface{})
			return currentResultAsObject[currentItem.(string)]
		}
		if ((currentResultJsLikeType == jsLikeType.Array) && (reflect.TypeOf(currentItem).Kind() == reflect.Int) && ((currentItem.(int)) >= 0) && (len(currentResult.([]interface{})) > (currentItem.(int)))) {
			currentResultAsArray := currentResult.([]interface{})
			return currentResultAsArray[currentItem.(int)]
		}
		return nil
	}), restArguments, nil)
}

func nullishCoalescing(anything interface{}, defaultValue interface{}) interface{} {
	if (anything == nil) {
		return defaultValue
	} else {
		return anything
	}
}

func pipe(restArguments ...interface{}) interface{} {
	var pipeLastResult interface{} = nil
	var pipeResult interface{} = arrayReduce((func(restArgumentsArrayReduceCallback ...interface{}) interface{} {
		currentResult := restArgumentsArrayReduceCallback[0]
		currentArgument := restArgumentsArrayReduceCallback[1]
		pipeLastResult = currentResult
		if (getType(currentResult) == jsLikeType.Null) {
			return currentArgument
		}
		if (getType(currentArgument) == jsLikeType.Function) {
			return currentArgument.(func(...interface{}) interface{})(currentResult)
		}
		return nil
	}), restArguments, nil)
	if (getType(pipeResult) == jsLikeType.Function) {
		pipeResultAsFunction := pipeResult.(func(...interface{}) interface{})
		return pipeResultAsFunction(pipeLastResult)
	}
	return pipeResult
}

func jsonStringify(restArguments ...interface{}) string {
	prettyDefault := false
	anything := restArguments[0]
	pretty := nullishCoalescing(pipe(optionalChaining(restArguments, 1), func(restArgumentsPipeResult ...interface{}) interface{} {
		return optionalChaining(restArgumentsPipeResult[0], "pretty")
	}), prettyDefault)
	indentDefault := strings.Repeat(" ", 4)
	indentLevel := 0
	var jsonStringifyInner func(interface{}) string
	jsonStringifyInner = func(anythingInner interface{}) string {
		anythingInnerType := getType(anythingInner)
		if (anythingInnerType == jsLikeType.Null) {
			return "null"
		}
		if (anythingInnerType == jsLikeType.String) {
			return (`"` + (anythingInner.(string)) + `"`)
		}
		if ((anythingInnerType == jsLikeType.Numeric) || (anythingInnerType == jsLikeType.Boolean)) {
			return anyToString(anythingInner)
		}
		if (anythingInnerType == jsLikeType.Object) {
			anythingInnerAsObject := anythingInner.(map[string]interface{})
			if (len(anythingInnerAsObject) == 0) {
				return "{}"
			}
			indentLevel += 1
			result := ternary((pretty == true), (func(_ ...interface{}) interface{} {
				return ("{\n" + strings.Repeat(indentDefault, indentLevel))
			}), (func(_ ...interface{}) interface{} {
				return "{ "
			})).(string)
			objectEntryIndex := 0
			for objectKey, objectValue := range anythingInnerAsObject {
				result += (`"` + objectKey + `": ` + jsonStringifyInner(objectValue))
				if ((objectEntryIndex + 1) != len(anythingInnerAsObject)) {
					result += ternary((pretty == true), (func(_ ...interface{}) interface{} {
						return (",\n" + strings.Repeat(indentDefault, indentLevel))
					}), (func(_ ...interface{}) interface{} {
						return ", "
					})).(string)
				}
				objectEntryIndex += 1
			}
			indentLevel -= 1
			result += ternary((pretty == true), (func(_ ...interface{}) interface{} {
				return ("\n" + strings.Repeat(indentDefault, indentLevel) + "}")
			}), (func(_ ...interface{}) interface{} {
				return " }"
			})).(string)
			return result
		}
		if (anythingInnerType == jsLikeType.Array) {
			anythingInnerAsArray := anythingInner.([]interface{})
			if (len(anythingInnerAsArray) == 0) {
				return "[]"
			}
			indentLevel += 1
			result := ternary((pretty == true), (func(_ ...interface{}) interface{} {
				return ("[\n" + strings.Repeat(indentDefault, indentLevel))
			}), (func(_ ...interface{}) interface{} {
				return "["
			})).(string)
			for arrayItemIndex, arrayItem := range anythingInnerAsArray {
				result += jsonStringifyInner(arrayItem)
				if ((arrayItemIndex + 1) != len(anythingInnerAsArray)) {
					result += ternary((pretty == true), (func(_ ...interface{}) interface{} {
						return (",\n" + strings.Repeat(indentDefault, indentLevel))
					}), (func(_ ...interface{}) interface{} {
						return ", "
					})).(string)
				}
			}
			indentLevel -= 1
			result += ternary((pretty == true), (func(_ ...interface{}) interface{} {
				return "\n" + strings.Repeat(indentDefault, indentLevel) + "]"
			}), (func(_ ...interface{}) interface{} {
				return "]"
			})).(string)
			return result
		}
		if (anythingInnerType == jsLikeType.Function) {
			return "[object Function]"
		}
		return anythingInnerType
	}
	return jsonStringifyInner(anything)
}

func stringInterpolation(restArguments ...interface{}) string {
	return arrayReduce((func(restArgumentsArrayReduceCallback ...interface{}) interface{} {
		currentResult := restArgumentsArrayReduceCallback[0]
		currentArgument := restArgumentsArrayReduceCallback[1]
		currentArgumentType := getType(currentArgument)
		return (currentResult.(string) + ternary((currentArgumentType == jsLikeType.String), (func(_ ...interface{}) interface{} {
				return currentArgument.(string)
			}),
			(func(_ ...interface{}) interface{} {
				return ternary(((currentArgumentType == jsLikeType.Array) && (len(currentArgument.([]interface{})) == 1)), (func(_ ...interface{}) interface{} {
						return jsonStringify(currentArgument.([]interface{})[0])
					}),
					(func(_ ...interface{}) interface{} {
						return jsonStringify(currentArgument)
					})).(string)
			})).(string))
	}), restArguments, "").(string)
}

func consoleLog(restArguments ...interface{}) {
	fmt.Println(stringInterpolation(restArguments...))
}

func getGoFloat64(anything interface{}) interface{} {
	switch anythingGoType := anything.(type) {
	case float64:
		return anythingGoType
	case float32:
		return float64(anythingGoType)
	case int64:
		return float64(anythingGoType)
	case int32: // rune
		return float64(anythingGoType)
	case int16:
		return float64(anythingGoType)
	case int8:
		return float64(anythingGoType)
	case int:
		return float64(anythingGoType)
	case uint64:
		return float64(anythingGoType)
	case uint32:
		return float64(anythingGoType)
	case uint16:
		return float64(anythingGoType)
	case uint8: // byte
		return float64(anythingGoType)
	case uint:
		return float64(anythingGoType)
	default:
		return errors.New("excpected Go float64-convertible value")
	}
}

func spreadObject(restArguments ...interface{}) map[string]interface{} {
	newObject := map[string]interface{}{}
	for _, argument := range restArguments {
		argumentJsLikeType := getType(argument)
		if (argumentJsLikeType == jsLikeType.Object) {
			for objectKey, objectValue := range argument.(map[string]interface{}) {
				newObject[objectKey] = objectValue
			}
			continue
		}
		if (argumentJsLikeType == jsLikeType.Array) {
			for arrayItemIndex, arrayItem := range argument.([]interface{}) {
				newObject[jsonStringify(arrayItemIndex)] = arrayItem
			}
			continue
		}
	}
	return newObject
}

func spreadArray(restArguments ...interface{}) []interface{} {
	newArray := []interface{}{}
	for _, argument := range restArguments {
		argumentJsLikeType := getType(argument)
		if (argumentJsLikeType == jsLikeType.Object) {
			argumentAsObject := argument.(map[string]interface{})
			if (len(argumentAsObject) == 1) {
				for _, objectValue := range argumentAsObject {
					newArray = append(newArray, objectValue)
				}
				continue
			}
			newArray = append(newArray, argument)
			continue
		}
		if (argumentJsLikeType == jsLikeType.Array) {
			newArray = append(newArray, argument.([]interface{})...)
			continue
		}
	}
	return newArray
}

func objectFromEntries(anyObjectEntries interface{}) interface{} {
	// JavaScript-like Object.fromEntries() function
	newObject := map[string]interface{}{}
	for _, objectEntry := range anyObjectEntries.([]interface{}) {
		objectKey := objectEntry.([]interface{})[0]
		objectValue := objectEntry.([]interface{})[1]
		newObject[anyToString(objectKey)] = objectValue
	}
	return newObject
}

func arrayEntries(anyArray interface{}) []interface{} {
	// JavaScript-like Object.fromEntries() function
	newObjectEntries := []interface{}{}
	for arrayItemIndex, arrayItem := range anyArray.([]interface{}) {
		newObjectEntries = append(newObjectEntries, []interface{}{arrayItemIndex, arrayItem})
	}
	return newObjectEntries
}

func arrayEvery(callbackFunction func(...interface{}) bool, anyArray interface{}) bool {
	// JavaScript-like Array.every() function arrayEveryV4
	for arrayItemIndex, arrayItem := range anyArray.([]interface{}) {
		if (callbackFunction(arrayItem, arrayItemIndex, anyArray) == false) {
			return false
		}
	}
	return true
}

func arrayFilter(callbackFunction func(...interface{}) bool, anyArray interface{}) []interface{} {
	// JavaScript-like Array.filter() function arrayFilterV2
	dataFiltered := []interface{}{}
	for arrayItemIndex, arrayItem := range anyArray.([]interface{}) {
		if (callbackFunction(arrayItem, arrayItemIndex, anyArray) == true) {
			dataFiltered = append(dataFiltered, arrayItem)
		}
	}
	return dataFiltered
}

func arrayFind(callbackFunction func(...interface{}) bool, anyArray interface{}) interface{} {
	// JavaScript-like Array.find() function arrayFindV4
	for arrayItemIndex, arrayItem := range anyArray.([]interface{}) {
		if (callbackFunction(arrayItem, arrayItemIndex, anyArray) == true) {
			return arrayItem
		}
	}
	return nil
}

func arrayFindIndex(callbackFunction func(...interface{}) bool, anyArray interface{}) int {
	// JavaScript-like Array.findIndex() function arrayFindIndexV4
	for arrayItemIndex, arrayItem := range anyArray.([]interface{}) {
		if (callbackFunction(arrayItem, arrayItemIndex, anyArray) == true) {
			return arrayItemIndex
		}
	}
	return -1
}

func arrayIncludes(searchElement interface{}, anyArray interface{}) bool {
	// JavaScript-like Array.includes() function arrayIncludesV2
	for _, arrayItem := range anyArray.([]interface{}) {
		if (arrayItem == searchElement) {
			return true
		}
	}
	return false
}

func arrayMap(callbackFunction func(...interface{}) interface{}, anyArray interface{}) []interface{} {
	// JavaScript-like Array.map() function arrayMapV2
	newArray := []interface{}{}
	for arrayItemIndex, arrayItem := range anyArray.([]interface{}) {
		newArray = append(newArray, callbackFunction(arrayItem, arrayItemIndex, anyArray))
	}
	return newArray
}

func objectEntries(anyObject interface{}) interface{} {
	// JavaScript-like Object.entries() function
	newArray := []interface{}{}
	for objectKey, objectValue := range anyObject.(map[string]interface{}) {
		newArray = append(newArray, []interface{}{objectKey, objectValue})
	}
	return newArray
}

func objectKeys(anyObject interface{}) interface{} {
	// JavaScript-like Object.keys() function
	newArray := []interface{}{}
	for objectKey, _ := range anyObject.(map[string]interface{}) {
		newArray = append(newArray, objectKey)
	}
	return newArray
}

func objectValues(anyObject interface{}) interface{} {
	// JavaScript-like Object.values() function
	newArray := []interface{}{}
	for _, objectValue := range (anyObject.(map[string]interface{})) {
		newArray = append(newArray, objectValue)
	}
	return newArray
}

func main() {
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

    consoleLog("\n// basic conditional control flow\n")

    myAge = 10
    consoleLog(stringInterpolation("myAge: ", []interface{}{myAge}))
    if ((myAge.(int)) > 24) {
        consoleLog("you are old")
    } else if ((myAge.(int)) > 17) {
        consoleLog("you are young")
    } else {
        consoleLog("you are under age")
    }

    consoleLog("\n// equal to (==)\n")

    myAnswer = 100
    consoleLog(stringInterpolation("myAnswer: ", []interface{}{myAnswer}))
    consoleLog(stringInterpolation("CORRECT_ANSWER: ", []interface{}{CORRECT_ANSWER}))
    consoleLog("(myAnswer == CORRECT_ANSWER):")
    if (myAnswer == CORRECT_ANSWER) {
        consoleLog("Your answer is correct")
    } else {
        consoleLog("Your answer is wrong")
    }

    consoleLog("\n// not equal to (!=)\n")

    myAnswer = 25
    consoleLog(stringInterpolation("myAnswer: ", []interface{}{myAnswer}))
    consoleLog(stringInterpolation("CORRECT_ANSWER: ", []interface{}{CORRECT_ANSWER}))
    consoleLog("(myAnswer != CORRECT_ANSWER):")
    if (myAnswer != CORRECT_ANSWER) {
        consoleLog("Your answer is correct")
    } else {
        consoleLog("Your answer is wrong")
    }

    consoleLog("\n// greater than (>)\n")

    myAge = 70
    consoleLog(stringInterpolation("myAge: ", []interface{}{myAge}))
    consoleLog("(myAge > 50):")
    if ((myAge.(int)) > 50) {
        consoleLog("You are old")
    }

    consoleLog("\n// less than (<)\n")

    myAge = 16
    consoleLog(stringInterpolation("myAge: ", []interface{}{myAge}))
    consoleLog("(myAge < 20):")
    if ((myAge.(int)) < 20) {
        consoleLog("You are young")
    }

    consoleLog("\n// greater than or equal to (>=)\n")

    myAge = 73
    consoleLog(stringInterpolation("myAge: ", []interface{}{myAge}))
    consoleLog("(myAge >= 65):")
    if ((myAge.(int)) >= 65) {
        consoleLog("You are allowed to retire")
    }

    consoleLog("\n// less than or equal to (<=)\n")

    myAge = 14
    consoleLog(stringInterpolation("myAge: ", []interface{}{myAge}))
    consoleLog("(myAge <= 16):")
    if ((myAge.(int)) <= 16) {
        consoleLog("You are not allowed to drive")
    }

    consoleLog("\n// Logical AND (&&)\n")

    myAge = 17
    consoleLog(stringInterpolation("myAge: ", []interface{}{myAge}))
    hasDrivingLicense = false
    consoleLog(stringInterpolation("hasDrivingLicense: ", []interface{}{hasDrivingLicense}))
    consoleLog("((myAge >= 17) && (hasDrivingLicense == true)):")
    if (((myAge.(int)) >= 17) && (hasDrivingLicense == true)) {
        consoleLog("You are allowed to drive")
    } else {
        consoleLog("You are not allowed to drive")
    }

    myAge = 17
    consoleLog(stringInterpolation("myAge: ", []interface{}{myAge}))
    hasDrivingLicense = true
    consoleLog(stringInterpolation("hasDrivingLicense: ", []interface{}{hasDrivingLicense}))
    consoleLog("((myAge >= 17) && (hasDrivingLicense == true)):")
    if (((myAge.(int)) >= 17) && (hasDrivingLicense == true)) {
        consoleLog("You are allowed to drive")
    } else {
        consoleLog("You are not allowed to drive")
    }

    consoleLog("\n// Logical OR (||)\n")

    myAge = 2
    consoleLog(stringInterpolation("myAge: ", []interface{}{myAge}))
    consoleLog("((myAge <= 3) || (myAge >= 65)):")
    if (((myAge.(int)) <= 3) || ((myAge.(int)) >= 65)) {
        consoleLog("You should stay home")
    }

    myAge = 89
    consoleLog(stringInterpolation("myAge: ", []interface{}{myAge}))
    consoleLog("((myAge <= 3) || (myAge >= 65)):")
    if (((myAge.(int)) <= 3) || ((myAge.(int)) >= 65)) {
        consoleLog("You should stay home")
    }

    consoleLog("\n// Logical NOT (!)\n")

    canDrive = false
    consoleLog(stringInterpolation("canDrive: ", []interface{}{canDrive}))
    consoleLog(stringInterpolation("!canDrive: ", []interface{}{!(canDrive.(bool))}))

    canDrive = true
    consoleLog(stringInterpolation("canDrive: ", []interface{}{canDrive}))
    consoleLog(stringInterpolation("!canDrive: ", []interface{}{!(canDrive.(bool))}))
}
