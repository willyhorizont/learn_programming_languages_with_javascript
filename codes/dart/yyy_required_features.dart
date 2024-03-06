import "dart:convert";

void main() {
	dynamic prettyJsonStringify(dynamic anything) {
		final jsonEncoder = new JsonEncoder.withIndent("    ");
		return jsonEncoder.convert(anything);
	}

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
	dynamic something = "foo";
	print("something: ${prettyJsonStringify(something)}");
	something = 123;
	print("something: ${prettyJsonStringify(something)}");
	something = true;
	print("something: ${prettyJsonStringify(something)}");
	something = null;
	print("something: ${prettyJsonStringify(something)}");
	something = <dynamic>[1, 2, 3];
	print("something: ${prettyJsonStringify(something)}");
	something = <String, dynamic>{"foo": "bar"};
	print("something: ${prettyJsonStringify(something)}");

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
	dynamic getModifiedIndentLevel() {
		dynamic indentLevel = 0;
		dynamic changeIndentLevel() {
			indentLevel += 1;
			if (indentLevel < 5) changeIndentLevel();
			return indentLevel;
		}
		return changeIndentLevel();
	}
	print("getModifiedIndentLevel(): ${getModifiedIndentLevel()}");
	dynamic createNewGame(int initialCredit) {
		int currentCredit = initialCredit;
		print("initial credit: ${initialCredit}");
		return () {
			currentCredit -= 1;
			if (currentCredit == 0) {
				print("not enough credits");
				return;
			}
			print("playing game, ${currentCredit} credit(s) remaining");
		};
	}
	final playGame = createNewGame(3);
	playGame();
	playGame();
	playGame();

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
	final myObject = <String, dynamic>{
		"my_string": "foo",
		"my_number": 123,
		"my_bool": true,
		"my_null": null,
		"my_object": <String, dynamic>{
			"foo": "bar"
		},
		"my_array": <dynamic>[1, 2, 3]
	};
	print("myObject: ${prettyJsonStringify(myObject)}");

	/*
		4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
		```javascript
		const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
		console.log("myArray:", myArray);
		```
	*/
	final myArray = <dynamic>["foo", 123, true, null, <dynamic>[1, 2, 3], <String, dynamic>{"foo": "bar"}];
	print("myArray: ${prettyJsonStringify(myArray)}");

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
	dynamic sayHello(dynamic callbackFunction) {
		print("hello");
    	callbackFunction();
	}
	dynamic sayHowAreYou() {
		print("how are you?");
	}
	sayHello(sayHowAreYou);
	sayHello(() {
		print("how are you?");
	});

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
	dynamic multiply(dynamic a) {
		return (dynamic b) {
			return (a * b);
		};
	}
	final multiplyBy2 = multiply(2);
	final multiplyBy2Result = multiplyBy2(10);
	print("multiplyBy2Result: ${multiplyBy2Result}");

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
	final getRectangleAreaV1 = (dynamic rectangleWidth, dynamic rectangleLength) {
		return (rectangleWidth * rectangleLength);
	};
	print("getRectangleAreaV1(7, 5): ${getRectangleAreaV1(7, 5)}");
	final getRectangleAreaV2 = (dynamic rectangleWidth, dynamic rectangleLength) => (rectangleWidth * rectangleLength);
	print("getRectangleAreaV2(7, 5): ${getRectangleAreaV2(7, 5)}");

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
	final myArray2 = <dynamic>[
		(dynamic rectangleWidth, dynamic rectangleLength) {
			return (rectangleWidth * rectangleLength);
		},
		"foo",
		123,
		true,
		null,
		<dynamic>[1, 2, 3],
		<String, dynamic>{"foo": "bar"}
	];
	print("myArray2[0](7, 5): ${myArray2[0](7, 5)}");

	final myObject2 = <String, dynamic>{
		"my_function": (dynamic rectangleWidth, dynamic rectangleLength) {
			return (rectangleWidth * rectangleLength);
		},
		"my_string": "foo",
		"my_number": 123,
		"my_bool": true,
		"my_null": null,
		"my_object": <String, dynamic>{
			"foo": "bar"
		},
		"my_array": <dynamic>[1, 2, 3]
	};
	print("myObject2[\"my_function\"](7, 5): ${myObject2["my_function"](7, 5)}");
}
