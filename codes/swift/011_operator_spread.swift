import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

func jsonStringify(_ anything: Any? = nil, pretty: Bool = false, indent: String = "    ") -> String {
    var indentLevel = 0
    func jsonStringifyInner(_ anythingInner: Any?, _ indentInner: String) -> String {
        guard let anythingInner = anythingInner else {
            return "null"
        }
        if let anythingInner = anythingInner as? String {
            return "\"\(anythingInner)\""
        }
        if let anythingInner = anythingInner as? Bool {
            return "\(anythingInner)"
        }
        if let anythingInner = anythingInner as? NSNumber {
            return "\(anythingInner)"
        }
        if let anythingInner = anythingInner as? MyArray {
            if (anythingInner.count == 0) {
                return "[]"
            }
            indentLevel += 1
            var result = ((pretty == true) ? "[\n\(String(repeating: indentInner, count: indentLevel))" : "[")
            for (arrayItemIndex, arrayItem) in anythingInner.enumerated() {
                result += jsonStringifyInner(arrayItem, indentInner)
                if ((arrayItemIndex + 1) != anythingInner.count) {
                    result += ((pretty == true) ? ",\n\(String(repeating: indentInner, count: indentLevel))" : ", ")
                }
            }
            indentLevel -= 1
            result += ((pretty == true) ? "\n\(String(repeating: indentInner, count: indentLevel))]" : "]")
            return result
        }
        if let anythingInner = anythingInner as? MyObject {
            if (anythingInner.count == 0) {
                return "{}"
            }
            indentLevel += 1
            var result = ((pretty == true) ? "{\n\(String(repeating: indentInner, count: indentLevel))" : "{")
            for (objectEntryIndex, (objectKey, objectValue)) in anythingInner.enumerated() {
                result += "\"\(objectKey)\": \(jsonStringifyInner(objectValue, indentInner))"
                if ((objectEntryIndex + 1) != anythingInner.count) {
                    result += ((pretty == true) ? ",\n\(String(repeating: indentInner, count: indentLevel))" : ", ")
                }
            }
            indentLevel -= 1
            result += ((pretty == true) ? "\n\(String(repeating: indentInner, count: indentLevel))}" : "}")
            return result
        }
        return "null"
    }
    return jsonStringifyInner(anything, indent)
}

// There's no JavaScript-like Spread Syntax (...) in Swift.
// But, we can create our own function to mimic it in Swift.

func spreadObject(_ arguments: Any?...) -> MyObject {
    var newObject = MyObject()
    for (_, argument) in arguments.enumerated() {
        if (argument is MyObject) {
            guard let argument = argument as? MyObject else {
                continue
            }
            for (objectKey, objectValue) in argument {
                newObject[objectKey] = objectValue
            }
            continue
        }
        if (argument is MyArray) {
            guard let argument = argument as? MyArray else {
                continue
            }
            for (arrayItemIndex, arrayItem) in argument.enumerated() {
                newObject[String(arrayItemIndex)] = arrayItem
            }
            continue
        }
    }
    return newObject
}

func spreadArray(_ arguments: Any?...) -> MyArray {
    var newArray = MyArray()
    for (_, argument) in arguments.enumerated() {
        if (argument is MyObject) {
            guard let argument = argument as? MyObject else {
                continue
            }
            if (argument.count == 1) {
                for (_, objectValue) in argument {
                    newArray.append(objectValue)
                }
                continue
            }
            newArray.append(argument)
            continue
        }
        if (argument is MyArray) {
            guard let argument = argument as? MyArray else {
                continue
            }
            for (_, arrayItem) in argument.enumerated() {
                newArray.append(arrayItem)
            }
            continue
        }
    }
    return newArray
}

print("\n// JavaScript-like Spread Syntax (...) in Swift")

let fruits: MyArray = ["Mango", "Melon", "Banana"]
print("fruits: \(jsonStringify(fruits))")

let vegetables: MyArray = ["Carrot", "Tomato"]
print("vegetables: \(jsonStringify(vegetables))")

var countryCapitalsInAsia: MyObject = [
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo"
]
print("countryCapitalsInAsia: \(jsonStringify(countryCapitalsInAsia, pretty: true))")

var countryCapitalsInEurope: MyObject = [
    "France": "Paris",
    "England": "London"
]
print("countryCapitalsInEurope: \(jsonStringify(countryCapitalsInEurope, pretty: true))")

print("\n// [...array1, ...array2]:\n")

let combination1 = spreadArray(fruits, vegetables)
print("combination1: \(jsonStringify(combination1, pretty: true))")
// combination1: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Carrot",
//     "Tomato"
// ]

let combination2 = spreadArray(fruits, ["Cucumber", "Cabbage"] as MyArray)
print("combination2: \(jsonStringify(combination2, pretty: true))")
// combination2: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Cucumber",
//     "Cabbage"
// ]

print("\n// { ...object1, ...object2 }:\n")

let combination3 = spreadObject(countryCapitalsInAsia, countryCapitalsInEurope)
print("combination3: \(jsonStringify(combination3, pretty: true))")
// combination3: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "France": "Paris",
//     "England": "London"
// }

let combination4 = spreadObject(countryCapitalsInAsia, ["Germany": "Berlin", "Italy": "Rome"] as MyObject)
print("combination4: \(jsonStringify(combination4, pretty: true))")
// combination4: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "Germany": "Berlin",
//     "Italy": "Rome"
// }

print("\n// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n")

let combination5 = spreadArray(fruits, ["vegetables": vegetables] as MyObject)
print("combination5: \(jsonStringify(combination5, pretty: true))")
// combination5: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Carrot",
//         "Tomato"
//     ]
// ]

let combination6 = spreadArray(fruits, ["vegetables": ["Cucumber", "Cabbage"] as MyArray] as MyObject)
print("combination6: \(jsonStringify(combination6, pretty: true))")
// combination6: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Cucumber",
//         "Cabbage"
//     ]
// ]

print("\n// [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n")

let combination7 = spreadArray(fruits, ["countryCapitalsInAsia": countryCapitalsInAsia] as MyObject)
print("combination7: \(jsonStringify(combination7, pretty: true))")
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

let combination8 = spreadArray(fruits, ["countryCapitalsInEurope": ["Germany": "Berlin", "Italy": "Rome"] as MyObject] as MyObject)
print("combination8: \(jsonStringify(combination8, pretty: true))")
// combination8: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// ]

print("\n// { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n")

let combination9 = spreadObject(countryCapitalsInAsia, ["countryCapitalsInEurope": countryCapitalsInEurope] as MyObject)
print("combination9: \(jsonStringify(combination9, pretty: true))")
// combination9: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "countryCapitalsInEurope": {
//         "France": "Paris",
//         "England": "London"
//     }
// }

let combination10 = spreadObject(countryCapitalsInAsia, ["countryCapitalsInEurope": ["Germany": "Berlin", "Italy": "Rome"] as MyObject] as MyObject)
print("combination10: \(jsonStringify(combination10, pretty: true))")
// combination10: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "countryCapitalsInEurope": {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// }

print("\n// { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n")

let combination11 = spreadObject(countryCapitalsInAsia, ["vegetables": vegetables] as MyObject)
print("combination11: \(jsonStringify(combination11, pretty: true))")
// combination11: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Carrot",
//         "Tomato"
//     ]
// }

let combination12 = spreadObject(countryCapitalsInAsia, ["vegetables": ["Cucumber", "Cabbage"] as MyArray] as MyObject)
print("combination12: \(jsonStringify(combination12, pretty: true))")
// combination12: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Cucumber",
//         "Cabbage"
//     ]
// }

print("\n// { ...object1, ...array2 }:\n")

let combination13 = spreadObject(countryCapitalsInAsia, vegetables)
print("combination13: \(jsonStringify(combination13, pretty: true))")
// combination13: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "0": "Carrot",
//     "1": "Tomato"
// }

let combination14 = spreadObject(countryCapitalsInAsia, ["Cucumber", "Cabbage"] as MyArray)
print("combination14: \(jsonStringify(combination14, pretty: true))")
// combination14: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "0": "Cucumber",
//     "1": "Cabbage"
// }

// print("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n")

// this combination throw an error in JavaScript
// let combinationErrorInJavascript1 = spreadArray(fruits, countryCapitalsInAsia)
// print("combinationErrorInJavascript1: \(jsonStringify(combinationErrorInJavascript1, pretty: true))")

// this combination throw an error in JavaScript
// let combinationErrorInJavascript2 = spreadArray(fruits, ["Germany": "Berlin", "Italy": "Rome"] as MyObject)
// print("combinationErrorInJavascript2: \(jsonStringify(combinationErrorInJavascript2, pretty: true))")
