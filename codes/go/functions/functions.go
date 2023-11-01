package main

import (
	"fmt"
)

// ? function statement or function declaration
func getRectangleAreaV1(rectangleWidth int, rectangleLength int) int {
	return rectangleWidth * rectangleLength
}

// ? Passing functions as arguments to other functions

func sayHi(doSomething func()) {
	fmt.Println("hi")
	doSomething()
}

func sayHowAreYou() {
	fmt.Println("how are you?")
}

// ===================================================

func addition(a int, b int) int {
	return a + b
}

// ? Returning functions as values from other functions (closure)

func multiplyV1(a int) func(b int) int {
	multiplyBy := func(b int) int {
		return a * b
	}
	return multiplyBy
}

func multiplyV2(a int) func(b int) int {
	return func(b int) int {
		return a * b
	}
}

// ===================================================

func main() {
	// ? function expression
	getRectangleAreaV2 := func(rectangleWidth int, rectangleLength int) int {
		return rectangleWidth * rectangleLength
	}

	// ? anonymous function
	// func(rectangleWidth int, rectangleLength int) int {
	// 	return rectangleWidth * rectangleLength
	// }

	/*
		? In Go, a function is a first-class citizen, which means it supports:
		? • Passing functions as arguments to other functions
		? • Assigning functions to variables or storing them in data structures
		? • Returning functions as values from other functions (closure)
	*/

	// ? Passing functions as arguments to other functions

	sayHi(sayHowAreYou)

	sayHi(func() {
		fmt.Println("how are you?")
	})

	// ? Assigning functions to variables or storing them in data structures

	getRectangleAreaV3 := func(rectangleWidth int, rectangleLength int) int {
		return rectangleWidth * rectangleLength
	}

	myArrayOfGetRectangleAreaFunctions := []func(int, int) int{
		getRectangleAreaV1,
		func(rectangleWidth int, rectangleLength int) int {
			return rectangleWidth * rectangleLength
		},
	}

	getRectangleAreaFunction1 := myArrayOfGetRectangleAreaFunctions[0](3, 5)
	getRectangleAreaFunction2 := myArrayOfGetRectangleAreaFunctions[1](3, 5)

	simpleCalculator := map[string]func(int, int) int{
		"addition": addition,
		"subtraction": func(rectangleWidth int, rectangleLength int) int {
			return rectangleWidth - rectangleLength
		},
	}

	simpleCalculatorResult1 := simpleCalculator["addition"](3, 4)
	simpleCalculatorResult2 := simpleCalculator["subtraction"](35, 8)

	// ? Returning functions as values from other functions (closure)

	multiplyBy2 := multiplyV1(2)
	multiplyBy2Result := multiplyBy2(10) // 20

	multiplyBy3 := multiplyV2(3)
	multiplyBy3Result := multiplyBy3(10) // 30

	multiplyV3 := func(a int) func(b int) int {
		return func(b int) int {
			return a * b
		}
	}

	multiplyBy4 := multiplyV3(4)
	multiplyBy4Result := multiplyBy4(10) // 40

	fmt.Println("getRectangleAreaV2(3, 5):", getRectangleAreaV2(3, 5))
	fmt.Println("getRectangleAreaV3(3, 5):", getRectangleAreaV3(3, 5))
	fmt.Println("getRectangleAreaFunction1:", getRectangleAreaFunction1)
	fmt.Println("getRectangleAreaFunction2:", getRectangleAreaFunction2)
	fmt.Println("simpleCalculatorResult1:", simpleCalculatorResult1)
	fmt.Println("simpleCalculatorResult2:", simpleCalculatorResult2)
	fmt.Println("multiplyBy2Result:", multiplyBy2Result)
	fmt.Println("multiplyBy3Result:", multiplyBy3Result)
	fmt.Println("multiplyBy4Result:", multiplyBy4Result)
}
