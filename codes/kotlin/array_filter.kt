@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
    fun prettyArrayOfPrimitives(anArrayOfPrimitives: MutableList<Any?>): String {
        var result = "["
        for ((arrayItemIndex, arrayItem) in anArrayOfPrimitives.withIndex()) {
            if (((arrayItem is String) == false) && ((arrayItem is Number) == false) && ((arrayItem is Boolean) == false) && (arrayItem != null)) continue
            if (arrayItem is String) result += "\"${arrayItem}\""
            if ((arrayItem is Number) || (arrayItem is Boolean) || (arrayItem == null)) result += "${arrayItem}"
            if ((arrayItemIndex + 1) != anArrayOfPrimitives.size) result += ", "
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
                if (anythingInner.size == 0) return "[]"
                indentLevel += 1
                var result = "[\n${indentInner.repeat(indentLevel)}"
                for ((arrayItemIndex, arrayItem) in anythingInner.withIndex()) {
                    result += prettyJsonStringifyInner(arrayItem, indentInner)
                    if ((arrayItemIndex + 1) != anythingInner.size) result += ",\n${indentInner.repeat(indentLevel)}"
                }
                indentLevel -= 1
                result += "\n${indentInner.repeat(indentLevel)}]"
                return result
            }
            if (anythingInner is MutableMap<*, *>) {
                if (anythingInner.entries.size == 0) return "{}"
                indentLevel += 1
                var result = "{\n${indentInner.repeat(indentLevel)}"
                anythingInner.entries.forEachIndexed { objectEntryIndex, objectEntry ->
                    val objectKey = objectEntry.key
                    val objectValue = objectEntry.value
                    result += "\"${objectKey}\": ${prettyJsonStringifyInner(objectValue, indentInner)}"
                    if ((objectEntryIndex + 1) != anythingInner.entries.size) result += ",\n${indentInner.repeat(indentLevel)}"
                }
                indentLevel -= 1
                result += "\n${indentInner.repeat(indentLevel)}}"
                return result
            }
            return "null"
        }
        return prettyJsonStringifyInner(anything, indent)
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
    println("numbers: ${prettyArrayOfPrimitives(numbers)}")

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
    println("products: ${prettyJsonStringify(products)}")

    var productsBelow100: Any?
    var productsAbove100: Any?

    println("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

    productsBelow100 = arrayFilterV1({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) <= 100) }, products)
    println("products with price <= 100 only: ${prettyJsonStringify(productsBelow100)}")
    // products with price <= 100 only: [
    //     {
    //         "code": "potato_chips",
    //         "price": 5
    //     }
    // ]

    productsAbove100 = arrayFilterV1({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) > 100) }, products)
    println("products with price > 100 only: ${prettyJsonStringify(productsAbove100)}")
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
    println("products with price <= 100 only: ${prettyJsonStringify(productsBelow100)}")
    // products with price <= 100 only: [
    //     {
    //         "code": "potato_chips",
    //         "price": 5
    //     }
    // ]

    productsAbove100 = arrayFilterV2({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) > 100) }, products)
    println("products with price > 100 only: ${prettyJsonStringify(productsAbove100)}")
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
    println("products with price <= 100 only: ${prettyJsonStringify(productsBelow100)}")
    // products with price <= 100 only: [
    //     {
    //         "code": "potato_chips",
    //         "price": 5
    //     }
    // ]

    productsAbove100 = products.filter { product: Any? -> (((product as MutableMap<String, Any?>)["price"] as Int) > 100) }
    println("products with price > 100 only: ${prettyJsonStringify(productsAbove100)}")
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
