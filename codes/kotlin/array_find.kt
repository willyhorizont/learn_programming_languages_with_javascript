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

    fun arrayFindV1(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Any? {
        // JavaScript-like Array.find() function
        var dataFound: Any? = null
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == true) {
                dataFound = arrayItem
                break
            }
        }
        return dataFound
    }

    fun arrayFindV2(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Any? {
        // JavaScript-like Array.find() function
        var dataFound: Any? = null
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
                dataFound = arrayItem
                break
            }
        }
        return dataFound
    }

    fun arrayFindV3(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Any? {
        // JavaScript-like Array.find() function
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == true) return arrayItem
        }
        return null
    }

    fun arrayFindV4(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): Any? {
        // JavaScript-like Array.find() function
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) return arrayItem
        }
        return null
    }

    println("\n// JavaScript-like Array.find() in Kotlin MutableList")
    
    val numbers = mutableListOf<Any?>(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
    println("numbers: ${jsonStringify(numbers)}")

    var evenNumberFound: Any?
    var oddNumberFound: Any?
    
    println("// using JavaScript-like Array.find() function \"arrayFindV1\"")

    evenNumberFound = arrayFindV1({ number: Any?, _: Int, _: MutableList<Any?> -> (((number as Int) % 2) == 0) }, numbers)
    println("even number found: ${evenNumberFound}")
    // even number found: 12

    oddNumberFound = arrayFindV1({ number: Any?, _: Int, _: MutableList<Any?> -> (((number as Int) % 2) != 0) }, numbers)
    println("odd number found: ${oddNumberFound}")
    // odd number found: 27
    
    println("// using JavaScript-like Array.find() function \"arrayFindV2\"")

    evenNumberFound = arrayFindV2({ number: Any?, _: Int, _: MutableList<Any?> -> (((number as Int) % 2) == 0) }, numbers)
    println("even number found: ${evenNumberFound}")
    // even number found: 12

    oddNumberFound = arrayFindV2({ number: Any?, _: Int, _: MutableList<Any?> -> (((number as Int) % 2) != 0) }, numbers)
    println("odd number found: ${oddNumberFound}")
    // odd number found: 27
    
    println("// using JavaScript-like Array.find() function \"arrayFindV3\"")

    evenNumberFound = arrayFindV3({ number: Any?, _: Int, _: MutableList<Any?> -> (((number as Int) % 2) == 0) }, numbers)
    println("even number found: ${evenNumberFound}")
    // even number found: 12

    oddNumberFound = arrayFindV3({ number: Any?, _: Int, _: MutableList<Any?> -> (((number as Int) % 2) != 0) }, numbers)
    println("odd number found: ${oddNumberFound}")
    // odd number found: 27
    
    println("// using JavaScript-like Array.find() function \"arrayFindV4\"")

    evenNumberFound = arrayFindV4({ number: Any?, _: Int, _: MutableList<Any?> -> (((number as Int) % 2) == 0) }, numbers)
    println("even number found: ${evenNumberFound}")
    // even number found: 12

    oddNumberFound = arrayFindV4({ number: Any?, _: Int, _: MutableList<Any?> -> (((number as Int) % 2) != 0) }, numbers)
    println("odd number found: ${oddNumberFound}")
    // odd number found: 27
    
    println("// using Kotlin Array.find() built-in method \"Array.find\"")

    evenNumberFound = numbers.find { number: Any? -> (((number as Int) % 2) == 0) }
    println("even number found: ${evenNumberFound}")
    // even number found: 12

    oddNumberFound = numbers.find { number: Any? -> (((number as Int) % 2) != 0) }
    println("odd number found: ${oddNumberFound}")
    // odd number found: 27

    println("\n// JavaScript-like Array.find() in Kotlin MutableList of MutableMaps")

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

    val productToFind = "bubble_gum"
    println("product to find: ${productToFind}")

    var productFound: Any?

    println("// using JavaScript-like Array.find() function \"arrayFindV1\"")

    productFound = arrayFindV1({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["code"] as String) == productToFind) }, products)
    println("product found: ${jsonStringify(productFound, pretty = true)}")
    // product found: {
    //     "code":"bubble_gum",
    //     "price": 233
    // }

    println("// using JavaScript-like Array.find() function \"arrayFindV2\"")

    productFound = arrayFindV2({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["code"] as String) == productToFind) }, products)
    println("product found: ${jsonStringify(productFound, pretty = true)}")
    // product found: {
    //     "code":"bubble_gum",
    //     "price": 233
    // }

    println("// using JavaScript-like Array.find() function \"arrayFindV3\"")

    productFound = arrayFindV3({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["code"] as String) == productToFind) }, products)
    println("product found: ${jsonStringify(productFound, pretty = true)}")
    // product found: {
    //     "code":"bubble_gum",
    //     "price": 233
    // }

    println("// using JavaScript-like Array.find() function \"arrayFindV4\"")

    productFound = arrayFindV4({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["code"] as String) == productToFind) }, products)
    println("product found: ${jsonStringify(productFound, pretty = true)}")
    // product found: {
    //     "code":"bubble_gum",
    //     "price": 233
    // }
    
    println("// using Kotlin Array.find() built-in method \"Array.find\"")

    productFound = products.find { product: Any? -> (((product as MutableMap<String, Any?>)["code"] as String) == productToFind) }
    println("product found: ${jsonStringify(productFound, pretty = true)}")
    // product found: {
    //     "code":"bubble_gum",
    //     "price": 233
    // }
}
