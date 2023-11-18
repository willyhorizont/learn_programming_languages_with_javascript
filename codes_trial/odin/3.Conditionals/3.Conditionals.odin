package main

import "core:fmt"

main :: proc() {
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

    CORRECT_ANSWER :: 100

    my_answer: int
	my_age: int
	has_driving_license: bool
	can_drive: bool

    fmt.println("\n// basic conditional control flow\n", sep = "")

	my_age = 10
	fmt.println("my_age: ", my_age, sep = "")
	if (my_age > 24) {
		fmt.println("you are old", sep = "")
	} else if (my_age > 17) {
		fmt.println("you are young", sep = "")
	} else {
		fmt.println("you are under age", sep = "")
	}

	fmt.println("\n// equal to (==)\n", sep = "")

	my_answer = 100
	fmt.println("my_answer: ", my_answer, sep = "")
	fmt.println("CORRECT_ANSWER: ", CORRECT_ANSWER, sep = "")
	fmt.println("(my_answer == CORRECT_ANSWER): ", sep = "")
	if (my_answer == CORRECT_ANSWER) {
		fmt.println("Your answer is correct", sep = "")
	} else {
		fmt.println("Your answer is wrong", sep = "")
	}

	fmt.println("\n// not equal to (!=)\n", sep = "")

	my_answer = 25
	fmt.println("my_answer: ", my_answer, sep = "")
	fmt.println("CORRECT_ANSWER: ", CORRECT_ANSWER, sep = "")
	fmt.println("(my_answer != CORRECT_ANSWER): ", sep = "")
	if (my_answer != CORRECT_ANSWER) {
		fmt.println("Your answer is wrong", sep = "")
	} else {
		fmt.println("Your answer is correct", sep = "")
	}

	fmt.println("\n// greater than (>)\n", sep = "")

	my_age = 70
	fmt.println("my_age: ", my_age, sep = "")
	fmt.println("(my_age > 50): ", sep = "")
	if (my_age > 50) do fmt.println("You are old", sep = "")

	fmt.println("\n// less than (<)\n", sep = "")

	my_age = 16
	fmt.println("my_age: ", my_age, sep = "")
	fmt.println("(my_age < 20): ", sep = "")
	if (my_age < 20) do fmt.println("You are young", sep = "")

	fmt.println("\n// greater than or equal to (>=)\n", sep = "")

	my_age = 73
	fmt.println("my_age: ", my_age, sep = "")
	fmt.println("(my_age >= 65): ", sep = "")
	if (my_age >= 65) do fmt.println("You are allowed to retire", sep = "")

	fmt.println("\n// less than or equal to (<=)\n", sep = "")

	my_age = 14
	fmt.println("my_age: ", my_age, sep = "")
	fmt.println("(my_age <= 16): ", sep = "")
	if (my_age <= 16) do fmt.println("You are not allowed to drive", sep = "")

	fmt.println("\n// Logical AND (&&)\n", sep = "")

	my_age = 17
	fmt.println("my_age: ", my_age, sep = "")
	has_driving_license = false
	fmt.println("has_driving_license: ", has_driving_license, sep = "")
	fmt.println("((my_age >= 17) && (has_driving_license == true)): ", sep = "")
	if ((my_age >= 17) && (has_driving_license == true)) do fmt.println("You are allowed to drive", sep = "")
    else do fmt.println("You are not allowed to drive", sep = "")

	my_age = 17
	fmt.println("my_age: ", my_age, sep = "")
	has_driving_license = true
	fmt.println("has_driving_license: ", has_driving_license, sep = "")
	fmt.println("((my_age >= 17) && (has_driving_license == true)): ", sep = "")
	if ((my_age >= 17) && (has_driving_license == true)) do fmt.println("You are allowed to drive", sep = "")
    else do fmt.println("You are not allowed to drive", sep = "")

	fmt.println("\n// Logical OR (||)\n", sep = "")

	my_age = 2
	fmt.println("my_age: ", my_age, sep = "")
	fmt.println("((my_age <= 3) || (my_age >= 65)): ", sep = "")
	if ((my_age <= 3) || (my_age >= 65)) do fmt.println("You should stay home", sep = "")

	my_age = 89
	fmt.println("my_age: ", my_age, sep = "")
	fmt.println("((my_age <= 3) || (my_age >= 65)): ", sep = "")
	if ((my_age <= 3) || (my_age >= 65)) do fmt.println("You should stay home", sep = "")

	fmt.println("\n// Logical NOT (!)\n", sep = "")

	can_drive = false
	fmt.println("can_drive: ", can_drive, sep = "")
	fmt.println("!can_drive: ", !can_drive, sep = "")

	can_drive = true
	fmt.println("can_drive: ", can_drive, sep = "")
	fmt.println("!can_drive: ", !can_drive, sep = "")
}
