@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc factorial.kt -include-runtime -d factorial.jar && kotlin factorial.jar

fun main() {
    println("\n// Factorial(n) in Kotlin")

    fun factorialV1(number: Int): Int {
        if ((number > 1) == false) return 1
        var result = 1
        var i = number
        while (true) {
            result *= i
            i -= 1
            if (i <= 0) break
        }
        return result
    }

    fun factorialV2(number: Int): Int {
        if ((number > 1) == false) return 1
        var result = 1
        var i = number
        while (i >= 1) {
            result *= i
            i -= 1
        }
        return result
    }

    fun factorialV3(number: Int): Int {
        if ((number > 1) == false) return 1
        var result = 1
        for (i in number downTo 1 step 1) {
            result *= i
        }
        return result
    }

    println("// using factorial function \"factorialV1\"")
    println("Factorial(5): ${factorialV1(5)}")
    // Factorial(5): 120

    println("// using factorial function \"factorialV2\"")
    println("Factorial(5): ${factorialV2(5)}")
    // Factorial(5): 120

    println("// using factorial function \"factorialV3\"")
    println("Factorial(5): ${factorialV3(5)}")
    // Factorial(5): 120
}
