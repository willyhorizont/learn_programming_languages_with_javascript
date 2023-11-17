package main

import (
	"fmt"
)

const EMPTY_STRING = ""
const TAB = "    "

// type any interface{}
type array []any
type object map[string]any

func main() {
	friend := object{
		"name":    "Alisa",
		"country": "Finland",
		"age":     25,
	}

	fmt.Println("friend, get country:", friend["country"])
	// friend, get country: Finland

	// iterate over and get each key-value pair
	for objectKey, objectValue := range friend {
		fmt.Println("friend, for loop, key:", fmt.Sprint(objectKey), "\b, value:", fmt.Sprint(objectValue))
	}
	// fruits, for loop, key: 0, value: apple
	// fruits, for loop, key: 1, value: mango
	// fruits, for loop, key: 2, value: orange

	// iterate over and get each key-value pair and iteration index
	iterationIndex := 0
	for objectKey, objectValue := range friend {
		fmt.Println("friend, for loop, index:", iterationIndex, "\b, key:", fmt.Sprint(objectKey), "\b, value:", fmt.Sprint(objectValue))
		iterationIndex += 1
	}
	// friend, for loop, index: 0 ,key: name, value: Alisa
	// friend, for loop, index: 1 ,key: country, value: Finland
	// friend, for loop, index: 2 ,key: age, value: 25
}
