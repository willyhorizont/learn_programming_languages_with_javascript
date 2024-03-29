import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

// There's no JavaScript-like Spread Syntax (...) in Swift.
// But, we can create our own function to mimic it in Swift.

func prettyArrayOfPrimitives(_ anArrayOfPrimitives: MyArray) -> String {
    var result = "["
    for (arrayItemIndex, arrayItem) in anArrayOfPrimitives.enumerated() {
        guard let arrayItem = arrayItem else {
            result += "nil"
            if ((arrayItemIndex + 1) != anArrayOfPrimitives.count) {
                result += ", "
            }
            continue
        }
        if (((arrayItem is String) == false) && ((arrayItem is NSNumber) == false)) && ((arrayItem is Bool) == false) {
            continue
        }
        if let arrayItem = arrayItem as? String {
            result += "\"\(arrayItem)\""
        }
        if let arrayItem = arrayItem as? Bool {
            result += "\(arrayItem)"
        } else {
            if let arrayItem = arrayItem as? NSNumber {
                result += "\(arrayItem)"
            }
        }
        if ((arrayItemIndex + 1) != anArrayOfPrimitives.count) {
            result += ", "
        }
    }
    result += "]"
    return result
}

func prettyJsonStringify(_ anything: Any? = nil, indent: String = "    ") -> String {
    var indentLevel = 0
    func prettyJsonStringifyInner(_ anythingInner: Any?, _ indentInner: String) -> String {
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
            var result = "[\n\(String(repeating: indentInner, count: indentLevel))"
            for (arrayItemIndex, arrayItem) in anythingInner.enumerated() {
                result += prettyJsonStringifyInner(arrayItem, indentInner)
                if ((arrayItemIndex + 1) != anythingInner.count) {
                    result += ",\n\(String(repeating: indentInner, count: indentLevel))"
                }
            }
            indentLevel -= 1
            result += "\n\(String(repeating: indentInner, count: indentLevel))]"
            return result
        }
        if let anythingInner = anythingInner as? MyObject {
            if (anythingInner.count == 0) {
                return "{}"
            }
            indentLevel += 1
            var result = "{\n\(String(repeating: indentInner, count: indentLevel))"
            for (entryIndex, (objectKey, objectValue)) in anythingInner.enumerated() {
                result += "\"\(objectKey)\": \(prettyJsonStringifyInner(objectValue, indentInner))"
                if ((entryIndex + 1) != anythingInner.count) {
                    result += ",\n\(String(repeating: indentInner, count: indentLevel))"
                }
            }
            indentLevel -= 1
            result += "\n\(String(repeating: indentInner, count: indentLevel))}"
            return result
        }
        return "null"
    }
    return prettyJsonStringifyInner(anything, indent)
}

func spreadSyntaxObject(_ parameters: Any?...) -> MyObject {
    var newObject = MyObject()
    for (_, parameter) in parameters.enumerated() {
        if (parameter is MyObject) {
            guard let parameter = parameter as? MyObject else {
                continue
            }
            for (objectKey, objectValue) in parameter {
                newObject[objectKey] = objectValue
            }
            continue
        }
        if (parameter is MyArray) {
            guard let parameter = parameter as? MyArray else {
                continue
            }
            for (arrayItemIndex, arrayItem) in parameter.enumerated() {
                newObject[String(arrayItemIndex)] = arrayItem
            }
            continue
        }
    }
    return newObject
}

func spreadSyntaxArray(_ parameters: Any?...) -> MyArray {
    var newArray = MyArray()
    for (_, parameter) in parameters.enumerated() {
        if (parameter is MyObject) {
            guard let parameter = parameter as? MyObject else {
                continue
            }
            if (parameter.count == 1) {
                for (_, objectValue) in parameter {
                    newArray.append(objectValue)
                }
                continue
            }
            newArray.append(parameter)
            continue
        }
        if (parameter is MyArray) {
            guard let parameter = parameter as? MyArray else {
                continue
            }
            for (_, arrayItem) in parameter.enumerated() {
                newArray.append(arrayItem)
            }
            continue
        }
    }
    return newArray
}

print("\n// JavaScript-like Spread Syntax (...) in Swift")

let fruits: MyArray = ["Mango", "Melon", "Banana"]
print("fruits: \(prettyArrayOfPrimitives(fruits))")

let vegetables: MyArray = ["Carrot", "Tomato"]
print("vegetables: \(prettyArrayOfPrimitives(vegetables))")

let countryCapitalsInAsia: MyObject = [
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo"
]
print("countryCapitalsInAsia: \(prettyJsonStringify(countryCapitalsInAsia))")

let countryCapitalsInEurope: MyObject = [
    "France": "Paris",
    "England": "London"
]
print("countryCapitalsInEurope: \(prettyJsonStringify(countryCapitalsInEurope))")

print("\n// [...array1, ...array2]:\n")

let combination1 = spreadSyntaxArray(fruits, vegetables)
print("combination1: \(prettyJsonStringify(combination1))")
// combination1: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Carrot",
//     "Tomato"
// ]

let combination2 = spreadSyntaxArray(fruits, ["Cucumber", "Cabbage"] as MyArray)
print("combination2: \(prettyJsonStringify(combination2))")
// combination2: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Cucumber",
//     "Cabbage"
// ]

print("\n// { ...object1, ...object2 }:\n")

let combination3 = spreadSyntaxObject(countryCapitalsInAsia, countryCapitalsInEurope)
print("combination3: \(prettyJsonStringify(combination3))")
// combination3: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "France": "Paris",
//     "England": "London"
// }

let combination4 = spreadSyntaxObject(countryCapitalsInAsia, ["Germany": "Berlin", "Italy": "Rome"] as MyObject)
print("combination4: \(prettyJsonStringify(combination4))")
// combination4: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "Germany": "Berlin",
//     "Italy": "Rome"
// }

print("\n// [...array1, array2]:\n")

let combination5 = spreadSyntaxArray(fruits, ["vegetables": vegetables] as MyObject)
print("combination5: \(prettyJsonStringify(combination5))")
// combination5: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Carrot",
//         "Tomato"
//     ]
// ]

let combination6 = spreadSyntaxArray(fruits, ["vegetables": ["Cucumber", "Cabbage"] as MyArray] as MyObject)
print("combination6: \(prettyJsonStringify(combination6))")
// combination6: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Cucumber",
//         "Cabbage"
//     ]
// ]

print("\n// [...array1, object1]:\n")

let combination7 = spreadSyntaxArray(fruits, ["countryCapitalsInAsia": countryCapitalsInAsia] as MyObject)
print("combination7: \(prettyJsonStringify(combination7))")
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

let combination8 = spreadSyntaxArray(fruits, ["countryCapitalsInEurope": ["Germany": "Berlin", "Italy": "Rome"] as MyObject] as MyObject)
print("combination8: \(prettyJsonStringify(combination8))")
// combination8: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// ]

print("\n// { ...object1, object2 }:\n")

let combination9 = spreadSyntaxObject(countryCapitalsInAsia, ["countryCapitalsInEurope": countryCapitalsInEurope] as MyObject)
print("combination9: \(prettyJsonStringify(combination9))")
// combination9: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "countryCapitalsInEurope": {
//         "France": "Paris",
//         "England": "London"
//     }
// }

let combination10 = spreadSyntaxObject(countryCapitalsInAsia, ["countryCapitalsInEurope": ["Germany": "Berlin", "Italy": "Rome"] as MyObject] as MyObject)
print("combination10: \(prettyJsonStringify(combination10))")
// combination10: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "countryCapitalsInEurope": {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// }

print("\n// { ...object1, array2 }:\n")

let combination11 = spreadSyntaxObject(countryCapitalsInAsia, ["vegetables": vegetables] as MyObject)
print("combination11: \(prettyJsonStringify(combination11))")
// combination11: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Carrot",
//         "Tomato"
//     ]
// }

let combination12 = spreadSyntaxObject(countryCapitalsInAsia, ["vegetables": ["Cucumber", "Cabbage"] as MyArray] as MyObject)
print("combination12: \(prettyJsonStringify(combination12))")
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

let combination13 = spreadSyntaxObject(countryCapitalsInAsia, vegetables)
print("combination13: \(prettyJsonStringify(combination13))")
// combination13: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "0": "Carrot",
//     "1": "Tomato"
// }

let combination14 = spreadSyntaxObject(countryCapitalsInAsia, ["Cucumber", "Cabbage"] as MyArray)
print("combination14: \(prettyJsonStringify(combination14))")
// combination14: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "0": "Cucumber",
//     "1": "Cabbage"
// }

// print("\n// [...array1, ...object1]: // this combination throw an error in JavaScript\n")

// this combination throw an error in JavaScript
// let combinationErrorInJavascript1 = spreadSyntaxArray(fruits, countryCapitalsInAsia)
// print("combinationErrorInJavascript1: \(prettyJsonStringify(combinationErrorInJavascript1))")

// this combination throw an error in JavaScript
// let combinationErrorInJavascript2 = spreadSyntaxArray(fruits, ["Germany": "Berlin", "Italy": "Rome"] as MyObject)
// print("combinationErrorInJavascript2: \(prettyJsonStringify(combinationErrorInJavascript2))")
