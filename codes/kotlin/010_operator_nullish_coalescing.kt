@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
    println("\n// JavaScript-like Nullish Coalescing Operator (??) in Kotlin")

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

    // in Kotlin, JavaScript-like Nullish Coalescing Operator (??) is called Elvis Operator (?:)

    val JSON_OBJECT = mutableMapOf<String, Any?>(
        "foo" to mutableMapOf<String, Any?>(
            "bar" to "baz",
        ),
        "fruits" to mutableListOf<Any?>("apple", "mango", "banana")
    )
    println("JSON_OBJECT: ${jsonStringify(JSON_OBJECT, pretty = true)}")

    println("(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): ${try { (JSON_OBJECT["foo"] as MutableMap<String, Any?>)["bar"] } catch (err: Exception) { null } ?: "not found"}")
    // (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): baz

    println("(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): ${try { (JSON_OBJECT["foo"] as MutableMap<String, Any?>)["baz"] } catch (err: Exception) { null } ?: "not found"}")
    // (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): not found

    println("(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): ${try { (JSON_OBJECT["fruits"] as MutableList<Any?>)[2] } catch (err: Exception) { null } ?: "not found"}")
    // (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): banana

    println("(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): ${try { (JSON_OBJECT["fruits"] as MutableList<Any?>)[5] } catch (err: Exception) { null } ?: "not found"}")
    // (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): not found
}
