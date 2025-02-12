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
                    val objectKey: Any? = objectEntry.key
                    val objectValue: Any? = objectEntry.value
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

    // in Kotlin, JavaScript-like Array is called MutableList

    val fruits: Any? = mutableListOf<Any?>("apple", "mango", "orange")
    println("fruits: ${jsonStringify(fruits)}")

    println("fruits, length: ${(fruits as MutableList<Any?>).size}")
    // fruits, length: 3

    println("fruits, get mango: ${(fruits as MutableList<Any?>)[1]}")
    // fruits, get mango: mango

    println("fruits, first element: ${(fruits as MutableList<Any?>)[0]}")
    // fruits, first element: apple

    println("fruits, first element: ${(fruits as MutableList<Any?>).first()}")
    // fruits, first element: apple
    
    println("fruits, last element: ${(fruits as MutableList<Any?>)[((fruits as MutableList<Any?>).size - 1)]}")
    // fruits, last element: orange

    println("fruits, last element: ${(fruits as MutableList<Any?>).last()}")
    // fruits, last element: orange
    
    (fruits as MutableList<Any?>).forEachIndexed { arrayItemIndex, arrayItem -> println("fruits, forEach loop, index: ${arrayItemIndex}, value: ${arrayItem}") }
    // fruits, forEach loop, index: 0, value: apple
    // fruits, forEach loop, index: 1, value: mango
    // fruits, forEach loop, index: 2, value: orange

    for ((arrayItemIndex, arrayItem) in (fruits as MutableList<Any?>).withIndex()) {
        println("fruits, forEach loop, index: ${arrayItemIndex}, value: ${arrayItem}")
    }
    // fruits, forEach loop, index: 0, value: apple
    // fruits, forEach loop, index: 1, value: mango
    // fruits, forEach loop, index: 2, value: orange

    // in Kotlin, JavaScript-like Array of Objects is called MutableList of MutableMaps

    // var products: Any? = mutableListOf<Any?>(
    //     mutableMapOf<String, Any?>(
    //         "id" to "P1",
    //         "name" to "bubble gum"
    //     ),
    //     mutableMapOf<String, Any?>(
    //         "id" to "P2",
    //         "name" to "potato chips"
    //     ),
    // )
    // println("products: ${jsonStringify(products, pretty = true)}")

    // products.forEachIndexed { arrayItemIndex, arrayItem ->
    //     (arrayItem as MutableMap<String, Any?>).entries.forEachIndexed { objectEntryIndex, objectEntry ->
    //         var objectKey: Any? = objectEntry.key
    //         var objectValue: Any? = objectEntry.value
    //         println("products, forEach loop, array item index: ${arrayItemIndex}, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}")
    //     }
    // }
    // // products, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
    // // products, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
    // // products, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
    // // products, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips

    // for ((arrayItemIndex, arrayItem) in products.withIndex()) {
    //     (arrayItem as MutableMap<String, Any?>).entries.forEachIndexed { objectEntryIndex, objectEntry ->
    //         var objectKey: Any? = objectEntry.key
    //         var objectValue: Any? = objectEntry.value
    //         println("products, forEach loop, array item index: ${arrayItemIndex}, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}")
    //     }
    // }
    // // products, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
    // // products, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
    // // products, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
    // // products, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
}
