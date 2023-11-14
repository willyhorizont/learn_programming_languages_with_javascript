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

func nullishCoalescing(anything any, defaultValue any) any {
	if anything == nil {
		return defaultValue
	} else {
		return anything
	}
}

func main() {
	fmt.Println("\n// JavaScript-like Nullish Coalescing Operator (??) in Go")

	// There's no JavaScript-like Nullish Coalescing Operator (??) in Go.
	// But, we can create our own function to mimic it in Go.

	JSON_OBJECT := object{
		"foo": object{
			"bar": "baz",
		},
	}
	fmt.Println("JSON_OBJECT:", prettyJsonStringify(JSON_OBJECT))

	fmt.Println("// using JavaScript-like Nullish Coalescing Operator (??) function \"nullishCoalescing\"")

	fmt.Println("JSON_OBJECT?.foo?.bar ?? \"not found\":", nullishCoalescing(JSON_OBJECT["foo"].(object)["bar"], "not found"))
	// JSON_OBJECT?.foo?.bar ?? "not found": baz
	fmt.Println("JSON_OBJECT?.foo?.baz ?? \"not found\":", nullishCoalescing(JSON_OBJECT["foo"].(object)["baz"], "not found"))
	// JSON_OBJECT?.foo?.baz ?? "not found": not found

	fmt.Println("// using the Go way")

	foobar := JSON_OBJECT["foo"].(object)["bar"]
	foobaz := JSON_OBJECT["foo"].(object)["baz"]
	if foobar == nil {
		foobar = "not found"
	}
	if foobaz == nil {
		foobaz = "not found"
	}
	fmt.Println("JSON_OBJECT?.foo?.bar ?? \"not found\":", foobar)
	// JSON_OBJECT?.foo?.bar ?? "not found": baz
	fmt.Println("JSON_OBJECT?.foo?.baz ?? \"not found\":", foobaz)
	// JSON_OBJECT?.foo?.baz ?? "not found": not found
}
