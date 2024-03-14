print("\n// Factorial(n) in Swift")

enum GenericException: Error {
    case genericError(String)
}

func factorialV1(_ number: Int) throws -> Int {
    if (number < 0) {
        throw GenericException.genericError("Error: Argument should be >= 0")
    }
    if (number == 0) {
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

func factorialV2(_ number: Int) throws -> Int {
    if (number < 0) {
        throw GenericException.genericError("Error: Argument should be >= 0")
    }
    if (number == 0) {
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

func factorialV3(_ number: Int) throws -> Int {
    if (number < 0) {
        throw GenericException.genericError("Error: Argument should be >= 0")
    }
    if (number == 0) {
        return 1
    }
    var result = 1
    for i in stride(from: number, through: 1, by: -1) {
        result *= i
    }
    return result
}

func factorialV4(_ number: Int) throws -> Int {
    if (number < 0) {
        throw GenericException.genericError("Error: Argument should be >= 0")
    }
    if (number == 0) {
        return 1
    }
    do {
        let factorialResult = try factorialV4(number - 1)
        return (number * factorialResult)
    } catch GenericException.genericError(let errorMessage) {
        throw GenericException.genericError(errorMessage)
    }
}

if let factorialResult = try? factorialV1(5) {
    print("// using factorial function \"factorialV1\"")
    print("Factorial(5): \(factorialResult)")
    // Factorial(5): 120
}

if let factorialResult = try? factorialV2(5) {
    print("// using factorial function \"factorialV2\"")
    print("Factorial(5): \(factorialResult)")
    // Factorial(5): 120
}

if let factorialResult = try? factorialV3(5) {
    print("// using factorial function \"factorialV3\"")
    print("Factorial(5): \(factorialResult)")
    // Factorial(5): 120
}

if let factorialResult = try? factorialV4(5) {
    print("// using factorial function \"factorialV4\"")
    print("Factorial(5): \(factorialResult)")
    // Factorial(5): 120
}

print("// using factorial function \"factorialV1\"")
print({ () -> String in
    guard let factorialResult = try? factorialV1(5) else {
        return ""
    }
    return "Factorial(5): \(factorialResult)"
}())
// Factorial(5): 120

print("// using factorial function \"factorialV2\"")
print({ () -> String in
    guard let factorialResult = try? factorialV2(5) else {
        return ""
    }
    return "Factorial(5): \(factorialResult)"
}())
// Factorial(5): 120

print("// using factorial function \"factorialV3\"")
print({ () -> String in
    guard let factorialResult = try? factorialV3(5) else {
        return ""
    }
    return "Factorial(5): \(factorialResult)"
}())
// Factorial(5): 120

print("// using factorial function \"factorialV4\"")
print({ () -> String in
    guard let factorialResult = try? factorialV4(5) else {
        return ""
    }
    return "Factorial(5): \(factorialResult)"
}())
// Factorial(5): 120

do {
    print("// using factorial function \"factorialV1\"")
    try print("Factorial(5): \(factorialV1(5))")
    // Factorial(5): 120

    print("// using factorial function \"factorialV2\"")
    try print("Factorial(5): \(factorialV2(5))")
    // Factorial(5): 120

    print("// using factorial function \"factorialV3\"")
    try print("Factorial(5): \(factorialV3(5))")
    // Factorial(5): 120

    print("// using factorial function \"factorialV4\"")
    try print("Factorial(5): \(factorialV4(5))")
    // Factorial(5): 120
} catch GenericException.genericError(let errorMessage) {
    print(errorMessage)
}
