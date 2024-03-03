@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc Array.includes.kt -include-runtime -d Array.includes.jar && kotlin Array.includes.jar

fun main() {
    fun prettyArrayOfPrimitives(anArrayOfPrimitives: MutableList<Any?>): String {
        var result = "["
        for ((arrayItemIndex, arrayItem) in anArrayOfPrimitives.withIndex()) {
            if (((arrayItem is String) == false) && ((arrayItem is Number) == false) && ((arrayItem is Boolean) == false) && (arrayItem != null)) continue
            if (arrayItem is String) {
                result += "\"${arrayItem}\""
            }
            if ((arrayItem is Number) || (arrayItem is Boolean) || arrayItem == null) {
                result += "${arrayItem}"
            }
            if ((arrayItemIndex + 1) != anArrayOfPrimitives.size) {
                result += ", "
            }
        }
        result += "]"
        return result
    }

    fun arrayIncludesV1(searchElement: Any?, anArray: MutableList<Any?>): Boolean {
        // JavaScript-like Array.includes() function
        return searchElement in anArray
    }

    // JavaScript-like Array.includes() function
    val arrayIncludesV2 = { searchElement: Any?, anArray: MutableList<Any?> -> searchElement in anArray }

    println("\n// JavaScript-like Array.includes() in Kotlin")

    val myFriends = mutableListOf<Any?>("Alisa", "Trivia")
    println("myFriends: ${prettyArrayOfPrimitives(myFriends)}")

    var name: String
    var isMyFriend: Boolean

    println("// using JavaScript-like Array.includes() function \"arrayIncludesV1\"")

    name = "Alisa"
    println("name: \"${name}\"")
    isMyFriend = arrayIncludesV1(name, myFriends)
    println("is my friends includes \"${name}\": ${isMyFriend}")
    // is my friends includes "Alisa": true

    name = "Trivia"
    println("name: \"${name}\"")
    isMyFriend = arrayIncludesV1(name, myFriends)
    println("is my friends includes \"${name}\": ${isMyFriend}")
    // is my friends includes "Trivia": true

    name = "Tony"
    println("name: \"${name}\"")
    isMyFriend = arrayIncludesV1(name, myFriends)
    println("is my friends includes \"${name}\": ${isMyFriend}")
    // is my friends includes "Tony": false

    name = "Ezekiel"
    println("name: \"${name}\"")
    isMyFriend = arrayIncludesV1(name, myFriends)
    println("is my friends includes \"${name}\": ${isMyFriend}")
    // is my friends includes "Ezekiel": false

    println("// using JavaScript-like Array.includes() function \"arrayIncludesV2\"")

    name = "Alisa"
    println("name: \"${name}\"")
    isMyFriend = arrayIncludesV2(name, myFriends)
    println("is my friends includes \"${name}\": ${isMyFriend}")
    // is my friends includes "Alisa": true

    name = "Trivia"
    println("name: \"${name}\"")
    isMyFriend = arrayIncludesV2(name, myFriends)
    println("is my friends includes \"${name}\": ${isMyFriend}")
    // is my friends includes "Trivia": true

    name = "Tony"
    println("name: \"${name}\"")
    isMyFriend = arrayIncludesV2(name, myFriends)
    println("is my friends includes \"${name}\": ${isMyFriend}")
    // is my friends includes "Tony": false

    name = "Ezekiel"
    println("name: \"${name}\"")
    isMyFriend = arrayIncludesV2(name, myFriends)
    println("is my friends includes \"${name}\": ${isMyFriend}")
    // is my friends includes "Ezekiel": false

    println("// using Kotlin \"in\" operator")

    name = "Alisa"
    println("name: \"${name}\"")
    isMyFriend = name in myFriends
    println("is my friends includes \"${name}\": ${isMyFriend}")
    // is my friends includes "Alisa": true

    name = "Trivia"
    println("name: \"${name}\"")
    isMyFriend = name in myFriends
    println("is my friends includes \"${name}\": ${isMyFriend}")
    // is my friends includes "Trivia": true

    name = "Tony"
    println("name: \"${name}\"")
    isMyFriend = name in myFriends
    println("is my friends includes \"${name}\": ${isMyFriend}")
    // is my friends includes "Tony": false

    name = "Ezekiel"
    println("name: \"${name}\"")
    isMyFriend = name in myFriends
    println("is my friends includes \"${name}\": ${isMyFriend}")
    // is my friends includes "Ezekiel": false
}
