import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

print("\n// JavaScript-like Nullish Coalescing Operator (??) in Swift")

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

func optionalChaining(_ anything: Any? = nil, _ objectPropertiesArray: Any?...) -> Any? {
    // JavaScript-like Optional Chaining Operator (?.) function
    if ((((anything is MyObject) == false) && ((anything is MyArray) == false)) || (objectPropertiesArray.count == 0)) {
        return anything
    }
    return objectPropertiesArray.reduce(nil) { (currentResult: Any?, currentItem: Any?) -> Any? in
        guard let currentItem = currentItem else {
            return nil
        }
        guard let currentResult = currentResult else {
            if let anything = anything as? MyObject, let currentItem = currentItem as? String {
                return anything[currentItem] as Any?
            }
            if let anything = anything as? MyArray, let currentItem = currentItem as? Int {
                return (((currentItem >= 0) && (anything.count > currentItem)) ? anything[currentItem] : nil) as Any?
            }
            return nil
        }
        if let currentResult = currentResult as? MyObject, let currentItem = currentItem as? String {
            return currentResult[currentItem] as Any?
        }
        if let currentResult = currentResult as? MyArray, let currentItem = currentItem as? Int {
            return (((currentItem >= 0) && (currentResult.count > currentItem)) ? currentResult[currentItem] : nil) as Any?
        }
        return nil
    }
}

var JSON_OBJECT: MyObject = [
    "foo": [
        "bar": "baz"
    ] as MyObject,
    "fruits": ["apple", "mango", "banana"] as MyArray
]
print("JSON_OBJECT: \(jsonStringify(JSON_OBJECT, pretty: true))")

print("// using JavaScript-like Optional Chaining Operator (?.) function \"optionalChaining\"")

print("(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'):", (optionalChaining(JSON_OBJECT, "foo", "bar") as? String ?? "not found"))
// (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): baz

print("(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'):", (optionalChaining(JSON_OBJECT, "foo", "baz") as? String ?? "not found"))
// (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): not found

print("(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'):", (optionalChaining(JSON_OBJECT, "fruits", 2) as? String ?? "not found"))
// (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): banana

print("(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'):", (optionalChaining(JSON_OBJECT, "fruits", 5) as? String ?? "not found"))
// (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): not found
