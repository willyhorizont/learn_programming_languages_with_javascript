import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

// There's no JavaScript-like Array.find() in Swift.
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

func arrayFindV1(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Any? {
    // JavaScript-like Array.find() function
    var dataFound: Any? = nil
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        let isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            dataFound = arrayItem
            break
        }
    }
    return dataFound
}

func arrayFindV2(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Any? {
    // JavaScript-like Array.find() function
    var dataFound: Any? = nil
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
            dataFound = arrayItem
            break
        }
    }
    return dataFound
}

func arrayFindV3(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Any? {
    // JavaScript-like Array.find() function
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        let isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            return arrayItem
        }
    }
    return nil
}

func arrayFindV4(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Any? {
    // JavaScript-like Array.find() function
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
            return arrayItem
        }
    }
    return nil
}

print("\n// JavaScript-like Array.find() in Swift Array")

let numbers: MyArray = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("numbers: \(prettyArrayOfPrimitives(numbers))")

var evenNumberFound: Any? = nil
var oddNumberFound: Any? = nil

print("// using JavaScript-like Array.find() function \"arrayFindV1\"")

evenNumberFound = arrayFindV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return ((result % 2) == 0)
}, numbers)
print("even number found: \(evenNumberFound ?? "nil")")
// even number found: 12

oddNumberFound = arrayFindV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return ((result % 2) != 0)
}, numbers)
print("odd number found: \(oddNumberFound ?? "nil")")
// odd number found: 27

print("// using JavaScript-like Array.find() function \"arrayFindV2\"")

evenNumberFound = arrayFindV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return ((result % 2) == 0)
}, numbers)
print("even number found: \(evenNumberFound ?? "nil")")
// even number found: 12

oddNumberFound = arrayFindV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return ((result % 2) != 0)
}, numbers)
print("odd number found: \(oddNumberFound ?? "nil")")
// odd number found: 27

print("// using JavaScript-like Array.find() function \"arrayFindV3\"")

evenNumberFound = arrayFindV3({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return ((result % 2) == 0)
}, numbers)
print("even number found: \(evenNumberFound ?? "nil")")
// even number found: 12

oddNumberFound = arrayFindV3({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return ((result % 2) != 0)
}, numbers)
print("odd number found: \(oddNumberFound ?? "nil")")
// odd number found: 27

print("// using JavaScript-like Array.find() function \"arrayFindV4\"")

evenNumberFound = arrayFindV4({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return ((result % 2) == 0)
}, numbers)
print("even number found: \(evenNumberFound ?? "nil")")
// even number found: 12

oddNumberFound = arrayFindV4({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return ((result % 2) != 0)
}, numbers)
print("odd number found: \(oddNumberFound ?? "nil")")
// odd number found: 27

print("\n// JavaScript-like Array.find() in Swift Array of Dictionaries")

let products: MyArray = [
    [
        "code": "pasta",
        "price": 321
    ] as MyObject,
    [
        "code": "bubble_gum",
        "price": 233
    ] as MyObject,
    [
        "code": "potato_chips",
        "price": 5
    ] as MyObject,
    [
        "code": "towel",
        "price": 499
    ] as MyObject
]
print("products: \(prettyJsonStringify(products))")

let productToFind = "bubble_gum"
print("product to find: \(productToFind)")

var productFound: Any? = nil

print("// using JavaScript-like Array.find() function \"arrayFindV1\"")

productFound = arrayFindV1({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return (result == productToFind)
}, products)
print("product found: \(prettyJsonStringify(productFound))")
// product found: {
//     "code":"bubble_gum",
//     "price": 233
// }

print("// using JavaScript-like Array.find() function \"arrayFindV2\"")

productFound = arrayFindV2({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return (result == productToFind)
}, products)
print("product found: \(prettyJsonStringify(productFound))")
// product found: {
//     "code":"bubble_gum",
//     "price": 233
// }

print("// using JavaScript-like Array.find() function \"arrayFindV3\"")

productFound = arrayFindV3({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return (result == productToFind)
}, products)
print("product found: \(prettyJsonStringify(productFound))")
// product found: {
//     "code":"bubble_gum",
//     "price": 233
// }

print("// using JavaScript-like Array.find() function \"arrayFindV4\"")

productFound = arrayFindV4({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return (result == productToFind)
}, products)
print("product found: \(prettyJsonStringify(productFound))")
// product found: {
//     "code":"bubble_gum",
//     "price": 233
// }
