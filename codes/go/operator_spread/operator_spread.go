package main

import (
	"encoding/json"
	"fmt"
	"reflect"
)

// There's no JavaScript-like Spread Syntax (...) in Go.
// But, we can create our own function to mimic it in Go.

const EMPTY_STRING = ""
const TAB = "    "

type Any interface{}
type Object map[string]Any

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

func spreadSyntaxObject(parameters ...Any) Object {
	var newObject = make(Object)
	for _, parameter := range parameters {
		parameterType := reflect.TypeOf(parameter).Kind()
		if parameterType == reflect.Map {
			for objectKey, objectValue := range parameter.(Object) {
				newObject[objectKey] = objectValue
			}
		}
		if parameterType == reflect.Slice {
			for arrayItemIndex, arrayItem := range parameter.([]Any) {
				newObject[prettyJsonStringify(arrayItemIndex)] = arrayItem
			}
		}
	}
	return newObject
}

func spreadSyntaxArray(parameters ...Any) []Any {
	var newArray = []Any{}
	for _, parameter := range parameters {
		parameterType := reflect.TypeOf(parameter).Kind()
		if parameterType == reflect.Map {
			if len(parameter.(Object)) == 1 {
				for _, objectValue := range parameter.(Object) {
					newArray = append(newArray, objectValue)
				}
				continue
			}
			newArray = append(newArray, parameter)
			continue
		}
		if parameterType == reflect.Slice {
			newArray = append(newArray, parameter.([]Any)...)
			continue
		}
	}
	return newArray
}

func main() {
	fmt.Println("\n// JavaScript-like Spread Syntax (...) in Go")

	fruits := []Any{"Mango", "Melon", "Banana"}
	fmt.Println("fruits: ", prettyArrayOfPrimitives(fruits))

	vegetables := []Any{"Carrot", "Tomato"}
	fmt.Println("vegetables: ", prettyArrayOfPrimitives(vegetables))

	countryCapitalsInAsia := Object{
		"Thailand": "Bangkok",
		"China":    "Beijing",
		"Japan":    "Tokyo",
	}
	fmt.Println("countryCapitalsInAsia: ", prettyJsonStringify(countryCapitalsInAsia))

	countryCapitalsInEurope := Object{
		"France":  "Paris",
		"England": "London",
	}
	fmt.Println("countryCapitalsInEurope: ", prettyJsonStringify(countryCapitalsInEurope))

	print("// [...array1, ...array2]:")

	combination1 := spreadSyntaxArray(fruits, vegetables)
	fmt.Println("combination1: ", prettyJsonStringify(combination1))
	// combination1: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     "Carrot",
	//     "Tomato"
	// ]

	combination2 := spreadSyntaxArray(fruits, []Any{"Cucumber", "Onions"})
	fmt.Println("combination2: ", prettyJsonStringify(combination2))
	// combination2: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     "Cucumber",
	//     "Onions"
	// ]

	print("// { ...object1, ...object2 }:")

	combination3 := spreadSyntaxObject(countryCapitalsInAsia, countryCapitalsInEurope)
	fmt.Println("combination3: ", prettyJsonStringify(combination3))
	// combination3: {
	//     "Thailand": "Bangkok",
	//     "China": "Beijing",
	//     "Japan": "Tokyo",
	//     "France": "Paris",
	//     "England": "London"
	// }

	combination4 := spreadSyntaxObject(countryCapitalsInAsia, Object{"Germany": "Berlin", "Italy": "Rome"})
	fmt.Println("combination4: ", prettyJsonStringify(combination4))
	// combination4: {
	//     "Thailand": "Bangkok",
	//     "China": "Beijing",
	//     "Japan": "Tokyo",
	//     "Germany": "Berlin",
	//     "Italy": "Rome"
	// }

	print("// [...array1, array2]:")

	combination5 := spreadSyntaxArray(fruits, Object{"vegetables": vegetables})
	fmt.Println("combination5: ", prettyJsonStringify(combination5))
	// combination5: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     [
	//         "Carrot",
	//         "Tomato"
	//     ]
	// ]

	combination6 := spreadSyntaxArray(fruits, Object{"vegetables": []Any{"Cucumber", "Onions"}})
	fmt.Println("combination6: ", prettyJsonStringify(combination6))
	// combination6: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     [
	//         "Cucumber",
	//         "Onions"
	//     ]
	// ]

	print("// [...array1, object1]:")

	combination7 := spreadSyntaxArray(fruits, Object{"countryCapitalsInAsia": countryCapitalsInAsia})
	fmt.Println("combination7: ", prettyJsonStringify(combination7))
	// combination7: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     {
	//         "Thailand": "Bangkok",
	//         "China": "Beijing",
	//         "Japan": "Tokyo"
	//     }
	// ]

	combination8 := spreadSyntaxArray(fruits, Object{"Germany": "Berlin", "Italy": "Rome"})
	fmt.Println("combination8: ", prettyJsonStringify(combination8))
	// combination8: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     {
	//         "Germany": "Berlin",
	//         "Italy": "Rome"
	//     }
	// ]

	print("// { ...object1, object2 }:")

	combination9 := spreadSyntaxObject(countryCapitalsInAsia, Object{"countryCapitalsInEurope": countryCapitalsInEurope})
	fmt.Println("combination9: ", prettyJsonStringify(combination9))
	// combination9: {
	//    "Thailand" : "Bangkok",
	//    "China" : "Beijing",
	//    "Japan" : "Tokyo",
	//    "countryCapitalsInEurope" : {
	//       "France" : "Paris",
	//       "England" : "London"
	//    }
	// }

	combination10 := spreadSyntaxObject(countryCapitalsInAsia, Object{"countryCapitalsInEurope": Object{"Germany": "Berlin", "Italy": "Rome"}})
	fmt.Println("combination10: ", prettyJsonStringify(combination10))
	//combination10: {
	//	"Thailand": "Bangkok",
	//	"China": "Beijing",
	//	"Japan": "Tokyo",
	//	"countryCapitalsInEurope": {
	//		"Germany": "Berlin",
	//		"Italy": "Rome"
	//	}
	//}

	print("// { ...object1, array2 }:")

	combination11 := spreadSyntaxObject(countryCapitalsInAsia, Object{"vegetables": vegetables})
	fmt.Println("combination11: ", prettyJsonStringify(combination11))
	// combination11: {
	//     "Thailand": "Bangkok",
	//     "China": "Beijing",
	//     "Japan": "Tokyo",
	//     "vegetables": [
	//         "Carrot",
	//         "Tomato"
	//     ]
	// }

	combination12 := spreadSyntaxObject(countryCapitalsInAsia, Object{"vegetables": []Any{"Cucumber", "Onions"}})
	fmt.Println("combination12: ", prettyJsonStringify(combination12))
	// combination12: {
	//     "Thailand": "Bangkok",
	//     "China": "Beijing",
	//     "Japan": "Tokyo",
	//     "vegetables": [
	//         "Cucumber",
	//         "Onions"
	//     ]
	// }

	print("// { ...object1, ...array2 }:")

	combination13 := spreadSyntaxObject(countryCapitalsInAsia, vegetables)
	fmt.Println("combination13: ", prettyJsonStringify(combination13))
	// combination13: {
	//    "Thailand" : "Bangkok",
	//    "China" : "Beijing",
	//    "Japan" : "Tokyo",
	//    "0" : "Carrot",
	//    "1" : "Tomato"
	// }

	combination14 := spreadSyntaxObject(countryCapitalsInAsia, []Any{"Cucumber", "Onions"})
	fmt.Println("combination14: ", prettyJsonStringify(combination14))
	// combination14: {
	//    "Thailand" : "Bangkok",
	//    "China" : "Beijing",
	//    "Japan" : "Tokyo",
	//    "0" : "Cucumber",
	//    "1" : "Onions"
	// }

	// print("// [...array1, ...object1]: // this combination throw an error in JavaScript")

	// this combination throw an error in JavaScript
	// combinationErrorInJavaScript1 := spreadSyntaxObject(fruits, countryCapitalsInAsia)
	// fmt.Println("combinationErrorInJavaScript1: ", prettyJsonStringify(combinationErrorInJavaScript1))

	// this combination throw an error in JavaScript
	// combinationErrorInJavaScript2 := spreadSyntaxObject(fruits, Object{"Germany": "Berlin", "Italy": "Rome"})
	// fmt.Println("combinationErrorInJavaScript2: ", prettyJsonStringify(combinationErrorInJavaScript2))
}
