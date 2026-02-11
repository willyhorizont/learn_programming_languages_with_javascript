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
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
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
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
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
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
    */
    val myObject = mutableMapOf<String, Any?>(
        "my_string" to "foo",
        "my_number" to 123,
        "my_boolean" to true,
        "my_null" to null,
        "my_array" to mutableListOf<Any?>(1, 2, 3),
        "my_object" to mutableMapOf<String, Any?>(
            "foo" to "bar"
        )
    )
    println("myObject: ${jsonStringify(myObject, pretty = true)}")

    /*
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
    */
    val myArray = mutableListOf<Any?>("foo", 123, true, null, mutableListOf<Any?>(1, 2, 3), mutableMapOf<String, Any?>("foo" to "bar"))
    println("myArray: ${jsonStringify(myArray, pretty = true)}")

    /*
x. support passing functions as arguments to other functions
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
x. support returning functions as values from other functions
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
x. support assigning functions to variables
    */
    val getRectangleAreaV1 = fun(rectangleWidth: Int, rectangleLength: Int): Int {
        return (rectangleWidth * rectangleLength)
    }
    println("getRectangleAreaV1(7, 5): ${getRectangleAreaV1(7, 5)}")
    val getRectangleAreaV2 = ({ rectangleWidth: Int, rectangleLength: Int -> (rectangleWidth * rectangleLength) } as (Int, Int) -> Int)
    println("getRectangleAreaV2(7, 5): ${getRectangleAreaV2(7, 5)}")

    /*
x. support storing functions in data structures like object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure or array/list/slice/ordered-list-data-structure
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
        "my_boolean" to true,
        "my_null" to null,
        "my_array" to mutableListOf<Any?>(1, 2, 3),
        "my_object" to mutableMapOf<String, Any?>(
            "foo" to "bar"
        )
    )
    println("myObject2[\"my_function\"](7, 5): ${(myObject2["my_function"] as (Int, Int) -> Int)(7, 5)}")
}
