package main

import (
	"encoding/json"
	"fmt"
	"reflect"
)

const EMPTY_STRING = ""
const TAB = "    "

// type any interface{}
type array []any
type object map[string]any

func prettyArrayOfPrimitives(anArray array) string {
	result := "["
	for arrayItemIndex, arrayItem := range anArray {
		switch arrayItemType := reflect.TypeOf(arrayItem).Kind(); arrayItemType {
		case reflect.String:
			result += "\"" + arrayItem.(string) + "\""
		case reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64, reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64, reflect.Float32, reflect.Float64, reflect.Complex64, reflect.Complex128:
			result += fmt.Sprint(arrayItem)
		default:
			continue
		}
		if ((arrayItemIndex + 1) != len(anArray)) {
			result = result + ", "
		}
	}
	result = result + "]"
	return result
}

func prettyJsonStringify(anything any) string {
	marshalledJson, err := json.MarshalIndent(anything, EMPTY_STRING, TAB)
	if err == nil {
		return string(marshalledJson)
	}

	return "undefined"
}

func main() {
	// Array in Go

	fruits := array{"apple", "mango", "orange"}
	fmt.Println("fruits:", prettyArrayOfPrimitives(fruits))

	fmt.Println("fruits, length:", fmt.Sprint(len(fruits)))
	// fruits, length: 3

	fmt.Println("fruits, get mango:", fmt.Sprint(fruits[1]))
	// fruits, get mango: mango

	fmt.Println("fruits, first element:", fmt.Sprint(fruits[0]))
	// fruits, first element: apple

	fmt.Println("fruits, last element:", fmt.Sprint(fruits[len(fruits)-1]))
	// fruits, last element: orange

	for arrayItemIndex, arrayItem := range fruits {
		fmt.Println("fruits, for loop, index:", fmt.Sprint(arrayItemIndex), "\b, value:", fmt.Sprint(arrayItem))
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
	fmt.Println("products:", prettyJsonStringify(products))

	for arrayItemIndex, arrayItem := range products {
		for objectKey, objectValue := range arrayItem.(object) {
			fmt.Println("products, loop, index:", fmt.Sprint(arrayItemIndex), "\b, key:", fmt.Sprint(objectKey), "\b, value:", fmt.Sprint(objectValue))
		}
	}
	// products, loop, index: 0, key: id, value: P1
	// products, loop, index: 0, key: name, value: bubble gum
	// products, loop, index: 1, key: id, value: P2
	// products, loop, index: 1, key: name, value: potato chips
}