import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

// There's no JavaScript-like Array.filter() in Swift.
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

func arrayFilterV1(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> MyArray {
    // JavaScript-like Array.filter() function
    var dataFiltered = MyArray()
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        let isConditionMatch = callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == true) {
            dataFiltered.append(arrayItem)
        }
    }
    return dataFiltered
}

func arrayFilterV2(_ callbackFunction: (Any?, Int, MyArray) -> Bool, _ anArray: MyArray) -> MyArray {
    // JavaScript-like Array.filter() function
    var dataFiltered = MyArray()
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == true) {
            dataFiltered.append(arrayItem)
        }
    }
    return dataFiltered
}

print("\n// JavaScript-like Array.filter() in Swift [Any?] (Array)")

let numbers: MyArray = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("numbers: \(prettyArrayOfPrimitives(numbers))")

var numbersEven: MyArray
var numbersOdd: MyArray

print("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

numbersEven = arrayFilterV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result % 2) == 0
}, numbers)
print("even numbers only: \(numbersEven)")
// even numbers only: [12, 34, 36, 4, 254]

numbersOdd = arrayFilterV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result % 2) != 0
}, numbers)
print("odd numbers only: \(numbersOdd)")
// odd numbers only: [27, 23, 65, 93, 87]

print("// using JavaScript-like Array.filter() function \"arrayFilterV2\"")

numbersEven = arrayFilterV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result % 2) == 0
}, numbers)
print("even numbers only: \(numbersEven)")
// even numbers only: [12, 34, 36, 4, 254]

numbersOdd = arrayFilterV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return (result % 2) != 0
}, numbers)
print("odd numbers only: \(numbersOdd)")
// odd numbers only: [27, 23, 65, 93, 87]

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

var productsBelow100: MyArray
var productsAbove100: MyArray

print("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

productsBelow100 = arrayFilterV1({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result <= 100
}, products)
print("products with price <= 100 only: \(prettyJsonStringify(productsBelow100))")
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

productsAbove100 = arrayFilterV1({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result >= 100
}, products)
print("products with price >= 100 only: \(prettyJsonStringify(productsAbove100))")
// products with price >= 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]

print("// using JavaScript-like Array.filter() function \"arrayFilterV2\"")

productsBelow100 = arrayFilterV2({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result <= 100
}, products)
print("products with price <= 100 only: \(prettyJsonStringify(productsBelow100))")
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

productsAbove100 = arrayFilterV2({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return result >= 100
}, products)
print("products with price >= 100 only: \(prettyJsonStringify(productsAbove100))")
// products with price >= 100 only: [
//     {
//         "code": "pasta",
//         "price": 321
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233
//     },
//     {
//         "code": "towel",
//         "price": 499
//     }
// ]
