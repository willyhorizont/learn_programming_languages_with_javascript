import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

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

let friend: MyObject = [
    "name": "Alisa",
    "country": "Finland",
    "age": 25
]
print("friend: \(prettyArrayOfPrimitives(friend))")

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
