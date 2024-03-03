package main

import (
	"fmt"
)

// ? < function statement or function declaration

func getRectangleAreaV1(rectangleWidth int, rectangleLength int) int {
	return (rectangleWidth * rectangleLength)
}
// call the function example: getRectangleAreaV1(7, 5)

// ? function statement or function declaration />



// ? < Passing functions as arguments to other functions

func sayHellloV1(callbackFunction func()) {
	fmt.Println("hello")
	callbackFunction()
}

func sayHowAreYouV1() {
	fmt.Println("how are you?")
}

// ? Passing functions as arguments to other functions />



func addition(a int, b int) int {
	return (a + b)
}



// ? < Returning functions as values from other functions

func multiplyV1(a int) func(b int) int {
	multiplyBy := func(b int) int {
		return (a * b)
	}
	return multiplyBy
}

func multiplyV2(a int) func(b int) int {
	return func(b int) int {
		return (a * b)
	}
}

// ? Returning functions as values from other functions />



func main() {
	// ? function expression

	getRectangleAreaV2 := func(rectangleWidth int, rectangleLength int) int {
		return (rectangleWidth * rectangleLength)
	}
	// call the function example: getRectangleAreaV2(7, 5)

	// ? anonymous function

	// func(rectangleWidth int, rectangleLength int) int {
	// 	   return (rectangleWidth * rectangleLength)
	// }

	// ? Passing functions as arguments to other functions

	sayHellloV1(sayHowAreYouV1)

	sayHellloV1(func() {
		fmt.Println("how are you?")
	})

	sayHellloV2 := func(callbackFunction func()) {
		fmt.Println("hello")
		callbackFunction()
	}
	
	sayHowAreYouV2 := func() {
		fmt.Println("how are you?")
	}

	sayHellloV2(sayHowAreYouV2)

	sayHellloV2(func() {
		fmt.Println("how are you?")
	})

	// ? Assigning functions to variables or storing them in data structures

	getRectangleAreaV2Copy := func(rectangleWidth int, rectangleLength int) int {
		return (rectangleWidth * rectangleLength)
	}

	myArrayOfGetRectangleAreaFunctions := []func(int, int) int{
		getRectangleAreaV1,
		func(rectangleWidth int, rectangleLength int) int {
			return (rectangleWidth * rectangleLength)
		},
	}
	getRectangleAreaFunctionResult1 := myArrayOfGetRectangleAreaFunctions[0](7, 5)
	getRectangleAreaFunctionResult2 := myArrayOfGetRectangleAreaFunctions[1](7, 5)

	simpleCalculator := map[string]func(int, int) int{
		"addition": addition,
		"subtraction": func(rectangleWidth int, rectangleLength int) int {
			return (rectangleWidth - rectangleLength)
		},
	}
	simpleCalculatorResult1 := simpleCalculator["addition"](9, 3)
	simpleCalculatorResult2 := simpleCalculator["subtraction"](35, 8)

	// ? Returning functions as values from other functions

	multiplyBy2 := multiplyV1(2)
	multiplyBy2Result := multiplyBy2(10) // 20

	multiplyBy3 := multiplyV2(3)
	multiplyBy3Result := multiplyBy3(10) // 30

	multiplyV3 := func(a int) func(b int) int {
		return func(b int) int {
			return (a * b)
		}
	}

	multiplyBy4 := multiplyV3(4)
	multiplyBy4Result := multiplyBy4(10) // 40

	fmt.Println("getRectangleAreaV2(7, 5):", getRectangleAreaV2(7, 5))
	fmt.Println("getRectangleAreaV2Copy(7, 5):", getRectangleAreaV2Copy(7, 5))
	fmt.Println("getRectangleAreaFunctionResult1:", getRectangleAreaFunctionResult1)
	fmt.Println("getRectangleAreaFunctionResult2:", getRectangleAreaFunctionResult2)
	fmt.Println("simpleCalculatorResult1:", simpleCalculatorResult1)
	fmt.Println("simpleCalculatorResult2:", simpleCalculatorResult2)
	fmt.Println("multiplyBy2Result:", multiplyBy2Result)
	fmt.Println("multiplyBy3Result:", multiplyBy3Result)
	fmt.Println("multiplyBy4Result:", multiplyBy4Result)
}
