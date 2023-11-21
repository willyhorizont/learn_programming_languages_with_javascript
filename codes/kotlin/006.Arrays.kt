@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc 1.Arrays.kt -include-runtime -d 1.Arrays.jar && kotlin 1.Arrays.jar

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

    products.forEachIndexed { arrayItemIndex, arrayItem -> (arrayItem as MutableMap<String, Any?>).forEach { (objectKey, objectValue) -> println("products, loop, index: ${arrayItemIndex}, key: ${objectKey}, value: ${objectValue}") } }
    // products, loop, index: 0, key: id, value: P1
    // products, loop, index: 0, key: name, value: bubble gum
    // products, loop, index: 1, key: id, value: P2
    // products, loop, index: 1, key: name, value: potato chips

    for ((arrayItemIndex, arrayItem) in products.withIndex()) {
        for ((objectKey, objectValue) in arrayItem as MutableMap<String, Any?>) {
            println("products, loop, index: ${arrayItemIndex}, key: ${objectKey}, value: ${objectValue}")
        }
    }
    // products, loop, index: 0, key: id, value: P1
    // products, loop, index: 0, key: name, value: bubble gum
    // products, loop, index: 1, key: id, value: P2
    // products, loop, index: 1, key: name, value: potato chips
}
