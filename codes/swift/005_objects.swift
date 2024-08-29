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

// in Swift, JavaScript-like Object is called Dictionary

var friend: MyObject = [
    "name": "Alisa",
    "country": "Finland",
    "age": 25
]
print("friend: \(jsonStringify(friend, pretty: true))")

print("friend, get total object keys: \(friend.count)")
// friend, get total object keys: 3

print("friend, get country: \(friend["country"] as? String ?? "null")")
// friend, get country: Finland

print("friend, get country:", { () -> String in
    // this is called optional binding
    if let result = friend["country"] as? String {
        return result
    }
    return "null"
}())
// friend, get country: Finland

print("friend, get country:", { () -> String in
    // this is called optional binding
    guard let result = friend["country"] as? String else {
        return "null"
    }
    return result
}())
// friend, get country: Finland

// iterate over and get each key-value pair
for (objectKey, objectValue) in friend {
    print("friend, for loop, key: \(objectKey), value: \(objectValue ?? "null")")
}
// friend, for loop, key: name, value: Alisa
// friend, for loop, key: country, value: Finland
// friend, for loop, key: age, value: 25

// iterate over and get each key-value pair and object iteration/entry index
for (objectEntryIndex, (objectKey, objectValue)) in friend.enumerated() {
    print("friend, for loop, object iteration/entry index: \(objectEntryIndex), key: \(objectKey), value: \(objectValue ?? "null")")
}
// friend, for loop, object iteration/entry index: 0, key: name, value: Alisa
// friend, for loop, object iteration/entry index: 1, key: country, value: Finland
// friend, for loop, object iteration/entry index: 2, key: age, value: 25

friend["age"] = 27
print("friend: \(jsonStringify(friend, pretty: true))")

friend["gender"] = "Female"
print("friend: \(jsonStringify(friend, pretty: true))")

friend.removeValue(forKey: "country")
print("friend: \(jsonStringify(friend, pretty: true))")

// Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
let deliveryResponseKeyMessage = "message"
var deliveryResponse: MyObject = [
    deliveryResponseKeyMessage: "ok"
]
print("deliveryResponse: \(jsonStringify(deliveryResponse, pretty: true))")
let deliveryResponseKeyStatus = "status"
deliveryResponse[deliveryResponseKeyStatus] = 200
print("deliveryResponse: \(jsonStringify(deliveryResponse, pretty: true))")
