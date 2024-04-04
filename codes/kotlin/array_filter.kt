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

    fun arrayFilterV1(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): MutableList<Any?> {
        // JavaScript-like Array.filter() function
        val dataFiltered = mutableListOf<Any?>()
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == true) dataFiltered.add(arrayItem)
        }
        return dataFiltered
    }

    fun arrayFilterV2(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): MutableList<Any?> {
        // JavaScript-like Array.filter() function
        val dataFiltered = mutableListOf<Any?>()
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) dataFiltered.add(arrayItem)
        }
        return dataFiltered
    }

    println("\n// JavaScript-like Array.filter() in Kotlin MutableList")
    
    val numbers = mutableListOf<Any?>(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
    println("numbers: ${jsonStringify(numbers)}")

    var numbersEven: Any?
    var numbersOdd: Any?
    
    println("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

    numbersEven = arrayFilterV1({ number: Any?, _: Int, _: MutableList<Any?> -> (((number as Int) % 2) == 0) }, numbers)
    println("even numbers only: ${numbersEven}")
    // even numbers only: [12, 34, 36, 4, 254]

    numbersOdd = arrayFilterV1({ number: Any?, _: Int, _: MutableList<Any?> -> (((number as Int) % 2) != 0) }, numbers)
    println("odd numbers only: ${numbersOdd}")
    // odd numbers only: [27, 23, 65, 93, 87]
    
    println("// using JavaScript-like Array.filter() function \"arrayFilterV2\"")

    numbersEven = arrayFilterV2({ number: Any?, _: Int, _: MutableList<Any?> -> (((number as Int) % 2) == 0) }, numbers)
    println("even numbers only: ${numbersEven}")
    // even numbers only: [12, 34, 36, 4, 254]

    numbersOdd = arrayFilterV2({ number: Any?, _: Int, _: MutableList<Any?> -> (((number as Int) % 2) != 0) }, numbers)
    println("odd numbers only: ${numbersOdd}")
    // odd numbers only: [27, 23, 65, 93, 87]
    
    println("// using Kotlin Array.filter() built-in method \"Array.filter\"")

    numbersEven = numbers.filter { number: Any? -> (((number as Int) % 2) == 0) }
    println("even numbers only: ${numbersEven}")
    // even numbers only: [12, 34, 36, 4, 254]

    numbersOdd = numbers.filter { number: Any? -> (((number as Int) % 2) != 0) }
    println("odd numbers only: ${numbersOdd}")
    // odd numbers only: [27, 23, 65, 93, 87]

    println("\n// JavaScript-like Array.filter() in Kotlin MutableList of MutableMaps")

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

    var productsBelow100: Any?
    var productsAbove100: Any?

    println("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

    productsBelow100 = arrayFilterV1({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) <= 100) }, products)
    println("products with price <= 100 only: ${jsonStringify(productsBelow100, pretty = true)}")
    // products with price <= 100 only: [
    //     {
    //         "code": "potato_chips",
    //         "price": 5
    //     }
    // ]

    productsAbove100 = arrayFilterV1({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) > 100) }, products)
    println("products with price > 100 only: ${jsonStringify(productsAbove100, pretty = true)}")
    // products with price > 100 only: [
    //     {
    //         "code": "pasta",
    //         "price": 321
    //     },
    //     {
    //         "code": "bubble_gum",
    //         "price": 233
    //     },
    //     {
    //         "code": "towel",
    //         "price": 499
    //     }
    // ]

    println("// using JavaScript-like Array.filter() function \"arrayFilterV2\"")

    productsBelow100 = arrayFilterV2({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) <= 100) }, products)
    println("products with price <= 100 only: ${jsonStringify(productsBelow100, pretty = true)}")
    // products with price <= 100 only: [
    //     {
    //         "code": "potato_chips",
    //         "price": 5
    //     }
    // ]

    productsAbove100 = arrayFilterV2({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) > 100) }, products)
    println("products with price > 100 only: ${jsonStringify(productsAbove100, pretty = true)}")
    // products with price > 100 only: [
    //     {
    //         "code": "pasta",
    //         "price": 321
    //     },
    //     {
    //         "code": "bubble_gum",
    //         "price": 233
    //     },
    //     {
    //         "code": "towel",
    //         "price": 499
    //     }
    // ]
    
    println("// using Kotlin Array.filter() built-in method \"Array.filter\"")

    productsBelow100 = products.filter { product: Any? -> (((product as MutableMap<String, Any?>)["price"] as Int) <= 100) }
    println("products with price <= 100 only: ${jsonStringify(productsBelow100, pretty = true)}")
    // products with price <= 100 only: [
    //     {
    //         "code": "potato_chips",
    //         "price": 5
    //     }
    // ]

    productsAbove100 = products.filter { product: Any? -> (((product as MutableMap<String, Any?>)["price"] as Int) > 100) }
    println("products with price > 100 only: ${jsonStringify(productsAbove100, pretty = true)}")
    // products with price > 100 only: [
    //     {
    //         "code": "pasta",
    //         "price": 321
    //     },
    //     {
    //         "code": "bubble_gum",
    //         "price": 233
    //     },
    //     {
    //         "code": "towel",
    //         "price": 499
    //     }
    // ]
}
