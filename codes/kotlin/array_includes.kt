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

    fun arrayIncludesV1(searchElement: Any?, anArray: MutableList<Any?>): Boolean {
        // JavaScript-like Array.includes() function
        return searchElement in anArray
    }

    // JavaScript-like Array.includes() function
    val arrayIncludesV2 = { searchElement: Any?, anArray: MutableList<Any?> -> searchElement in anArray }

    println("\n// JavaScript-like Array.includes() in Kotlin")

    val myFriends = mutableListOf<Any?>("Alisa", "Trivia")
    println("myFriends: ${jsonStringify(myFriends)}")

    var aName: Any?
    var isMyFriend: Any?

    println("// using JavaScript-like Array.includes() function \"arrayIncludesV1\"")

    aName = "Alisa"
    isMyFriend = arrayIncludesV1(aName, myFriends)
    println("is my friends includes \"${aName}\": ${isMyFriend}")
    // is my friends includes "Alisa": true

    aName = "Trivia"
    isMyFriend = arrayIncludesV1(aName, myFriends)
    println("is my friends includes \"${aName}\": ${isMyFriend}")
    // is my friends includes "Trivia": true

    aName = "Tony"
    isMyFriend = arrayIncludesV1(aName, myFriends)
    println("is my friends includes \"${aName}\": ${isMyFriend}")
    // is my friends includes "Tony": false

    aName = "Ezekiel"
    isMyFriend = arrayIncludesV1(aName, myFriends)
    println("is my friends includes \"${aName}\": ${isMyFriend}")
    // is my friends includes "Ezekiel": false

    println("// using JavaScript-like Array.includes() function \"arrayIncludesV2\"")

    aName = "Alisa"
    isMyFriend = arrayIncludesV2(aName, myFriends)
    println("is my friends includes \"${aName}\": ${isMyFriend}")
    // is my friends includes "Alisa": true

    aName = "Trivia"
    isMyFriend = arrayIncludesV2(aName, myFriends)
    println("is my friends includes \"${aName}\": ${isMyFriend}")
    // is my friends includes "Trivia": true

    aName = "Tony"
    isMyFriend = arrayIncludesV2(aName, myFriends)
    println("is my friends includes \"${aName}\": ${isMyFriend}")
    // is my friends includes "Tony": false

    aName = "Ezekiel"
    isMyFriend = arrayIncludesV2(aName, myFriends)
    println("is my friends includes \"${aName}\": ${isMyFriend}")
    // is my friends includes "Ezekiel": false

    println("// using Kotlin \"in\" operator")

    aName = "Alisa"
    isMyFriend = aName in myFriends
    println("is my friends includes \"${aName}\": ${isMyFriend}")
    // is my friends includes "Alisa": true

    aName = "Trivia"
    isMyFriend = aName in myFriends
    println("is my friends includes \"${aName}\": ${isMyFriend}")
    // is my friends includes "Trivia": true

    aName = "Tony"
    isMyFriend = aName in myFriends
    println("is my friends includes \"${aName}\": ${isMyFriend}")
    // is my friends includes "Tony": false

    aName = "Ezekiel"
    isMyFriend = aName in myFriends
    println("is my friends includes \"${aName}\": ${isMyFriend}")
    // is my friends includes "Ezekiel": false
}
