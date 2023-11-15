@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc fizzbuzz.kt -include-runtime -d fizzbuzz.jar && kotlin fizzbuzz.jar

fun main() {
    println("\n// FizzBuzz(n) in Kotlin")

    fun fizzbuzzV1(stopNumber: Int): String {
        if (stopNumber < 1) return "argument should be greater than 0"
        var result = ""
        var number = 1
        while (true) {
            if (result == "") {
                result = "${number}"
                number += 1
                if (number > stopNumber) break
                continue
            }
            if (((number % 3) == 0) && ((number % 5) == 0)) {
                result = "${result}, FizzBuzz"
                number += 1
                if (number > stopNumber) break
                continue
            }
            if ((number % 3) == 0) {
                result = "${result}, Fizz"
                number += 1
                if (number > stopNumber) break
                continue
            }
            if ((number % 5) == 0) {
                result = "${result}, Buzz"
                number += 1
                if (number > stopNumber) break
                continue
            }
            result = "${result}, ${number}"
            number += 1
            if (number > stopNumber) break
        }
        return result
    }

    fun fizzbuzzV2(stopNumber: Int): String {
        if (stopNumber < 1) return "argument should be greater than 0"
        var result = ""
        var number = 1
        while (number <= stopNumber) {
            if (result == "") {
                result = "${number}"
                number += 1
                continue
            }
            if (((number % 3) == 0) && ((number % 5) == 0)) {
                result = "${result}, FizzBuzz"
                number += 1
                continue
            }
            if ((number % 3) == 0) {
                result = "${result}, Fizz"
                number += 1
                continue
            }
            if ((number % 5) == 0) {
                result = "${result}, Buzz"
                number += 1
                continue
            }
            result = "${result}, ${number}"
            number += 1
        }
        return result
    }

    fun fizzbuzzV3(stopNumber: Int): String {
        if (stopNumber < 1) return "argument should be greater than 0"
        var result = ""
        var number = 1
        while (true) {
            if (result == "") {
                result = "${number}"
            } else if (((number % 3) == 0) && ((number % 5) == 0)) {
                result = "${result}, FizzBuzz"
            } else if ((number % 3) == 0) {
                result = "${result}, Fizz"
            } else if ((number % 5) == 0) {
                result = "${result}, Buzz"
            } else {
                result = "${result}, ${number}"
            }
            number += 1
            if (number > stopNumber) break
        }
        return result
    }

    fun fizzbuzzV4(stopNumber: Int): String {
        if (stopNumber < 1) return "argument should be greater than 0"
        var result = ""
        var number = 1
        while (number <= stopNumber) {
            if (result == "") {
                result = "${number}"
            } else if (((number % 3) == 0) && ((number % 5) == 0)) {
                result = "${result}, FizzBuzz"
            } else if ((number % 3) == 0) {
                result = "${result}, Fizz"
            } else if ((number % 5) == 0) {
                result = "${result}, Buzz"
            } else {
                result = "${result}, ${number}"
            }
            number += 1
        }
        return result
    }

    fun fizzbuzzV5(stopNumber: Int): String {
        if (stopNumber < 1) return "argument should be greater than 0"
        var result = ""
        var number = 1
        while (true) {
            result = if (result == "") "${number}" else if (((number % 3) == 0) && ((number % 5) == 0)) "${result}, FizzBuzz" else if ((number % 3) == 0) "${result}, Fizz" else if ((number % 5) == 0) "${result}, Buzz" else "${result}, ${number}"
            number += 1
            if (number > stopNumber) break
        }
        return result
    }

    fun fizzbuzzV6(stopNumber: Int): String {
        if (stopNumber < 1) return "argument should be greater than 0"
        var result = ""
        var number = 1
        while (number <= stopNumber) {
            result = if (result == "") "${number}" else if (((number % 3) == 0) && ((number % 5) == 0)) "${result}, FizzBuzz" else if ((number % 3) == 0) "${result}, Fizz" else if ((number % 5) == 0) "${result}, Buzz" else "${result}, ${number}"
            number += 1
        }
        return result
    }

    fun fizzbuzzV7(stopNumber: Int): String {
        if (stopNumber < 1) return "argument should be greater than 0"
        var result = ""
        for (number in 1..stopNumber step 1) {
            if (result == "") {
                result = "${number}"
                continue
            }
            if (((number % 3) == 0) && ((number % 5) == 0)) {
                result = "${result}, FizzBuzz"
                continue
            }
            if ((number % 3) == 0) {
                result = "${result}, Fizz"
                continue
            }
            if ((number % 5) == 0) {
                result = "${result}, Buzz"
                continue
            }
            result = "${result}, ${number}"
        }
        return result
    }

    fun fizzbuzzV8(stopNumber: Int): String {
        if (stopNumber < 1) return "argument should be greater than 0"
        var result = ""
        for (number in 1..stopNumber step 1) {
            if (result == "") {
                result = "${number}"
            } else if (((number % 3) == 0) && ((number % 5) == 0)) {
                result = "${result}, FizzBuzz"
            } else if ((number % 3) == 0) {
                result = "${result}, Fizz"
            } else if ((number % 5) == 0) {
                result = "${result}, Buzz"
            } else {
                result = "${result}, ${number}"
            }
        }
        return result
    }

    fun fizzbuzzV9(stopNumber: Int): String {
        if (stopNumber < 1) return "argument should be greater than 0"
        var result = ""
        for (number in 1..stopNumber step 1) {
            result = if (result == "") "${number}" else if (((number % 3) == 0) && ((number % 5) == 0)) "${result}, FizzBuzz" else if ((number % 3) == 0) "${result}, Fizz" else if ((number % 5) == 0) "${result}, Buzz" else "${result}, ${number}"
        }
        return result
    }

    val fizzbuzzV10 = { stopNumber: Int -> (1..stopNumber step 1).fold("") { currentResult: String, number: Int ->  if (currentResult == "") "${number}" else if (((number % 3) == 0) && ((number % 5) == 0)) "${currentResult}, FizzBuzz" else if ((number % 3) == 0) "${currentResult}, Fizz" else if ((number % 5) == 0) "${currentResult}, Buzz" else "${currentResult}, ${number}" } }

    println("// using fizzbuzz function \"fizzbuzzV1\"");
    println("FizzBuzz(36): ${fizzbuzzV1(36)}");
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    println("// using fizzbuzz function \"fizzbuzzV2\"");
    println("FizzBuzz(36): ${fizzbuzzV2(36)}");
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    println("// using fizzbuzz function \"fizzbuzzV3\"");
    println("FizzBuzz(36): ${fizzbuzzV3(36)}");
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    println("// using fizzbuzz function \"fizzbuzzV4\"");
    println("FizzBuzz(36): ${fizzbuzzV4(36)}");
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    println("// using fizzbuzz function \"fizzbuzzV5\"");
    println("FizzBuzz(36): ${fizzbuzzV5(36)}");
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    println("// using fizzbuzz function \"fizzbuzzV6\"");
    println("FizzBuzz(36): ${fizzbuzzV6(36)}");
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    println("// using fizzbuzz function \"fizzbuzzV7\"");
    println("FizzBuzz(36): ${fizzbuzzV7(36)}");
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    println("// using fizzbuzz function \"fizzbuzzV8\"");
    println("FizzBuzz(36): ${fizzbuzzV8(36)}");
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    println("// using fizzbuzz function \"fizzbuzzV9\"");
    println("FizzBuzz(36): ${fizzbuzzV9(36)}");
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

    println("// using fizzbuzz function \"fizzbuzzV10\"");
    println("FizzBuzz(36): ${fizzbuzzV10(36)}");
    // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
}
