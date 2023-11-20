print("\n// FizzBuzz(n) in Swift")

func fizzbuzzV1(_ stopNumber: Int) -> String {
    if (stopNumber < 1) {
        return "argument should be greater than 0"
    }
    var result = ""
    var number = 1
    while (true) {
        if (result == "") {
            result = "\(number)"
            number += 1
            if (number > stopNumber) {
                break
            }
            continue
        }
        if (((number % 3) == 0) && ((number % 5) == 0)) {
            result = "\(result), FizzBuzz"
            number += 1
            if (number > stopNumber) {
                break
            }
            continue
        }
        if ((number % 3) == 0) {
            result = "\(result), Fizz"
            number += 1
            if (number > stopNumber) {
                break
            }
            continue
        }
        if ((number % 5) == 0) {
            result = "\(result), Buzz"
            number += 1
            if (number > stopNumber) {
                break
            }
            continue
        }
        result = "\(result), \(number)"
        number += 1
        if (number > stopNumber) {
            break
        }
    }
    return result
}

func fizzbuzzV2(_ stopNumber: Int) -> String {
    if (stopNumber < 1) {
        return "argument should be greater than 0"
    }
    var result = ""
    var number = 1
    while (number <= stopNumber) {
        if (result == "") {
            result = "\(number)"
            number += 1
            continue
        }
        if (((number % 3) == 0) && ((number % 5) == 0)) {
            result = "\(result), FizzBuzz"
            number += 1
            continue
        }
        if ((number % 3) == 0) {
            result = "\(result), Fizz"
            number += 1
            continue
        }
        if ((number % 5) == 0) {
            result = "\(result), Buzz"
            number += 1
            continue
        }
        result = "\(result), \(number)"
        number += 1
    }
    return result
}

func fizzbuzzV3(_ stopNumber: Int) -> String {
    if (stopNumber < 1) {
        return "argument should be greater than 0"
    }
    var result = ""
    var number = 1
    while (true) {
        if (result == "") {
            result = "\(number)"
        } else if (((number % 3) == 0) && ((number % 5) == 0)) {
            result = "\(result), FizzBuzz"
        } else if ((number % 3) == 0) {
            result = "\(result), Fizz"
        } else if ((number % 5) == 0) {
            result = "\(result), Buzz"
        } else {
            result = "\(result), \(number)"
        }
        number += 1
        if (number > stopNumber) {
            break
        }
    }
    return result
}

func fizzbuzzV4(_ stopNumber: Int) -> String {
    if (stopNumber < 1) {
        return "argument should be greater than 0"
    }
    var result = ""
    var number = 1
    while (number <= stopNumber) {
        if (result == "") {
            result = "\(number)"
        } else if (((number % 3) == 0) && ((number % 5) == 0)) {
            result = "\(result), FizzBuzz"
        } else if ((number % 3) == 0) {
            result = "\(result), Fizz"
        } else if ((number % 5) == 0) {
            result = "\(result), Buzz"
        } else {
            result = "\(result), \(number)"
        }
        number += 1
    }
    return result
}

func fizzbuzzV5(_ stopNumber: Int) -> String {
    if (stopNumber < 1) {
        return "argument should be greater than 0"
    }
    var result = ""
    var number = 1
    while (true) {
        result = (result == "")
            ? "\(number)"
            : (((number % 3) == 0) && ((number % 5) == 0))
                ? "\(result), FizzBuzz"
                : ((number % 3) == 0)
                    ? "\(result), Fizz"
                    : ((number % 5) == 0)
                        ? "\(result), Buzz"
                        : "\(result), \(number)"
        number += 1
        if (number > stopNumber) {
            break
        }
    }
    return result
}

func fizzbuzzV6(_ stopNumber: Int) -> String {
    if (stopNumber < 1) {
        return "argument should be greater than 0"
    }
    var result = ""
    var number = 1
    while (number <= stopNumber) {
        result = (result == "")
            ? "\(number)"
            : (((number % 3) == 0) && ((number % 5) == 0))
                ? "\(result), FizzBuzz"
                : ((number % 3) == 0)
                    ? "\(result), Fizz"
                    : ((number % 5) == 0)
                        ? "\(result), Buzz"
                        : "\(result), \(number)"
        number += 1
    }
    return result
}

func fizzbuzzV7(_ stopNumber: Int) -> String {
    if (stopNumber < 1) {
        return "argument should be greater than 0"
    }
    var result = ""
    var number = 1
    while (true) {
        result = (result == "") ? "\(number)" : (((number % 3) == 0) && ((number % 5) == 0)) ? "\(result), FizzBuzz" : ((number % 3) == 0) ? "\(result), Fizz" : ((number % 5) == 0) ? "\(result), Buzz" : "\(result), \(number)"
        number += 1
        if (number > stopNumber) {
            break
        }
    }
    return result
}

func fizzbuzzV8(_ stopNumber: Int) -> String {
    if (stopNumber < 1) {
        return "argument should be greater than 0"
    }
    var result = ""
    var number = 1
    while (number <= stopNumber) {
        result = (result == "") ? "\(number)" : (((number % 3) == 0) && ((number % 5) == 0)) ? "\(result), FizzBuzz" : ((number % 3) == 0) ? "\(result), Fizz" : ((number % 5) == 0) ? "\(result), Buzz" : "\(result), \(number)"
        number += 1
    }
    return result
}

func fizzbuzzV9(_ stopNumber: Int) -> String {
    if (stopNumber < 1) {
        return "argument should be greater than 0"
    }
    var result = ""
    for number in stride(from: 1, through: stopNumber, by: 1) {
        if (result == "") {
            result = "\(number)"
            continue
        }
        if (((number % 3) == 0) && ((number % 5) == 0)) {
            result = "\(result), FizzBuzz"
            continue
        }
        if ((number % 3) == 0) {
            result = "\(result), Fizz"
            continue
        }
        if ((number % 5) == 0) {
            result = "\(result), Buzz"
            continue
        }
        result = "\(result), \(number)"
    }
    return result
}

func fizzbuzzV10(_ stopNumber: Int) -> String {
    if (stopNumber < 1) {
        return "argument should be greater than 0"
    }
    var result = ""
    for number in stride(from: 1, through: stopNumber, by: 1) {
        if (result == "") {
            result = "\(number)"
        } else if (((number % 3) == 0) && ((number % 5) == 0)) {
            result = "\(result), FizzBuzz"
        } else if ((number % 3) == 0) {
            result = "\(result), Fizz"
        } else if ((number % 5) == 0) {
            result = "\(result), Buzz"
        } else {
            result = "\(result), \(number)"
        }
    }
    return result
}

func fizzbuzzV11(_ stopNumber: Int) -> String {
    if (stopNumber < 1) {
        return "argument should be greater than 0"
    }
    var result = ""
    for number in stride(from: 1, through: stopNumber, by: 1) {
        result = (result == "")
            ? "\(number)"
            : (((number % 3) == 0) && ((number % 5) == 0))
                ? "\(result), FizzBuzz"
                : ((number % 3) == 0)
                    ? "\(result), Fizz"
                    : ((number % 5) == 0)
                        ? "\(result), Buzz"
                        : "\(result), \(number)"
    }
    return result
}

func fizzbuzzV12(_ stopNumber: Int) -> String {
    if (stopNumber < 1) {
        return "argument should be greater than 0"
    }
    var result = ""
    for number in stride(from: 1, through: stopNumber, by: 1) {
        result = (result == "") ? "\(number)" : (((number % 3) == 0) && ((number % 5) == 0)) ? "\(result), FizzBuzz" : ((number % 3) == 0) ? "\(result), Fizz" : ((number % 5) == 0) ? "\(result), Buzz" : "\(result), \(number)"
    }
    return result
}

let fizzbuzzV13 = { (_ stopNumber: Int) -> String in stopNumber < 1 ? "argument should be greater than 0" : stride(from: 1, through: stopNumber, by: 1).reduce("") { (currentResult, number) in (currentResult == "") ? "\(number)" : (((number % 3) == 0) && ((number % 5) == 0)) ? "\(currentResult), FizzBuzz" : ((number % 3) == 0) ? "\(currentResult), Fizz" : ((number % 5) == 0) ? "\(currentResult), Buzz" : "\(currentResult), \(number)" } }

print("// using fizzbuzz function \"fizzbuzzV1\"")
print("FizzBuzz(36): \(fizzbuzzV1(36))")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("// using fizzbuzz function \"fizzbuzzV2\"")
print("FizzBuzz(36): \(fizzbuzzV2(36))")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("// using fizzbuzz function \"fizzbuzzV3\"")
print("FizzBuzz(36): \(fizzbuzzV3(36))")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("// using fizzbuzz function \"fizzbuzzV4\"")
print("FizzBuzz(36): \(fizzbuzzV4(36))")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("// using fizzbuzz function \"fizzbuzzV5\"")
print("FizzBuzz(36): \(fizzbuzzV5(36))")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("// using fizzbuzz function \"fizzbuzzV6\"")
print("FizzBuzz(36): \(fizzbuzzV6(36))")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("// using fizzbuzz function \"fizzbuzzV7\"")
print("FizzBuzz(36): \(fizzbuzzV7(36))")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("// using fizzbuzz function \"fizzbuzzV8\"")
print("FizzBuzz(36): \(fizzbuzzV8(36))")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("// using fizzbuzz function \"fizzbuzzV9\"")
print("FizzBuzz(36): \(fizzbuzzV9(36))")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("// using fizzbuzz function \"fizzbuzzV10\"")
print("FizzBuzz(36): \(fizzbuzzV10(36))")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("// using fizzbuzz function \"fizzbuzzV11\"")
print("FizzBuzz(36): \(fizzbuzzV11(36))")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("// using fizzbuzz function \"fizzbuzzV12\"")
print("FizzBuzz(36): \(fizzbuzzV12(36))")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("// using fizzbuzz function \"fizzbuzzV13\"")
print("FizzBuzz(36): \(fizzbuzzV13(36))")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
