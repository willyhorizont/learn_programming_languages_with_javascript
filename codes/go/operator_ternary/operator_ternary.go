package main

import (
	"encoding/json"
	"fmt"
)

const EMPTY_STRING = ""
const TAB = "    "

type Any interface{}
type Object map[string]Any

func prettyJsonStringify(anythingLikeJson Any) string {
	marshalledJson, err := json.MarshalIndent(anythingLikeJson, EMPTY_STRING, TAB)
	if err == nil {
		return string(marshalledJson)
	}

	return "undefined"
}

func ternaryOperator(conditionIsTrue bool, resultIfConditionIsTrue Any, resultIfConditionIsFalse Any) Any {
	if conditionIsTrue {
		return resultIfConditionIsTrue
	}
	return resultIfConditionIsFalse
}

func main() {
	fmt.Println("\n// Ternary Operator in Go")

	const CORRECT_ANSWER = "foo"
	fmt.Println("correct answer:", prettyJsonStringify(CORRECT_ANSWER))

	var myAnswer string

	print("-- using Ternary Operator function \"ternaryOperator\"")

	myAnswer = "bar"
	fmt.Println("my answer: \"" + myAnswer + "\"")
	fmt.Println("is my answer correct:", ternaryOperator((myAnswer == CORRECT_ANSWER), "correct!", "wrong!"))
	// is my answer correct: wrong!

	myAnswer = "foo"
	fmt.Println("my answer: \"" + myAnswer + "\"")
	fmt.Println("is my answer correct:", ternaryOperator((myAnswer == CORRECT_ANSWER), "correct!", "wrong!"))
	// is my answer correct: correct!

	print("-- using the Go way")

	myAnswer = "bar"
	fmt.Println("my answer: \"" + myAnswer + "\"")
	if myAnswer == CORRECT_ANSWER {
		fmt.Println("is my answer correct: correct!")
	} else {
		fmt.Println("is my answer correct: wrong!")
	}
	// is my answer correct: wrong!

	myAnswer = "foo"
	fmt.Println("my answer: \"" + myAnswer + "\"")
	if myAnswer == CORRECT_ANSWER {
		fmt.Println("is my answer correct: correct!")
	} else {
		fmt.Println("is my answer correct: wrong!")
	}
	// is my answer correct: correct!
}
