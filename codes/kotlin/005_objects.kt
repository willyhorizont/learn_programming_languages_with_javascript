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

    // in Kotlin, JavaScript-like Object is called MutableMap

    val friend = mutableMapOf<String, Any?>(
        "name" to "Alisa",
        "country" to "Finland",
        "age" to 25
    )
    println("friend: ${jsonStringify(friend, pretty = true)}")

    println("friend, get country: ${friend["country"]}")
    // friend, get country: Finland

    println("friend, get total object keys: ${friend.entries.size}")
    // friend, get total object keys: 3

    // iterate over and get each key-value pair
    for ((objectKey, objectValue) in friend) {
        println("friend, for loop, key: ${objectKey}, value: ${objectValue}")
    }
    // fruits, for loop, key: name, value: Alisa
    // fruits, for loop, key: country, value: Finland
    // fruits, for loop, key: age, value: 25

    // iterate over and get each key-value pair
    friend.forEach { (objectKey, objectValue) -> println("friend, forEach loop, key: ${objectKey}, value: ${objectValue}") }
    // fruits, for loop, key: name, value: Alisa
    // fruits, for loop, key: country, value: Finland
    // fruits, for loop, key: age, value: 25

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
