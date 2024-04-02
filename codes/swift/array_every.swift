import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

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
            for (objectEntryIndex, (objectKey, objectValue)) in anythingInner.enumerated() {
                result += "\"\(objectKey)\": \(prettyJsonStringifyInner(objectValue, indentInner))"
                if ((objectEntryIndex + 1) != anythingInner.count) {
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

func arrayEveryV1(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Bool {
    // JavaScript-like Array.every() function
    var isConditionMatch = false
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == false) {
            break
        }
    }
    return isConditionMatch
}

func arrayEveryV2(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Bool {
    // JavaScript-like Array.every() function
    var isConditionMatch = false
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == false) {
            return isConditionMatch
        }
    }
    return isConditionMatch
}

func arrayEveryV3(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Bool {
    // JavaScript-like Array.every() function
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        let isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == false) {
            return false
        }
    }
    return true
}

func arrayEveryV4(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Bool {
    // JavaScript-like Array.every() function
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == false) {
            return false
        }
    }
    return true
}

print("\n// JavaScript-like Array.every() in Swift Array")

let numbers: MyArray = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("numbers: \(prettyArrayOfPrimitives(numbers))")

var isAllNumberLessThan500: Bool
var isAllNumberMoreThan500: Bool

print("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

isAllNumberLessThan500 = arrayEveryV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result < 500)
}, numbers)
print("is all number < 500: \(isAllNumberLessThan500)")
// is all number < 500: true

isAllNumberMoreThan500 = arrayEveryV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result > 500)
}, numbers)
print("is all number > 500: \(isAllNumberMoreThan500)")
// is all number > 500: false

print("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

isAllNumberLessThan500 = arrayEveryV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result < 500)
}, numbers)
print("is all number < 500: \(isAllNumberLessThan500)")
// is all number < 500: true

isAllNumberMoreThan500 = arrayEveryV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result > 500)
}, numbers)
print("is all number > 500: \(isAllNumberMoreThan500)")
// is all number > 500: false

print("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

isAllNumberLessThan500 = arrayEveryV3({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result < 500)
}, numbers)
print("is all number < 500: \(isAllNumberLessThan500)")
// is all number < 500: true

isAllNumberMoreThan500 = arrayEveryV3({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result > 500)
}, numbers)
print("is all number > 500: \(isAllNumberMoreThan500)")
// is all number > 500: false

print("// using JavaScript-like Array.every() function \"arrayEveryV4\"")

isAllNumberLessThan500 = arrayEveryV4({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result < 500)
}, numbers)
print("is all number < 500: \(isAllNumberLessThan500)")
// is all number < 500: true

isAllNumberMoreThan500 = arrayEveryV4({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result > 500)
}, numbers)
print("is all number > 500: \(isAllNumberMoreThan500)")
// is all number > 500: false

print("// using Swift Array.every() built-in method \"Array.allSatisfy\"")

isAllNumberLessThan500 = numbers.allSatisfy { (number: Any?) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result < 500)
}
print("is all number < 500: \(isAllNumberLessThan500)")
// is all number < 500: true

isAllNumberMoreThan500 = numbers.allSatisfy { (number: Any?) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result > 500)
}
print("is all number > 500: \(isAllNumberMoreThan500)")
// is all number > 500: false

print("\n// JavaScript-like Array.filter() in Swift Array of Dictionaries")

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

var isAllProductPriceLessThan500: Bool
var isAllProductPriceMoreThan500: Bool

print("// using JavaScript-like Array.every() function \"arrayEveryV1\"")

isAllProductPriceLessThan500 = arrayEveryV1({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result < 500)
}, products)
print("is all product price < 500: \(isAllProductPriceLessThan500)")
// is all product price < 500: true

isAllProductPriceMoreThan500 = arrayEveryV1({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result > 500)
}, products)
print("is all product price > 500: \(isAllProductPriceMoreThan500)")
// is all product price > 500: false

print("// using JavaScript-like Array.every() function \"arrayEveryV2\"")

isAllProductPriceLessThan500 = arrayEveryV2({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result < 500)
}, products)
print("is all product price < 500: \(isAllProductPriceLessThan500)")
// is all product price < 500: true

isAllProductPriceMoreThan500 = arrayEveryV2({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result > 500)
}, products)
print("is all product price > 500: \(isAllProductPriceMoreThan500)")
// is all product price > 500: false

print("// using JavaScript-like Array.every() function \"arrayEveryV3\"")

isAllProductPriceLessThan500 = arrayEveryV3({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result < 500)
}, products)
print("is all product price < 500: \(isAllProductPriceLessThan500)")
// is all product price < 500: true

isAllProductPriceMoreThan500 = arrayEveryV3({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result > 500)
}, products)
print("is all product price > 500: \(isAllProductPriceMoreThan500)")
// is all product price > 500: false

print("// using JavaScript-like Array.every() function \"arrayEveryV4\"")

isAllProductPriceLessThan500 = arrayEveryV4({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result < 500)
}, products)
print("is all product price < 500: \(isAllProductPriceLessThan500)")
// is all product price < 500: true

isAllProductPriceMoreThan500 = arrayEveryV4({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result > 500)
}, products)
print("is all product price > 500: \(isAllProductPriceMoreThan500)")
// is all product price > 500: false

print("// using Swift Array.every() built-in method \"Array.allSatisfy\"")

isAllProductPriceLessThan500 = products.allSatisfy { (product: Any?) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result < 500)
}
print("is all product price < 500: \(isAllProductPriceLessThan500)")
// is all product price < 500: true

isAllProductPriceMoreThan500 = products.allSatisfy { (product: Any?) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result > 500)
}
print("is all product price > 500: \(isAllProductPriceMoreThan500)")
// is all product price > 500: false
