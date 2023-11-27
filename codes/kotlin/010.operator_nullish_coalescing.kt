@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc operator_nullish_coalescing.kt -include-runtime -d operator_nullish_coalescing.jar && kotlin operator_nullish_coalescing.jar

fun main() {
    println("\n// JavaScript-like Nullish Coalescing Operator (??) in Kotlin")

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

    // in Kotlin, JavaScript-like Nullish Coalescing Operator (??) is Elvis Operator (?:)

    val JSON_OBJECT = mutableMapOf<String, Any?>(
        "foo" to mutableMapOf<String, Any?>(
            "bar" to "baz",
        ),
        "fruits" to mutableListOf<Any?>("apple", "mango", "banana")
    )
    println("JSON_OBJECT: ${prettyJsonStringify(JSON_OBJECT)}")

    println("JSON_OBJECT?.foo?.bar ?? \"not found\": ${try { (JSON_OBJECT["foo"] as MutableMap<String, Any?>)["bar"] } catch (err: Exception) { null } ?: "not found"}")
    // JSON_OBJECT?.foo?.bar ?? "not found": baz

    println("JSON_OBJECT?.foo?.baz ?? \"not found\": ${try { (JSON_OBJECT["foo"] as MutableMap<String, Any?>)["baz"] } catch (err: Exception) { null } ?: "not found"}")
    // JSON_OBJECT?.foo?.baz ?? "not found": not found

    println("JSON_OBJECT?.foo?.bar ?? \"not found\": ${prettyJsonStringify(try { (JSON_OBJECT["foo"] as MutableMap<String, Any?>)["bar"] } catch (err: Exception) { null } ?: "not found")}")
    // JSON_OBJECT?.foo?.bar ?? "not found": "baz"

    println("JSON_OBJECT?.foo?.baz ?? \"not found\": ${prettyJsonStringify(try { (JSON_OBJECT["foo"] as MutableMap<String, Any?>)["baz"] } catch (err: Exception) { null } ?: "not found")}")
    // JSON_OBJECT?.foo?.baz ?? "not found": "not found"

    println("JSON_OBJECT?.fruits?.[2] ?? \"not found\": ${try { (JSON_OBJECT["fruits"] as MutableList<Any?>)[2] } catch (err: Exception) { null } ?: "not found"}")
    // JSON_OBJECT?.fruits?.[2] ?? "not found": banana

    println("JSON_OBJECT?.fruits?.[5] ?? \"not found\": ${try { (JSON_OBJECT["fruits"] as MutableList<Any?>)[5] } catch (err: Exception) { null } ?: "not found"}")
    // JSON_OBJECT?.fruits?.[5] ?? "not found": not found

    println("JSON_OBJECT?.fruits?.[2] ?? \"not found\": ${prettyJsonStringify(try { (JSON_OBJECT["fruits"] as MutableList<Any?>)[2] } catch (err: Exception) { null } ?: "not found")}")
    // JSON_OBJECT?.fruits?.[2] ?? "not found": "banana"

    println("JSON_OBJECT?.fruits?.[5] ?? \"not found\": ${prettyJsonStringify(try { (JSON_OBJECT["fruits"] as MutableList<Any?>)[5] } catch (err: Exception) { null } ?: "not found")}")
    // JSON_OBJECT?.fruits?.[5] ?? "not found": "not found"
}
