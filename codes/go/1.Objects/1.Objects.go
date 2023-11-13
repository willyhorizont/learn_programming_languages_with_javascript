package main

import (
	"fmt"
	"strings"
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

	// iterate over and get each key-value pair
	for objectKey, objectValue := range friend {
		fmt.Println(strings.Join([]string{"friend, for loop, key:", fmt.Sprint(objectKey), ", value:", fmt.Sprint(objectValue)}, ""))
	}
	// fruits, for loop, key: 0, value: apple
	// fruits, for loop, key: 1, value: mango
	// fruits, for loop, key: 2, value: orange
}
