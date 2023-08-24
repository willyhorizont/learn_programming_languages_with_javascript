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

func main() {
	fmt.Println("\n// Ternary Operator in GO")

	const CORRECT_ANSWER = "foo"
	fmt.Println("correct answer:", prettyJsonStringify(CORRECT_ANSWER))

	var myAnswer string
	var isMyAnswerCorrect string

	myAnswer = "hello"
	fmt.Println("my answer: \"" + myAnswer + "\"")
	if myAnswer == CORRECT_ANSWER {
		isMyAnswerCorrect = "congrats!"
	} else {
		isMyAnswerCorrect = "wrong answer!"
	}
	fmt.Println("result: " + isMyAnswerCorrect)
	// result: wrong answer!

	myAnswer = "foo"
	fmt.Println("my answer: \"" + myAnswer + "\"")
	if myAnswer == CORRECT_ANSWER {
		isMyAnswerCorrect = "congrats!"
	} else {
		isMyAnswerCorrect = "wrong answer!"
	}
	fmt.Println("result: " + isMyAnswerCorrect)
	// result: congrats!
}
