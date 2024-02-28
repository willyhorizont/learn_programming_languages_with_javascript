@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc 1.Objects.kt -include-runtime -d 1.Objects.jar && kotlin 1.Objects.jar

fun main() {
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

    val friend = mutableMapOf<String, Any?>(
        "name" to "Alisa",
        "country" to "Finland",
        "age" to 25
    )
    println("friend: ${prettyJsonStringify(friend)}")

    println("friend, get country: ${friend["country"]}")
    // friend, get country: Finland

    // iterate over and get each key-value pair
    friend.forEach { (objectKey, objectValue) -> println("friend, foreach loop, key: ${objectKey}, value: ${objectValue}") }
    // fruits, for loop, key: 0, value: apple
	// fruits, for loop, key: 1, value: mango
	// fruits, for loop, key: 2, value: orange

    // iterate over and get each key-value pair
    for ((objectKey, objectValue) in friend) {
        println("friend, for loop, key: ${objectKey}, value: ${objectValue}")
    }
    // fruits, for loop, key: 0, value: apple
	// fruits, for loop, key: 1, value: mango
	// fruits, for loop, key: 2, value: orange

    // iterate over and get each key-value pair and iteration/entry index
    friend.entries.forEachIndexed { entryIndex, entryItem ->
        val objectKey = entryItem.key
        val objectValue = entryItem.value
        println("friend, foreach loop, iteration/entry index: ${entryIndex}, key: ${objectKey}, value: ${objectValue}")
    }
    // friend, foreach loop, iteration/entry index: 0, key: name, value: Alisa
    // friend, foreach loop, iteration/entry index: 1, key: country, value: Finland
    // friend, foreach loop, iteration/entry index: 2, key: age, value: 25
}
