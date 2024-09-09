def MyArray(arrayItem: Any*): Array[Any] = (if (arrayItem.isEmpty) Array.empty[Any] else arrayItem.toArray[Any])

println("\n// FizzBuzz(n) in Scala")

def fizzbuzzV1(stopNumber: Int): String = {
    if (stopNumber < 1) throw new Exception("Argument should be > 0")
    var result = ""
    def myWhileLoopV1(number: Int): Unit = {
        var numberInner: Int = number
        while (true) {
            if (result == "") {
                result = s"${numberInner}"
                if (numberInner >= stopNumber) return // break
                numberInner += 1
                myWhileLoopV1(numberInner) // continue
                return
            }
            if (((numberInner % 3) == 0) && ((numberInner % 5) == 0)) {
                result = s"${result}, FizzBuzz"
                if (numberInner >= stopNumber) return // break
                numberInner += 1
                myWhileLoopV1(numberInner) // continue
                return
            }
            if ((numberInner % 3) == 0) {
                result = s"${result}, Fizz"
                if (numberInner >= stopNumber) return // break
                numberInner += 1
                myWhileLoopV1(numberInner) // continue
                return
            }
            if ((numberInner % 5) == 0) {
                result = s"${result}, Buzz"
                if (numberInner >= stopNumber) return // break
                numberInner += 1
                myWhileLoopV1(numberInner) // continue
                return
            }
            result = s"${result}, ${numberInner}"
            if (numberInner >= stopNumber) return // break
            numberInner += 1
        }
    }
    myWhileLoopV1(1)
    return result
}

def fizzbuzzV2(stopNumber: Int): String = {
    if (stopNumber < 1) throw new Exception("Argument should be > 0")
    var result = ""
    def myWhileLoopV1(number: Int): Unit = {
        var numberInner: Int = number
        while (numberInner <= stopNumber) {
            if (result == "") {
                result = s"${numberInner}"
                numberInner += 1
                myWhileLoopV1(numberInner) // continue
                return
            }
            if (((numberInner % 3) == 0) && ((numberInner % 5) == 0)) {
                result = s"${result}, FizzBuzz"
                numberInner += 1
                myWhileLoopV1(numberInner) // continue
                return
            }
            if ((numberInner % 3) == 0) {
                result = s"${result}, Fizz"
                numberInner += 1
                myWhileLoopV1(numberInner) // continue
                return
            }
            if ((numberInner % 5) == 0) {
                result = s"${result}, Buzz"
                numberInner += 1
                myWhileLoopV1(numberInner) // continue
                return
            }
            result = s"${result}, ${numberInner}"
            numberInner += 1
        }
    }
    myWhileLoopV1(1)
    return result
}

def fizzbuzzV3(stopNumber: Int): String = {
    if (stopNumber < 1) throw new Exception("Argument should be > 0")
    var result = ""
    def myWhileLoopV1(number: Int): Unit = {
        var numberInner: Int = number
        while (true) {
            if (result == "") {
                result = s"${numberInner}"
            } else if (((numberInner % 3) == 0) && ((numberInner % 5) == 0)) {
                result = s"${result}, FizzBuzz"
            } else if ((numberInner % 3) == 0) {
                result = s"${result}, Fizz"
            } else if ((numberInner % 5) == 0) {
                result = s"${result}, Buzz"
            } else {
                result = s"${result}, ${numberInner}"
            }
            if (numberInner >= stopNumber) return // break
            numberInner += 1
        }
    }
    myWhileLoopV1(1)
    return result
}

def fizzbuzzV4(stopNumber: Int): String = {
    if (stopNumber < 1) throw new Exception("Argument should be > 0")
    var result = ""
    def myWhileLoopV1(number: Int): Unit = {
        var numberInner: Int = number
        while (numberInner <= stopNumber) {
            if (result == "") {
                result = s"${numberInner}"
            } else if (((numberInner % 3) == 0) && ((numberInner % 5) == 0)) {
                result = s"${result}, FizzBuzz"
            } else if ((numberInner % 3) == 0) {
                result = s"${result}, Fizz"
            } else if ((numberInner % 5) == 0) {
                result = s"${result}, Buzz"
            } else {
                result = s"${result}, ${numberInner}"
            }
            numberInner += 1
        }
    }
    myWhileLoopV1(1)
    return result
}

def fizzbuzzV5(stopNumber: Int): String = {
    if (stopNumber < 1) throw new Exception("Argument should be > 0")
    var result = ""
    def myWhileLoopV1(number: Int): Unit = {
        var numberInner: Int = number
        while (true) {
            result = (if (result == "") s"${numberInner}" else if (((numberInner % 3) == 0) && ((numberInner % 5) == 0)) s"${result}, FizzBuzz" else if ((numberInner % 3) == 0) s"${result}, Fizz" else if ((numberInner % 5) == 0) s"${result}, Buzz" else s"${result}, ${numberInner}")
            if (numberInner >= stopNumber) return // break
            numberInner += 1
        }
    }
    myWhileLoopV1(1)
    return result
}

def fizzbuzzV6(stopNumber: Int): String = {
    if (stopNumber < 1) throw new Exception("Argument should be > 0")
    var result = ""
    def myWhileLoopV1(number: Int): Unit = {
        var numberInner: Int = number
        while (numberInner <= stopNumber) {
            result = (if (result == "") s"${numberInner}" else if (((numberInner % 3) == 0) && ((numberInner % 5) == 0)) s"${result}, FizzBuzz" else if ((numberInner % 3) == 0) s"${result}, Fizz" else if ((numberInner % 5) == 0) s"${result}, Buzz" else s"${result}, ${numberInner}")
            numberInner += 1
        }
    }
    myWhileLoopV1(1)
    return result
}

def fizzbuzzV7(stopNumber: Int): String = {
    if (stopNumber < 1) throw new Exception("Argument should be > 0")
    var result = ""
    def myForLoopAscending(number: Int = 0): Unit = {
        for (numberInner <- (number to stopNumber by 1)) {
            if (result == "") {
                result = s"${numberInner}"
                myForLoopAscending(numberInner + 1) // continue
                return
            }
            if (((numberInner % 3) == 0) && ((numberInner % 5) == 0)) {
                result = s"${result}, FizzBuzz"
                myForLoopAscending(numberInner + 1) // continue
                return
            }
            if ((numberInner % 3) == 0) {
                result = s"${result}, Fizz"
                myForLoopAscending(numberInner + 1) // continue
                return
            }
            if ((numberInner % 5) == 0) {
                result = s"${result}, Buzz"
                myForLoopAscending(numberInner + 1) // continue
                return
            }
            result = s"${result}, ${numberInner}"
        }
    }
    myForLoopAscending(1)
    return result
}

def fizzbuzzV8(stopNumber: Int): String = {
    if (stopNumber < 1) throw new Exception("Argument should be > 0")
    var result = ""
    def myForLoopAscending(number: Int = 0): Unit = {
        for (numberInner <- (number to stopNumber by 1)) {
            if (result == "") {
                result = s"${numberInner}"
            } else if (((numberInner % 3) == 0) && ((numberInner % 5) == 0)) {
                result = s"${result}, FizzBuzz"
            } else if ((numberInner % 3) == 0) {
                result = s"${result}, Fizz"
            } else if ((numberInner % 5) == 0) {
                result = s"${result}, Buzz"
            } else {
                result = s"${result}, ${numberInner}"
            }
        }
    }
    myForLoopAscending(1)
    return result
}

def fizzbuzzV9(stopNumber: Int): String = {
    if (stopNumber < 1) throw new Exception("Argument should be > 0")
    var result = ""
    def myForLoopAscending(number: Int = 0): Unit = {
        for (numberInner <- (number to stopNumber by 1)) {
            result = (if (result == "") s"${numberInner}" else if (((numberInner % 3) == 0) && ((numberInner % 5) == 0)) s"${result}, FizzBuzz" else if ((numberInner % 3) == 0) s"${result}, Fizz" else if ((numberInner % 5) == 0) s"${result}, Buzz" else s"${result}, ${numberInner}")
        }
    }
    myForLoopAscending(1)
    return result
}

def fizzbuzzV10(stopNumber: Int): String = {
    if (stopNumber < 1) throw new Exception("Argument should be > 0")
    return (MyArray(("").asInstanceOf[Any]) ++ (1 to stopNumber by 1).toArray[Any]).reduce(((currentResult: Any, currentNumber: Any) => (if (currentResult.asInstanceOf[String] == "") s"${currentNumber.asInstanceOf[Int]}" else if (((currentNumber.asInstanceOf[Int] % 3) == 0) && ((currentNumber.asInstanceOf[Int] % 5) == 0)) s"${currentResult.asInstanceOf[String]}, FizzBuzz" else if ((currentNumber.asInstanceOf[Int] % 3) == 0) s"${currentResult.asInstanceOf[String]}, Fizz" else if ((currentNumber.asInstanceOf[Int] % 5) == 0) s"${currentResult.asInstanceOf[String]}, Buzz" else s"${currentResult.asInstanceOf[String]}, ${currentNumber.asInstanceOf[Int]}"): Any)).asInstanceOf[String]
}

def fizzbuzzV11(stopNumber: Int): String = {
    if (stopNumber < 1) throw new Exception("Argument should be > 0")
    return (1 to stopNumber by 1).toArray[Any].fold(("").asInstanceOf[Any])(((currentResult: Any, currentNumber: Any) => (if (currentResult.asInstanceOf[String] == "") s"${currentNumber.asInstanceOf[Int]}" else if (((currentNumber.asInstanceOf[Int] % 3) == 0) && ((currentNumber.asInstanceOf[Int] % 5) == 0)) s"${currentResult.asInstanceOf[String]}, FizzBuzz" else if ((currentNumber.asInstanceOf[Int] % 3) == 0) s"${currentResult.asInstanceOf[String]}, Fizz" else if ((currentNumber.asInstanceOf[Int] % 5) == 0) s"${currentResult.asInstanceOf[String]}, Buzz" else s"${currentResult.asInstanceOf[String]}, ${currentNumber.asInstanceOf[Int]}"): Any)).asInstanceOf[String]
}

def fizzbuzzV12(stopNumber: Int): String = {
    if (stopNumber < 1) throw new Exception("Argument should be > 0")
    return (1 to stopNumber by 1).toArray[Any].foldLeft(("").asInstanceOf[Any])(((currentResult: Any, currentNumber: Any) => (if (currentResult.asInstanceOf[String] == "") s"${currentNumber.asInstanceOf[Int]}" else if (((currentNumber.asInstanceOf[Int] % 3) == 0) && ((currentNumber.asInstanceOf[Int] % 5) == 0)) s"${currentResult.asInstanceOf[String]}, FizzBuzz" else if ((currentNumber.asInstanceOf[Int] % 3) == 0) s"${currentResult.asInstanceOf[String]}, Fizz" else if ((currentNumber.asInstanceOf[Int] % 5) == 0) s"${currentResult.asInstanceOf[String]}, Buzz" else s"${currentResult.asInstanceOf[String]}, ${currentNumber.asInstanceOf[Int]}"): Any)).asInstanceOf[String]
}

println("// using fizzbuzz function \"fizzbuzzV1\"")
println(s"Factorial(36): ${fizzbuzzV1(36)}")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("// using fizzbuzz function \"fizzbuzzV2\"")
println(s"Factorial(36): ${fizzbuzzV2(36)}")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("// using fizzbuzz function \"fizzbuzzV3\"")
println(s"Factorial(36): ${fizzbuzzV3(36)}")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("// using fizzbuzz function \"fizzbuzzV4\"")
println(s"Factorial(36): ${fizzbuzzV4(36)}")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("// using fizzbuzz function \"fizzbuzzV5\"")
println(s"Factorial(36): ${fizzbuzzV5(36)}")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("// using fizzbuzz function \"fizzbuzzV6\"")
println(s"Factorial(36): ${fizzbuzzV6(36)}")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("// using fizzbuzz function \"fizzbuzzV7\"")
println(s"Factorial(36): ${fizzbuzzV7(36)}")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("// using fizzbuzz function \"fizzbuzzV8\"")
println(s"Factorial(36): ${fizzbuzzV8(36)}")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("// using fizzbuzz function \"fizzbuzzV9\"")
println(s"Factorial(36): ${fizzbuzzV9(36)}")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("// using fizzbuzz function \"fizzbuzzV10\"")
println(s"Factorial(36): ${fizzbuzzV10(36)}")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("// using fizzbuzz function \"fizzbuzzV11\"")
println(s"Factorial(36): ${fizzbuzzV11(36)}")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

println("// using fizzbuzz function \"fizzbuzzV12\"")
println(s"Factorial(36): ${fizzbuzzV12(36)}")
// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
