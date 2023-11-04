package main

import "fmt"

const EMPTY_STRING = ""
const TAB = "    "

type Any interface{}
type Object map[string]Any

func main() {
	myFruitsInFridge := []Any{"apple", "mango", "orange"}

	fmt.Println("array length:", len(myFruitsInFridge))

	for arrayItemIndex, _ := range myFruitsInFridge {
		fmt.Println(arrayItemIndex)
	}

	// array length: 3
	// 0
	// 1
	// 2
}
