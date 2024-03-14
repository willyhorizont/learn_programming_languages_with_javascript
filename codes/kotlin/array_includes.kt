@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
    fun prettyArrayOfPrimitives(anArrayOfPrimitives: MutableList<Any?>): String {
        var result = "["
        for ((arrayItemIndex, arrayItem) in anArrayOfPrimitives.withIndex()) {
            if (((arrayItem is String) == false) && ((arrayItem is Number) == false) && ((arrayItem is Boolean) == false) && (arrayItem != null)) continue
            if (arrayItem is String) result += "\"${arrayItem}\""
            if ((arrayItem is Number) || (arrayItem is Boolean) || (arrayItem == null)) result += "${arrayItem}"
            if ((arrayItemIndex + 1) != anArrayOfPrimitives.size) result += ", "
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

    var aName: String
    var isMyFriend: Boolean

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
