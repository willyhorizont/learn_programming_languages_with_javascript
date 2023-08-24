package main

import (
	"encoding/json"
	"fmt"
	"reflect"
	"strings"
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

func arrayEvery(callbackFunction func(Any, int, []Any) bool, anArray []Any) bool {
	// JavaScript-like Array.every() function
	for arrayItemIndex, arrayItem := range anArray {
		if callbackFunction(arrayItem, arrayItemIndex, anArray) == false {
			return false
		}
	}
	return true
}

func prettySliceOfPrimitives(anArray []Any) string {
	isNotSliceOfPrimitives := arrayEvery(func(something Any, _ int, _ []Any) bool {
		somethingType := reflect.TypeOf(something).Kind()
		return somethingType != reflect.Int && somethingType != reflect.Int8 && somethingType != reflect.Int16 && somethingType != reflect.Int32 && somethingType != reflect.Int64 && somethingType != reflect.String && somethingType != reflect.Bool && somethingType != reflect.Float32 && somethingType != reflect.Float64
	}, anArray)
	if isNotSliceOfPrimitives {
		return "undefined"
	}
	stringSlice := []string{}
	for arrayItemIndex, arrayItem := range anArray {
		arrayItemType := reflect.TypeOf(arrayItem).Kind()
		if arrayItemType == reflect.Float32 {
			stringArrayItem := fmt.Sprint(arrayItem.(float32))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Float64 {
			stringArrayItem := fmt.Sprint(arrayItem.(float64))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Int {
			stringArrayItem := fmt.Sprint(arrayItem.(int))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Int8 {
			stringArrayItem := fmt.Sprint(arrayItem.(int8))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Int16 {
			stringArrayItem := fmt.Sprint(arrayItem.(int16))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Int32 {
			stringArrayItem := fmt.Sprint(arrayItem.(int32))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Int64 {
			stringArrayItem := fmt.Sprint(arrayItem.(int64))
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		if arrayItemType == reflect.Bool {
			stringArrayItem := prettyJsonStringify(arrayItem)
			if arrayItemIndex != len(anArray)-1 {
				stringArrayItem += ", "
			}
			stringSlice = append(stringSlice, stringArrayItem)
			continue
		}
		stringArrayItem := "\"" + arrayItem.(string) + "\""
		if arrayItemIndex != len(anArray)-1 {
			stringArrayItem += ", "
		}
		stringSlice = append(stringSlice, stringArrayItem)
	}
	return "[" + strings.Join(stringSlice, EMPTY_STRING) + "]"
}

func arrayIncludesV1(searchElement Any, anArray []Any) bool {
	// JavaScript-like Array.includes() function
	elementFound := false
	for _, arrayItem := range anArray {
		isConditionMatch := arrayItem == searchElement
		if isConditionMatch {
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
		if isConditionMatch {
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
			return elementFound
		}
	}
	return elementFound
}

func arrayIncludesV5(searchElement Any, anArray []Any) bool {
	// JavaScript-like Array.includes() function
	for _, arrayItem := range anArray {
		isConditionMatch := arrayItem == searchElement
		if isConditionMatch {
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
	fmt.Println("\n// JavaScript-like Array.includes() in GO")

	myFriends := []Any{"Alisa", "Trivia"}
	fmt.Println("my friends:", prettySliceOfPrimitives(myFriends))

	var name Any
	var isMyFriend Any

	fmt.Println("// using JavaScript-like Array.includes() function \"arrayIncludesV1\"")

	name = "Alisa"
	fmt.Println("name: " + prettyJsonStringify(name))
	isMyFriend = arrayIncludesV1(name, myFriends)
	fmt.Println("is my friends includes " + prettyJsonStringify(name) + ": " + prettyJsonStringify(isMyFriend))
	// is my friends includes "Alisa": true

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
