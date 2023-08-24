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

func spreadSyntaxObject(args ...Any) Object {
	var newObject = make(Object)
	for _, arg := range args {
		argType := reflect.TypeOf(arg).Kind()
		if argType == reflect.Map {
			for objectKey, objectValue := range arg.(Object) {
				newObject[objectKey] = objectValue
			}
		}
		if argType == reflect.Slice {
			for arrayItemIndex, arrayItem := range arg.([]Any) {
				newObject[prettyJsonStringify(arrayItemIndex)] = arrayItem
			}
		}
	}
	return newObject
}

func spreadSyntaxArray(arrayOfArray ...[]Any) []Any {
	var newArray = []Any{}
	for _, arrayOfArrayItem := range arrayOfArray {
		newArray = append(newArray, arrayOfArrayItem...)
	}
	return newArray
}

func main() {
	fmt.Println("\n// Spread Syntax in Go Slice")

	myFruitsInFridge := []Any{"apple", "mango", "orange"}
	fmt.Println("my fruits in fridge: ", prettySliceOfPrimitives(myFruitsInFridge))

	myFruitsFromGroceryStore := []Any{"melon", "banana"}
	fmt.Println("my fruits from grocery store: ", prettySliceOfPrimitives(myFruitsFromGroceryStore))

	myFruits := spreadSyntaxArray(myFruitsInFridge, myFruitsFromGroceryStore)
	fmt.Println("my fruits: ", prettySliceOfPrimitives(myFruits))
	// my fruits: ["apple", "mango", "orange", "melon", "banana"]

	fmt.Println("\n// Spread Syntax in Go Slice of Maps")

	generalCar := Object{
		"wheels": 4,
		"tires":  4,
	}
	fmt.Println("general car: ", prettyJsonStringify(generalCar))

	minivanCar := spreadSyntaxObject(generalCar, Object{"doors": 4})
	fmt.Println("minivan car: ", prettyJsonStringify(minivanCar))
	// minivan car: {
	//     "wheels": 4,
	//     "tires": 4,
	//     "doors": 4
	// }

	superCar := spreadSyntaxObject(generalCar, Object{"doors": 2})
	fmt.Println("super car: ", prettyJsonStringify(superCar))
	// super car: {
	//     "wheels": 4,
	//     "tires": 4,
	//     "doors": 2
	// }
}
