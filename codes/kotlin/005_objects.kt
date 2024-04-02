@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
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

    // in Kotlin, JavaScript-like Object is called MutableMap

    val friend = mutableMapOf<String, Any?>(
        "name" to "Alisa",
        "country" to "Finland",
        "age" to 25
    )
    println("friend: ${prettyJsonStringify(friend)}")

    println("friend, get country: ${friend["country"]}")
    // friend, get country: Finland

    // iterate over and get each key-value pair
    for ((objectKey, objectValue) in friend) {
        println("friend, for loop, key: ${objectKey}, value: ${objectValue}")
    }
    // fruits, for loop, key: 0, value: apple
    // fruits, for loop, key: 1, value: mango
    // fruits, for loop, key: 2, value: orange

    // iterate over and get each key-value pair
    friend.forEach { (objectKey, objectValue) -> println("friend, forEach loop, key: ${objectKey}, value: ${objectValue}") }
    // fruits, for loop, key: 0, value: apple
    // fruits, for loop, key: 1, value: mango
    // fruits, for loop, key: 2, value: orange

    // iterate over and get each key-value pair and object iteration/entry index
    friend.entries.forEachIndexed { objectEntryIndex, objectEntry ->
        val objectKey = objectEntry.key
        val objectValue = objectEntry.value
        println("friend, forEach loop, object iteration/entry index: ${objectEntryIndex}, key: ${objectKey}, value: ${objectValue}")
    }
    // friend, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
    // friend, forEach loop, object iteration/entry index: 1, key: country, value: Finland
    // friend, forEach loop, object iteration/entry index: 2, key: age, value: 25
}
