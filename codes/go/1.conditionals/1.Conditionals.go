package main

import (
	"fmt"
)

func main() {
	/*
	   Relational Operators / Comparison Operators:
	   equal to (==)
	   not equal to (!=)
	   greater than (>)
	   less than (<)
	   greater than or equal to (>=)
	   less than or equal to (<=)

	   Logical Operators:
	   Logical AND (&&)
	   Logical OR (||)
	   Logical NOT (!)
	*/
	CORRECT_ANSWER := 100

	var myAnswer int
	var myAge int
	var hasDrivingLicense bool
	var canDrive bool

	fmt.Println("\n// basic conditional control flow\n")

	myAge = 10
	fmt.Println("myAge:", myAge)
	if (myAge > 24) {
		fmt.Println("you are old")
	} else if (myAge > 17) {
		fmt.Println("you are young")
	} else {
		fmt.Println("you are under age")
	}

	fmt.Println("\n// equal to (==)\n")

	myAnswer = 100
	fmt.Println("myAnswer:", myAnswer)
	fmt.Println("CORRECT_ANSWER:", CORRECT_ANSWER)
	fmt.Println("(myAnswer == CORRECT_ANSWER):")
	if (myAnswer == CORRECT_ANSWER) {
		fmt.Println("Your answer is correct")
	} else {
		fmt.Println("Your answer is wrong")
	}

	fmt.Println("\n// not equal to (!=)\n")

	myAnswer = 25
	fmt.Println("myAnswer:", myAnswer)
	fmt.Println("CORRECT_ANSWER:", CORRECT_ANSWER)
	fmt.Println("(myAnswer != CORRECT_ANSWER):")
	if (myAnswer != CORRECT_ANSWER) {
		fmt.Println("Your answer is wrong")
	} else {
		fmt.Println("Your answer is correct")
	}

	fmt.Println("\n// greater than (>)\n")

	myAge = 70
	fmt.Println("myAge:", myAge)
	fmt.Println("(myAge > 50):")
	if (myAge > 50) {
		fmt.Println("You are old")
	}

	fmt.Println("\n// less than (<)\n")

	myAge = 16
	fmt.Println("myAge:", myAge)
	fmt.Println("(myAge < 20):")
	if (myAge < 20) {
		fmt.Println("You are young")
	}

	fmt.Println("\n// greater than or equal to (>=)\n")

	myAge = 73
	fmt.Println("myAge:", myAge)
	fmt.Println("(myAge >= 65):")
	if (myAge >= 65) {
		fmt.Println("You are allowed to retire")
	}

	fmt.Println("\n// less than or equal to (<=)\n")

	myAge = 14
	fmt.Println("myAge:", myAge)
	fmt.Println("(myAge <= 16):")
	if (myAge <= 16) {
		fmt.Println("You are not allowed to drive")
	}

	fmt.Println("\n// Logical AND (&&)\n")

	myAge = 17
	fmt.Println("myAge:", myAge)
	hasDrivingLicense = false
	fmt.Println("hasDrivingLicense:", hasDrivingLicense)
	fmt.Println("((myAge >= 17) && (hasDrivingLicense == true)):")
	if ((myAge >= 17) && (hasDrivingLicense == true)) {
		fmt.Println("You are allowed to drive")
	} else {
		fmt.Println("You are not allowed to drive")
	}

	myAge = 17
	fmt.Println("myAge:", myAge)
	hasDrivingLicense = true
	fmt.Println("hasDrivingLicense:", hasDrivingLicense)
	fmt.Println("((myAge >= 17) && (hasDrivingLicense == true)):")
	if ((myAge >= 17) && (hasDrivingLicense == true)) {
		fmt.Println("You are allowed to drive")
	} else {
		fmt.Println("You are not allowed to drive")
	}

	fmt.Println("\n// Logical OR (||)\n")

	myAge = 2
	fmt.Println("myAge:", myAge)
	fmt.Println("((myAge <= 3) || (myAge >= 65)):")
	if ((myAge <= 3) || (myAge >= 65)) {
		fmt.Println("You should stay home")
	}

	myAge = 89
	fmt.Println("myAge:", myAge)
	fmt.Println("((myAge <= 3) || (myAge >= 65)):")
	if ((myAge <= 3) || (myAge >= 65)) {
		fmt.Println("You should stay home")
	}

	fmt.Println("\n// Logical NOT (!)\n")

	canDrive = false
	fmt.Println("canDrive:", canDrive)
	fmt.Println("!canDrive:", !canDrive)

	canDrive = true
	fmt.Println("canDrive:", canDrive)
	fmt.Println("!canDrive:", !canDrive)
}
