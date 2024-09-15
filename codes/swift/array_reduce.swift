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

func toDouble(_ anything: Any?) -> Double? {
    guard let anything = anything else {
        return nil
    }
    if let doubleValue = anything as? Double {
        return doubleValue
    }
    if let floatValue = anything as? Float {
        return Double(floatValue)
    }
    if let floatValue = anything as? Float16 {
        return Double(floatValue)
    }
    if let floatValue = anything as? Float32 {
        return Double(floatValue)
    }
    if let floatValue = anything as? Float64 {
        return Double(floatValue)
    }
    if let floatValue = anything as? Float80 {
        return Double(floatValue)
    }
    if let intValue = anything as? Int {
        return Double(intValue)
    }
    if let intValue = anything as? Int8 {
        return Double(intValue)
    }
    if let intValue = anything as? Int16 {
        return Double(intValue)
    }
    if let intValue = anything as? Int32 {
        return Double(intValue)
    }
    if let intValue = anything as? Int64 {
        return Double(intValue)
    }
    if let uintValue = anything as? UInt {
        return Double(uintValue)
    }
    if let uintValue = anything as? UInt8 {
        return Double(uintValue)
    }
    if let uintValue = anything as? UInt16 {
        return Double(uintValue)
    }
    if let uintValue = anything as? UInt32 {
        return Double(uintValue)
    }
    if let uintValue = anything as? UInt64 {
        return Double(uintValue)
    }
    return nil
}

func arrayReduce(_ callbackFunction: (Any?, Any?, Int, MyArray) -> Any?, _ anArray: MyArray, _ initialValue: Any?) -> Any? {
    // JavaScript-like Array.reduce() function
    var result = initialValue
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
    }
    return result
}

print("\n// JavaScript-like Array.reduce() in Swift Array")

let numbers: MyArray = [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3]
print("numbers: \(jsonStringify(numbers))")

var numbersTotal: Any?

print("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

numbersTotal = arrayReduce({ (currentResult: Any?, currentNumber: Any?, _: Int, _: MyArray) -> Any? in
    if let currentResultDouble = toDouble(currentResult), let currentNumberDouble = toDouble(currentNumber) {
        return (currentResultDouble + currentNumberDouble)
    }
    return currentResult
}, numbers, 0.0)
print("total number: \(numbersTotal ?? "null")")
// total number: 41.2

print("// using Swift Array.reduce() built-in method \"Array.reduce\"")

numbersTotal = numbers.reduce(0.0) { (currentResult: Any?, currentNumber: Any?) -> Any? in
    if let currentResultDouble = toDouble(currentResult), let currentNumberDouble = toDouble(currentNumber) {
        return (currentResultDouble + currentNumberDouble)
    }
    return currentResult
}
print("total number: \(numbersTotal ?? "null")")
// total number: 41.2

print("\n// JavaScript-like Array.reduce() in Swift Array of Dictionaries")

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

var productsGrouped: Any?

print("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

productsGrouped = arrayReduce({ (currentResult: Any?, currentProduct: Any?, _: Int, _: MyArray) -> Any? in
    guard let currentResult = currentResult as? MyObject, let arrayExpensive = currentResult["expensive"], let arrayCheap = currentResult["cheap"], let currentProduct = currentProduct as? MyObject, let currentProductPrice = currentProduct["price"] as? Int else {
        return nil
    }
    return ((currentProductPrice > 100) ? spreadObject(currentResult, ["expensive": spreadArray(arrayExpensive, ["currentProduct": currentProduct] as MyObject)]) : spreadObject(currentResult, ["cheap": spreadArray(arrayCheap, ["currentProduct": currentProduct] as MyObject)]))
}, products, ["expensive": MyArray(), "cheap": MyArray()] as MyObject)
print("grouped products: \(jsonStringify(productsGrouped, pretty: true))")
// grouped products: {
//     "expensive": [
//         {
//             "code": "pasta",
//             "price": 321
//         },
//         {
//             "code": "bubble_gum",
//             "price": 233
//         },
//         {
//             "code": "towel",
//             "price": 499
//         }
//     ],
//     "cheap": [
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }

print("// using Swift Array.reduce() built-in method \"Array.reduce\"")

productsGrouped = products.reduce(["expensive": MyArray(), "cheap": MyArray()] as MyObject) { (currentResult: Any?, currentProduct: Any?) -> Any? in
    guard let currentResult = currentResult as? MyObject, let arrayExpensive = currentResult["expensive"], let arrayCheap = currentResult["cheap"], let currentProduct = currentProduct as? MyObject, let currentProductPrice = currentProduct["price"] as? Int else {
        return nil
    }
    return ((currentProductPrice > 100) ? spreadObject(currentResult, ["expensive": spreadArray(arrayExpensive, ["currentProduct": currentProduct] as MyObject)]) : spreadObject(currentResult, ["cheap": spreadArray(arrayCheap, ["currentProduct": currentProduct] as MyObject)]))
}
print("grouped products: \(jsonStringify(productsGrouped, pretty: true))")
// grouped products: {
//     "expensive": [
//         {
//             "code": "pasta",
//             "price": 321
//         },
//         {
//             "code": "bubble_gum",
//             "price": 233
//         },
//         {
//             "code": "towel",
//             "price": 499
//         }
//     ],
//     "cheap": [
//         {
//             "code": "potato_chips",
//             "price": 5
//         }
//     ]
// }
