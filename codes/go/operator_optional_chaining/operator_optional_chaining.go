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

func main() {
	// There's no JavaScript-like Optional Chaining Operator (?.) in GO.
	// But, we don't need that in GO.

	fmt.Println("\n// JavaScript-like Optional Chaining Operator (?.) in GO")

	JSON_OBJECT := Object{
		"foo": Object{
			"bar": "baz",
		},
	}
	fmt.Println("JSON_OBJECT:", prettyJsonStringify(JSON_OBJECT))

	fmt.Println("JSON_OBJECT?.foo?.bar:", prettyJsonStringify(JSON_OBJECT["foo"].(Object)["bar"]))
	// JSON_OBJECT?.foo?.bar: "baz"
	fmt.Println("JSON_OBJECT?.foo?.baz:", prettyJsonStringify(JSON_OBJECT["foo"].(Object)["baz"]))
	// JSON_OBJECT?.foo?.baz: null
}
