@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc Array.findIndex.kt -include-runtime -d Array.findIndex.jar && kotlin Array.findIndex.jar

fun main() {
    fun prettyArrayOfPrimitives(anArrayOfPrimitives: MutableList<Any?>): String {
        var result = "["
        for ((arrayItemIndex, arrayItem) in anArrayOfPrimitives.withIndex()) {
            if (((arrayItem is String) == false) && ((arrayItem is Number) == false)) continue
            if (arrayItem is String) {
                result += "\"${arrayItem}\""
            }
            if (arrayItem is Number) {
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
        fun prettyJsonStringifyInnerFunction(anything: Any? = null, indent: String = "    "): String {
            if (anything == "null") return "null"
            if (anything == "undefined") return "undefined"
            if (anything == null) return "undefined"
            if (anything is String) return "\"${anything}\""
            if (anything is Number || anything is Boolean) return "${anything}"
            if (anything is MutableList<*>) {
                indentLevel += 1
                var result = "[\n${indent.repeat(indentLevel)}"
                for ((arrayItemIndex, arrayItem) in anything.withIndex()) {
                    result += prettyJsonStringifyInnerFunction(arrayItem)
                    if ((arrayItemIndex + 1) != anything.size) {
                        result += ",\n${indent.repeat(indentLevel)}"
                    }
                }
                indentLevel -= 1
                result += "\n${indent.repeat(indentLevel)}]"
                return result
            }
            if (anything is MutableMap<*, *>) {
                indentLevel += 1
                var result = "{\n${indent.repeat(indentLevel)}"
                anything.entries.forEachIndexed { entryIndex, entryItem ->
                    val objectKey = entryItem.key
                    val objectValue = entryItem.value
                    result += "\"${objectKey}\": ${prettyJsonStringifyInnerFunction(objectValue)}"
                    if ((entryIndex + 1) != anything.entries.size) {
                        result += ",\n${indent.repeat(indentLevel)}"
                    }
                }
                indentLevel -= 1
                result += "\n${indent.repeat(indentLevel)}}"
                return result
            }
            return "undefined"
        }
        return prettyJsonStringifyInnerFunction(anything, indent)
    }

    fun arrayFindIndexV1(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Number {
        // JavaScript-like Array.findIndex() function
        var itemIndex = -1
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == true) {
                itemIndex = arrayItemIndex
                break
            }
        }
        return itemIndex
    }

    fun arrayFindIndexV2(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Number {
        // JavaScript-like Array.findIndex() function
        var itemIndex = -1
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
                itemIndex = arrayItemIndex
                break
            }
        }
        return itemIndex
    }

    fun arrayFindIndexV3(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Number {
        // JavaScript-like Array.findIndex() function
        var itemIndex = -1
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == true) return arrayItemIndex
        }
        return itemIndex
    }

    fun arrayFindIndexV4(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Number {
        // JavaScript-like Array.findIndex() function
        var itemIndex = -1
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) return arrayItemIndex
        }
        return itemIndex
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

    println("\n// JavaScript-like Array.findIndex() in Kotlin mutableListOf<Any?>")
    
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
    
    println("// using Kotlin Array.findIndex() built-in function \"indexOfFirst\"")

    numberFoundIndex = numbers.indexOfFirst { number: Any? -> ((number as Int) == numberToFind) }
    println("number found index: ${numberFoundIndex}")
    // number found index: 2

    println("\n// JavaScript-like Array.findIndex() in Kotlin mutableListOf<mutableMapOf<String, Any?>>")

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
    println("product to find: ${prettyJsonStringify(productToFind)}")

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
    
    println("// using Kotlin Array.findIndex() built-in function \"indexOfFirst\"")

    productFoundIndex = products.indexOfFirst { product: Any? -> (((product as MutableMap<String, Any?>)["code"] as String) == productToFind) }
    println("product found index: ${productFoundIndex}")
    // product found index: 0
}
