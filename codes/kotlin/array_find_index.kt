@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
    fun prettyArrayOfPrimitives(anArrayOfPrimitives: MutableList<Any?>): String {
        var result = "["
        for ((arrayItemIndex, arrayItem) in anArrayOfPrimitives.withIndex()) {
            if (((arrayItem is String) == false) && ((arrayItem is Number) == false) && ((arrayItem is Boolean) == false) && (arrayItem != null)) continue
            if (arrayItem is String) {
                result += "\"${arrayItem}\""
            }
            if ((arrayItem is Number) || (arrayItem is Boolean) || arrayItem == null) {
                result += "${arrayItem}"
            }
            if ((arrayItemIndex + 1) != anArrayOfPrimitives.size) {
                result += ", "
            }
        }
        result += "]"
        return result
    }

    fun prettyJsonStringify(anything: Any? = null, indent: String = "    "): String {
        var indentLevel = 0
        fun prettyJsonStringifyInner(anythingInner: Any?, indentInner: String): String {
            if (anythingInner == null) return "null"
            if (anythingInner is String) return "\"${anythingInner}\""
            if (anythingInner is Number || anythingInner is Boolean) return "${anythingInner}"
            if (anythingInner is MutableList<*>) {
                if (anythingInner.size == 0) {
                    val result = "[]"
                    return result
                }
                indentLevel += 1
                var result = "[\n${indentInner.repeat(indentLevel)}"
                for ((arrayItemIndex, arrayItem) in anythingInner.withIndex()) {
                    result += prettyJsonStringifyInner(arrayItem, indentInner)
                    if ((arrayItemIndex + 1) != anythingInner.size) {
                        result += ",\n${indentInner.repeat(indentLevel)}"
                    }
                }
                indentLevel -= 1
                result += "\n${indentInner.repeat(indentLevel)}]"
                return result
            }
            if (anythingInner is MutableMap<*, *>) {
                if (anythingInner.entries.size == 0) {
                    val result = "{}"
                    return result
                }
                indentLevel += 1
                var result = "{\n${indentInner.repeat(indentLevel)}"
                anythingInner.entries.forEachIndexed { entryIndex, entryItem ->
                    val objectKey = entryItem.key
                    val objectValue = entryItem.value
                    result += "\"${objectKey}\": ${prettyJsonStringifyInner(objectValue, indentInner)}"
                    if ((entryIndex + 1) != anythingInner.entries.size) {
                        result += ",\n${indentInner.repeat(indentLevel)}"
                    }
                }
                indentLevel -= 1
                result += "\n${indentInner.repeat(indentLevel)}}"
                return result
            }
            return "null"
        }
        return prettyJsonStringifyInner(anything, indent)
    }

    fun arrayFindIndexV1(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Number {
        // JavaScript-like Array.findIndex() function
        var dataFoundIndex = -1
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == true) {
                dataFoundIndex = arrayItemIndex
                break
            }
        }
        return dataFoundIndex
    }

    fun arrayFindIndexV2(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Number {
        // JavaScript-like Array.findIndex() function
        var dataFoundIndex = -1
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
                dataFoundIndex = arrayItemIndex
                break
            }
        }
        return dataFoundIndex
    }

    fun arrayFindIndexV3(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Number {
        // JavaScript-like Array.findIndex() function
        var dataFoundIndex = -1
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == true) return arrayItemIndex
        }
        return dataFoundIndex
    }

    fun arrayFindIndexV4(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Number {
        // JavaScript-like Array.findIndex() function
        var dataFoundIndex = -1
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) return arrayItemIndex
        }
        return dataFoundIndex
    }

    fun arrayFindIndexV5(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Number {
        // JavaScript-like Array.findIndex() function
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == true) return arrayItemIndex
        }
        return -1
    }

    fun arrayFindIndexV6(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Number {
        // JavaScript-like Array.findIndex() function
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) return arrayItemIndex
        }
        return -1
    }

    println("\n// JavaScript-like Array.findIndex() in Kotlin MutableList<Any?> (List)")
    
    val numbers = mutableListOf<Any?>(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
    println("numbers: ${prettyArrayOfPrimitives(numbers)}")

    val numberToFind = 27
    println("number to find: ${numberToFind}")

    var numberFoundIndex: Number
    
    println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

    numberFoundIndex = arrayFindIndexV1({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) == numberToFind) }, numbers)
    println("number found index: ${numberFoundIndex}")
    // number found index: 2
    
    println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

    numberFoundIndex = arrayFindIndexV2({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) == numberToFind) }, numbers)
    println("number found index: ${numberFoundIndex}")
    // number found index: 2
    
    println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"")

    numberFoundIndex = arrayFindIndexV3({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) == numberToFind) }, numbers)
    println("number found index: ${numberFoundIndex}")
    // number found index: 2
    
    println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"")

    numberFoundIndex = arrayFindIndexV4({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) == numberToFind) }, numbers)
    println("number found index: ${numberFoundIndex}")
    // number found index: 2
    
    println("// using Kotlin Array.findIndex() built-in method \"Array.indexOfFirst\"")

    numberFoundIndex = numbers.indexOfFirst { number: Any? -> ((number as Int) == numberToFind) }
    println("number found index: ${numberFoundIndex}")
    // number found index: 2

    println("\n// JavaScript-like Array.findIndex() in Kotlin MutableList<MutableMap<String, Any?>> (List of Maps)")

    val products = mutableListOf<Any?>(
        mutableMapOf<String, Any?>(
            "code" to "pasta",
            "price" to 321
        ),
        mutableMapOf<String, Any?>(
            "code" to "bubble_gum",
            "price" to 233
        ),
        mutableMapOf<String, Any?>(
            "code" to "potato_chips",
            "price" to 5
        ),
        mutableMapOf<String, Any?>(
            "code" to "towel",
            "price" to 499
        )
    )
    println("products: ${prettyJsonStringify(products)}")
    
    val productToFind = "pasta"
    println("product to find: ${productToFind}")

    var productFoundIndex: Any?

    println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

    productFoundIndex = arrayFindIndexV1({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["code"] as String) == productToFind) }, products)
    println("product found index: ${productFoundIndex}")
    // product found index: 0

    println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

    productFoundIndex = arrayFindIndexV2({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["code"] as String) == productToFind) }, products)
    println("product found index: ${productFoundIndex}")
    // product found index: 0

    println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"")

    productFoundIndex = arrayFindIndexV3({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["code"] as String) == productToFind) }, products)
    println("product found index: ${productFoundIndex}")
    // product found index: 0

    println("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"")

    productFoundIndex = arrayFindIndexV4({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["code"] as String) == productToFind) }, products)
    println("product found index: ${productFoundIndex}")
    // product found index: 0
    
    println("// using Kotlin Array.findIndex() built-in method \"Array.indexOfFirst\"")

    productFoundIndex = products.indexOfFirst { product: Any? -> (((product as MutableMap<String, Any?>)["code"] as String) == productToFind) }
    println("product found index: ${productFoundIndex}")
    // product found index: 0
}
