import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

// There's no JavaScript-like Array.filter() in Swift.
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

print("\n// JavaScript-like Array.filter() in Swift Array")

let numbers: MyArray = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("numbers: \(jsonStringify(numbers))")

var numbersEven: MyArray
var numbersOdd: MyArray

print("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

numbersEven = arrayFilterV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return ((result % 2) == 0)
}, numbers)
print("even numbers only: \(jsonStringify(numbersEven))")
// even numbers only: [12, 34, 36, 4, 254]

numbersOdd = arrayFilterV1({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return ((result % 2) != 0)
}, numbers)
print("odd numbers only: \(jsonStringify(numbersOdd))")
// odd numbers only: [27, 23, 65, 93, 87]

print("// using JavaScript-like Array.filter() function \"arrayFilterV2\"")

numbersEven = arrayFilterV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return ((result % 2) == 0)
}, numbers)
print("even numbers only: \(jsonStringify(numbersEven))")
// even numbers only: [12, 34, 36, 4, 254]

numbersOdd = arrayFilterV2({ (number: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = number as? Int else {
        return false
    }
    return ((result % 2) != 0)
}, numbers)
print("odd numbers only: \(jsonStringify(numbersOdd))")
// odd numbers only: [27, 23, 65, 93, 87]

print("// using Swift Array.filter() built-in method \"Array.filter\"")

numbersEven = numbers.filter {
    guard let result = $0 as? Int else {
        return false
    }
    return ((result % 2) == 0)
}
print("even numbers only: \(jsonStringify(numbersEven))")
// even numbers only: [12, 34, 36, 4, 254]

numbersOdd = numbers.filter {
    guard let result = $0 as? Int else {
        return false
    }
    return ((result % 2) != 0)
}
print("odd numbers only: \(jsonStringify(numbersOdd))")
// odd numbers only: [27, 23, 65, 93, 87]

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
print("products: \(jsonStringify(products, pretty: true))")

var productsBelow100: MyArray
var productsAbove100: MyArray

print("// using JavaScript-like Array.filter() function \"arrayFilterV1\"")

productsBelow100 = arrayFilterV1({ (product: Any?, _: Int, _: MyArray) -> Bool in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result <= 100)
}, products)
print("products with price <= 100 only: \(jsonStringify(productsBelow100, pretty: true))")
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
    return (result > 100)
}, products)
print("products with price > 100 only: \(jsonStringify(productsAbove100, pretty: true))")
// products with price > 100 only: [
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
    return (result <= 100)
}, products)
print("products with price <= 100 only: \(jsonStringify(productsBelow100, pretty: true))")
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
    return (result > 100)
}, products)
print("products with price > 100 only: \(jsonStringify(productsAbove100, pretty: true))")
// products with price > 100 only: [
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

print("// using Swift Array.filter() built-in method \"Array.filter\"")

productsBelow100 = products.filter {
    guard let result = $0 as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result <= 100)
}
print("products with price <= 100 only: \(jsonStringify(productsBelow100, pretty: true))")
// products with price <= 100 only: [
//     {
//         "code": "potato_chips",
//         "price": 5
//     }
// ]

productsAbove100 = products.filter {
    guard let result = $0 as? MyObject, let result = result["price"] as? Int else {
        return false
    }
    return (result > 100)
}
print("products with price > 100 only: \(jsonStringify(productsAbove100, pretty: true))")
// products with price > 100 only: [
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
