package main

import (
	"fmt"
)

func factorialV1(number int) int {
	if (number > 1) == false {
		return 1
	}
	result := 1
	i := number
	for true {
		result *= i
		i -= 1
		if i <= 0 {
			break
		}
	}
	return result
}

func factorialV2(number int) int {
	if (number > 1) == false {
		return 1
	}
	result := 1
	i := number
	for i >= 1 {
		result *= i
		i -= 1
	}
	return result
}

func factorialV3(number int) int {
	if (number > 1) == false {
		return 1
	}
	result := 1
	for i := number; i >= 1; i -= 1 {
		result *= i
	}
	return result
}

func main() {
	fmt.Println("\n// Factorial(n) in Go")

	fmt.Println("// using factorial function \"factorialV1\"")
	fmt.Println("Factorial(5):", factorialV1(5))
	// Factorial(5): 120

	fmt.Println("// using factorial function \"factorialV2\"")
	fmt.Println("Factorial(5):", factorialV2(5))
	// Factorial(5): 120

	fmt.Println("// using factorial function \"factorialV3\"")
	fmt.Println("Factorial(5):", factorialV3(5))
	// Factorial(5): 120
}
