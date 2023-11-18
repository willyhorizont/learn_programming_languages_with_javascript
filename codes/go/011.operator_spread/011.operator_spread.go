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
		if ((arrayItemIndex + 1) != len(anArray)) {
			result = result + ", "
		}
	}
	result = result + "]"
	return result
}

func spreadSyntaxObject(parameters ...any) object {
	var newObject = make(object)
	for _, parameter := range parameters {
		parameterType := reflect.TypeOf(parameter).Kind()
		if (parameterType == reflect.Map) {
			for objectKey, objectValue := range parameter.(object) {
				newObject[objectKey] = objectValue
			}
		}
		if (parameterType == reflect.Slice) {
			for arrayItemIndex, arrayItem := range parameter.(array) {
				newObject[prettyJsonStringify(arrayItemIndex)] = arrayItem
			}
		}
	}
	return newObject
}

func spreadSyntaxArray(parameters ...any) array {
	var newArray = array{}
	for _, parameter := range parameters {
		parameterType := reflect.TypeOf(parameter).Kind()
		if (parameterType == reflect.Map) {
			if (len(parameter.(object)) == 1) {
				for _, objectValue := range parameter.(object) {
					newArray = append(newArray, objectValue)
				}
				continue
			}
			newArray = append(newArray, parameter)
			continue
		}
		if (parameterType == reflect.Slice) {
			newArray = append(newArray, parameter.(array)...)
			continue
		}
	}
	return newArray
}

func main() {
	fmt.Println("\n// JavaScript-like Spread Syntax (...) in Go")

	fruits := array{"Mango", "Melon", "Banana"}
	fmt.Println("fruits:", prettyArrayOfPrimitives(fruits))

	vegetables := array{"Carrot", "Tomato"}
	fmt.Println("vegetables:", prettyArrayOfPrimitives(vegetables))

	countryCapitalsInAsia := object{
		"Thailand": "Bangkok",
		"China":    "Beijing",
		"Japan":    "Tokyo",
	}
	fmt.Println("countryCapitalsInAsia:", prettyJsonStringify(countryCapitalsInAsia))

	countryCapitalsInEurope := object{
		"France":  "Paris",
		"England": "London",
	}
	fmt.Println("countryCapitalsInEurope:", prettyJsonStringify(countryCapitalsInEurope))

	fmt.Println("// [...array1, ...array2]:")

	combination1 := spreadSyntaxArray(fruits, vegetables)
	fmt.Println("combination1:", prettyJsonStringify(combination1))
	// combination1: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     "Carrot",
	//     "Tomato"
	// ]

	combination2 := spreadSyntaxArray(fruits, array{"Cucumber", "Onions"})
	fmt.Println("combination2:", prettyJsonStringify(combination2))
	// combination2: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     "Cucumber",
	//     "Onions"
	// ]

	fmt.Println("// { ...object1, ...object2 }:")

	combination3 := spreadSyntaxObject(countryCapitalsInAsia, countryCapitalsInEurope)
	fmt.Println("combination3:", prettyJsonStringify(combination3))
	// combination3: {
	//     "Thailand": "Bangkok",
	//     "China": "Beijing",
	//     "Japan": "Tokyo",
	//     "France": "Paris",
	//     "England": "London"
	// }

	combination4 := spreadSyntaxObject(countryCapitalsInAsia, object{"Germany": "Berlin", "Italy": "Rome"})
	fmt.Println("combination4:", prettyJsonStringify(combination4))
	// combination4: {
	//     "Thailand": "Bangkok",
	//     "China": "Beijing",
	//     "Japan": "Tokyo",
	//     "Germany": "Berlin",
	//     "Italy": "Rome"
	// }

	fmt.Println("// [...array1, array2]:")

	combination5 := spreadSyntaxArray(fruits, object{"vegetables": vegetables})
	fmt.Println("combination5:", prettyJsonStringify(combination5))
	// combination5: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     [
	//         "Carrot",
	//         "Tomato"
	//     ]
	// ]

	combination6 := spreadSyntaxArray(fruits, object{"vegetables": array{"Cucumber", "Onions"}})
	fmt.Println("combination6:", prettyJsonStringify(combination6))
	// combination6: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     [
	//         "Cucumber",
	//         "Onions"
	//     ]
	// ]

	fmt.Println("// [...array1, object1]:")

	combination7 := spreadSyntaxArray(fruits, object{"countryCapitalsInAsia": countryCapitalsInAsia})
	fmt.Println("combination7:", prettyJsonStringify(combination7))
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

	combination8 := spreadSyntaxArray(fruits, object{"Germany": "Berlin", "Italy": "Rome"})
	fmt.Println("combination8:", prettyJsonStringify(combination8))
	// combination8: [
	//     "Mango",
	//     "Melon",
	//     "Banana",
	//     {
	//         "Germany": "Berlin",
	//         "Italy": "Rome"
	//     }
	// ]

	fmt.Println("// { ...object1, object2 }:")

	combination9 := spreadSyntaxObject(countryCapitalsInAsia, object{"countryCapitalsInEurope": countryCapitalsInEurope})
	fmt.Println("combination9:", prettyJsonStringify(combination9))
	// combination9: {
	//    "Thailand" : "Bangkok",
	//    "China" : "Beijing",
	//    "Japan" : "Tokyo",
	//    "countryCapitalsInEurope" : {
	//       "France" : "Paris",
	//       "England" : "London"
	//    }
	// }

	combination10 := spreadSyntaxObject(countryCapitalsInAsia, object{"countryCapitalsInEurope": object{"Germany": "Berlin", "Italy": "Rome"}})
	fmt.Println("combination10:", prettyJsonStringify(combination10))
	//combination10: {
	//	"Thailand": "Bangkok",
	//	"China": "Beijing",
	//	"Japan": "Tokyo",
	//	"countryCapitalsInEurope": {
	//		"Germany": "Berlin",
	//		"Italy": "Rome"
	//	}
	//}

	fmt.Println("// { ...object1, array2 }:")

	combination11 := spreadSyntaxObject(countryCapitalsInAsia, object{"vegetables": vegetables})
	fmt.Println("combination11:", prettyJsonStringify(combination11))
	// combination11: {
	//     "Thailand": "Bangkok",
	//     "China": "Beijing",
	//     "Japan": "Tokyo",
	//     "vegetables": [
	//         "Carrot",
	//         "Tomato"
	//     ]
	// }

	combination12 := spreadSyntaxObject(countryCapitalsInAsia, object{"vegetables": array{"Cucumber", "Onions"}})
	fmt.Println("combination12:", prettyJsonStringify(combination12))
	// combination12: {
	//     "Thailand": "Bangkok",
	//     "China": "Beijing",
	//     "Japan": "Tokyo",
	//     "vegetables": [
	//         "Cucumber",
	//         "Onions"
	//     ]
	// }

	fmt.Println("// { ...object1, ...array2 }:")

	combination13 := spreadSyntaxObject(countryCapitalsInAsia, vegetables)
	fmt.Println("combination13:", prettyJsonStringify(combination13))
	// combination13: {
	//    "Thailand" : "Bangkok",
	//    "China" : "Beijing",
	//    "Japan" : "Tokyo",
	//    "0" : "Carrot",
	//    "1" : "Tomato"
	// }

	combination14 := spreadSyntaxObject(countryCapitalsInAsia, array{"Cucumber", "Onions"})
	fmt.Println("combination14:", prettyJsonStringify(combination14))
	// combination14: {
	//    "Thailand" : "Bangkok",
	//    "China" : "Beijing",
	//    "Japan" : "Tokyo",
	//    "0" : "Cucumber",
	//    "1" : "Onions"
	// }

	// fmt.Println("// [...array1, ...object1]: // this combination throw an error in JavaScript")

	// this combination throw an error in JavaScript
	// combinationErrorInJavaScript1 := spreadSyntaxObject(fruits, countryCapitalsInAsia)
	// fmt.Println("combinationErrorInJavaScript1:", prettyJsonStringify(combinationErrorInJavaScript1))

	// this combination throw an error in JavaScript
	// combinationErrorInJavaScript2 := spreadSyntaxObject(fruits, object{"Germany": "Berlin", "Italy": "Rome"})
	// fmt.Println("combinationErrorInJavaScript2:", prettyJsonStringify(combinationErrorInJavaScript2))
}
