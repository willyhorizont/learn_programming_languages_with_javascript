import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

print("\n// JavaScript-like Optional Chaining Operator (?.) in Swift")

func prettyJsonStringify(_ anything: Any? = nil, indent: String = "    ") -> String {
    var indentLevel = 0
    func prettyJsonStringifyInner(_ anythingInner: Any?, _ indentInner: String) -> String {
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
        return "null"
    }
    return prettyJsonStringifyInner(anything, indent)
}

let JSON_OBJECT: MyObject = [
    "foo": [
        "bar": "baz"
    ] as MyObject,
    "fruits": ["apple", "mango", "banana"] as MyArray
]
print("JSON_OBJECT: \(prettyJsonStringify(JSON_OBJECT))")

if let result = JSON_OBJECT["foo"] as? MyObject {
    if let result = result["bar"] {
        if let result = result {
            print("JSON_OBJECT?.foo?.bar:", result)
        } else {
            print("JSON_OBJECT?.foo?.bar: undefined")
        }
    } else {
        print("JSON_OBJECT?.foo?.bar: undefined")
    }
} else {
    print("JSON_OBJECT?.foo?.bar: undefined")
}
// JSON_OBJECT?.foo?.bar: baz

if let result = JSON_OBJECT["foo"] as? MyObject {
    if let result = result["baz"] {
        if let result = result {
            print("JSON_OBJECT?.foo?.baz:", result)
        } else {
            print("JSON_OBJECT?.foo?.baz: undefined")
        }
    } else {
        print("JSON_OBJECT?.foo?.baz: undefined")
    }
} else {
    print("JSON_OBJECT?.foo?.baz: undefined")
}
// JSON_OBJECT?.foo?.baz: undefined

print("JSON_OBJECT?.foo?.bar:", prettyJsonStringify({ () -> Any? in
    guard let result = JSON_OBJECT["foo"] as? MyObject, let result = result["bar"] else {
        return nil
    }
    return result
}()))
// JSON_OBJECT?.foo?.bar: "baz"

print("JSON_OBJECT?.foo?.baz:", prettyJsonStringify({ () -> Any? in
    guard let result = JSON_OBJECT["foo"] as? MyObject, let result = result["baz"] else {
        return nil
    }
    return result
}()))
// JSON_OBJECT?.foo?.baz: undefined

if let result = JSON_OBJECT["fruits"] as? MyArray {
    if let result = result.indices.contains(2) ? result[2] : nil {
        print("JSON_OBJECT?.fruits?.[2]:", result)
    } else {
        print("JSON_OBJECT?.fruits?.[2]: undefined")
    }
} else {
    print("JSON_OBJECT?.fruits?.[2]: undefined")
}
// JSON_OBJECT?.fruits?.[2]: banana

if let result = JSON_OBJECT["fruits"] as? MyArray {
    if let result = result.indices.contains(5) ? result[5] : nil {
        print("JSON_OBJECT?.fruits?.[5]:", result)
    } else {
        print("JSON_OBJECT?.fruits?.[5]: undefined")
    }
} else {
    print("JSON_OBJECT?.fruits?.[5]: undefined")
}
// JSON_OBJECT?.fruits?.[5]: undefined

print("JSON_OBJECT?.fruits?.[2]:", prettyJsonStringify({ () -> Any? in
    guard let result = JSON_OBJECT["fruits"] as? MyArray else {
        return nil
    }
    return result.indices.contains(2) ? result[2] : nil
}()))
// JSON_OBJECT?.fruits?.[2]: "banana"

print("JSON_OBJECT?.fruits?.[5]:", prettyJsonStringify({ () -> Any? in
    guard let result = JSON_OBJECT["fruits"] as? MyArray else {
        return nil
    }
    return result.indices.contains(5) ? result[5] : nil
}()))
// JSON_OBJECT?.fruits?.[5]: undefined
