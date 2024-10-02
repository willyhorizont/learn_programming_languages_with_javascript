@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
    fun jsonStringify(anything: Any? = null, pretty: Boolean = false, indent: String = "    "): String {
        var indentLevel = 0
        fun jsonStringifyInner(anythingInner: Any?, indentInner: String): String {
            if (anythingInner == null) return "null"
            if (anythingInner is String) return "\"${anythingInner}\""
            if (anythingInner is Number || anythingInner is Boolean) return "${anythingInner}"
            if (anythingInner is MutableList<*>) {
                if (anythingInner.size == 0) return "[]"
                indentLevel += 1
                var result = (if (pretty == true) "[\n${indentInner.repeat(indentLevel)}" else "[")
                for ((arrayItemIndex, arrayItem) in anythingInner.withIndex()) {
                    result += jsonStringifyInner(arrayItem, indentInner)
                    if ((arrayItemIndex + 1) != anythingInner.size) result += (if (pretty == true) ",\n${indentInner.repeat(indentLevel)}" else ", ")
                }
                indentLevel -= 1
                result += (if (pretty == true) "\n${indentInner.repeat(indentLevel)}]" else "]")
                return result
            }
            if (anythingInner is MutableMap<*, *>) {
                if (anythingInner.entries.size == 0) return "{}"
                indentLevel += 1
                var result = (if (pretty == true) "{\n${indentInner.repeat(indentLevel)}" else "{")
                anythingInner.entries.forEachIndexed { objectEntryIndex, objectEntry ->
                    val objectKey = objectEntry.key
                    val objectValue = objectEntry.value
                    result += "\"${objectKey}\": ${jsonStringifyInner(objectValue, indentInner)}"
                    if ((objectEntryIndex + 1) != anythingInner.entries.size) result += (if (pretty == true) ",\n${indentInner.repeat(indentLevel)}" else ", ")
                }
                indentLevel -= 1
                result += (if (pretty == true) "\n${indentInner.repeat(indentLevel)}}" else "}")
                return result
            }
            return "null"
        }
        return jsonStringifyInner(anything, indent)
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

    var something: Any? = "foo"
    println("something: ${jsonStringify(something, pretty = true)}")
    something = 123
    println("something: ${jsonStringify(something, pretty = true)}")
    something = true
    println("something: ${jsonStringify(something, pretty = true)}")
    something = null
    println("something: ${jsonStringify(something, pretty = true)}")
    something = mutableListOf<Any?>(1, 2, 3)
    println("something: ${jsonStringify(something, pretty = true)}")
    something = mutableMapOf<String, Any?>("foo" to "bar")
    println("something: ${jsonStringify(something, pretty = true)}")

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
console.log(`getModifiedIndentLevel(): ${getModifiedIndentLevel()}`);
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
    fun getModifiedIndentLevel(): Int {
        var indentLevel = 0
        fun changeIndentLevel(): Int {
            indentLevel += 1
            if (indentLevel < 5) changeIndentLevel()
            return indentLevel
        }
        return changeIndentLevel()
    }
    println("getModifiedIndentLevel(): ${getModifiedIndentLevel()}")
    fun createNewGame(initialCredit: Int): () -> Unit {
        var currentCredit = initialCredit
        println("initial credit: ${initialCredit}")
        return fun(): Unit {
            currentCredit -= 1
            if (currentCredit == 0) {
                println("not enough credits")
            } else {
                println("playing game, ${currentCredit} credit(s) remaining")
            }
        }
    }
    val playGame = createNewGame(3)
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
console.log(`myObject: ${myObject}`);
```
    */
    val myObject = mutableMapOf<String, Any?>(
        "my_string" to "foo",
        "my_number" to 123,
        "my_bool" to true,
        "my_null" to null,
        "my_array" to mutableListOf<Any?>(1, 2, 3),
        "my_object" to mutableMapOf<String, Any?>(
            "foo" to "bar"
        )
    )
    println("myObject: ${jsonStringify(myObject, pretty = true)}")

    /*
4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
```javascript
const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
console.log(`myArray: ${myArray}`);
```
    */
    val myArray = mutableListOf<Any?>("foo", 123, true, null, mutableListOf<Any?>(1, 2, 3), mutableMapOf<String, Any?>("foo" to "bar"))
    println("myArray: ${jsonStringify(myArray, pretty = true)}")

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
    fun sayHello(callbackFunction: () -> Unit) {
        println("hello")
        callbackFunction()
    }
    fun sayHowAreYou() {
        println("how are you?")
    }
    sayHello(::sayHowAreYou)
    sayHello(fun() {
        println("how are you?")
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
    fun multiply(a: Int): (Int) -> Int {
        return fun(b: Int): Int {
            return (a * b)
        }
    }
    val multiplyBy2 = multiply(2)
    val multiplyBy2Result = multiplyBy2(10)
    println("multiplyBy2Result: ${multiplyBy2Result}")

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
    val getRectangleAreaV1 = fun(rectangleWidth: Int, rectangleLength: Int): Int {
        return (rectangleWidth * rectangleLength)
    }
    println("getRectangleAreaV1(7, 5): ${getRectangleAreaV1(7, 5)}")
    val getRectangleAreaV2 = ({ rectangleWidth: Int, rectangleLength: Int -> (rectangleWidth * rectangleLength) } as (Int, Int) -> Int)
    println("getRectangleAreaV2(7, 5): ${getRectangleAreaV2(7, 5)}")

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
    val myArray2 = mutableListOf<Any?>(
        fun(a: Int, b: Int): Int {
            return (a * b)
        },
        "foo",
        123,
        true,
        null,
        mutableListOf<Any?>(1, 2, 3),
        mutableMapOf<String, Any?>("foo" to "bar")
    )
    println("myArray2[0](7, 5): ${(myArray2[0] as (Int, Int) -> Int)(7, 5)}")
    val myObject2 = mutableMapOf<String, Any?>(
        "my_function" to fun(a: Int, b: Int): Int {
            return (a * b)
        },
        "my_string" to "foo",
        "my_number" to 123,
        "my_bool" to true,
        "my_null" to null,
        "my_array" to mutableListOf<Any?>(1, 2, 3),
        "my_object" to mutableMapOf<String, Any?>(
            "foo" to "bar"
        )
    )
    println("myObject2[\"my_function\"](7, 5): ${(myObject2["my_function"] as (Int, Int) -> Int)(7, 5)}")
}
