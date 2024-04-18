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

print("\n// JavaScript-like Array.includes() in Swift")

// There's no JavaScript-like Array.includes() in Swift.
// But, we can use Swift Array.includes() built-in method "Array.contains".

let myFriends: MyArray = ["Alisa", "Trivia"]
print("myFriends: \(jsonStringify(myFriends))")

var aName: String
var isMyFriend: Bool

print("// using Swift Array.includes() built-in method \"Array.contains\"")

aName = "Alisa"
isMyFriend = myFriends.contains { (myFriend: Any?) -> Bool in
    if let result = myFriend as? String {
        return result == aName
    }
    return false
}
print("is my friends includes \"\(aName)\": \(isMyFriend)")
// is my friends includes "Alisa": true

aName = "Trivia"
isMyFriend = myFriends.contains { (myFriend: Any?) -> Bool in
    if let result = myFriend as? String {
        return result == aName
    }
    return false
}
print("is my friends includes \"\(aName)\": \(isMyFriend)")
// is my friends includes "Trivia": true

aName = "Tony"
isMyFriend = myFriends.contains { (myFriend: Any?) -> Bool in
    if let result = myFriend as? String {
        return result == aName
    }
    return false
}
print("is my friends includes \"\(aName)\": \(isMyFriend)")
// is my friends includes "Tony": false

aName = "Ezekiel"
isMyFriend = myFriends.contains { (myFriend: Any?) -> Bool in
    if let result = myFriend as? String {
        return result == aName
    }
    return false
}
print("is my friends includes \"\(aName)\": \(isMyFriend)")
// is my friends includes "Ezekiel": false
