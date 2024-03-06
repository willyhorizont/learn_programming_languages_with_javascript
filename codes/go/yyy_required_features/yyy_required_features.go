package main

import (
	"encoding/json"
	"fmt"
	"reflect"
)

const EMPTY_STRING = ""
const TAB = "    "

// type any interface{}
type array []any
type object map[string]any

func prettyJsonStringify(anything any) string {
	marshalledJson, err := json.MarshalIndent(anything, EMPTY_STRING, TAB)
	if (err == nil) {
		return string(marshalledJson)
	}
	return "undefined"
}

func prettyArrayOfPrimitives(anArray array) string {
	result := "["
	for arrayItemIndex, arrayItem := range anArray {
		if (arrayItem == nil) {
			result += "nil"
		}
		if (arrayItem != nil) {
			switch arrayItemType := reflect.TypeOf(arrayItem).Kind(); arrayItemType {
			case reflect.String:
				result += "\"" + arrayItem.(string) + "\""
			case reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64, reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64, reflect.Float32, reflect.Float64, reflect.Complex64, reflect.Complex128:
				result += fmt.Sprint(arrayItem)
			case reflect.Bool:
				if arrayItem.(bool) {
					result += "true"
				} else {
					result += "false"
				}
			case reflect.Invalid:
				result += "nil"
			default:
				continue
			}
		}
		if ((arrayItemIndex + 1) != len(anArray)) {
			result = result + ", "
		}
	}
	result = result + "]"
	return result
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
	fmt.Println("something:", prettyJsonStringify(something))
	something = 123
	fmt.Println("something:", prettyJsonStringify(something))
	something = true
	fmt.Println("something:", prettyJsonStringify(something))
	something = nil
	fmt.Println("something:", prettyJsonStringify(something))
	something = array{1, 2, 3}
	fmt.Println("something:", prettyArrayOfPrimitives((something).(array)))
	something = object{"foo": "bar"}
	fmt.Println("something:", prettyJsonStringify(something))

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
	fmt.Println("getModifiedIndentLevel():", getModifiedIndentLevel())
	createNewGame := func(initialCredit int) func() {
		currentCredit := initialCredit
		fmt.Println("initial credit:", initialCredit)
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
			"my_object": {
				"foo": "bar"
			},
			"my_array": [1, 2, 3]
		};
		console.log("myObject:", myObject);
		```
	*/
	myObject := object{
		"my_string": "foo",
		"my_number": 123,
		"my_bool": true,
		"my_null": nil,
		"my_object": object{
			"foo": "bar",
		},
		"my_array": array{1, 2, 3},
	}
	fmt.Println("myObject:", prettyJsonStringify(myObject))

	/*
		4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
		```javascript
		const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
		console.log("myArray:", myArray);
		```
	*/
	myArray := array{"foo", 123, true, nil, array{1, 2, 3}, object{"foo": "bar"}}
	fmt.Println("myArray:", prettyJsonStringify(myArray))

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
	fmt.Println("multiplyBy2Result:", multiplyBy2Result)

	/*
		7. support assigning functions to variables
		```javascript
		const getRectangleAreaV1 = function (rectangleWidth, rectangleLength) {
			return (rectangleWidth * rectangleLength);
		};
		console.log("getRectangleAreaV1(7, 5):", getRectangleAreaV1(7, 5));
		const getRectangleAreaV2 = function (rectangleWidth, rectangleLength) {
			return (rectangleWidth * rectangleLength);
		};
		console.log("getRectangleAreaV2(7, 5):", getRectangleAreaV2(7, 5));
		const getRectangleAreaV3 = (rectangleWidth, rectangleLength) => {
			return (rectangleWidth * rectangleLength);
		};
		console.log("getRectangleAreaV3(7, 5):", getRectangleAreaV3(7, 5));
		const getRectangleAreaV4 = (rectangleWidth, rectangleLength) => (rectangleWidth * rectangleLength);
		console.log("getRectangleAreaV4(7, 5):", getRectangleAreaV4(7, 5));
		```
	*/
	getRectangleArea := func(rectangleWidth int, rectangleLength int) int {
		return (rectangleWidth * rectangleLength)
	}
	fmt.Println("getRectangleArea(7, 5):", getRectangleArea(7, 5))

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
			{ "foo": "bar" },
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
			"my_object": {
				"foo": "bar"
			},
			"my_array": [1, 2, 3]
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
	fmt.Println("myArray2[0](7, 5):", myArray2[0].(func(int, int) int)(7, 5))

	myObject2 := object{
		"my_function": func(a int, b int) int {
			return (a * b)
		},
		"my_string": "foo",
		"my_number": 123,
		"my_bool": true,
		"my_null": nil,
		"my_object": object{
			"foo": "bar",
		},
		"my_array": array{1, 2, 3},
	}
	fmt.Println("myObject2[\"my_function\"](7, 5):", myObject2["my_function"].(func(int, int) int)(7, 5))
}
