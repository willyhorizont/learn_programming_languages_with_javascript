@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc 1.Arrays.kt -include-runtime -d 1.Arrays.jar && kotlin 1.Arrays.jar

fun main() {
    fun prettyArrayOfPrimitives(anArrayOfPrimitives: MutableList<Any?>): String {
        var result = "["
        for ((arrayItemIndex, arrayItem) in anArrayOfPrimitives.withIndex()) {
            if (((arrayItem is String) == false) && ((arrayItem is Number) == false) && ((arrayItem is Boolean) == false) && (arrayItem != null)) continue
            if (arrayItem is String) {
                result += "\"${arrayItem}\""
            }
            if ((arrayItem is Number) || (arrayItem is Boolean) || arrayItem == null) {
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
        fun prettyJsonStringifyInner(anythingInner: Any?, indentInner: String): String {
            if (anythingInner == null) return "undefined"
            if (anythingInner == "null") return "null"
            if (anythingInner == "undefined") return "undefined"
            if (anythingInner is String) return "\"${anythingInner}\""
            if (anythingInner is Number || anythingInner is Boolean) return "${anythingInner}"
            if (anythingInner is MutableList<*>) {
                if (anythingInner.size == 0) {
                    val result = "[]"
                    return result
                }
                indentLevel += 1
                var result = "[\n${indentInner.repeat(indentLevel)}"
                for ((arrayItemIndex, arrayItem) in anythingInner.withIndex()) {
                    result += prettyJsonStringifyInner(arrayItem, indentInner)
                    if ((arrayItemIndex + 1) != anythingInner.size) {
                        result += ",\n${indentInner.repeat(indentLevel)}"
                    }
                }
                indentLevel -= 1
                result += "\n${indentInner.repeat(indentLevel)}]"
                return result
            }
            if (anythingInner is MutableMap<*, *>) {
                if (anythingInner.entries.size == 0) {
                    val result = "{}"
                    return result
                }
                indentLevel += 1
                var result = "{\n${indentInner.repeat(indentLevel)}"
                anythingInner.entries.forEachIndexed { entryIndex, entryItem ->
                    val objectKey = entryItem.key
                    val objectValue = entryItem.value
                    result += "\"${objectKey}\": ${prettyJsonStringifyInner(objectValue, indentInner)}"
                    if ((entryIndex + 1) != anythingInner.entries.size) {
                        result += ",\n${indentInner.repeat(indentLevel)}"
                    }
                }
                indentLevel -= 1
                result += "\n${indentInner.repeat(indentLevel)}}"
                return result
            }
            return "undefined"
        }
        return prettyJsonStringifyInner(anything, indent)
    }

    // Array in Kotlin

    val fruits = mutableListOf<Any?>("apple", "mango", "orange")
    println("fruits: ${prettyArrayOfPrimitives(fruits)}")

    println("fruits, length: ${fruits.size}")
    // fruits, length: 3

    println("fruits, get mango: ${fruits[1]}")
    // fruits, get mango: mango

    println("fruits, first element: ${fruits.first()}")
    // fruits, first element: apple

    println("fruits, last element: ${fruits.last()}")
    // fruits, last element: orange
    
    fruits.forEachIndexed { arrayItemIndex, arrayItem -> println("fruits, foreach loop, index: ${arrayItemIndex}, value: ${arrayItem}") }
    // fruits, foreach loop, index: 0, value: apple
    // fruits, foreach loop, index: 1, value: mango
    // fruits, foreach loop, index: 2, value: orange

    for ((arrayItemIndex, arrayItem) in fruits.withIndex()) {
        println("fruits, for loop, index: ${arrayItemIndex}, value: ${arrayItem}")
    }
    // fruits, for loop, index: 0, value: apple
    // fruits, for loop, index: 1, value: mango
    // fruits, for loop, index: 2, value: orange

    // Array of Objects in Kotlin

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
        (arrayItem as MutableMap<String, Any?>).entries.forEachIndexed { entryIndex, entryItem ->
            val objectKey = entryItem.key
            val objectValue = entryItem.value
            println("products, foreach loop, array item index: ${arrayItemIndex}, iteration/entry index: ${entryIndex}, key: ${objectKey}, value: ${objectValue}")
        }
    }
    // products, foreach loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
    // products, foreach loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
    // products, foreach loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
    // products, foreach loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips

    for ((arrayItemIndex, arrayItem) in products.withIndex()) {
        (arrayItem as MutableMap<String, Any?>).entries.forEachIndexed { entryIndex, entryItem ->
            val objectKey = entryItem.key
            val objectValue = entryItem.value
            println("products, foreach loop, array item index: ${arrayItemIndex}, iteration/entry index: ${entryIndex}, key: ${objectKey}, value: ${objectValue}")
        }
    }
    // products, for loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
    // products, for loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
    // products, for loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
    // products, for loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips
}
