package main

import (
	"encoding/json"
	"fmt"
	"reflect"
)

const EMPTY_STRING = ""
const TAB = "    "

type Any interface{}

func prettyJsonStringify(anything Any) string {
	marshalledJson, err := json.MarshalIndent(anything, EMPTY_STRING, TAB)
	if err == nil {
		return string(marshalledJson)
	}

	return "undefined"
}

func prettyArrayOfPrimitives(anArray []Any) string {
	result := "["
	for arrayItemIndex, arrayItem := range anArray {
		arrayItemType := reflect.TypeOf(arrayItem).Kind()
		if arrayItemType != reflect.Float32 &&
			arrayItemType != reflect.Float64 &&
			arrayItemType != reflect.Int &&
			arrayItemType != reflect.Int8 &&
			arrayItemType != reflect.Int16 &&
			arrayItemType != reflect.Int32 &&
			arrayItemType != reflect.Int64 &&
			arrayItemType != reflect.Uint &&
			arrayItemType != reflect.Uint8 &&
			arrayItemType != reflect.Uint16 &&
			arrayItemType != reflect.Uint32 &&
			arrayItemType != reflect.Uint64 &&
			arrayItemType != reflect.String {
			continue
		}
		if arrayItemType == reflect.String {
			stringArrayItem := arrayItem.(string)
			result = result + "\"" + stringArrayItem + "\""
		}
		if arrayItemType == reflect.Float32 {
			stringArrayItem := fmt.Sprint(arrayItem.(float32))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Float64 {
			stringArrayItem := fmt.Sprint(arrayItem.(float64))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Int {
			stringArrayItem := fmt.Sprint(arrayItem.(int))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Int8 {
			stringArrayItem := fmt.Sprint(arrayItem.(int8))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Int16 {
			stringArrayItem := fmt.Sprint(arrayItem.(int16))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Int32 {
			stringArrayItem := fmt.Sprint(arrayItem.(int32))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Int64 {
			stringArrayItem := fmt.Sprint(arrayItem.(int64))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Uint {
			stringArrayItem := fmt.Sprint(arrayItem.(uint))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Uint8 {
			stringArrayItem := fmt.Sprint(arrayItem.(uint8))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Uint16 {
			stringArrayItem := fmt.Sprint(arrayItem.(uint16))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Uint32 {
			stringArrayItem := fmt.Sprint(arrayItem.(uint32))
			result = result + stringArrayItem
		}
		if arrayItemType == reflect.Int64 {
			stringArrayItem := fmt.Sprint(arrayItem.(uint64))
			result = result + stringArrayItem
		}
		if (arrayItemIndex + 1) != len(anArray) {
			result = result + ", "
		}
	}
	result = result + "]"
	return result
}

func arrayIncludesV1(searchElement Any, anArray []Any) bool {
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

func arrayIncludesV2(searchElement Any, anArray []Any) bool {
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

func arrayIncludesV3(searchElement Any, anArray []Any) bool {
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

func arrayIncludesV4(searchElement Any, anArray []Any) bool {
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

func arrayIncludesV5(searchElement Any, anArray []Any) bool {
	// JavaScript-like Array.includes() function
	for _, arrayItem := range anArray {
		isConditionMatch := arrayItem == searchElement
		if isConditionMatch == true {
			return true
		}
	}
	return false
}

func arrayIncludesV6(searchElement Any, anArray []Any) bool {
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

	myFriends := []Any{"Alisa", "Trivia"}
	fmt.Println("my friends:", prettyArrayOfPrimitives(myFriends))

	var name Any
	var isMyFriend Any

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
