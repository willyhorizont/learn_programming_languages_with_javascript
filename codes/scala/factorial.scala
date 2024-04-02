println("\n// Factorial(n) in Scala")

def factorialV1(number: Int): Int = {
    if (number < 0) throw new Exception("Argument should be >= 0")
    if (number == 0) return 1
    var result = 1
    var i = number
    while (true) {
        result *= i
        if (i <= 1) return result
        i -= 1
    }
    return result
}

def factorialV2(number: Int): Int = {
    if (number < 0) throw new Exception("Argument should be >= 0")
    if (number == 0) return 1
    var result = 1
    var i = number
    while (i >= 1) {
        result *= i
        i -= 1
    }
    return result
}

def factorialV3(number: Int): Int = {
    if (number < 0) throw new Exception("Argument should be >= 0")
    if (number == 0) return 1
    var result = 1
    for (i <- (number to 1 by -1)) {
        result *= i
    }
    return result
}

def factorialV4(number: Int): Int = {
    if (number < 0) throw new Exception("Argument should be >= 0")
    if (number == 0) return 1
    return (number * factorialV4(number - 1))
}

println("// using factorial function \"factorialV1\"")
println(s"Factorial(5): ${factorialV1(5)}")
// Factorial(5): 120

println("// using factorial function \"factorialV2\"")
println(s"Factorial(5): ${factorialV2(5)}")
// Factorial(5): 120

println("// using factorial function \"factorialV3\"")
println(s"Factorial(5): ${factorialV3(5)}")
// Factorial(5): 120

println("// using factorial function \"factorialV4\"")
println(s"Factorial(5): ${factorialV4(5)}")
// Factorial(5): 120
