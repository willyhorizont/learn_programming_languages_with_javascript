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
                anythingInner.entries.forEachIndexed { entryIndex, entryItem ->
                    val objectKey = entryItem.key
                    val objectValue = entryItem.value
                    result += "\"${objectKey}\": ${prettyJsonStringifyInner(objectValue, indentInner)}"
                    if ((entryIndex + 1) != anythingInner.entries.size) result += ",\n${indentInner.repeat(indentLevel)}"
                }
                indentLevel -= 1
                result += "\n${indentInner.repeat(indentLevel)}}"
                return result
            }
            return "null"
        }
        return prettyJsonStringifyInner(anything, indent)
    }

    fun spreadSyntaxObject(vararg parameters: Any?): MutableMap<String, Any?> {
        val newObject = mutableMapOf<String, Any?>()
        for ((parameterIndex, parameter) in parameters.withIndex()) {
            if (parameter is MutableMap<*, *>) {
                for ((objectKey, objectValue) in parameter as MutableMap<String, Any?>) {
                    newObject[objectKey.toString()] = objectValue
                }
                continue
            }
            if (parameter is MutableList<*>) {
                for ((arrayItemIndex, arrayItem) in (parameter as MutableList<Any?>).withIndex()) {
                    newObject[arrayItemIndex.toString()] = arrayItem
                }
                continue
            }
        }
        return newObject
    }

    fun spreadSyntaxArray(vararg parameters: Any?): MutableList<Any?> {
        val newArray = mutableListOf<Any?>()
        for ((parameterIndex, parameter) in parameters.withIndex()) {
            if (parameter is MutableMap<*, *>) {
                if ((parameter as MutableMap<String, Any?>).size == 1) {
                    for ((objectKey, objectValue) in (parameter as MutableMap<String, Any?>)) {
                        newArray.add(objectValue)
                    }
                    continue
                }
                newArray.add(parameter)
                continue
            }
            if (parameter is MutableList<*>) {
                for ((arrayItemIndex, arrayItem) in (parameter as MutableList<Any?>).withIndex()) {
                    newArray.add(arrayItem)
                }
                continue
            }
        }
        return newArray
    }

    fun arrayReduce(callbackFunction: (Any?, Any?, Int, MutableList<Any?>) -> Any?, anArray: MutableList<Any?>, initialValue: Any?): Any? {
        // JavaScript-like Array.reduce() function
        var result = initialValue
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
        }
        return result
    }

    println("\n// JavaScript-like Array.reduce() in Kotlin MutableList")
    
    val numbers = mutableListOf<Any?>(36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3)
    println("numbers: ${prettyArrayOfPrimitives(numbers)}")

    var numbersTotal: Any?

    println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")
    
    numbersTotal = arrayReduce({ currentResult: Any?, currentNumber: Any?, _: Int, _: MutableList<Any?> -> if (currentResult is Number && currentNumber is Number) (currentResult.toDouble() + currentNumber.toDouble()) else currentResult }, numbers, 0.0)
    println("total number: ${numbersTotal}")
    // total number: 41.2

    println("// using Kotlin Array.reduce() built-in method \"Array.fold\"")

    numbersTotal = numbers.fold(0.0) { currentResult: Any?, currentNumber: Any? -> if (currentResult is Number && currentNumber is Number) (currentResult.toDouble() + currentNumber.toDouble()) else currentResult }
    println("total number: ${numbersTotal}")
    // total number: 41.2

    println("\n// JavaScript-like Array.reduce() in Kotlin MutableList of MutableMaps")

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

    var productsGrouped: Any?

    println("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

    productsGrouped = arrayReduce({ currentResult: Any?, currentProduct: Any?, _: Int, _: MutableList<Any?> -> (if (((currentProduct as MutableMap<String, Any?>)["price"] as Int) > 100) spreadSyntaxObject(currentResult, mutableMapOf<String, Any?>("expensive" to spreadSyntaxArray((currentResult as MutableMap<String, Any?>)["expensive"], mutableMapOf<String, Any?>("currentProduct" to currentProduct)))) else spreadSyntaxObject(currentResult, mutableMapOf<String, Any?>("cheap" to spreadSyntaxArray((currentResult as MutableMap<String, Any?>)["cheap"], mutableMapOf<String, Any?>("currentProduct" to currentProduct))))) }, products, mutableMapOf<String, Any?>("expensive" to mutableListOf<Any?>(), "cheap" to mutableListOf<Any?>()))
    println("grouped products: ${prettyJsonStringify(productsGrouped)}")
    // grouped products: {
    //     "expensive": [
    //         {
    //             "code": "pasta",
    //             "price": 321
    //         },
    //         {
    //             "code": "bubble_gum",
    //             "price": 233
    //         },
    //         {
    //             "code": "towel",
    //             "price": 499
    //         }
    //     ],
    //     "cheap": [
    //         {
    //             "code": "potato_chips",
    //             "price": 5
    //         }
    //     ]
    // }

    println("// using Kotlin Array.reduce() built-in method \"Array.fold\"")

    productsGrouped = products.fold(mutableMapOf<String, Any?>("expensive" to mutableListOf<Any?>(), "cheap" to mutableListOf<Any?>())) { currentResult: Any?, currentProduct: Any? -> (if (((currentProduct as MutableMap<String, Any?>)["price"] as Int) > 100) spreadSyntaxObject(currentResult, mutableMapOf<String, Any?>("expensive" to spreadSyntaxArray((currentResult as MutableMap<String, Any?>)["expensive"], mutableMapOf<String, Any?>("currentProduct" to currentProduct)))) else spreadSyntaxObject(currentResult, mutableMapOf<String, Any?>("cheap" to spreadSyntaxArray((currentResult as MutableMap<String, Any?>)["cheap"], mutableMapOf<String, Any?>("currentProduct" to currentProduct))))) }
    println("grouped products: ${prettyJsonStringify(productsGrouped)}")
    // grouped products: {
    //     "expensive": [
    //         {
    //             "code": "pasta",
    //             "price": 321
    //         },
    //         {
    //             "code": "bubble_gum",
    //             "price": 233
    //         },
    //         {
    //             "code": "towel",
    //             "price": 499
    //         }
    //     ],
    //     "cheap": [
    //         {
    //             "code": "potato_chips",
    //             "price": 5
    //         }
    //     ]
    // }
}
