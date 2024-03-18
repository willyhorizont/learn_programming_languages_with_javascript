import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

func arrayReduce(_ callbackFunction: (Any?, Any?, Int, MyArray) -> Any?, _ anArray: MyArray, _ initialValue: Any?) -> Any? {
    // JavaScript-like Array.reduce() function
    var result = initialValue
    for (arrayItemIndex, arrayItem) in anArray.enumerated() {
        result = callbackFunction(result, arrayItem, arrayItemIndex, anArray)
    }
    return result
}

func getDouble(_ anything: Any?) -> Double? {
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

let numbers: MyArray = [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3]

var numbersTotal: Any?

numbersTotal = arrayReduce({ (currentResult: Any?, currentNumber: Any?, _: Int, _: MyArray) -> Any? in
    if let currentResultDouble = getDouble(currentResult), let currentNumberDouble = getDouble(currentNumber) {
        return currentResultDouble + currentNumberDouble
    }
    return currentResult
}, numbers, 0.0)
print("total number: \(numbersTotal ?? "nil")")
// total number: 41.2

numbersTotal = numbers.reduce(0.0) { (currentResult: Any?, currentNumber: Any?) -> Any? in
    if let currentResultDouble = getDouble(currentResult), let currentNumberDouble = getDouble(currentNumber) {
        return currentResultDouble + currentNumberDouble
    }
    return currentResult
}
print("total number: \(numbersTotal ?? "nil")")
// total number: 41.2
