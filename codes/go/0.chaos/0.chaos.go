package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"reflect"
)

const EMPTY_STRING = ""
const TAB = "    "

type Any interface{}
type Object map[string]Any

func prettyJsonStringifyV1(anArray []Any) string {
	marshalledJson, err := json.Marshal(anArray)
	if err == nil {
		marshalledIndentedJson := &bytes.Buffer{}
		marshalledIndentedJsonSource := []byte(marshalledJson)
		marshalledIndentedJsonError := json.Indent(marshalledIndentedJson, marshalledIndentedJsonSource, EMPTY_STRING, TAB)

		if marshalledIndentedJsonError == nil {
			return marshalledIndentedJson.String()
		}

		return EMPTY_STRING
	}

	return EMPTY_STRING
}

func prettyJsonStringifyV2(anArray []Any) string {
	marshalledJson, err := json.MarshalIndent(anArray, EMPTY_STRING, TAB)
	if err == nil {
		return string(marshalledJson)
	}

	return EMPTY_STRING
}

func spreadOperator(arrayOfAnything ...Any) Any {
	arrayItemType := reflect.TypeOf(arrayOfAnything).Kind()
	if arrayItemType == reflect.Slice {
		return "ASD"
	}
	if arrayItemType == reflect.Map {
		newObject := make(Object)
		for _, object := range arrayOfAnything {
			for objectKey, objectValue := range object.(Object) {
				newObject[objectKey] = objectValue
			}
		}
		return newObject
	}
	return nil
}

func prettyJsonStringify(anythingLikeJson Any) string {
	marshalledJson, err := json.MarshalIndent(anythingLikeJson, EMPTY_STRING, TAB)
	if err == nil {
		return string(marshalledJson)
	}

	return "undefined"
}

func mergeMaps(arrayOfObjects ...Object) Object {
	newObject := make(Object)
	for _, anObject := range arrayOfObjects {
		for objectKey, objectValue := range anObject {
			newObject[objectKey] = objectValue
		}
	}
	return newObject
}

func spreadOperatorObjectBackup(arrayOfObjects ...Object) Object {
	var newObject = make(Object)
	for _, anObject := range arrayOfObjects {
		for objectKey, objectValue := range anObject {
			newObject[objectKey] = objectValue
		}
	}
	return newObject
}

func spreadOperatorObject(args ...Any) Object {
	var newObject = make(Object)
	for _, arg := range args {
		argType := reflect.TypeOf(arg).Kind()
		if argType == reflect.Map {
			for objectKey, objectValue := range arg.(Object) {
				newObject[objectKey] = objectValue
			}
		}
		if argType == reflect.Slice {
			for arrayItemIndex, anArrayItem := range arg.([]Any) {
				newObject[prettyJsonStringify(arrayItemIndex)] = anArrayItem
			}
		}
	}
	return newObject
}

func spreadOperatorArray(arrayOfArray ...[]Any) []Any {
	var newArray = []Any{}
	for _, arrayOfArrayItem := range arrayOfArray {
		newArray = append(newArray, arrayOfArrayItem...)
	}
	return newArray
}

func combineArrays(anArray []Any, elements ...Any) []Any {
	return append(anArray, elements...)
}

func Sum(nums ...int) int {
	res := 0
	for _, n := range nums {
		res += n
	}
	return res
}

func main() {
	numbers := []Any{12, 34}
	products := []Any{
		Object{
			"code":  "pasta",
			"price": 321,
		},
		Object{
			"code":  "bubble_gum",
			"price": 233,
		},
	}
	products1 := []Any{
		Object{
			"code":  "pasta",
			"price": 6969,
		},
		Object{
			"code":  "bubble_gum",
			"price": 233,
		},
	}
	productItem1 := Object{
		"code":  "pasta",
		"price": 321,
	}
	productItem2 := Object{
		"code":  "pasta",
		"price": 6969,
		"stock": 12345,
	}
	asd1 := spreadOperatorArray(products, numbers)
	fmt.Println("asd1:", prettyJsonStringify(asd1))

	asd2 := spreadOperatorArray(numbers, products)
	fmt.Println("asd2:", prettyJsonStringify(asd2))

	asd3 := spreadOperatorObject(products, numbers)
	fmt.Println("asd3:", prettyJsonStringify(asd3))

	asd4 := spreadOperatorObject(numbers, products)
	fmt.Println("asd4:", prettyJsonStringify(asd4))

	asd5 := spreadOperatorArray(products, products1)
	fmt.Println("asd5:", prettyJsonStringify(asd5))

	asd6 := spreadOperatorObject(products, products1)
	fmt.Println("asd6:", prettyJsonStringify(asd6))

	asd7 := spreadOperatorObject(productItem1, productItem2)
	fmt.Println("asd7:", prettyJsonStringify(asd7))

	zxc1 := Sum(1, 2, 3, 4, 5)
	fmt.Println(zxc1)
}
