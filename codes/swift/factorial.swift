print("\n// Factorial(n) in Swift")

func factorialV1(_ number: Int) -> Int {
    if ((number > 1) == false) {
        return 1
    }
    var result = 1
    var i = number
    while (true) {
        result *= i
        i -= 1
        if (i <= 0) {
            break
        }
    }
    return result
}

func factorialV2(_ number: Int) -> Int {
    if ((number > 1) == false) {
        return 1
    }
    var result = 1
    var i = number
    while (i >= 1) {
        result *= i
        i -= 1
    }
    return result
}

func factorialV3(_ number: Int) -> Int {
    if ((number > 1) == false) {
        return 1
    }
    var result = 1
    for i in stride(from: number, through: 1, by: -1) {
        result *= i
    }
    return result
}

print("// using factorial function \"factorialV1\"")
print("Factorial(5): \(factorialV1(5))")
// Factorial(5): 120

print("// using factorial function \"factorialV2\"")
print("Factorial(5): \(factorialV2(5))")
// Factorial(5): 120

print("// using factorial function \"factorialV3\"")
print("Factorial(5): \(factorialV3(5))")
// Factorial(5): 120
