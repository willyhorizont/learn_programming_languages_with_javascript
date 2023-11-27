@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc Array.every.kt -include-runtime -d Array.every.jar && kotlin Array.every.jar

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
            if (anything == null) return "undefined"
            if (anything == "null") return "null"
            if (anything == "undefined") return "undefined"
            if (anything is String) return "\"${anything}\""
            if (anything is Number || anything is Boolean) return "${anything}"
            if (anything is MutableList<*>) {
                indentLevel += 1
                var result = "[\n${indent.repeat(indentLevel)}"
                for ((arrayItemIndex, arrayItem) in anything.withIndex()) {
                    result += prettyJsonStringifyInnerFunction(arrayItem, indent)
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
                    result += "\"${objectKey}\": ${prettyJsonStringifyInnerFunction(objectValue, indent)}"
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

    fun arrayEveryV1(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Boolean {
        // JavaScript-like Array.every() function
        var isConditionMatch = false
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == false) break
        }
        return isConditionMatch
    }

    fun arrayEveryV2(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Boolean {
        // JavaScript-like Array.every() function
        var isConditionMatch = false
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == false) return isConditionMatch
        }
        return isConditionMatch
    }

    fun arrayEveryV3(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Boolean {
        // JavaScript-like Array.every() function
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == false) return false
        }
        return true
    }

    fun arrayEveryV4(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Boolean {
        // JavaScript-like Array.every() function
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == false) return false
        }
        return true
    }

    println("\n// JavaScript-like Array.every() in Kotlin MutableList<Any?> (List)")
    
    val numbers = mutableListOf<Any?>(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
    println("numbers: ${prettyArrayOfPrimitives(numbers)}")

    var isAllNumberLessThan500: Any?
    var isAllNumberMoreThan500: Any?
    
    println("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

    isAllNumberLessThan500 = arrayEveryV1({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) < 500) }, numbers)
    println("is all number < 500: ${isAllNumberLessThan500}")
    // is all number < 500: true

    isAllNumberMoreThan500 = arrayEveryV1({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) > 500) }, numbers)
    println("is all number > 500: ${isAllNumberMoreThan500}")
    // is all number > 500: false
    
    println("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

    isAllNumberLessThan500 = arrayEveryV2({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) < 500) }, numbers)
    println("is all number < 500: ${isAllNumberLessThan500}")
    // is all number < 500: true

    isAllNumberMoreThan500 = arrayEveryV2({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) > 500) }, numbers)
    println("is all number > 500: ${isAllNumberMoreThan500}")
    // is all number > 500: false
    
    println("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

    isAllNumberLessThan500 = arrayEveryV3({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) < 500) }, numbers)
    println("is all number < 500: ${isAllNumberLessThan500}")
    // is all number < 500: true

    isAllNumberMoreThan500 = arrayEveryV3({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) > 500) }, numbers)
    println("is all number > 500: ${isAllNumberMoreThan500}")
    // is all number > 500: false
    
    println("// using JavaScript-like Array.every() function \"arrayEveryV4\"")

    isAllNumberLessThan500 = arrayEveryV4({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) < 500) }, numbers)
    println("is all number < 500: ${isAllNumberLessThan500}")
    // is all number < 500: true

    isAllNumberMoreThan500 = arrayEveryV4({ number: Any?, _: Int, _: MutableList<Any?> -> ((number as Int) > 500) }, numbers)
    println("is all number > 500: ${isAllNumberMoreThan500}")
    // is all number > 500: false
    
    println("// using Kotlin Array.every() built-in method \"Array.all\"")

    isAllNumberLessThan500 = numbers.all { number: Any? -> ((number as Int) < 500) }
    println("is all number < 500: ${isAllNumberLessThan500}")
    // is all number < 500: true

    isAllNumberMoreThan500 = numbers.all { number: Any? -> ((number as Int) > 500) }
    println("is all number > 500: ${isAllNumberMoreThan500}")
    // is all number > 500: false

    println("\n// JavaScript-like Array.every() in Kotlin MutableList<MutableMap<String, Any?>> (List of Maps)")

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

    var isAllProductPriceLessThan500: Any?
    var isAllProductPriceMoreThan500: Any?

    println("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

    isAllProductPriceLessThan500 = arrayEveryV1({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) < 500) }, products)
    println("is all product price < 500: ${isAllProductPriceLessThan500}")
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = arrayEveryV1({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) > 500) }, products)
    println("is all product price > 500: ${isAllProductPriceMoreThan500}")
    // is all product price > 500: false

    println("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

    isAllProductPriceLessThan500 = arrayEveryV2({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) < 500) }, products)
    println("is all product price < 500: ${isAllProductPriceLessThan500}")
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = arrayEveryV2({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) > 500) }, products)
    println("is all product price > 500: ${isAllProductPriceMoreThan500}")
    // is all product price > 500: false

    println("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

    isAllProductPriceLessThan500 = arrayEveryV3({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) < 500) }, products)
    println("is all product price < 500: ${isAllProductPriceLessThan500}")
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = arrayEveryV3({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) > 500) }, products)
    println("is all product price > 500: ${isAllProductPriceMoreThan500}")
    // is all product price > 500: false

    println("// using JavaScript-like Array.every() function \"arrayEveryV4\"")

    isAllProductPriceLessThan500 = arrayEveryV4({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) < 500) }, products)
    println("is all product price < 500: ${isAllProductPriceLessThan500}")
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = arrayEveryV4({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) > 500) }, products)
    println("is all product price > 500: ${isAllProductPriceMoreThan500}")
    // is all product price > 500: false
    
    println("// using Kotlin Array.every() built-in method \"Array.all\"")

    isAllProductPriceLessThan500 = products.all { product: Any? -> (((product as MutableMap<String, Any?>)["price"] as Int) < 500) }
    println("is all product price < 500: ${isAllProductPriceLessThan500}")
    // is all product price < 500: true

    isAllProductPriceMoreThan500 = products.all { product: Any? -> (((product as MutableMap<String, Any?>)["price"] as Int) > 500) }
    println("is all product price > 500: ${isAllProductPriceMoreThan500}")
    // is all product price > 500: false
}
