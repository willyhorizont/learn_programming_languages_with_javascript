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

    fun arraySomeV1(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Boolean {
        // JavaScript-like Array.every() function
        var isConditionMatch = false
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == true) break
        }
        return isConditionMatch
    }

    fun arraySomeV2(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Boolean {
        // JavaScript-like Array.every() function
        var isConditionMatch = false
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == true) return isConditionMatch
        }
        return isConditionMatch
    }

    fun arraySomeV3(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Boolean {
        // JavaScript-like Array.every() function
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == true) return true
        }
        return false
    }

    fun arraySomeV4(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Boolean {
        // JavaScript-like Array.every() function
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) return true
        }
        return false
    }

    println("\n// JavaScript-like Array.some() in Kotlin MutableList")
    
    val numbers = mutableListOf<Any?>(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
    println("numbers: ${jsonStringify(numbers)}")

    var isAnyNumberLessThan500: Any?
    var isAnyNumberMoreThan500: Any?
    
    println("// using JavaScript-like Array.some() function \"arraySomeV1\"")

    isAnyNumberLessThan500 = arraySomeV1({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) < 500) }, numbers)
    println("is any number < 500: ${isAnyNumberLessThan500}")
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV1({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) > 500) }, numbers)
    println("is any number > 500: ${isAnyNumberMoreThan500}")
    // is any number > 500: false
    
    println("// using JavaScript-like Array.some() function \"arraySomeV2\"")

    isAnyNumberLessThan500 = arraySomeV2({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) < 500) }, numbers)
    println("is any number < 500: ${isAnyNumberLessThan500}")
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV2({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) > 500) }, numbers)
    println("is any number > 500: ${isAnyNumberMoreThan500}")
    // is any number > 500: false
    
    println("// using JavaScript-like Array.some() function \"arraySomeV3\"")

    isAnyNumberLessThan500 = arraySomeV3({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) < 500) }, numbers)
    println("is any number < 500: ${isAnyNumberLessThan500}")
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV3({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) > 500) }, numbers)
    println("is any number > 500: ${isAnyNumberMoreThan500}")
    // is any number > 500: false
    
    println("// using JavaScript-like Array.some() function \"arraySomeV4\"")

    isAnyNumberLessThan500 = arraySomeV4({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) < 500) }, numbers)
    println("is any number < 500: ${isAnyNumberLessThan500}")
    // is any number < 500: true

    isAnyNumberMoreThan500 = arraySomeV4({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) > 500) }, numbers)
    println("is any number > 500: ${isAnyNumberMoreThan500}")
    // is any number > 500: false
    
    println("// using Kotlin Array.some() built-in method \"Array.any\"")

    isAnyNumberLessThan500 = numbers.any { number: Any? -> ((number as Int) < 500) }
    println("is any number < 500: ${isAnyNumberLessThan500}")
    // is any number < 500: true

    isAnyNumberMoreThan500 = numbers.any { number: Any? -> ((number as Int) > 500) }
    println("is any number > 500: ${isAnyNumberMoreThan500}")
    // is any number > 500: false

    println("\n// JavaScript-like Array.some() in Kotlin MutableList of MutableMaps")

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

    var isAnyProductPriceLessThan500: Any?
    var isAnyProductPriceMoreThan500: Any?

    println("// using JavaScript-like Array.some() function \"arraySomeV1\"")

    isAnyProductPriceLessThan500 = arraySomeV1({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) < 500) }, products)
    println("is any product price < 500: ${isAnyProductPriceLessThan500}")
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV1({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) > 500) }, products)
    println("is any product price > 500: ${isAnyProductPriceMoreThan500}")
    // is any product price > 500: false

    println("// using JavaScript-like Array.some() function \"arraySomeV2\"")

    isAnyProductPriceLessThan500 = arraySomeV2({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) < 500) }, products)
    println("is any product price < 500: ${isAnyProductPriceLessThan500}")
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV2({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) > 500) }, products)
    println("is any product price > 500: ${isAnyProductPriceMoreThan500}")
    // is any product price > 500: false

    println("// using JavaScript-like Array.some() function \"arraySomeV3\"")

    isAnyProductPriceLessThan500 = arraySomeV3({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) < 500) }, products)
    println("is any product price < 500: ${isAnyProductPriceLessThan500}")
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV3({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) > 500) }, products)
    println("is any product price > 500: ${isAnyProductPriceMoreThan500}")
    // is any product price > 500: false

    println("// using JavaScript-like Array.some() function \"arraySomeV4\"")

    isAnyProductPriceLessThan500 = arraySomeV4({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) < 500) }, products)
    println("is any product price < 500: ${isAnyProductPriceLessThan500}")
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = arraySomeV4({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) > 500) }, products)
    println("is any product price > 500: ${isAnyProductPriceMoreThan500}")
    // is any product price > 500: false
    
    println("// using Kotlin Array.some() built-in method \"Array.any\"")

    isAnyProductPriceLessThan500 = products.any { product: Any? -> (((product as MutableMap<String, Any?>)["price"] as Int) < 500) }
    println("is any product price < 500: ${isAnyProductPriceLessThan500}")
    // is any product price < 500: true

    isAnyProductPriceMoreThan500 = products.any { product: Any? -> (((product as MutableMap<String, Any?>)["price"] as Int) > 500) }
    println("is any product price > 500: ${isAnyProductPriceMoreThan500}")
    // is any product price > 500: false
}
