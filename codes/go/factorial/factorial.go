package main

import (
	"errors"
	"fmt"
)

func factorialV1(number int) (int, error) {
	if (number < 0) {
		return 0, errors.New("Argument should be >= 0")
	}
	if (number == 0) {
		return 1, nil
	}
	result := 1
	i := number
	for (true) {
		result *= i
		if (i <= 1) {
			break
		}
		i -= 1
	}
	return result, nil
}

func factorialV2(number int) (int, error) {
	if (number < 0) {
		return 0, errors.New("Argument should be >= 0")
	}
	if (number == 0) {
		return 1, nil
	}
	result := 1
	i := number
	for (i >= 1) {
		result *= i
		i -= 1
	}
	return result, nil
}

func factorialV3(number int) (int, error) {
	if (number < 0) {
		return 0, errors.New("Argument should be >= 0")
	}
	if (number == 0) {
		return 1, nil
	}
	result := 1
	for i := number; i >= 1; i -= 1 {
		result *= i
	}
	return result, nil
}

func factorialV4(number int) (int, error) {
	if (number < 0) {
		return 0, errors.New("Argument should be >= 0")
	}
	if (number == 0) {
		return 1, nil
	}
	factorialResult, factorialError := factorialV4(number - 1)
	if (factorialError != nil) {
		return 0, factorialError
	}
	return (number * factorialResult), nil
}

func main() {
	fmt.Println("\n// Factorial(n) in Go")

	var factorialResult any
	var factorialError any

	fmt.Println("// using factorial function \"factorialV1\"")
	factorialResult, factorialError = factorialV1(5)
	if (factorialError == nil) {
		fmt.Println("Factorial(5):", factorialResult)
		// Factorial(5): 120
	}

	fmt.Println("// using factorial function \"factorialV2\"")
	factorialResult, factorialError = factorialV2(5)
	if (factorialError == nil) {
		fmt.Println("Factorial(5):", factorialResult)
		// Factorial(5): 120
	}

	fmt.Println("// using factorial function \"factorialV3\"")
	factorialResult, factorialError = factorialV3(5)
	if (factorialError == nil) {
		fmt.Println("Factorial(5):", factorialResult)
		// Factorial(5): 120
	}

	fmt.Println("// using factorial function \"factorialV4\"")
	factorialResult, factorialError = factorialV4(5)
	if (factorialError == nil) {
		fmt.Println("Factorial(5):", factorialResult)
		// Factorial(5): 120
	}
}
