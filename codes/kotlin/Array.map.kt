@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc Array.map.kt -include-runtime -d Array.map.jar && kotlin Array.map.jar

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

    fun getType(anything: Any? = null): String {
        if (anything == null) return "undefined"
        if (anything == "null") return "null"
        if (anything == "undefined") return "undefined"
        if (anything is String) return "String"
        if (anything is Number) return "Number"
        if (anything is Boolean) return "Boolean"
        if (anything is MutableList<*>) return "Array"
        if (anything is MutableMap<*, *>) return "Object"
        return "undefined"
    }

    fun spreadSyntaxObject(vararg parameters: Any?): MutableMap<String, Any?> {
        val newObject = mutableMapOf<String, Any?>()
        for ((parameterIndex, parameter) in parameters.withIndex()) {
            val parameterType = getType(parameter)
            if (parameterType == "Object") {
                for ((objectKey, objectValue) in parameter as MutableMap<String, Any?>) {
                    newObject[objectKey.toString()] = objectValue
                }
                continue
            }
            if (parameterType == "Array") {
                for ((arrayItemIndex, arrayItem) in (parameter as MutableList<Any?>).withIndex()) {
                    newObject[arrayItemIndex.toString()] = arrayItem
                }
                continue
            }
        }
        return newObject
    }

    fun arrayMapV1(callbackFunction: (Any?, Int, MutableList<Any?>) -> Any?, anArray: MutableList<Any?>): MutableList<Any?> {
        // JavaScript-like Array.map() function
        val newArray = mutableListOf<Any?>()
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            val newArrayItem = callbackFunction(arrayItem, arrayItemIndex, anArray)
            newArray.add(newArrayItem)
        }
        return newArray
    }

    fun arrayMapV2(callbackFunction: (Any?, Int, MutableList<Any?>) -> Any?, anArray: MutableList<Any?>): MutableList<Any?> {
        // JavaScript-like Array.map() function
        val newArray = mutableListOf<Any?>()
        for ((arrayItemIndex, arrayItem) in anArray.withIndex()) {
            newArray.add(callbackFunction(arrayItem, arrayItemIndex, anArray))
        }
        return newArray
    }

    println("\n// JavaScript-like Array.map() in Kotlin MutableList<Any?> (List)")
    
    val numbers = mutableListOf<Any?>(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
    println("numbers: ${prettyArrayOfPrimitives(numbers)}")

    var numbersLabeled: Any?
    
    println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

    numbersLabeled = arrayMapV1({ number: Any?, _: Int, _: MutableList<Any?> -> mutableMapOf<String, Any?>(number.toString() to (if (((number as Int) % 2) == 0) "even" else "odd")) }, numbers)
    println("labeled numbers: ${prettyJsonStringify(numbersLabeled)}")
    // labeled numbers: [
	//     {
	//         "12": "even"
	//     },
	//     {
	//         "34": "even"
	//     },
	//     {
	//         "27": "odd"
	//     },
	//     {
	//         "23": "odd"
	//     },
	//     {
	//         "65": "odd"
	//     },
	//     {
	//         "93": "odd"
	//     },
	//     {
	//         "36": "even"
	//     },
	//     {
	//         "87": "odd"
	//     },
	//     {
	//         "4": "even"
	//     },
	//     {
	//         "254": "even"
	//     }
	// ]

    println("// using JavaScript-like Array.map() function \"arrayMapV2\"")

    numbersLabeled = arrayMapV2({ number: Any?, _: Int, _: MutableList<Any?> -> mutableMapOf<String, Any?>(number.toString() to (if (((number as Int) % 2) == 0) "even" else "odd")) }, numbers)
    println("labeled numbers: ${prettyJsonStringify(numbersLabeled)}")
    // labeled numbers: [
	//     {
	//         "12": "even"
	//     },
	//     {
	//         "34": "even"
	//     },
	//     {
	//         "27": "odd"
	//     },
	//     {
	//         "23": "odd"
	//     },
	//     {
	//         "65": "odd"
	//     },
	//     {
	//         "93": "odd"
	//     },
	//     {
	//         "36": "even"
	//     },
	//     {
	//         "87": "odd"
	//     },
	//     {
	//         "4": "even"
	//     },
	//     {
	//         "254": "even"
	//     }
	// ]

    println("// using Kotlin Array.map() built-in method \"Array.map\"")

    numbersLabeled = numbers.map { number: Any? -> mutableMapOf<String, Any?>(number.toString() to (if (((number as Int) % 2) == 0) "even" else "odd")) }
    println("labeled numbers: ${prettyJsonStringify(numbersLabeled)}")
    // labeled numbers: [
	//     {
	//         "12": "even"
	//     },
	//     {
	//         "34": "even"
	//     },
	//     {
	//         "27": "odd"
	//     },
	//     {
	//         "23": "odd"
	//     },
	//     {
	//         "65": "odd"
	//     },
	//     {
	//         "93": "odd"
	//     },
	//     {
	//         "36": "even"
	//     },
	//     {
	//         "87": "odd"
	//     },
	//     {
	//         "4": "even"
	//     },
	//     {
	//         "254": "even"
	//     }
	// ]

    println("\n// JavaScript-like Array.map() in Kotlin MutableList<MutableMap<String, Any?>> (List of Maps)")

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

    var productsLabeled: Any?

    println("// using JavaScript-like Array.map() function \"arrayMapV1\"")

    productsLabeled = arrayMapV1({ product: Any?, _: Int, _: MutableList<Any?> -> spreadSyntaxObject(product, mutableMapOf<String, Any?>("label" to (if (((product as MutableMap<String, Any?>)["price"] as Int) > 100) "expensive" else "cheap"))) }, products)
    println("labeled products: ${prettyJsonStringify(productsLabeled)}")
    // labeled products: [
	//     {
	//         "code": "pasta",
	//         "price": 321,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "bubble_gum",
	//         "price": 233,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "potato_chips",
	//         "price": 5,
	//         "label": "cheap"
	//     },
	//     {
	//         "code": "towel",
	//         "price": 499,
	//         "label": "expensive"
	//     }
	// ]

    println("// using JavaScript-like Array.map() function \"arrayMapV2\"")

    productsLabeled = arrayMapV2({ product: Any?, _: Int, _: MutableList<Any?> -> spreadSyntaxObject(product, mutableMapOf<String, Any?>("label" to (if (((product as MutableMap<String, Any?>)["price"] as Int) > 100) "expensive" else "cheap"))) }, products)
    println("labeled products: ${prettyJsonStringify(productsLabeled)}")
    // labeled products: [
	//     {
	//         "code": "pasta",
	//         "price": 321,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "bubble_gum",
	//         "price": 233,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "potato_chips",
	//         "price": 5,
	//         "label": "cheap"
	//     },
	//     {
	//         "code": "towel",
	//         "price": 499,
	//         "label": "expensive"
	//     }
	// ]

    println("// using Kotlin Array.map() built-in method \"Array.map\"")

    productsLabeled = products.map { product: Any? -> spreadSyntaxObject(product, mutableMapOf<String, Any?>("label" to (if (((product as MutableMap<String, Any?>)["price"] as Int) > 100) "expensive" else "cheap"))) }
    println("labeled products: ${prettyJsonStringify(productsLabeled)}")
    // labeled products: [
	//     {
	//         "code": "pasta",
	//         "price": 321,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "bubble_gum",
	//         "price": 233,
	//         "label": "expensive"
	//     },
	//     {
	//         "code": "potato_chips",
	//         "price": 5,
	//         "label": "cheap"
	//     },
	//     {
	//         "code": "towel",
	//         "price": 499,
	//         "label": "expensive"
	//     }
	// ]
}
