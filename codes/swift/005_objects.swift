import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

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

let friend: MyObject = [
    "name": "Alisa",
    "country": "Finland",
    "age": 25
]
print("friend: \(prettyJsonStringify(friend))")

print("friend, get country: \((friend["country"] ?? "undefined") ?? "undefined")")
// friend, get country: Finland

// this is called optional binding
if let result = friend["country"] {
    print("friend, get country: \(result ?? "undefined")")
    // friend, get country: Finland
}

print("friend, get country:", { () -> Any in
    // this is called optional binding
    guard let result = friend["country"], let result = result else {
        return "undefined"
    }
    return result
}())
// friend, get country: Finland

// iterate over and get each key-value pair
for (objectKey, objectValue) in friend {
    print("friend, for loop, key: \(objectKey), value: \(objectValue ?? "undefined")")
}
// friend, for loop, key: name, value: Alisa
// friend, for loop, key: country, value: Finland
// friend, for loop, key: age, value: 25

// iterate over and get each key-value pair and iteration/entry index
for (entryIndex, (objectKey, objectValue)) in friend.enumerated() {
    print("friend, for loop, iteration/entry index: \(entryIndex), key: \(objectKey), value: \(objectValue ?? "undefined")")
}
// friend, for loop, iteration/entry index: 0, key: name, value: Alisa
// friend, for loop, iteration/entry index: 1, key: country, value: Finland
// friend, for loop, iteration/entry index: 2, key: age, value: 25
