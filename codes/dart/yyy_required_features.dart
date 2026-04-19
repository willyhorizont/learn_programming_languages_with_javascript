import "dart:convert";

void main() {
    dynamic jsonStringify(dynamic anything, { bool pretty = false, String indent = "    " }) {
		if (pretty == true) {
			final jsonEncoder = new JsonEncoder.withIndent(indent);
			return jsonEncoder.convert(anything);
		}
		final jsonEncoder = new JsonEncoder();
		return jsonEncoder.convert(anything).split(',').join(', ');
    }

    /*
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
    */
    dynamic something = "foo";
    print("something: ${jsonStringify(something, pretty: true)}");
    something = 123;
    print("something: ${jsonStringify(something, pretty: true)}");
    something = true;
    print("something: ${jsonStringify(something, pretty: true)}");
    something = null;
    print("something: ${jsonStringify(something, pretty: true)}");
    something = <dynamic>[1, 2, 3];
    print("something: ${jsonStringify(something, pretty: true)}");
    something = <String, dynamic>{"foo": "bar"};
    print("something: ${jsonStringify(something, pretty: true)}");

    /*
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
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
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
    */
    final myObject = <String, dynamic>{
        "my_string": "foo",
        "my_number": 123,
        "my_boolean": true,
        "my_null": null,
        "my_array": <dynamic>[1, 2, 3],
        "my_object": <String, dynamic>{
            "foo": "bar"
        }
    };
    print("myObject: ${jsonStringify(myObject, pretty: true)}");

    /*
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
    */
    final myArray = <dynamic>["foo", 123, true, null, <dynamic>[1, 2, 3], <String, dynamic>{"foo": "bar"}];
    print("myArray: ${jsonStringify(myArray, pretty: true)}");

    /*
x. support passing functions as arguments to other functions
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
x. support returning functions as values from other functions
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
x. support assigning functions to variables
    */
    final getRectangleAreaV1 = (dynamic rectangleWidth, dynamic rectangleLength) {
        return (rectangleWidth * rectangleLength);
    };
    print("getRectangleAreaV1(7, 5): ${getRectangleAreaV1(7, 5)}");
    final getRectangleAreaV2 = (dynamic rectangleWidth, dynamic rectangleLength) => (rectangleWidth * rectangleLength);
    print("getRectangleAreaV2(7, 5): ${getRectangleAreaV2(7, 5)}");

    /*
x. support storing functions in data structures like object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure or array/list/slice/ordered-list-data-structure
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
        "my_boolean": true,
        "my_null": null,
        "my_array": <dynamic>[1, 2, 3],
        "my_object": <String, dynamic>{
            "foo": "bar"
        }
    };
    print("myObject2[\"my_function\"](7, 5): ${myObject2["my_function"](7, 5)}");
}
