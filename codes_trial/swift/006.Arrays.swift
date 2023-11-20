typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

// Array

let fruits: MyArray = ["apple", "mango", "orange"]

print("fruits, length:", fruits.count)
// fruits, length: 3

print("fruits, get mango:", fruits[1] ?? "undefined")
// fruits, get mango: mango

// this is called optional binding
if let result = fruits[1] {
    print("fruits, get mango: \(result)")
    // fruits, get mango: mango
}

print("fruits, get mango:", { () -> Any in
    // this is called optional binding
    guard let result = fruits[1] else {
        return "undefined"
    }
    return result
}())
// fruits, get mango: mango

print("fruits, first element:", (fruits.first ?? "undefined") ?? "undefined")
// fruits, first element: apple

// this is called optional binding
if let result = fruits.first {
    if let result2 = result {
        print("fruits, first element:", result2)
        // fruits, first element: apple
    }
}

print("fruits, first element:", { () -> Any in
    // this is called optional binding
    guard let result = fruits.first, let result = result else {
        return "undefined"
    }
    return result
}())
// fruits, first element: apple

print("fruits, first element:", fruits[0] ?? "undefined")
// fruits, first element: apple

// this is called optional binding
if let result = fruits[0] {
    print("fruits, first element:", result)
    // fruits, first element: apple
}

print("fruits, first element:", { () -> Any in
    // this is called optional binding
    guard let result = fruits[0] else {
        return "undefined"
    }
    return result
}())
// fruits, first element: apple

print("fruits, last element:", fruits[fruits.count - 1] ?? "undefined")
// fruits, last element: orange

// this is called optional binding
if let result = fruits[fruits.count - 1] {
    print("fruits, last element:", result)
}

print("fruits, last element:", { () -> Any in
    // this is called optional binding
    guard let result = fruits[fruits.count - 1] else {
        return "undefined"
    }
    return result
}())
// fruits, last element: orange

print("fruits, last element:", (fruits.last ?? "undefined") ?? "undefined")
// fruits, last element: orange

// this is called optional binding
if let result = fruits.last {
    if let result = result {
        print("fruits, last element:", result)
        // fruits, last element: orange
    }
}

print("fruits, last element:", { () -> Any in
    // this is called optional binding
    guard let result = fruits.last, let result = result else {
        return "undefined"
    }
    return result
}())
// fruits, last element: orange

for (arrayItemIndex, arrayItem) in fruits.enumerated() {
    print("friend, for loop, index: \(arrayItemIndex), value: \(arrayItem ?? "undefined")")
}
// fruits, for loop, index: 0, value: apple
// fruits, for loop, index: 1, value: mango
// fruits, for loop, index: 2, value: orange

// Array of Objects

let products: MyArray = [
    [
        "id": "P1",
        "name": "bubble gum"
    ] as MyObject,
    [
        "id": "P2",
        "name": "potato chips"
    ] as MyObject
]

for (arrayItemIndex, arrayItem) in products.enumerated() {
    // this is called optional binding, `as?` is called conditional casting
    if let product = arrayItem as? MyObject {
        for (objectKey, objectValue) in product {
            print("friend, for loop, index: \(arrayItemIndex), key: \(objectKey), value: \(objectValue ?? "undefined")")
        }
    }
}
// friend, for loop, index: 0, key: name, value: bubble gum
// friend, for loop, index: 0, key: id, value: P1
// friend, for loop, index: 1, key: name, value: potato chips
// friend, for loop, index: 1, key: id, value: P2

for (arrayItemIndex, arrayItem) in products.enumerated() {
    // this is called optional binding, `as?` is called conditional casting
    guard let product = arrayItem as? MyObject else {
        continue
    }
    for (objectKey, objectValue) in product {
        print("friend, for loop, index: \(arrayItemIndex), key: \(objectKey), value: \(objectValue ?? "undefined")")
    }
}
// friend, for loop, index: 0, key: name, value: bubble gum
// friend, for loop, index: 0, key: id, value: P1
// friend, for loop, index: 1, key: name, value: potato chips
// friend, for loop, index: 1, key: id, value: P2
