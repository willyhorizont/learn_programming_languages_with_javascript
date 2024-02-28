@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc operator_nullish_coalescing.kt -include-runtime -d operator_nullish_coalescing.jar && kotlin operator_nullish_coalescing.jar

fun main() {
    println("\n// JavaScript-like Nullish Coalescing Operator (??) in Kotlin")

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
