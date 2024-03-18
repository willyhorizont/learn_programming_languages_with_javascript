@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
    println("\n// Custom Error and Error Handling in Kotlin")

    fun giveMeRespect(parameter: String): String {
        // Custom Error
        if (parameter != "respect") throw Exception("Exception: You should give me \"respect\"!")
        return "Thank you for giving me \"respect\"!"
    }

    var response: String

    // Error Handling
    try {
        response = giveMeRespect("boo!")
        println(response)
    } catch(anException: Exception) {
        println(anException.message)
    }
    println("I'm sorry!")

    // Without Error Handling
    response = giveMeRespect("boo!")
    // this will never executed
    println(response)
    println("I'm sorry!")
}
