package main

import (
	"errors"
	"fmt"
)

func giveMeRespect(argument string) (string, error) {
    if (argument != "respect") {
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
