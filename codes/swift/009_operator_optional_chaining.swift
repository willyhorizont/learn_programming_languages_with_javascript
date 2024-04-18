import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

print("\n// JavaScript-like Optional Chaining Operator (?.) in Swift")

// There's no JavaScript-like Optional Chaining Operator (?.) in Swift.
// But, we can use Swift "optional binding" syntax or we can create our own function to mimic it in Swift.

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

let JSON_OBJECT: MyObject = [
    "foo": [
        "bar": "baz"
    ] as MyObject,
    "fruits": ["apple", "mango", "banana"] as MyArray
]
print("JSON_OBJECT: \(jsonStringify(JSON_OBJECT, pretty: true))")

print("// using Swift optional binding syntax \"if let\"")

print("JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']:", jsonStringify({ () -> Any? in
    if let result = JSON_OBJECT["foo"] as? MyObject {
        if let result = result["bar"] {
            if let result = result {
                return result
            }
        }
    }
    return nil
}()))
// JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: baz

print("JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']:", jsonStringify({ () -> Any? in
    if let result = JSON_OBJECT["foo"] as? MyObject {
        if let result = result["baz"] {
            if let result = result {
                return result
            }
        }
    }
    return nil
}()))
// JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: nil

print("JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]:", jsonStringify({ () -> Any? in
    if let result = JSON_OBJECT["fruits"] as? MyArray {
        if let result = ((result.count > 2) ? result[2] : nil) {
            return result
        }
    }
    return nil
}()))
// JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: banana

print("JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]:", jsonStringify({ () -> Any? in
    if let result = JSON_OBJECT["fruits"] as? MyArray {
        if let result = ((result.count > 5) ? result[5] : nil) {
            return result
        }
    }
    return nil
}()))
// JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: nil

print("// using Swift optional binding syntax \"guard let\"")

print("JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']:", jsonStringify({ () -> Any? in
    guard let result = JSON_OBJECT["foo"] as? MyObject, let result = result["bar"] else {
        return nil
    }
    return result
}()))
// JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: "baz"

print("JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']:", jsonStringify({ () -> Any? in
    guard let result = JSON_OBJECT["foo"] as? MyObject, let result = result["baz"] else {
        return nil
    }
    return result
}()))
// JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: nil

print("JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]:", jsonStringify({ () -> Any? in
    guard let result = JSON_OBJECT["fruits"] as? MyArray else {
        return nil
    }
    guard let result = ((result.count > 2) ? result[2] : nil) else {
        return nil
    }
    return result
}()))
// JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: "banana"

print("JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]:", jsonStringify({ () -> Any? in
    guard let result = JSON_OBJECT["fruits"] as? MyArray else {
        return nil
    }
    guard let result = ((result.count > 5) ? result[5] : nil) else {
        return nil
    }
    return result
}()))
// JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: nil

print("// using JavaScript-like Optional Chaining Operator (?.) function \"optionalChaining\"")

print("JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']:", jsonStringify(optionalChaining(JSON_OBJECT, "foo", "bar")))
// JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: "baz"

print("JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']:", jsonStringify(optionalChaining(JSON_OBJECT, "foo", "baz")))
// JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: nil

print("JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]:", jsonStringify(optionalChaining(JSON_OBJECT, "fruits", 2)))
// JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: "banana"

print("JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]:", jsonStringify(optionalChaining(JSON_OBJECT, "fruits", 5)))
// JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: nil
