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

    // in Kotlin, JavaScript-like Array is called MutableList

    val fruits = mutableListOf<Any?>("apple", "mango", "orange")
    println("fruits: ${prettyArrayOfPrimitives(fruits)}")

    println("fruits, length: ${fruits.size}")
    // fruits, length: 3

    println("fruits, get mango: ${fruits[1]}")
    // fruits, get mango: mango

    println("fruits, first element: ${fruits[0]}")
    // fruits, first element: apple

    println("fruits, first element: ${fruits.first()}")
    // fruits, first element: apple
    
    println("fruits, last element: ${fruits[(fruits.size - 1)]}")
    // fruits, last element: orange

    println("fruits, last element: ${fruits.last()}")
    // fruits, last element: orange
    
    fruits.forEachIndexed { arrayItemIndex, arrayItem -> println("fruits, forEach loop, index: ${arrayItemIndex}, value: ${arrayItem}") }
    // fruits, forEach loop, index: 0, value: apple
    // fruits, forEach loop, index: 1, value: mango
    // fruits, forEach loop, index: 2, value: orange

    for ((arrayItemIndex, arrayItem) in fruits.withIndex()) {
        println("fruits, forEach loop, index: ${arrayItemIndex}, value: ${arrayItem}")
    }
    // fruits, forEach loop, index: 0, value: apple
    // fruits, forEach loop, index: 1, value: mango
    // fruits, forEach loop, index: 2, value: orange

    // in Kotlin, JavaScript-like Array of Objects is called MutableList of MutableMaps

    val products = mutableListOf<Any?>(
        mutableMapOf<String, Any?>(
            "id" to "P1",
            "name" to "bubble gum"
        ),
        mutableMapOf<String, Any?>(
            "id" to "P2",
            "name" to "potato chips"
        ),
    )
    println("products: ${prettyJsonStringify(products)}")

    products.forEachIndexed { arrayItemIndex, arrayItem ->
        (arrayItem as MutableMap<String, Any?>).entries.forEachIndexed { objectEntryIndex, objectEntry ->
            val objectKey = objectEntry.key
            val objectValue = objectEntry.value
            println("products, forEach loop, array item index: ${arrayItemIndex}, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}")
        }
    }
    // products, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
    // products, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
    // products, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
    // products, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

    for ((arrayItemIndex, arrayItem) in products.withIndex()) {
        (arrayItem as MutableMap<String, Any?>).entries.forEachIndexed { objectEntryIndex, objectEntry ->
            val objectKey = objectEntry.key
            val objectValue = objectEntry.value
            println("products, forEach loop, array item index: ${arrayItemIndex}, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}")
        }
    }
    // products, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
    // products, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
    // products, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
    // products, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
}
