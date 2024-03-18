package main

import (
	"encoding/json"
	"fmt"
)

const EMPTY_STRING = ""
const TAB = "    "

// type any interface{}
type array []any
type object map[string]any

func prettyJsonStringify(anything any) string {
	marshalledJson, err := json.MarshalIndent(anything, EMPTY_STRING, TAB)
	if (err == nil) {
		return string(marshalledJson)
	}
	return "undefined"
}

func ternary(trueCondition bool, valueIfConditionIsTrue any, valueIfConditionIsFalse any) any {
	if (trueCondition == true) {
		return valueIfConditionIsTrue
	}
	return valueIfConditionIsFalse
}

func main() {
	fmt.Println("\n// Ternary Operator in Go")

	const CORRECT_ANSWER = "foo"
	fmt.Println("correct answer:", prettyJsonStringify(CORRECT_ANSWER))

	var myAnswer string

	fmt.Println("// using Ternary Operator function \"ternary\"")

	myAnswer = "bar"
	fmt.Println("my answer: \"" + myAnswer + "\"")
	fmt.Println("is my answer correct:", ternary((myAnswer == CORRECT_ANSWER), "correct!", "wrong!"))
	// is my answer correct: wrong!

	myAnswer = "foo"
	fmt.Println("my answer: \"" + myAnswer + "\"")
	fmt.Println("is my answer correct:", ternary((myAnswer == CORRECT_ANSWER), "correct!", "wrong!"))
	// is my answer correct: correct!
}
