import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

func prettyArrayOfPrimitives(_ anArrayOfPrimitives: MyArray) -> String {
    var result = "["
    for (arrayItemIndex, arrayItem) in anArrayOfPrimitives.enumerated() {
        guard let arrayItem = arrayItem else {
            result += "nil"
            if ((arrayItemIndex + 1) != anArrayOfPrimitives.count) {
                result += ", "
            }
            continue
        }
        if (((arrayItem is String) == false) && ((arrayItem is NSNumber) == false)) && ((arrayItem is Bool) == false) {
            continue
        }
        if let arrayItem = arrayItem as? String {
            result += "\"\(arrayItem)\""
        }
        if let arrayItem = arrayItem as? Bool {
            result += "\(arrayItem)"
        } else {
            if let arrayItem = arrayItem as? NSNumber {
                result += "\(arrayItem)"
            }
        }
        if ((arrayItemIndex + 1) != anArrayOfPrimitives.count) {
            result += ", "
        }
    }
    result += "]"
    return result
}

print("\n// JavaScript-like Array.includes() in Swift")

// There's no JavaScript-like Array.includes() in Swift.
// But, we can use Swift Array.includes() built-in method "Array.contains".

let myFriends: MyArray = ["Alisa", "Trivia"]
print("myFriends: \(prettyArrayOfPrimitives(myFriends))")

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
