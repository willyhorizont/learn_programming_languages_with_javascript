package main

import (
	"fmt"
)

func fizzbuzzV1(stopNumber int) string {
	if stopNumber < 1 {
		return "argument should be greater than 0"
	}
	result := ""
	number := 1
	for true {
		if result == "" {
			result = fmt.Sprint(number)
			number += 1
			if number > stopNumber {
				break
			}
			continue
		}
		if ((number % 3) == 0) && ((number % 5) == 0) {
			result = result + ", FizzBuzz"
			number += 1
			if number > stopNumber {
				break
			}
			continue
		}
		if (number % 3) == 0 {
			result = result + ", Fizz"
			number += 1
			if number > stopNumber {
				break
			}
			continue
		}
		if (number % 5) == 0 {
			result = result + ", Buzz"
			number += 1
			if number > stopNumber {
				break
			}
			continue
		}
		result = result + ", " + fmt.Sprint(number)
		number += 1
		if number > stopNumber {
			break
		}
	}
	return result
}

func fizzbuzzV2(stopNumber int) string {
	if stopNumber < 1 {
		return "argument should be greater than 0"
	}
	result := ""
	number := 1
	for number <= stopNumber {
		if result == "" {
			result = fmt.Sprint(number)
			number += 1
			continue
		}
		if ((number % 3) == 0) && ((number % 5) == 0) {
			result = result + ", FizzBuzz"
			number += 1
			continue
		}
		if (number % 3) == 0 {
			result = result + ", Fizz"
			number += 1
			continue
		}
		if (number % 5) == 0 {
			result = result + ", Buzz"
			number += 1
			continue
		}
		result = result + ", " + fmt.Sprint(number)
		number += 1
	}
	return result
}

func fizzbuzzV3(stopNumber int) string {
	if stopNumber < 1 {
		return "argument should be greater than 0"
	}
	result := ""
	number := 1
	for true {
		if result == "" {
			result = fmt.Sprint(number)
		} else if ((number % 3) == 0) && ((number % 5) == 0) {
			result = result + ", FizzBuzz"
		} else if (number % 3) == 0 {
			result = result + ", Fizz"
		} else if (number % 5) == 0 {
			result = result + ", Buzz"
		} else {
			result = result + ", " + fmt.Sprint(number)
		}
		number += 1
		if number > stopNumber {
			break
		}
	}
	return result
}

func fizzbuzzV4(stopNumber int) string {
	if stopNumber < 1 {
		return "argument should be greater than 0"
	}
	result := ""
	number := 1
	for number <= stopNumber {
		if result == "" {
			result = fmt.Sprint(number)
		} else if ((number % 3) == 0) && ((number % 5) == 0) {
			result = result + ", FizzBuzz"
		} else if (number % 3) == 0 {
			result = result + ", Fizz"
		} else if (number % 5) == 0 {
			result = result + ", Buzz"
		} else {
			result = result + ", " + fmt.Sprint(number)
		}
		number += 1
	}
	return result
}

func fizzbuzzV5(stopNumber int) string {
	if stopNumber < 1 {
		return "argument should be greater than 0"
	}
	result := ""
	for number := 1; number <= stopNumber; number += 1 {
		if result == "" {
			result = fmt.Sprint(number)
			continue
		}
		if ((number % 3) == 0) && ((number % 5) == 0) {
			result = result + ", FizzBuzz"
			continue
		}
		if (number % 3) == 0 {
			result = result + ", Fizz"
			continue
		}
		if (number % 5) == 0 {
			result = result + ", Buzz"
			continue
		}
		result = result + ", " + fmt.Sprint(number)
	}
	return result
}

func fizzbuzzV6(stopNumber int) string {
	if stopNumber < 1 {
		return "argument should be greater than 0"
	}
	result := ""
	for number := 1; number <= stopNumber; number += 1 {
		if result == "" {
			result = fmt.Sprint(number)
		} else if ((number % 3) == 0) && ((number % 5) == 0) {
			result = result + ", FizzBuzz"
		} else if (number % 3) == 0 {
			result = result + ", Fizz"
		} else if (number % 5) == 0 {
			result = result + ", Buzz"
		} else {
			result = result + ", " + fmt.Sprint(number)
		}
	}
	return result
}

func main() {
	fmt.Println("\n// FizzBuzz(n) in Go")

	fmt.Println("// using fizzbuzz function \"fizzbuzzV1\"")
	fmt.Println("FizzBuzz(36):", fizzbuzzV1(36))
	// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

	fmt.Println("// using fizzbuzz function \"fizzbuzzV2\"")
	fmt.Println("FizzBuzz(36):", fizzbuzzV2(36))
	// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

	fmt.Println("// using fizzbuzz function \"fizzbuzzV3\"")
	fmt.Println("FizzBuzz(36):", fizzbuzzV3(36))
	// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

	fmt.Println("// using fizzbuzz function \"fizzbuzzV4\"")
	fmt.Println("FizzBuzz(36):", fizzbuzzV4(36))
	// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

	fmt.Println("// using fizzbuzz function \"fizzbuzzV5\"")
	fmt.Println("FizzBuzz(36):", fizzbuzzV5(36))
	// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

	fmt.Println("// using fizzbuzz function \"fizzbuzzV6\"")
	fmt.Println("FizzBuzz(36):", fizzbuzzV6(36))
	// FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
}
