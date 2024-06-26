import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

// There's no JavaScript-like Array.findIndex() in Swift.
// But, we can create our own function to mimic it in Swift.

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

func arrayFindIndexV1(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Int {
    // JavaScript-like Array.findIndex() function
    var dataFoundIndex = -1
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        let isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            dataFoundIndex = arrayItemIndex
            break
        }
    }
    return dataFoundIndex
}

func arrayFindIndexV2(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Int {
    // JavaScript-like Array.findIndex() function
    var dataFoundIndex = -1
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
            dataFoundIndex = arrayItemIndex
            break
        }
    }
    return dataFoundIndex
}

func arrayFindIndexV3(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Int {
    // JavaScript-like Array.findIndex() function
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        let isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            return arrayItemIndex
        }
    }
    return -1
}

func arrayFindIndexV4(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Int {
    // JavaScript-like Array.findIndex() function
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
            return arrayItemIndex
        }
    }
    return -1
}

print("\n// JavaScript-like Array.findIndex() in Swift Array")

let numbers: MyArray = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("numbers: \(jsonStringify(numbers))")

let numberToFind = 27
print("number to find: \(numberToFind)")

var numberFoundIndex: Int

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

numberFoundIndex = arrayFindIndexV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result == numberToFind)
}, numbers)
print("number found index: \(numberFoundIndex)")
// number found index: 2

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

numberFoundIndex = arrayFindIndexV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result == numberToFind)
}, numbers)
print("number found index: \(numberFoundIndex)")
// number found index: 2

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"")

numberFoundIndex = arrayFindIndexV3({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result == numberToFind)
}, numbers)
print("number found index: \(numberFoundIndex)")
// number found index: 2

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"")

numberFoundIndex = arrayFindIndexV4({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result == numberToFind)
}, numbers)
print("number found index: \(numberFoundIndex)")
// number found index: 2

print("// using Swift Array.findIndex() built-in method \"Array.firstIndex\"")

numberFoundIndex = (numbers.firstIndex { (number: Any?) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result == numberToFind)
} ?? -1)
print("number found index: \(numberFoundIndex)")
// number found index: 2

print("\n// JavaScript-like Array.findIndex() in Swift Array of Dictionaries")

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

let productToFind = "pasta"
print("product to find: \(productToFind)")

var productFoundIndex: Int

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

productFoundIndex = arrayFindIndexV1({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return (result == productToFind)
}, products)
print("product found index: \(productFoundIndex)")
// product found index: 0

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

productFoundIndex = arrayFindIndexV2({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return (result == productToFind)
}, products)
print("product found index: \(productFoundIndex)")
// product found index: 0

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"")

productFoundIndex = arrayFindIndexV3({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return (result == productToFind)
}, products)
print("product found index: \(productFoundIndex)")
// product found index: 0

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"")

productFoundIndex = arrayFindIndexV4({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return (result == productToFind)
}, products)
print("product found index: \(productFoundIndex)")
// product found index: 0

print("// using Swift Array.findIndex() built-in method \"Array.firstIndex\"")

productFoundIndex = (products.firstIndex { (product: Any?) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return (result == productToFind)
} ?? -1)
print("product found index: \(productFoundIndex)")
// product found index: 0
