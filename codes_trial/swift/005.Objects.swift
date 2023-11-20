typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

let friend: MyObject = [
    "name": "Alisa",
    "country": "Finland",
    "age": 25
]

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
for (iterationIndex, (objectKey, objectValue)) in friend.enumerated() {
    print("friend, for loop, index: \(iterationIndex), key: \(objectKey), value: \(objectValue ?? "undefined")")
}
// friend, for loop, index: 0, key: name, value: Alisa
// friend, for loop, index: 1, key: country, value: Finland
// friend, for loop, index: 2, key: age, value: 25
