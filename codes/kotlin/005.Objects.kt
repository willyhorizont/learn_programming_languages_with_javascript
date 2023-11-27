@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc 1.Objects.kt -include-runtime -d 1.Objects.jar && kotlin 1.Objects.jar

fun main() {
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
