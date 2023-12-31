import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

print("\n// JavaScript-like Nullish Coalescing Operator (??) in Swift")

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

let JSON_OBJECT: MyObject = [
    "foo": [
        "bar": "baz"
    ] as MyObject,
    "fruits": ["apple", "mango", "banana"] as MyArray
]
print("JSON_OBJECT: \(prettyJsonStringify(JSON_OBJECT))")

if let result = JSON_OBJECT["foo"] as? MyObject {
    if let result = result["bar"] {
        print("JSON_OBJECT?.foo?.bar ?? \"not found\":", result ?? "not found")
    } else {
        print("JSON_OBJECT?.foo?.bar ?? \"not found\": not found")
    }
} else {
    print("JSON_OBJECT?.foo?.bar ?? \"not found\": not found")
}
// JSON_OBJECT?.foo?.bar ?? "not found": baz

if let result = JSON_OBJECT["foo"] as? MyObject {
    if let result = result["baz"] {
        print("JSON_OBJECT?.foo?.baz ?? \"not found\":", result ?? "not found")
    } else {
        print("JSON_OBJECT?.foo?.baz ?? \"not found\": not found")
    }
} else {
    print("JSON_OBJECT?.foo?.baz ?? \"not found\": not found")
}
// JSON_OBJECT?.foo?.baz ?? "not found": not found

print("JSON_OBJECT?.foo?.bar ?? \"not found\":", { () -> Any? in
    guard let result = JSON_OBJECT["foo"] as? MyObject, let result = result["bar"] else {
        return nil
    }
    return result
}() ?? "not found")
// JSON_OBJECT?.foo?.bar ?? "not found": baz

print("JSON_OBJECT?.foo?.baz ?? \"not found\":", { () -> Any? in
    guard let result = JSON_OBJECT["foo"] as? MyObject, let result = result["baz"] else {
        return nil
    }
    return result
}() ?? "not found")
// JSON_OBJECT?.foo?.baz ?? "not found": not found

if let result = JSON_OBJECT["fruits"] as? MyArray {
    let result = result.indices.contains(2) ? result[2] : nil
    print("JSON_OBJECT?.fruits?.[2] ?? \"not found\":", result ?? "not found")
} else {
    print("JSON_OBJECT?.fruits?.[2] ?? \"not found\": not found")
}
// JSON_OBJECT?.fruits?.[2] ?? "not found": banana

if let result = JSON_OBJECT["fruits"] as? MyArray {
    let result = result.indices.contains(5) ? result[5] : nil
    print("JSON_OBJECT?.fruits?.[5] ?? \"not found\":", result ?? "not found")
} else {
    print("JSON_OBJECT?.fruits?.[5] ?? \"not found\": not found")
}
// JSON_OBJECT?.fruits?.[5] ?? "not found": not found

print("JSON_OBJECT?.fruits?.[2] ?? \"not found\":", { () -> Any? in
    guard let result = JSON_OBJECT["fruits"] as? MyArray else {
        return nil
    }
    return result.indices.contains(2) ? result[2] : nil
}() ?? "not found")
// JSON_OBJECT?.fruits?.[2] ?? "not found": banana

print("JSON_OBJECT?.fruits?.[5] ?? \"not found\":", { () -> Any? in
    guard let result = JSON_OBJECT["fruits"] as? MyArray else {
        return nil
    }
    return result.indices.contains(5) ? result[5] : nil
}() ?? "not found")
// JSON_OBJECT?.fruits?.[5] ?? "not found": not found
