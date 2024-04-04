package main

import (
	"encoding/json"
	"fmt"
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

func main() {
    /*
        1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
        ```javascript
        let something = "foo";
        console.log("something:", something);
        something = 123;
        console.log("something:", something);
        something = true;
        console.log("something:", something);
        something = null;
        console.log("something:", something);
        something = [1, 2, 3];
        console.log("something:", something);
        something = { "foo": "bar" };
        console.log("something:", something);
        ```
        ```go
        type Any interface{}
        ```
    */
    var something any = "foo"
    sPrintln("something: ", jsonStringify(something, object{"pretty": true}))
    something = 123
    sPrintln("something: ", jsonStringify(something, object{"pretty": true}))
    something = true
    sPrintln("something: ", jsonStringify(something, object{"pretty": true}))
    something = nil
    sPrintln("something: ", jsonStringify(something, object{"pretty": true}))
    something = array{1, 2, 3}
    sPrintln("something: ", jsonStringify(something, object{"pretty": true}))
    something = object{"foo": "bar"}
    sPrintln("something: ", jsonStringify(something, object{"pretty": true}))

    /*
        2. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
        ```javascript
        function getModifiedIndentLevel() {
            let indentLevel = 0;
            function changeIndentLevel() {
                indentLevel += 1;
                if (indentLevel < 5) changeIndentLevel();
                return indentLevel;
            }
            return changeIndentLevel();
        }
        console.log("getModifiedIndentLevel():", getModifiedIndentLevel());
        function createNewGame(initialCredit) {
            let currentCredit = initialCredit;
            console.log("initial credit:", initialCredit);
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
    getModifiedIndentLevel := func() int {
        indentLevel := 0
        var changeIndentLevel func() int
        changeIndentLevel = func() int {
            indentLevel += 1
            if (indentLevel < 5) {
                changeIndentLevel()
            }
            return indentLevel
        }
        return changeIndentLevel()
    }
    sPrintln("getModifiedIndentLevel(): ", array{getModifiedIndentLevel()})
    createNewGame := func(initialCredit int) func() {
        currentCredit := initialCredit
        sPrintln("initial credit: ", array{initialCredit})
        return func() {
            currentCredit -= 1
            if (currentCredit == 0) {
                fmt.Println("not enough credits")
                return
            }
            fmt.Println("playing game,", currentCredit, "credit(s) remaining")
        }
    }
    playGame := createNewGame(3)
    playGame()
    playGame()
    playGame()

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
        console.log("myObject:", myObject);
        ```
    */
    myObject := object{
        "my_string": "foo",
        "my_number": 123,
        "my_bool": true,
        "my_null": nil,
        "my_array": array{1, 2, 3},
        "my_object": object{
            "foo": "bar",
        },
    }
    sPrintln("myObject: ", jsonStringify(myObject, object{"pretty": true}))

    /*
        4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
        ```javascript
        const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
        console.log("myArray:", myArray);
        ```
    */
    myArray := array{"foo", 123, true, nil, array{1, 2, 3}, object{"foo": "bar"}}
    sPrintln("myArray: ", jsonStringify(myArray, object{"pretty": true}))

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
    sayHelllo := func(callbackFunction func()) {
        fmt.Println("hello")
        callbackFunction()
    }
    sayHowAreYou := func() {
        fmt.Println("how are you?")
    }
    sayHelllo(sayHowAreYou)
    sayHelllo(func() {
        fmt.Println("how are you?")
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
        console.log("multiplyBy2Result:", multiplyBy2Result);
        ```
    */
    multiply := func(a int) func(int) int {
        return func(b int) int {
            return (a * b)
        }
    }
    multiplyBy2 := multiply(2)
    multiplyBy2Result := multiplyBy2(10)
    sPrintln("multiplyBy2Result: ", array{multiplyBy2Result})

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
    getRectangleArea := func(rectangleWidth int, rectangleLength int) int {
        return (rectangleWidth * rectangleLength)
    }
    sPrintln("getRectangleArea(7, 5): ", array{getRectangleArea(7, 5)})

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
        console.log("myArray2[0](7, 5):", myArray2[0](7, 5));

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
        console.log("myObject2["my_function"](7, 5):", myObject2["my_function"](7, 5));
        ```
    */
    myArray2 := array{
        func(a int, b int) int {
            return (a * b)
        },
        "foo",
        123,
        true,
        nil,
        array{1, 2, 3},
        object{"foo": "bar"},
    }
    sPrintln("myArray2[0](7, 5): ", array{myArray2[0].(func(int, int) int)(7, 5)})

    myObject2 := object{
        "my_function": func(a int, b int) int {
            return (a * b)
        },
        "my_string": "foo",
        "my_number": 123,
        "my_bool": true,
        "my_null": nil,
        "my_array": array{1, 2, 3},
        "my_object": object{
            "foo": "bar",
        },
    }
    sPrintln("myObject2[\"my_function\"](7, 5): ", array{myObject2["my_function"].(func(int, int) int)(7, 5)})
}
