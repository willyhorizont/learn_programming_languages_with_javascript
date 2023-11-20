import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

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

func spreadSyntaxArray(_ parameters: Any?...) -> MyArray {
    var newArray = MyArray()
    for (_, parameter) in parameters.enumerated() {
        if parameter is MyObject {
            guard let parameter = parameter as? MyObject else {
                continue
            }
            if (parameter.count == 1) {
                for (_, objectValue) in parameter {
                    newArray.append(objectValue)
                }
                continue
            }
            newArray.append(parameter)
            continue
        }
        if parameter is MyArray {
            guard let parameter = parameter as? MyArray else {
                continue
            }
            for (_, arrayItem) in parameter.enumerated() {
                newArray.append(arrayItem)
            }
            continue
        }
    }
    return newArray
}

func arrayReduce(_ callbackFunction: (Any?, Any?, Int, MyArray) -> Any?, _ anArray: MyArray, _ initialValue: Any?) -> Any? {
    // JavaScript-like Array.reduce() function
    var result = initialValue
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
    }
    return result
}

print("\n// JavaScript-like Array.reduce() in Swift [Any?]")

let numbers: MyArray = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("numbers: \(prettyArrayOfPrimitives(numbers))")

var numbersTotal: Any?

print("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

numbersTotal = arrayReduce({ (currentResult: Any?, currentNumber: Any?, _: Int, _: MyArray) -> Any? in
    guard let currentResult = currentResult as? Int, let currentNumber = currentNumber as? Int else {
        return nil
    }
    return currentResult + currentNumber
}, numbers, 0)
print("total number: \(numbersTotal ?? "undefined")")
// total number: 635

print("// using Swift Array.reduce() built-in method \"Array.reduce\"")

numbersTotal = numbers.reduce(0) { (currentResult: Any?, currentNumber: Any?) -> Any? in
    guard let currentResult = currentResult as? Int, let currentNumber = currentNumber as? Int else {
        return nil
    }
    return currentResult + currentNumber
}
print("total number: \(numbersTotal ?? "undefined")")
// total number: 635

print("\n// JavaScript-like Array.map() in Swift [[String, Any?]]")

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

var productsGrouped: Any?

print("// using JavaScript-like Array.reduce() function \"arrayReduce\"")

productsGrouped = arrayReduce({ (currentResult: Any?, currentProduct: Any?, _: Int, _: MyArray) -> Any? in
    guard let currentResult = currentResult as? MyObject, let arrayExpensive = currentResult["expensive"], let arrayCheap = currentResult["cheap"], let currentProduct = currentProduct as? MyObject, let currentProductPrice = currentProduct["price"] as? Int else {
        return nil
    }
    return currentProductPrice > 100 ? spreadSyntaxObject(currentResult, ["expensive": spreadSyntaxArray(arrayExpensive, ["currentProduct": currentProduct] as MyObject)]) : spreadSyntaxObject(currentResult, ["cheap": spreadSyntaxArray(arrayCheap, ["currentProduct": currentProduct] as MyObject)])
}, products, ["expensive": MyArray(), "cheap": MyArray()] as MyObject)
print("grouped products: \(prettyJsonStringify(productsGrouped))")
// grouped products: {
// 	"expensive": [
// 		{
// 			"code": "pasta",
// 			"price": 321
// 		},
// 		{
// 			"code": "bubble_gum",
// 			"price": 233
// 		},
// 		{
// 			"code": "towel",
// 			"price": 499
// 		}
// 	],
// 	"cheap": [
// 		{
// 			"code": "potato_chips",
// 			"price": 5
// 		}
// 	]
// }

print("// using Swift Array.reduce() built-in method \"Array.reduce\"")

productsGrouped = products.reduce(["expensive": MyArray(), "cheap": MyArray()] as MyObject) { (currentResult: Any?, currentProduct: Any?) -> Any? in
    guard let currentResult = currentResult as? MyObject, let arrayExpensive = currentResult["expensive"], let arrayCheap = currentResult["cheap"], let currentProduct = currentProduct as? MyObject, let currentProductPrice = currentProduct["price"] as? Int else {
        return nil
    }
    return currentProductPrice > 100 ? spreadSyntaxObject(currentResult, ["expensive": spreadSyntaxArray(arrayExpensive, ["currentProduct": currentProduct] as MyObject)]) : spreadSyntaxObject(currentResult, ["cheap": spreadSyntaxArray(arrayCheap, ["currentProduct": currentProduct] as MyObject)])
}
print("grouped products: \(prettyJsonStringify(productsGrouped))")
// grouped products: {
// 	"expensive": [
// 		{
// 			"code": "pasta",
// 			"price": 321
// 		},
// 		{
// 			"code": "bubble_gum",
// 			"price": 233
// 		},
// 		{
// 			"code": "towel",
// 			"price": 499
// 		}
// 	],
// 	"cheap": [
// 		{
// 			"code": "potato_chips",
// 			"price": 5
// 		}
// 	]
// }
