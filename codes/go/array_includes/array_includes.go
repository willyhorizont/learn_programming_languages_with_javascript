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

func prettyJsonStringify(anything any) string {
	marshalledJson, err := json.MarshalIndent(anything, EMPTY_STRING, TAB)
	if (err == nil) {
		return string(marshalledJson)
	}
	return "undefined"
}

func prettyArrayOfPrimitives(anArray array) string {
	result := "["
	for arrayItemIndex, arrayItem := range anArray {
		if (arrayItem == nil) {
			result += "nil"
		}
		if (arrayItem != nil) {
			switch arrayItemType := reflect.TypeOf(arrayItem).Kind(); arrayItemType {
			case reflect.String:
				result += "\"" + arrayItem.(string) + "\""
			case reflect.Int, reflect.Int8, reflect.Int16, reflect.Int32, reflect.Int64, reflect.Uint, reflect.Uint8, reflect.Uint16, reflect.Uint32, reflect.Uint64, reflect.Float32, reflect.Float64, reflect.Complex64, reflect.Complex128:
				result += fmt.Sprint(arrayItem)
			case reflect.Bool:
				if (arrayItem.(bool) == true) {
					result += "true"
				} else {
					result += "false"
				}
			case reflect.Invalid:
				result += "nil"
			default:
				continue
			}
		}
		if ((arrayItemIndex + 1) != len(anArray)) {
			result = result + ", "
		}
	}
	result = result + "]"
	return result
}

func arrayIncludesV1(searchElement any, anArray array) bool {
	// JavaScript-like Array.includes() function
	isElementFound := false
	for _, arrayItem := range anArray {
		if (arrayItem == searchElement) {
			isElementFound = true
			break
		}
	}
	return isElementFound
}

func arrayIncludesV2(searchElement any, anArray array) bool {
	// JavaScript-like Array.includes() function
	for _, arrayItem := range anArray {
		if (arrayItem == searchElement) {
			return true
		}
	}
	return false
}

func main() {
	fmt.Println("\n// JavaScript-like Array.includes() in Go")

	myFriends := array{"Alisa", "Trivia"}
	fmt.Println("my friends:", prettyArrayOfPrimitives(myFriends))

	var aName any
	var isMyFriend any

	fmt.Println("// using JavaScript-like Array.includes() function \"arrayIncludesV1\"")

	aName = "Alisa"
	isMyFriend = arrayIncludesV1(aName, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(aName) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Alisa": true

	aName = "Trivia"
	isMyFriend = arrayIncludesV1(aName, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(aName) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Trivia": true

	aName = "Tony"
	isMyFriend = arrayIncludesV1(aName, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(aName) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Tony": false

	aName = "Ezekiel"
	isMyFriend = arrayIncludesV1(aName, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(aName) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Ezekiel": false

	fmt.Println("// using JavaScript-like Array.includes() function \"arrayIncludesV2\"")

	aName = "Alisa"
	isMyFriend = arrayIncludesV2(aName, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(aName) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Alisa": true

	aName = "Trivia"
	isMyFriend = arrayIncludesV2(aName, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(aName) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Trivia": true

	aName = "Tony"
	isMyFriend = arrayIncludesV2(aName, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(aName) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Tony": false

	aName = "Ezekiel"
	isMyFriend = arrayIncludesV2(aName, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(aName) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Ezekiel": false
}
