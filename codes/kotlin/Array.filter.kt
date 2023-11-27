@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc Array.filter.kt -include-runtime -d Array.filter.jar && kotlin Array.filter.jar

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

    fun arrayFilterV1(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): MutableList<Any?> {
        // JavaScript-like Array.filter() function
        val dataFiltered = mutableListOf<Any?>()
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            val isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
            if (isConditionMatch == true) {
                dataFiltered.add(arrayItem)
            }
        }
        return dataFiltered
    }

    fun arrayFilterV2(callbackFunction: (Any?, Int, MutableList<Any?>) -> Boolean, anArray: MutableList<Any?>): MutableList<Any?> {
        // JavaScript-like Array.filter() function
        val dataFiltered = mutableListOf<Any?>()
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
                dataFiltered.add(arrayItem)
            }
        }
        return dataFiltered
    }

    println("\n// JavaScript-like Array.filter() in Kotlin MutableList<Any?> (List)")
    
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

    println("\n// JavaScript-like Array.filter() in Kotlin MutableList<MutableMap<String, Any?>> (List of Maps)")

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

    productsAbove100 = arrayFilterV1({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) >= 100) }, products)
    println("products with price >= 100 only: ${prettyJsonStringify(productsAbove100)}")
    // products with price >= 100 only: [
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

    productsAbove100 = arrayFilterV2({ product: Any?, _: Int, _: MutableList<Any?> -> (((product as MutableMap<String, Any?>)["price"] as Int) >= 100) }, products)
    println("products with price >= 100 only: ${prettyJsonStringify(productsAbove100)}")
    // products with price >= 100 only: [
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

    productsAbove100 = products.filter { product: Any? -> (((product as MutableMap<String, Any?>)["price"] as Int) >= 100) }
    println("products with price >= 100 only: ${prettyJsonStringify(productsAbove100)}")
    // products with price >= 100 only: [
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
