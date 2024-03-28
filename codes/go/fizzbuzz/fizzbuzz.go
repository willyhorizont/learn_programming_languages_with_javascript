package main

import (
	"errors"
	"fmt"
)

func fizzbuzzV1(stopNumber int) (string, error) {
    if (stopNumber < 1) {
        return "", errors.New("Argument should be > 0")
    }
    result := ""
    number := 1
    for (true) {
        if (result == "") {
            result = fmt.Sprint(number)
            if (number >= stopNumber) {
                break
            }
            number += 1
            continue
        }
        if (((number % 3) == 0) && ((number % 5) == 0)) {
            result = (result + ", FizzBuzz")
            if (number >= stopNumber) {
                break
            }
            number += 1
            continue
        }
        if ((number % 3) == 0) {
            result = (result + ", Fizz")
            if (number >= stopNumber) {
                break
            }
            number += 1
            continue
        }
        if ((number % 5) == 0) {
            result = (result + ", Buzz")
            if (number >= stopNumber) {
                break
            }
            number += 1
            continue
        }
        result = (result + ", " + fmt.Sprint(number))
        if (number >= stopNumber) {
            break
        }
        number += 1
    }
    return result, nil
}

func fizzbuzzV2(stopNumber int) (string, error) {
    if (stopNumber < 1) {
        return "", errors.New("Argument should be > 0")
    }
    result := ""
    number := 1
    for number <= stopNumber {
        if (result == "") {
            result = fmt.Sprint(number)
            number += 1
            continue
        }
        if (((number % 3) == 0) && ((number % 5) == 0)) {
            result = (result + ", FizzBuzz")
            number += 1
            continue
        }
        if ((number % 3) == 0) {
            result = (result + ", Fizz")
            number += 1
            continue
        }
        if ((number % 5) == 0) {
            result = (result + ", Buzz")
            number += 1
            continue
        }
        result = (result + ", " + fmt.Sprint(number))
        number += 1
    }
    return result, nil
}

func fizzbuzzV3(stopNumber int) (string, error) {
    if (stopNumber < 1) {
        return "", errors.New("Argument should be > 0")
    }
    result := ""
    number := 1
    for (true) {
        if (result == "") {
            result = fmt.Sprint(number)
        } else if (((number % 3) == 0) && ((number % 5) == 0)) {
            result = (result + ", FizzBuzz")
        } else if ((number % 3) == 0) {
            result = (result + ", Fizz")
        } else if ((number % 5) == 0) {
            result = (result + ", Buzz")
        } else {
            result = (result + ", " + fmt.Sprint(number))
        }
        if (number >= stopNumber) {
            break
        }
        number += 1
    }
    return result, nil
}

func fizzbuzzV4(stopNumber int) (string, error) {
    if (stopNumber < 1) {
        return "", errors.New("Argument should be > 0")
    }
    result := ""
    number := 1
    for number <= stopNumber {
        if (result == "") {
            result = fmt.Sprint(number)
        } else if (((number % 3) == 0) && ((number % 5) == 0)) {
            result = (result + ", FizzBuzz")
        } else if ((number % 3) == 0) {
            result = (result + ", Fizz")
        } else if ((number % 5) == 0) {
            result = (result + ", Buzz")
        } else {
            result = (result + ", " + fmt.Sprint(number))
        }
        number += 1
    }
    return result, nil
}

func fizzbuzzV5(stopNumber int) (string, error) {
    if (stopNumber < 1) {
        return "", errors.New("Argument should be > 0")
    }
    result := ""
    for number := 1; number <= stopNumber; number += 1 {
        if (result == "") {
            result = fmt.Sprint(number)
            continue
        }
        if (((number % 3) == 0) && ((number % 5) == 0)) {
            result = (result + ", FizzBuzz")
            continue
        }
        if ((number % 3) == 0) {
            result = (result + ", Fizz")
            continue
        }
        if ((number % 5) == 0) {
            result = (result + ", Buzz")
            continue
        }
        result = (result + ", " + fmt.Sprint(number))
    }
    return result, nil
}

func fizzbuzzV6(stopNumber int) (string, error) {
    if (stopNumber < 1) {
        return "", errors.New("Argument should be > 0")
    }
    result := ""
    for number := 1; number <= stopNumber; number += 1 {
        if (result == "") {
            result = fmt.Sprint(number)
        } else if (((number % 3) == 0) && ((number % 5) == 0)) {
            result = (result + ", FizzBuzz")
        } else if ((number % 3) == 0) {
            result = (result + ", Fizz")
        } else if ((number % 5) == 0) {
            result = (result + ", Buzz")
        } else {
            result = (result + ", " + fmt.Sprint(number))
        }
    }
    return result, nil
}

func main() {
    fmt.Println("\n// FizzBuzz(n) in Go")

    var fizzbuzzResult any
    var fizzbuzzError any

    fmt.Println("// using fizzbuzz function \"fizzbuzzV1\"")
    fizzbuzzResult, fizzbuzzError = fizzbuzzV1(36)
    if (fizzbuzzError == nil) {
        fmt.Println("FizzBuzz(36):", fizzbuzzResult)
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
    }

    fmt.Println("// using fizzbuzz function \"fizzbuzzV2\"")
    fizzbuzzResult, fizzbuzzError = fizzbuzzV2(36)
    if (fizzbuzzError == nil) {
        fmt.Println("FizzBuzz(36):", fizzbuzzResult)
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
    }

    fmt.Println("// using fizzbuzz function \"fizzbuzzV3\"")
    fizzbuzzResult, fizzbuzzError = fizzbuzzV3(36)
    if (fizzbuzzError == nil) {
        fmt.Println("FizzBuzz(36):", fizzbuzzResult)
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
    }

    fmt.Println("// using fizzbuzz function \"fizzbuzzV4\"")
    fizzbuzzResult, fizzbuzzError = fizzbuzzV4(36)
    if (fizzbuzzError == nil) {
        fmt.Println("FizzBuzz(36):", fizzbuzzResult)
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
    }

    fmt.Println("// using fizzbuzz function \"fizzbuzzV5\"")
    fizzbuzzResult, fizzbuzzError = fizzbuzzV5(36)
    if (fizzbuzzError == nil) {
        fmt.Println("FizzBuzz(36):", fizzbuzzResult)
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
    }

    fmt.Println("// using fizzbuzz function \"fizzbuzzV6\"")
    fizzbuzzResult, fizzbuzzError = fizzbuzzV6(36)
    if (fizzbuzzError == nil) {
        fmt.Println("FizzBuzz(36):", fizzbuzzResult)
        // FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
    }
}
