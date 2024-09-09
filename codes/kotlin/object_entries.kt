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

    // There's no JavaScript-like Object.entries() in Kotlin.
    // But, we can create our own function to mimic it in Kotlin.

    fun objectEntries(anObject: MutableMap<String, Any?>): MutableList<Any?> {
        // JavaScript-like Object.entries() function
        val newArray = mutableListOf<Any?>()
        anObject.entries.forEachIndexed { _, objectEntry ->
            val objectKey = objectEntry.key
            val objectValue = objectEntry.value
            newArray.add(mutableListOf<Any?>(objectKey, objectValue))
        }
        return newArray
    }

    println("\n// JavaScript-like Object.entries() in Kotlin MutableMap")

    val friend = mutableMapOf<String, Any?>(
        "name" to "Alisa",
        "country" to "Finland",
        "age" to 25
    )
    println("friend: ${jsonStringify(friend, pretty = true)}")

    println("// using JavaScript-like Object.entries() function \"objectEntries\"")

    println("friend entries: ${jsonStringify(objectEntries(friend))}")
    // friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]
}
