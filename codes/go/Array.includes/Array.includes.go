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
	if err == nil {
		return string(marshalledJson)
	}

	return "undefined"
}

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
		if (arrayItemIndex + 1) != len(anArray) {
			result = result + ", "
		}
	}
	result = result + "]"
	return result
}

func arrayIncludesV1(searchElement any, anArray array) bool {
	// JavaScript-like Array.includes() function
	elementFound := false
	for _, arrayItem := range anArray {
		isConditionMatch := arrayItem == searchElement
		if isConditionMatch == true {
			elementFound = true
			break
		}
	}
	return elementFound
}

func arrayIncludesV2(searchElement any, anArray array) bool {
	// JavaScript-like Array.includes() function
	elementFound := false
	for _, arrayItem := range anArray {
		if arrayItem == searchElement {
			elementFound = true
			break
		}
	}
	return elementFound
}

func arrayIncludesV3(searchElement any, anArray array) bool {
	// JavaScript-like Array.includes() function
	elementFound := false
	for _, arrayItem := range anArray {
		isConditionMatch := arrayItem == searchElement
		if isConditionMatch == true {
			elementFound = true
			return elementFound
		}
	}
	return elementFound
}

func arrayIncludesV4(searchElement any, anArray array) bool {
	// JavaScript-like Array.includes() function
	elementFound := false
	for _, arrayItem := range anArray {
		if arrayItem == searchElement {
			elementFound = true
			return elementFound
		}
	}
	return elementFound
}

func arrayIncludesV5(searchElement any, anArray array) bool {
	// JavaScript-like Array.includes() function
	for _, arrayItem := range anArray {
		isConditionMatch := arrayItem == searchElement
		if isConditionMatch == true {
			return true
		}
	}
	return false
}

func arrayIncludesV6(searchElement any, anArray array) bool {
	// JavaScript-like Array.includes() function
	for _, arrayItem := range anArray {
		if arrayItem == searchElement {
			return true
		}
	}
	return false
}

func main() {
	fmt.Println("\n// JavaScript-like Array.includes() in Go")

	myFriends := array{"Alisa", "Trivia"}
	fmt.Println("my friends:", prettyArrayOfPrimitives(myFriends))

	var name any
	var isMyFriend any

	fmt.Println("// using JavaScript-like Array.includes() function \"arrayIncludesV1\"")

	name = "Alisa"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV1(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Alisa": true

	name = "Trivia"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV1(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Trivia": true

	name = "Tony"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV1(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Tony": false

	name = "Ezekiel"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV1(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Ezekiel": false

	fmt.Println("// using JavaScript-like Array.includes() function \"arrayIncludesV2\"")

	name = "Alisa"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV2(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Alisa": true

	name = "Trivia"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV2(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Trivia": true

	name = "Tony"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV2(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Tony": false

	name = "Ezekiel"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV2(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Ezekiel": false

	fmt.Println("// using JavaScript-like Array.includes() function \"arrayIncludesV3\"")

	name = "Alisa"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV3(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Alisa": true

	name = "Trivia"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV3(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Trivia": true

	name = "Tony"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV3(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Tony": false

	name = "Ezekiel"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV3(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Ezekiel": false

	fmt.Println("// using JavaScript-like Array.includes() function \"arrayIncludesV4\"")

	name = "Alisa"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV4(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Alisa": true

	name = "Trivia"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV4(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Trivia": true

	name = "Tony"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV4(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Tony": false

	name = "Ezekiel"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV4(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Ezekiel": false

	fmt.Println("// using JavaScript-like Array.includes() function \"arrayIncludesV5\"")

	name = "Alisa"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV5(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Alisa": true

	name = "Trivia"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV5(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Trivia": true

	name = "Tony"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV5(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Tony": false

	name = "Ezekiel"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV5(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Ezekiel": false

	fmt.Println("// using JavaScript-like Array.includes() function \"arrayIncludesV6\"")

	name = "Alisa"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV6(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Alisa": true

	name = "Trivia"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV6(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Trivia": true

	name = "Tony"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV6(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Tony": false

	name = "Ezekiel"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV6(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Ezekiel": false
}
