
// Compile and run the application command:
// kotlinc _chaos.kt -include-runtime -d _chaos.jar && kotlin _chaos.jar

fun main() {
    val jsonStringified = "[{code=p, price=3}]"
    for (charIndex in 0 until jsonStringified.length) {
        val char = jsonStringified[charIndex]
        val prevChar = if (charIndex > 0) jsonStringified[charIndex - 1] else null
        val nextChar = if ((charIndex + 1) < jsonStringified.length) jsonStringified[charIndex + 1] else null
        println("prevChar: $prevChar")
        println("char: $char")
        println("nextChar: $nextChar")
        println("\n")
    }
}