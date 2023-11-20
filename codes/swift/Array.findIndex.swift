import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

// There's no JavaScript-like Array.findIndex() in Swift.
// But, we can create our own function to mimic it in Swift.

func prettyArrayOfPrimitives(_ anArrayOfPrimitives: MyArray) -> String {
    var result = "["
    for (arrayItemIndex, arrayItem) in anArrayOfPrimitives.enumerated() {
        if (((arrayItem is String) == false) && ((arrayItem is NSNumber) == false)) {
            continue
        }
        if let arrayItem = arrayItem as? String {
            result += "\"\(arrayItem)\""
        }
        if let arrayItem = arrayItem as? NSNumber {
            result += "\(arrayItem)"
        }
        if ((arrayItemIndex + 1) != anArrayOfPrimitives.count) {
            result += ", "
        }
        
    }
    result += "]"
    return result
}

func prettyJsonStringify(_ anything: Any? = nil, indent: String? = "    ") -> String {
    var indentLevel = 0
    func prettyJsonStringifyInnerFunction(_ anything: Any? = nil, _ indent: String? = "    ") -> String {
        guard let anything = anything else {
            return "undefined"
        }
        if (anything as? String == "null") {
            return "null"
        }
        if (anything as? String == "undefined") {
            return "undefined"
        }
        if let anything = anything as? String {
            return "\"\(anything)\""
        }
        if let anything = anything as? NSNumber {
            return "\(anything)"
        }
        if let anything = anything as? Bool {
            return "\(anything)"
        }
        if let anything = anything as? MyArray {
            indentLevel += 1
            var result = "[\n\(String(repeating: indent ?? "    ", count: indentLevel))"
            for (arrayItemIndex, arrayItem) in anything.enumerated() {
                result += prettyJsonStringifyInnerFunction(arrayItem, indent)
                if ((arrayItemIndex + 1) != anything.count) {
                    result += ",\n\(String(repeating: indent ?? "    ", count: indentLevel))"
                }
            }
            indentLevel -= 1
            result += "\n\(String(repeating: indent ?? "    ", count: indentLevel))]"
            return result
        }
        if let anything = anything as? MyObject {
            indentLevel += 1
            var result = "{\n\(String(repeating: indent ?? "    ", count: indentLevel))"
            for (entryIndex, (objectKey, objectValue)) in anything.enumerated() {
                result += "\"\(objectKey)\": \(prettyJsonStringifyInnerFunction(objectValue, indent))"
                if ((entryIndex + 1) != anything.count) {
                    result += ",\n\(String(repeating: indent ?? "    ", count: indentLevel))"
                }
            }
            indentLevel -= 1
            result += "\n\(String(repeating: indent ?? "    ", count: indentLevel))}"
            return result
        }
        return "undefined"
    }
    return prettyJsonStringifyInnerFunction(anything, indent)
}

func arrayFindIndexV1(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Int {
    // JavaScript-like Array.findIndex() function
    var itemIndex = -1
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        let isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            itemIndex = arrayItemIndex
            break
        }
    }
    return itemIndex
}

func arrayFindIndexV2(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Int {
    // JavaScript-like Array.findIndex() function
    var itemIndex = -1
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
            itemIndex = arrayItemIndex
            break
        }
    }
    return itemIndex
}

func arrayFindIndexV3(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Int {
    // JavaScript-like Array.findIndex() function
    let itemIndex = -1
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        let isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            return arrayItemIndex
        }
    }
    return itemIndex
}

func arrayFindIndexV4(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Int {
    // JavaScript-like Array.findIndex() function
    let itemIndex = -1
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
            return arrayItemIndex
        }
    }
    return itemIndex
}

func arrayFindIndexV5(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Int {
    // JavaScript-like Array.findIndex() function
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        let isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            return arrayItemIndex
        }
    }
    return -1
}

func arrayFindIndexV6(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> Int {
    // JavaScript-like Array.findIndex() function
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
            return arrayItemIndex
        }
    }
    return -1
}

print("\n// JavaScript-like Array.findIndex() in Swift [Any?]")

let numbers: MyArray = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("numbers: \(prettyArrayOfPrimitives(numbers))")

let numberToFind = 27
print("number to find: \(numberToFind)")

var numberFoundIndex: Int

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

numberFoundIndex = arrayFindIndexV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result == numberToFind
}, numbers)
print("number found index: \(numberFoundIndex)")
// number found index: 2

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

numberFoundIndex = arrayFindIndexV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result == numberToFind
}, numbers)
print("number found index: \(numberFoundIndex)")
// number found index: 2

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"")

numberFoundIndex = arrayFindIndexV3({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result == numberToFind
}, numbers)
print("number found index: \(numberFoundIndex)")
// number found index: 2

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"")

numberFoundIndex = arrayFindIndexV4({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result == numberToFind
}, numbers)
print("number found index: \(numberFoundIndex)")
// number found index: 2

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV5\"")

numberFoundIndex = arrayFindIndexV5({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result == numberToFind
}, numbers)
print("number found index: \(numberFoundIndex)")
// number found index: 2

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV6\"")

numberFoundIndex = arrayFindIndexV6({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result == numberToFind
}, numbers)
print("number found index: \(numberFoundIndex)")
// number found index: 2

print("// using Swift Array.findIndex() built-in method \"Array.firstIndex\"")

numberFoundIndex = numbers.firstIndex { (number: Any?) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return result == numberToFind
} ?? -1
print("number found index: \(numberFoundIndex)")
// number found index: 2

print("\n// JavaScript-like Array.findIndex() in Swift [[String, Any?]]")

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

var productFoundIndex: Int

let productToFind = "pasta"
print("product to find: \(productToFind)")

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"")

productFoundIndex = arrayFindIndexV1({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return result == productToFind
}, products)
print("product found index: \(productFoundIndex)")
// product found index: 0

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"")

productFoundIndex = arrayFindIndexV2({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return result == productToFind
}, products)
print("product found index: \(productFoundIndex)")
// product found index: 0

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"")

productFoundIndex = arrayFindIndexV3({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return result == productToFind
}, products)
print("product found index: \(productFoundIndex)")
// product found index: 0

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"")

productFoundIndex = arrayFindIndexV4({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return result == productToFind
}, products)
print("product found index: \(productFoundIndex)")
// product found index: 0

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV5\"")

productFoundIndex = arrayFindIndexV5({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return result == productToFind
}, products)
print("product found index: \(productFoundIndex)")
// product found index: 0

print("// using JavaScript-like Array.findIndex() function \"arrayFindIndexV6\"")

productFoundIndex = arrayFindIndexV6({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return result == productToFind
}, products)
print("product found index: \(productFoundIndex)")
// product found index: 0

print("// using Swift Array.findIndex() built-in method \"Array.firstIndex\"")

productFoundIndex = products.firstIndex { (product: Any?) -> Bool in
    guard let result = product as? MyObject, let result = result["code"] as? String else {
        return false
    }
    return result == productToFind
} ?? -1
print("product found index: \(productFoundIndex)")
// product found index: 0
