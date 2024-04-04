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
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == true) return arrayItemIndex
        }
        return -1
    }

    fun arrayFindIndexV4(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Number {
        // JavaScript-like Array.findIndex() function
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) return arrayItemIndex
        }
        return -1
    }

    println("\n// JavaScript-like Array.findIndex() in Kotlin MutableList")
    
    val numbers = mutableListOf<Any?>(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
    println("numbers: ${jsonStringify(numbers)}")

    val numberToFind = 27
    println("number to find: ${numberToFind}")

    var numberFoundIndex: Any?
    
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

    println("\n// JavaScript-like Array.findIndex() in Kotlin MutableList of MutableMaps")

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
    println("products: ${jsonStringify(products, pretty = true)}")
    
    val productToFind = "pasta"
    println("product to find: ${jsonStringify(productToFind)}")

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
