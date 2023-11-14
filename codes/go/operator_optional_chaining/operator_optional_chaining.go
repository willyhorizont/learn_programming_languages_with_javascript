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
	if err == nil {
		return string(marshalledJson)
	}

	return "undefined"
}

func main() {
	fmt.Println("\n// JavaScript-like Optional Chaining Operator (?.) in Go")

	// There's no JavaScript-like Optional Chaining Operator (?.) in Go.
	// But, we don't need that in Go.

	JSON_OBJECT := object{
		"foo": object{
			"bar": "baz",
		},
	}
	fmt.Println("JSON_OBJECT:", prettyJsonStringify(JSON_OBJECT))

	fmt.Println("JSON_OBJECT?.foo?.bar:", prettyJsonStringify(JSON_OBJECT["foo"].(object)["bar"]))
	// JSON_OBJECT?.foo?.bar: "baz"
	fmt.Println("JSON_OBJECT?.foo?.baz:", prettyJsonStringify(JSON_OBJECT["foo"].(object)["baz"]))
	// JSON_OBJECT?.foo?.baz: null
}
