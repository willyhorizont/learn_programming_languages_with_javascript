import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

func prettyArrayOfPrimitives(_ anArrayOfPrimitives: MyArray) -> String {
    var result = "["
    for (arrayItemIndex, arrayItem) in anArrayOfPrimitives.enumerated() {
        guard let arrayItem = arrayItem else {
            result += "undefined"
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
            return "undefined"
        }
        if (anythingInner as? String == "null") {
            return "null"
        }
        if (anythingInner as? String == "undefined") {
            return "undefined"
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
                let result = "[]"
                return result
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
                let result = "{}"
                return result
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
        return "undefined"
    }
    return prettyJsonStringifyInner(anything, indent)
}

func arraySomeV1(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Bool {
    // JavaScript-like Array.some() function
    var isConditionMatch = false
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            break
        }
    }
    return isConditionMatch
}

func arraySomeV2(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Bool {
    // JavaScript-like Array.some() function
    var isConditionMatch = false
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            return isConditionMatch
        }
    }
    return isConditionMatch
}

func arraySomeV3(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Bool {
    // JavaScript-like Array.some() function
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        let isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            return true
        }
    }
    return false
}

func arraySomeV4(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Bool {
    // JavaScript-like Array.some() function
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
            return true
        }
    }
    return false
}

print("\n// JavaScript-like Array.some() in Swift [Any?] (Array)")

let numbers: MyArray = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("numbers: \(prettyArrayOfPrimitives(numbers))")

var isAnyNumberLessThan500: Bool
var isAnyNumberMoreThan500: Bool

print("// using JavaScript-like Array.some() function \"arraySomeV1\"")

isAnyNumberLessThan500 = arraySomeV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result < 500
}, numbers)
print("is any number < 500: \(isAnyNumberLessThan500)")
// is any number < 500: true

isAnyNumberMoreThan500 = arraySomeV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result > 500
}, numbers)
print("is any number > 500: \(isAnyNumberMoreThan500)")
// is any number > 500: false

print("// using JavaScript-like Array.some() function \"arraySomeV2\"")

isAnyNumberLessThan500 = arraySomeV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result < 500
}, numbers)
print("is any number < 500: \(isAnyNumberLessThan500)")
// is any number < 500: true

isAnyNumberMoreThan500 = arraySomeV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result > 500
}, numbers)
print("is any number > 500: \(isAnyNumberMoreThan500)")
// is any number > 500: false

print("// using JavaScript-like Array.some() function \"arraySomeV3\"")

isAnyNumberLessThan500 = arraySomeV3({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result < 500
}, numbers)
print("is any number < 500: \(isAnyNumberLessThan500)")
// is any number < 500: true

isAnyNumberMoreThan500 = arraySomeV3({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result > 500
}, numbers)
print("is any number > 500: \(isAnyNumberMoreThan500)")
// is any number > 500: false

print("// using JavaScript-like Array.some() function \"arraySomeV4\"")

isAnyNumberLessThan500 = arraySomeV4({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result < 500
}, numbers)
print("is any number < 500: \(isAnyNumberLessThan500)")
// is any number < 500: true

isAnyNumberMoreThan500 = arraySomeV4({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result > 500
}, numbers)
print("is any number > 500: \(isAnyNumberMoreThan500)")
// is any number > 500: false

print("// using Swift Array.some() built-in method \"Array.contains\"")

isAnyNumberLessThan500 = numbers.contains { (number: Any?) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result < 500
}
print("is any number < 500: \(isAnyNumberLessThan500)")
// is any number < 500: true

isAnyNumberMoreThan500 = numbers.contains { (number: Any?) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result > 500
}
print("is any number > 500: \(isAnyNumberMoreThan500)")
// is any number > 500: false

print("\n// JavaScript-like Array.filter() in Swift [[String, Any?]] (Array of Dictionaries)")

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

var isAnyProductPriceLessThan500: Bool
var isAnyProductPriceMoreThan500: Bool

print("// using JavaScript-like Array.some() function \"arraySomeV1\"")

isAnyProductPriceLessThan500 = arraySomeV1({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result < 500
}, products)
print("is any product price < 500: \(isAnyProductPriceLessThan500)")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = arraySomeV1({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result > 500
}, products)
print("is any product price > 500: \(isAnyProductPriceMoreThan500)")
// is any product price > 500: false

print("// using JavaScript-like Array.some() function \"arraySomeV2\"")

isAnyProductPriceLessThan500 = arraySomeV2({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result < 500
}, products)
print("is any product price < 500: \(isAnyProductPriceLessThan500)")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = arraySomeV2({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result > 500
}, products)
print("is any product price > 500: \(isAnyProductPriceMoreThan500)")
// is any product price > 500: false

print("// using JavaScript-like Array.some() function \"arraySomeV3\"")

isAnyProductPriceLessThan500 = arraySomeV3({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result < 500
}, products)
print("is any product price < 500: \(isAnyProductPriceLessThan500)")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = arraySomeV3({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result > 500
}, products)
print("is any product price > 500: \(isAnyProductPriceMoreThan500)")
// is any product price > 500: false

print("// using JavaScript-like Array.some() function \"arraySomeV4\"")

isAnyProductPriceLessThan500 = arraySomeV4({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result < 500
}, products)
print("is any product price < 500: \(isAnyProductPriceLessThan500)")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = arraySomeV4({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result > 500
}, products)
print("is any product price > 500: \(isAnyProductPriceMoreThan500)")
// is any product price > 500: false

print("// using Swift Array.some() built-in method \"Array.contains\"")

isAnyProductPriceLessThan500 = products.contains { (product: Any?) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result < 500
}
print("is any product price < 500: \(isAnyProductPriceLessThan500)")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = products.contains { (product: Any?) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result > 500
}
print("is any product price > 500: \(isAnyProductPriceMoreThan500)")
// is any product price > 500: false
