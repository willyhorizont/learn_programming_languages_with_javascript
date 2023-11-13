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
	// Array in Go

	fruits := array{"apple", "mango", "orange"}

	fmt.Println(strings.Join([]string{"fruits, length:", fmt.Sprint(len(fruits))}, ""))
	// fruits, length: 3

	for arrayItemIndex, arrayItem := range fruits {
		fmt.Println(strings.Join([]string{"fruits, for loop, index:", fmt.Sprint(arrayItemIndex), ", value:", fmt.Sprint(arrayItem)}, ""))
	}
	// fruits, for loop, index: 0, value: apple
	// fruits, for loop, index: 1, value: mango
	// fruits, for loop, index: 2, value: orange

	// Array of Objects in Go

	products := array{
		object{
			"id":   "P1",
			"name": "bubble gum",
		},
		object{
			"id":   "P2",
			"name": "potato chips",
		},
	}

	fmt.Println("products, length:", len(products))
	// products, length: 2

	for arrayItemIndex, arrayItem := range products {
		for objectKey, objectValue := range arrayItem.(object) {
			fmt.Println(strings.Join([]string{"products, loop, index: ", fmt.Sprint(arrayItemIndex), ", key: ", fmt.Sprint(objectKey), ", value: ", fmt.Sprint(objectValue)}, ""))
		}
	}
	// products, loop, index: 0, key: id, value: P1
	// products, loop, index: 0, key: name, value: bubble gum
	// products, loop, index: 1, key: id, value: P2
	// products, loop, index: 1, key: name, value: potato chips
}
