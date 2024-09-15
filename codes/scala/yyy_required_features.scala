import scala.collection.mutable

def MyObject(objectEntry: (String, Any)*): mutable.Map[String, Any] = (if (objectEntry.isEmpty) mutable.Map.empty[String, Any] else mutable.Map(objectEntry: _*))

def MyArray(arrayItem: Any*): Array[Any] = (if (arrayItem.isEmpty) Array.empty[Any] else arrayItem.toArray[Any])

val isNumeric = ((anything: Any) => (if (anything.isInstanceOf[Byte] || anything.isInstanceOf[Int] || anything.isInstanceOf[Long] || anything.isInstanceOf[Short] || anything.isInstanceOf[Double] || anything.isInstanceOf[Float] || anything.isInstanceOf[BigInt] || anything.isInstanceOf[BigDecimal]) true else false): Boolean)

def jsonStringify(anything: Any = null, pretty: Boolean = false, indent: String = "    "): String = {
    var indentLevel: Int = 0
    def jsonStringifyInner(anythingInner: Any, indentInner: String): String = {
        if (anythingInner == null) return "null"
        if (anythingInner.isInstanceOf[String]) return s"\"${anythingInner}\""
        if (isNumeric(anythingInner) || anythingInner.isInstanceOf[Boolean]) return s"${anythingInner}"
        if (anythingInner.isInstanceOf[Array[_]]) {
            if (anythingInner.asInstanceOf[Array[Any]].length == 0) return "[]"
            indentLevel += 1
            var result: String = (if (pretty == true) s"[\n${indentInner * indentLevel}" else "[")
            for ((arrayItem, arrayItemIndex) <- anythingInner.asInstanceOf[Array[Any]].zipWithIndex) {
                result += jsonStringifyInner(arrayItem, indentInner)
                if ((arrayItemIndex + 1) != anythingInner.asInstanceOf[Array[Any]].length) result += (if (pretty == true) s",\n${indentInner * indentLevel}" else ", ")
            }
            indentLevel -= 1
            result += (if (pretty == true) s"\n${indentInner * indentLevel}]" else "]")
            return result
        }
        if (anythingInner.isInstanceOf[mutable.Map[_, _]]) {
            if (anythingInner.asInstanceOf[mutable.Map[String, Any]].size == 0) return "{}"
            indentLevel += 1
            var result: String = (if (pretty == true) s"{\n${indentInner * indentLevel}" else "{")
            for (((objectKey, objectValue), objectEntryIndex) <- anythingInner.asInstanceOf[mutable.Map[String, Any]].toArray[Any].zipWithIndex) {
                result += s"\"${objectKey}\": ${jsonStringifyInner(objectValue, indentInner)}"
                if ((objectEntryIndex + 1) != anythingInner.asInstanceOf[mutable.Map[String, Any]].size) result += (if (pretty == true) s",\n${indentInner * indentLevel}" else ", ")
            }
            indentLevel -= 1
            result += (if (pretty == true) s"\n${indentInner * indentLevel}}" else "}")
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
var something: Any = "foo"
println("something: " + jsonStringify(something, pretty = true))
something = 123
println("something: " + jsonStringify(something, pretty = true))
something = true
println("something: " + jsonStringify(something, pretty = true))
something = null
println("something: " + jsonStringify(something, pretty = true))
something = MyArray(1, 2, 3)
println("something: " + jsonStringify(something, pretty = true))
something = MyObject("foo" -> "bar")
println("something: " + jsonStringify(something, pretty = true))

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
def getModifiedIndentLevel(): Int = {
    var indentLevel: Int = 0
    def changeIndentLevel(): Int = {
        indentLevel += 1
        if (indentLevel < 5) changeIndentLevel()
        return indentLevel
    }
    return changeIndentLevel()
}
println("getModifiedIndentLevel(): " + getModifiedIndentLevel())
def createNewGame(initialCredit: Int): () => Unit = {
    var currentCredit: Int = initialCredit
    println("initial credit: " + initialCredit)
    return new Function0[Unit] {
        def apply(): Unit = {
            currentCredit -= 1
            if (currentCredit == 0) {
                println("not enough credits")
                return
            }
            println(s"playing game, ${currentCredit} credit(s) remaining")
        }
    }
}
val playGame = createNewGame(3)
playGame.asInstanceOf[() => Unit]()
playGame.asInstanceOf[() => Unit]()
playGame.asInstanceOf[() => Unit]()

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
val myObject = MyObject(
    "my_string" -> "foo",
    "my_number" -> 123,
    "my_bool" -> true,
    "my_null" -> null,
    "my_array" -> MyArray(1, 2, 3),
    "my_object" -> MyObject(
        "foo" -> "bar"
    )
)
println("myObject: " + jsonStringify(myObject, pretty = true))

/*
4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
```javascript
const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
console.log(`myArray: ${myArray}`);
```
*/
val myArray = MyArray("foo", 123, true, null, MyArray(1, 2, 3), MyObject("foo" -> "bar"))
println("myArray: " + jsonStringify(myArray, pretty = true))

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
def sayHello(callbackFunction: () => Unit): Unit = {
    println("hello")
    callbackFunction()
}
def sayHowAreYou(): Unit = {
    println("how are you?")
}
sayHello(sayHowAreYou _)
sayHello(new Function0[Unit] {
    def apply(): Unit = {
        println("how are you?")
    }
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
console.log(`multiplyBy2Result: ${multiplyBy2Result}`);
```
*/
def multiply(a: Int): (Int) => Int = {
    return new Function1[Int, Int] {
        def apply(b: Int): Int = {
            return (a * b): Int
        }
    }
}
val multiplyBy2 = multiply(2)
val multiplyBy2Result = multiplyBy2.asInstanceOf[(Int) => Int](10)
println("multiplyBy2Result: " + multiplyBy2Result)

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
val getRectangleAreaV1 = new Function2[Int, Int, Int] {
    def apply(rectangleWidth: Int, rectangleLength: Int): Int = {
        return (rectangleWidth * rectangleLength): Int
    }
}
println(s"getRectangleAreaV1(7, 5): ${getRectangleAreaV1.asInstanceOf[(Int, Int) => Int](7, 5)}")
val getRectangleAreaV2 = { (rectangleWidth: Int, rectangleLength: Int) => (rectangleWidth * rectangleLength): Int }
println(s"getRectangleAreaV2(7, 5): ${getRectangleAreaV2.asInstanceOf[(Int, Int) => Int](7, 5)}")
val getRectangleAreaV3 = ((rectangleWidth: Int, rectangleLength: Int) => (rectangleWidth * rectangleLength): Int)
println(s"getRectangleAreaV3(7, 5): ${getRectangleAreaV3.asInstanceOf[(Int, Int) => Int](7, 5)}")

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
val myArray2 = MyArray(
    new Function2[Int, Int, Int] {
        def apply(a: Int, b: Int): Int = {
            return (a * b): Int
        }
    },
    "foo",
    123,
    true,
    null,
    MyArray(1, 2, 3),
    MyObject("foo" -> "bar")
)
println("myArray2[0](7, 5): " + myArray2.asInstanceOf[Array[Any]](0).asInstanceOf[(Int, Int) => Int](7, 5))
val myObject2 = MyObject(
    "my_function" -> new Function2[Int, Int, Int] {
        def apply(a: Int, b: Int): Int = {
            return (a * b): Int
        }
    },
    "my_string" -> "foo",
    "my_number" -> 123,
    "my_bool" -> true,
    "my_null" -> null,
    "my_array" -> MyArray(1, 2, 3),
    "my_object" -> MyObject(
        "foo" -> "bar"
    )
)
println("myObject2[\"my_function\"](7, 5): " + myObject2.asInstanceOf[mutable.Map[String, Any]]("my_function").asInstanceOf[(Int, Int) => Int](7, 5))
