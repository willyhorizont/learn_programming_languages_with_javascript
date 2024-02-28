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

func spreadSyntaxObject(_ parameters: Any?...) -> MyObject {
    var newObject = MyObject()
    for (_, parameter) in parameters.enumerated() {
        if parameter is MyObject {
            guard let parameter = parameter as? MyObject else {
                continue
            }
            for (objectKey, objectValue) in parameter {
                newObject[objectKey] = objectValue
            }
            continue
        }
        if parameter is MyArray {
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

func arrayMapV1(_ callbackFunction: (Any?, Int, MyArray) -> Any?, _ anArray: MyArray) -> MyArray {
    // JavaScript-like Array.map() function
    var newArray = MyArray()
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        let newArrayItem = callbackFunction(arrayItem, arrayItemIndex, anArray)
        newArray.append(newArrayItem)
    }
    return newArray
}

func arrayMapV2(_ callbackFunction: (Any?, Int, MyArray) -> Any?, _ anArray: MyArray) -> MyArray {
    // JavaScript-like Array.map() function
    var newArray = MyArray()
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        newArray.append(callbackFunction(arrayItem, arrayItemIndex, anArray))
    }
    return newArray
}

print("\n// JavaScript-like Array.map() in Swift [Any?] (Array)")

let numbers: MyArray = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("numbers: \(prettyArrayOfPrimitives(numbers))")

var numbersLabeled: MyArray

print("// using JavaScript-like Array.map() function \"arrayMapV1\"")

numbersLabeled = arrayMapV1({ (number: Any?, _: Int, _: MyArray) -> Any? in
    guard let result = number as? Int else {
        return nil
    }
    return [
        String(result): (result % 2) == 0 ? "even" : "odd"
    ] as MyObject
}, numbers)
print("labeled numbers: \(prettyJsonStringify(numbersLabeled))")
// labeled numbers: [
//     {
//         "12": "even"
//     },
//     {
//         "34": "even"
//     },
//     {
//         "27": "odd"
//     },
//     {
//         "23": "odd"
//     },
//     {
//         "65": "odd"
//     },
//     {
//         "93": "odd"
//     },
//     {
//         "36": "even"
//     },
//     {
//         "87": "odd"
//     },
//     {
//         "4": "even"
//     },
//     {
//         "254": "even"
//     }
// ]

print("// using JavaScript-like Array.map() function \"arrayMapV2\"")

numbersLabeled = arrayMapV2({ (number: Any?, _: Int, _: MyArray) -> Any? in
    guard let result = number as? Int else {
        return nil
    }
    return [
        String(result): (result % 2) == 0 ? "even" : "odd"
    ] as MyObject
}, numbers)
print("labeled numbers: \(prettyJsonStringify(numbersLabeled))")
// labeled numbers: [
//     {
//         "12": "even"
//     },
//     {
//         "34": "even"
//     },
//     {
//         "27": "odd"
//     },
//     {
//         "23": "odd"
//     },
//     {
//         "65": "odd"
//     },
//     {
//         "93": "odd"
//     },
//     {
//         "36": "even"
//     },
//     {
//         "87": "odd"
//     },
//     {
//         "4": "even"
//     },
//     {
//         "254": "even"
//     }
// ]

print("// using Swift Array.map() built-in method \"Array.map\"")

numbersLabeled = numbers.map { (number: Any?) -> Any? in
    guard let result = number as? Int else {
        return nil
    }
    return [
        String(result): (result % 2) == 0 ? "even" : "odd"
    ] as MyObject
}
print("labeled numbers: \(prettyJsonStringify(numbersLabeled))")
// labeled numbers: [
//     {
//         "12": "even"
//     },
//     {
//         "34": "even"
//     },
//     {
//         "27": "odd"
//     },
//     {
//         "23": "odd"
//     },
//     {
//         "65": "odd"
//     },
//     {
//         "93": "odd"
//     },
//     {
//         "36": "even"
//     },
//     {
//         "87": "odd"
//     },
//     {
//         "4": "even"
//     },
//     {
//         "254": "even"
//     }
// ]

print("\n// JavaScript-like Array.map() in Swift [[String, Any?]] (Array of Dictionaries)")

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

var productsLabeled: MyArray

print("// using JavaScript-like Array.map() function \"arrayMapV1\"")

productsLabeled = arrayMapV1({ (product: Any?, _: Int, _: MyArray) -> Any? in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return nil
    }
    return spreadSyntaxObject(product, ["label": result > 100 ? "expensive" : "cheap"] as MyObject)
}, products)
print("labeled products: \(prettyJsonStringify(productsLabeled))")
// labeled products: [
//     {
//         "code": "pasta",
//         "price": 321,
//         "label": "expensive"
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233,
//         "label": "expensive"
//     },
//     {
//         "code": "potato_chips",
//         "price": 5,
//         "label": "cheap"
//     },
//     {
//         "code": "towel",
//         "price": 499,
//         "label": "expensive"
//     }
// ]

print("// using JavaScript-like Array.map() function \"arrayMapV2\"")

productsLabeled = arrayMapV2({ (product: Any?, _: Int, _: MyArray) -> Any? in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return nil
    }
    return spreadSyntaxObject(product, ["label": result > 100 ? "expensive" : "cheap"] as MyObject)
}, products)
print("labeled products: \(prettyJsonStringify(productsLabeled))")
// labeled products: [
//     {
//         "code": "pasta",
//         "price": 321,
//         "label": "expensive"
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233,
//         "label": "expensive"
//     },
//     {
//         "code": "potato_chips",
//         "price": 5,
//         "label": "cheap"
//     },
//     {
//         "code": "towel",
//         "price": 499,
//         "label": "expensive"
//     }
// ]

print("// using Swift Array.map() built-in method \"Array.map\"")

productsLabeled = products.map { (product: Any?) -> Any? in
    guard let result = product as? MyObject, let result = result["price"] as? Int else {
        return nil
    }
    return spreadSyntaxObject(product, ["label": result > 100 ? "expensive" : "cheap"] as MyObject)
}
print("labeled products: \(prettyJsonStringify(productsLabeled))")
// labeled products: [
//     {
//         "code": "pasta",
//         "price": 321,
//         "label": "expensive"
//     },
//     {
//         "code": "bubble_gum",
//         "price": 233,
//         "label": "expensive"
//     },
//     {
//         "code": "potato_chips",
//         "price": 5,
//         "label": "cheap"
//     },
//     {
//         "code": "towel",
//         "price": 499,
//         "label": "expensive"
//     }
// ]
