package main

import (
	"encoding/json"
	"fmt"
)

const EMPTY_STRING = ""
const TAB = "    "

type Any interface{}
type Object map[string]Any

func prettyJsonStringify(anythingLikeJson Any) string {
	marshalledJson, err := json.MarshalIndent(anythingLikeJson, EMPTY_STRING, TAB)
	if err == nil {
		return string(marshalledJson)
	}

	return "undefined"
}

func nullishCoalescing(value Any, defaultValue Any) Any {
	if value == nil {
		return defaultValue
	} else {
		return value
	}
}

func main() {
	fmt.Println("\n// JavaScript-like Nullish Coalescing Operator (??) in Go")

	// There's no JavaScript-like Nullish Coalescing Operator (??) in Go.
	// But, we can create our own function to mimic it in Go.

	JSON_OBJECT := Object{
		"foo": Object{
			"bar": "baz",
		},
	}
	fmt.Println("JSON_OBJECT:", prettyJsonStringify(JSON_OBJECT))

	fmt.Println("// using JavaScript-like Nullish Coalescing Operator (??) function \"nullishCoalescing\"")

	fmt.Println("JSON_OBJECT?.foo?.bar ?? \"not found\":", nullishCoalescing(JSON_OBJECT["foo"].(Object)["bar"], "not found"))
	// JSON_OBJECT?.foo?.bar ?? "not found": baz
	fmt.Println("JSON_OBJECT?.foo?.baz ?? \"not found\":", nullishCoalescing(JSON_OBJECT["foo"].(Object)["baz"], "not found"))
	// JSON_OBJECT?.foo?.baz ?? "not found": not found

	fmt.Println("// using the Go way")

	foobar := JSON_OBJECT["foo"].(Object)["bar"]
	foobaz := JSON_OBJECT["foo"].(Object)["baz"]
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
