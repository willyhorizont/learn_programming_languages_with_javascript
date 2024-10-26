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
	}{ Null: "Null", Boolean: "Boolean", String: "String", Numeric: "Numeric", Object: "Object", Array: "Array", Function: "Function" }
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

    /*
1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
```javascript
let something = "foo";
console.log(`something: ${something}`);
something = 123;
console.log(`something: ${something}`);
something = true;
console.log(`something: ${something}`);
something = null;
console.log(`something: ${something}`);
something = [1, 2, 3];
console.log(`something: ${something}`);
something = { "foo": "bar" };
console.log(`something: ${something}`);
```
```go
type Any interface{}
```
    */
    var something interface{} = "foo"
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("something: ", (jsonStringify.(func(...interface{}) interface{}))(something, map[string]interface{}{"pretty": true})))
    something = 123
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("something: ", (jsonStringify.(func(...interface{}) interface{}))(something, map[string]interface{}{"pretty": true})))
    something = true
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("something: ", (jsonStringify.(func(...interface{}) interface{}))(something, map[string]interface{}{"pretty": true})))
    something = nil
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("something: ", (jsonStringify.(func(...interface{}) interface{}))(something, map[string]interface{}{"pretty": true})))
    something = []interface{}{1, 2, 3}
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("something: ", (jsonStringify.(func(...interface{}) interface{}))(something, map[string]interface{}{"pretty": true})))
    something = map[string]interface{}{"foo": "bar"}
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("something: ", (jsonStringify.(func(...interface{}) interface{}))(something, map[string]interface{}{"pretty": true})))

    /*
2. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
```javascript
function (getModifiedIndentLevel.(func(...interface{}) interface{}))() {
    let indentLevel = 0;
    function changeIndentLevel() {
        indentLevel += 1;
        if (indentLevel < 5) changeIndentLevel();
        return indentLevel;
    }
    return changeIndentLevel();
}
console.log(`(getModifiedIndentLevel.(func(...interface{}) interface{}))(): ${(getModifiedIndentLevel.(func(...interface{}) interface{}))()}`);
function createNewGame(initialCredit) {
    let currentCredit = initialCredit;
    console.log(`initial credit: ${initialCredit}`);
    return function () {
        currentCredit -= 1;
        if (currentCredit === 0) {
            console.log("not enough credits");
            return;
        }
        console.log(`playing game, ${currentCredit} credit(s) remaining`);
    };
}
const playGame = createNewGame(3);
playGame();
playGame();
playGame();
```
    */
    var getModifiedIndentLevel interface{} = func(_ ...interface{}) interface{} {
        var indentLevel interface{} = 0
        var changeIndentLevel interface{}
        changeIndentLevel = func(_ ...interface{}) interface{} {
            indentLevel = ((indentLevel.(int)) + 1)
            if ((indentLevel.(int)) < 5) {
                (changeIndentLevel.(func(...interface{}) interface{}))()
            }
            return indentLevel
        }
        return (changeIndentLevel.(func(...interface{}) interface{}))()
    }
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("(getModifiedIndentLevel.(func(...interface{}) interface{}))(): ", []interface{}{(getModifiedIndentLevel.(func(...interface{}) interface{}))()}))
    var createNewGame interface{} = func(restArguments ...interface{}) interface{} {
		var initialCredit interface{} = restArguments[0]
        var currentCredit interface{} = int(((getFloat64.(func(...interface{}) interface{}))(initialCredit).(float64)))
        (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("initial credit: ", []interface{}{initialCredit}))
        return func(restArguments ...interface{}) interface{} {
            currentCredit = ((currentCredit.(int)) - 1)
            if ((currentCredit.(int)) == 0) {
                (consoleLog.(func(...interface{}) interface{}))("not enough credits")
                return nil
            }
            (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("playing game, ", currentCredit, " credit(s) remaining"))
			return nil
        }
    }
    var playGame interface{} = (createNewGame.(func(...interface{}) interface{}))(3)
    (playGame.(func(...interface{}) interface{}))()
    (playGame.(func(...interface{}) interface{}))()
    (playGame.(func(...interface{}) interface{}))()

    /*
3. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
```javascript
const myObject = {
    "my_string": "foo",
    "my_number": 123,
    "my_bool": true,
    "my_null": null,
    "my_array": [1, 2, 3],
    "my_object": {
        "foo": "bar"
    }
};
console.log(`myObject: ${myObject}`);
```
    */
    var myObject interface{} = map[string]interface{}{
        "my_string": "foo",
        "my_number": 123,
        "my_bool": true,
        "my_null": nil,
        "my_array": []interface{}{1, 2, 3},
        "my_object": map[string]interface{}{
            "foo": "bar",
        },
    }
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("myObject: ", (jsonStringify.(func(...interface{}) interface{}))(myObject, map[string]interface{}{"pretty": true})))

    /*
4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
```javascript
const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
console.log(`myArray: ${myArray}`);
```
    */
    var myArray interface{} = []interface{}{"foo", 123, true, nil, []interface{}{1, 2, 3}, map[string]interface{}{"foo": "bar"}}
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("myArray: ", (jsonStringify.(func(...interface{}) interface{}))(myArray, map[string]interface{}{"pretty": true})))

    /*
5. support passing functions as arguments to other functions
```javascript
function sayHello(callbackFunction) {
    console.log("hello");
    callbackFunction();
}
function sayHowAreYou() {
    console.log("how are you?");
}
sayHello(sayHowAreYou);
sayHello(function () {
    console.log("how are you?");
});
```
    */
    var sayHello interface{} = func(restArguments ...interface{}) interface{} {
		var callbackFunction interface{} = restArguments[0]
        (consoleLog.(func(...interface{}) interface{}))("hello")
        (callbackFunction.(func(...interface{}) interface{}))()
		return nil
    }
    var sayHowAreYou interface{} = func(restArguments ...interface{}) interface{} {
        (consoleLog.(func(...interface{}) interface{}))("how are you?")
		return nil
    }
    (sayHello.(func(...interface{}) interface{}))(sayHowAreYou)
    (sayHello.(func(...interface{}) interface{}))(func(restArguments ...interface{}) interface{} {
        (consoleLog.(func(...interface{}) interface{}))("how are you?")
		return nil
    })

    /*
6. support returning functions as values from other functions
```javascript
function multiply(a) {
    return function (b) {
        return (a * b);
    };
}
const multiplyBy2 = multiply(2);
const multiplyBy2Result = multiplyBy2(10);
console.log(`multiplyBy2(10): ${multiplyBy2Result}`);
```
    */
    var multiply interface{} = func(restArguments ...interface{}) interface{} {
		var a interface{} = restArguments[0]
		var multiplyBy interface{} = func(restArgumentsInner ...interface{}) interface{} {
			var b interface{} = restArgumentsInner[0]
			return (int((((getFloat64.(func(...interface{}) interface{}))(a)).(float64)) * (((getFloat64.(func(...interface{}) interface{}))(b)).(float64))))
		}
		return multiplyBy
	}
	var multiplyBy2 interface{} = (multiply.(func(...interface{}) interface{}))(2)
    var multiplyBy2Result interface{} = (multiplyBy2.(func(...interface{}) interface{}))(10)
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("multiplyBy2(10): ", []interface{}{multiplyBy2Result}))

    /*
7. support assigning functions to variables
```javascript
const getRectangleAreaV1 = function (rectangleWidth, rectangleLength) {
    return (rectangleWidth * rectangleLength);
};
console.log(`getRectangleAreaV1(7, 5): ${getRectangleAreaV1(7, 5)}`);
const getRectangleAreaV2 = (rectangleWidth, rectangleLength) => {
    return (rectangleWidth * rectangleLength);
};
console.log(`getRectangleAreaV2(7, 5): ${getRectangleAreaV2(7, 5)}`);
const getRectangleAreaV3 = (rectangleWidth, rectangleLength) => (rectangleWidth * rectangleLength);
console.log(`getRectangleAreaV3(7, 5): ${getRectangleAreaV3(7, 5)}`);
```
    */
    var getRectangleArea interface{} = func(restArguments ...interface{}) interface{} {
		var rectangleWidth interface{} = restArguments[0]
		var rectangleLength interface{} = restArguments[1]
        return (int((((getFloat64.(func(...interface{}) interface{}))(rectangleWidth)).(float64)) * (((getFloat64.(func(...interface{}) interface{}))(rectangleLength)).(float64))))
    }
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("(getRectangleArea.(func(...interface{}) interface{}))(7, 5): ", []interface{}{(getRectangleArea.(func(...interface{}) interface{}))(7, 5)}))

    /*
8. support storing functions in data structures like array/list/slice/ordered-list-data-structure or object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure
```javascript
const myArray2 = [
    function (a, b) {
        return (a * b);
    },
    "foo",
    123,
    true,
    null,
    [1, 2, 3],
    { "foo": "bar" }
];
console.log(`myArray2[0](7, 5): ${myArray2[0](7, 5)}`);
const myObject2 = {
    "my_function": function (a, b) {
        return (a * b);
    },
    "my_string": "foo",
    "my_number": 123,
    "my_bool": true,
    "my_null": null,
    "my_array": [1, 2, 3],
    "my_object": {
        "foo": "bar"
    }
};
console.log(`myObject2["my_function"](7, 5): ${myObject2["my_function"](7, 5)}`);
```
    */
    var myArray2 interface{} = []interface{}{
        func(restArguments ...interface{}) interface{} {
			var a interface{} = restArguments[0]
			var b interface{} = restArguments[1]
			return (int((((getFloat64.(func(...interface{}) interface{}))(a)).(float64)) * (((getFloat64.(func(...interface{}) interface{}))(b)).(float64))))
		},
        "foo",
        123,
        true,
        nil,
        []interface{}{1, 2, 3},
        map[string]interface{}{"foo": "bar"},
    }
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))("(myArray2.([]interface{}))[0](7, 5): ", []interface{}{(myArray2.([]interface{}))[0].(func(...interface{}) interface{})(7, 5)}))
    var myObject2 interface{} = map[string]interface{}{
        "my_function": func(restArguments ...interface{}) interface{} {
			var a interface{} = restArguments[0]
			var b interface{} = restArguments[1]
			return (int((((getFloat64.(func(...interface{}) interface{}))(a)).(float64)) * (((getFloat64.(func(...interface{}) interface{}))(b)).(float64))))
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
    (consoleLog.(func(...interface{}) interface{}))((stringInterpolation.(func(...interface{}) interface{}))(`myObject2["my_function"](7, 5): `, []interface{}{(myObject2.(map[string]interface{}))["my_function"].(func(...interface{}) interface{})(7, 5)}))
}
