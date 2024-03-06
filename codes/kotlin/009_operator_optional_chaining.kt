@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
    println("\n// JavaScript-like Optional Chaining Operator (?.) in Kotlin")

    fun prettyJsonStringify(anything: Any? = null, indent: String = "    "): String {
        var indentLevel = 0
        fun prettyJsonStringifyInner(anythingInner: Any?, indentInner: String): String {
            if (anythingInner == null) return "null"
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
            return "null"
        }
        return prettyJsonStringifyInner(anything, indent)
    }

    // There's no JavaScript-like Optional Chaining Operator (?.) in Kotlin.
    // But, we can use Kotlin try-catch block to mimic it in Kotlin.

    val JSON_OBJECT = mutableMapOf<String, Any?>(
        "foo" to mutableMapOf<String, Any?>(
            "bar" to "baz",
        ),
        "fruits" to mutableListOf<Any?>("apple", "mango", "banana")
    )
    println("JSON_OBJECT: ${prettyJsonStringify(JSON_OBJECT)}")

    println("JSON_OBJECT?.foo?.bar: ${try { (JSON_OBJECT["foo"] as MutableMap<String, Any?>)["bar"] } catch (err: Exception) { null }}")
    // JSON_OBJECT?.foo?.bar: baz

    println("JSON_OBJECT?.foo?.baz: ${try { (JSON_OBJECT["foo"] as MutableMap<String, Any?>)["baz"] } catch (err: Exception) { null }}")
    // JSON_OBJECT?.foo?.baz: null // undefined and null is null in Kotlin

    println("JSON_OBJECT?.foo?.bar: ${prettyJsonStringify(try { (JSON_OBJECT["foo"] as MutableMap<String, Any?>)["bar"] } catch (err: Exception) { null })}")
    // JSON_OBJECT?.foo?.bar: "baz"

    println("JSON_OBJECT?.foo?.baz: ${prettyJsonStringify(try { (JSON_OBJECT["foo"] as MutableMap<String, Any?>)["baz"] } catch (err: Exception) { null })}")
    // JSON_OBJECT?.foo?.baz: undefined

    println("JSON_OBJECT?.fruits?.[2]: ${try { (JSON_OBJECT["fruits"] as MutableList<Any?>)[2] } catch (err: Exception) { null }}")
    // JSON_OBJECT?.fruits?.[2]: banana

    println("JSON_OBJECT?.fruits?.[5]: ${try { (JSON_OBJECT["fruits"] as MutableList<Any?>)[5] } catch (err: Exception) { null }}")
    // JSON_OBJECT?.fruits?.[5]: null // undefined and null is null in Kotlin

    println("JSON_OBJECT?.fruits?.[2]: ${prettyJsonStringify(try { (JSON_OBJECT["fruits"] as MutableList<Any?>)[2] } catch (err: Exception) { null })}")
    // JSON_OBJECT?.fruits?.[2]: "banana"

    println("JSON_OBJECT?.fruits?.[5]: ${prettyJsonStringify(try { (JSON_OBJECT["fruits"] as MutableList<Any?>)[5] } catch (err: Exception) { null })}")
    // JSON_OBJECT?.fruits?.[5]: undefined
}
