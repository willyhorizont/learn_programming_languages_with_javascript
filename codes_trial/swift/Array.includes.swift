import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

func prettyArrayOfPrimitives(_ anArrayOfPrimitives: MyArray) -> String {
    var result = "["
    for (arrayItemIndex, arrayItem) in anArrayOfPrimitives.enumerated() {
        if (((arrayItem is String) == false) && ((arrayItem is NSNumber) == false)) {
            continue
        }
        if let arrayItem = arrayItem as? String {
            result += "\"\(arrayItem)\""
        }
        if let arrayItem = arrayItem as? NSNumber {
            result += "\(arrayItem)"
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

var name: String
var isMyFriend: Bool

print("// using Swift Array.includes() built-in method \"Array.contains\"")

name = "Alisa"
print("name: \"\(name)\"")
isMyFriend = myFriends.contains { (myFriend: Any?) -> Bool in
    if let result = myFriend as? String {
        return result == name
    }
    return false
}
print("is my friends includes \"\(name)\": \(isMyFriend)")
// is my friends includes "Alisa": true

name = "Trivia"
print("name: \"\(name)\"")
isMyFriend = myFriends.contains { (myFriend: Any?) -> Bool in
    if let result = myFriend as? String {
        return result == name
    }
    return false
}
print("is my friends includes \"\(name)\": \(isMyFriend)")
// is my friends includes "Trivia": true

name = "Tony"
print("name: \"\(name)\"")
isMyFriend = myFriends.contains { (myFriend: Any?) -> Bool in
    if let result = myFriend as? String {
        return result == name
    }
    return false
}
print("is my friends includes \"\(name)\": \(isMyFriend)")
// is my friends includes "Tony": false

name = "Ezekiel"
print("name: \"\(name)\"")
isMyFriend = myFriends.contains { (myFriend: Any?) -> Bool in
    if let result = myFriend as? String {
        return result == name
    }
    return false
}
print("is my friends includes \"\(name)\": \(isMyFriend)")
// is my friends includes "Ezekiel": false
