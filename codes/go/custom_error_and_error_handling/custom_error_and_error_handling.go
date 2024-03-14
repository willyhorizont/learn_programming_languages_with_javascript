package main

import (
	"errors"
	"fmt"
)

func giveMeRespect(parameter string) (string, error) {
	if (parameter != "respect") {
		return "", errors.New("You should give me \"respect\"!")
	}
	return "Thank you for giving me \"respect\"!", nil
}

func main() {
	fmt.Println("\n// Custom Error and Error Handling in Go")

	// Error Handling
	response, anError := giveMeRespect("boo!")
	if (anError == nil) {
		fmt.Println(response)
	} else {
		fmt.Println(anError)
	}
	fmt.Println("I'm sorry!")
}
