@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
    println("\n// Factorial(n) in Kotlin")

    fun factorialV1(number: Int): Int {
        if (number < 0) throw Exception("Argument should be >= 0")
        if (number == 0) return 1
        var result = 1
        var i = number
        while (true) {
            result *= i
            if (i <= 1) break
            i -= 1
        }
        return result
    }

    fun factorialV2(number: Int): Int {
        if (number < 0) throw Exception("Argument should be >= 0")
        if (number == 0) return 1
        var result = 1
        var i = number
        while (i >= 1) {
            result *= i
            i -= 1
        }
        return result
    }

    fun factorialV3(number: Int): Int {
        if (number < 0) throw Exception("Argument should be >= 0")
        if (number == 0) return 1
        var result = 1
        for (i in number downTo 1 step 1) {
            result *= i
        }
        return result
    }

    fun factorialV4(number: Int): Int {
        if (number < 0) throw Exception("Argument should be >= 0")
        if (number == 0) return 1
        return (number * factorialV4(number - 1))
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

    println("// using factorial function \"factorialV4\"")
    println("Factorial(5): ${factorialV4(5)}")
    // Factorial(5): 120
}
