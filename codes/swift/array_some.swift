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

print("\n// JavaScript-like Array.some() in Swift Array")

let numbers: MyArray = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("numbers: \(jsonStringify(numbers))")

var isAnyNumberLessThan500: Bool
var isAnyNumberMoreThan500: Bool

print("// using JavaScript-like Array.some() function \"arraySomeV1\"")

isAnyNumberLessThan500 = arraySomeV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result < 500)
}, numbers)
print("is any number < 500: \(isAnyNumberLessThan500)")
// is any number < 500: true

isAnyNumberMoreThan500 = arraySomeV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result > 500)
}, numbers)
print("is any number > 500: \(isAnyNumberMoreThan500)")
// is any number > 500: false

print("// using JavaScript-like Array.some() function \"arraySomeV2\"")

isAnyNumberLessThan500 = arraySomeV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result < 500)
}, numbers)
print("is any number < 500: \(isAnyNumberLessThan500)")
// is any number < 500: true

isAnyNumberMoreThan500 = arraySomeV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result > 500)
}, numbers)
print("is any number > 500: \(isAnyNumberMoreThan500)")
// is any number > 500: false

print("// using JavaScript-like Array.some() function \"arraySomeV3\"")

isAnyNumberLessThan500 = arraySomeV3({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result < 500)
}, numbers)
print("is any number < 500: \(isAnyNumberLessThan500)")
// is any number < 500: true

isAnyNumberMoreThan500 = arraySomeV3({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result > 500)
}, numbers)
print("is any number > 500: \(isAnyNumberMoreThan500)")
// is any number > 500: false

print("// using JavaScript-like Array.some() function \"arraySomeV4\"")

isAnyNumberLessThan500 = arraySomeV4({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result < 500)
}, numbers)
print("is any number < 500: \(isAnyNumberLessThan500)")
// is any number < 500: true

isAnyNumberMoreThan500 = arraySomeV4({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result > 500)
}, numbers)
print("is any number > 500: \(isAnyNumberMoreThan500)")
// is any number > 500: false

print("// using Swift Array.some() built-in method \"Array.contains\"")

isAnyNumberLessThan500 = numbers.contains { (number: Any?) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result < 500)
}
print("is any number < 500: \(isAnyNumberLessThan500)")
// is any number < 500: true

isAnyNumberMoreThan500 = numbers.contains { (number: Any?) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result > 500)
}
print("is any number > 500: \(isAnyNumberMoreThan500)")
// is any number > 500: false

print("\n// JavaScript-like Array.some() in Swift Array of Dictionaries")

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
print("products: \(jsonStringify(products, pretty: true))")

var isAnyProductPriceLessThan500: Bool
var isAnyProductPriceMoreThan500: Bool

print("// using JavaScript-like Array.some() function \"arraySomeV1\"")

isAnyProductPriceLessThan500 = arraySomeV1({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result < 500)
}, products)
print("is any product price < 500: \(isAnyProductPriceLessThan500)")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = arraySomeV1({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result > 500)
}, products)
print("is any product price > 500: \(isAnyProductPriceMoreThan500)")
// is any product price > 500: false

print("// using JavaScript-like Array.some() function \"arraySomeV2\"")

isAnyProductPriceLessThan500 = arraySomeV2({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result < 500)
}, products)
print("is any product price < 500: \(isAnyProductPriceLessThan500)")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = arraySomeV2({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result > 500)
}, products)
print("is any product price > 500: \(isAnyProductPriceMoreThan500)")
// is any product price > 500: false

print("// using JavaScript-like Array.some() function \"arraySomeV3\"")

isAnyProductPriceLessThan500 = arraySomeV3({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result < 500)
}, products)
print("is any product price < 500: \(isAnyProductPriceLessThan500)")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = arraySomeV3({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result > 500)
}, products)
print("is any product price > 500: \(isAnyProductPriceMoreThan500)")
// is any product price > 500: false

print("// using JavaScript-like Array.some() function \"arraySomeV4\"")

isAnyProductPriceLessThan500 = arraySomeV4({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result < 500)
}, products)
print("is any product price < 500: \(isAnyProductPriceLessThan500)")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = arraySomeV4({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result > 500)
}, products)
print("is any product price > 500: \(isAnyProductPriceMoreThan500)")
// is any product price > 500: false

print("// using Swift Array.some() built-in method \"Array.contains\"")

isAnyProductPriceLessThan500 = products.contains { (product: Any?) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result < 500)
}
print("is any product price < 500: \(isAnyProductPriceLessThan500)")
// is any product price < 500: true

isAnyProductPriceMoreThan500 = products.contains { (product: Any?) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result > 500)
}
print("is any product price > 500: \(isAnyProductPriceMoreThan500)")
// is any product price > 500: false
