package main

import (
	"errors"
	"fmt"
)

func giveMeRespect(parameter string) (string, error) {
    if (parameter != "respect") {
        return "", errors.New("Error: You should give me \"respect\"!")
    }
    return "Thank you for giving me \"respect\"!", nil
}

func main() {
    fmt.Println("\n// Custom Error and Error Handling in Go")

    // Error Handling
    response, anErrorMessage := giveMeRespect("boo!")
    if (anErrorMessage == nil) {
        fmt.Println(response)
    } else {
        fmt.Println(anErrorMessage)
    }
    fmt.Println("I'm sorry!")
}
