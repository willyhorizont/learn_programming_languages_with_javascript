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

// in Swift, JavaScript-like Array is called Array

let fruits: MyArray = ["apple", "mango", "orange"]
print("fruits: \(jsonStringify(fruits))")

print("fruits, length:", fruits.count)
// fruits, length: 3

print("fruits, get mango:", (fruits[1] as? String ?? "null"))
// fruits, get mango: "mango"

print("fruits, get mango:", { () -> String in
    // this is called optional binding
    if let result = fruits[1] as? String {
        return result
    }
    return "null"
}())
// fruits, get mango: "mango"

print("fruits, get mango:", { () -> String in
    // this is called optional binding
    guard let result = fruits[1] as? String else {
        return "null"
    }
    return result
}())
// fruits, get mango: "mango"

print("fruits, first element:", (fruits.first as? String ?? "null"))
// fruits, first element: "apple"

print("fruits, first element:", { () -> String in
    // this is called optional binding
    if let result = fruits.first as? String {
        return result
    }
    return "null"
}())
// fruits, first element: "apple"

print("fruits, first element:", { () -> String in
    // this is called optional binding
    guard let result = fruits.first as? String else {
        return "null"
    }
    return result
}())
// fruits, first element: "apple"

print("fruits, first element:", (fruits[0] as? String ?? "null"))
// fruits, first element: "apple"

print("fruits, first element:", { () -> String in
    // this is called optional binding
    if let result = fruits[0] as? String {
        return result
    }
    return "null"
}())
// fruits, first element: "apple"

print("fruits, first element:", { () -> String in
    // this is called optional binding
    guard let result = fruits[0] as? String else {
        return "null"
    }
    return result
}())
// fruits, first element: "apple"

print("fruits, last element:", (fruits[fruits.count - 1] as? String ?? "null"))
// fruits, last element: "orange"

print("fruits, last element:", { () -> String in
    // this is called optional binding
    if let result = fruits[fruits.count - 1] as? String {
        return result
    }
    return "null"
}())
// fruits, last element: "orange"

print("fruits, last element:", { () -> String in
    // this is called optional binding
    guard let result = fruits[fruits.count - 1] as? String else {
        return "null"
    }
    return result
}())
// fruits, last element: "orange"

print("fruits, last element:", (fruits.last as? String ?? "null"))
// fruits, last element: "orange"

print("fruits, last element:", { () -> String in
    // this is called optional binding
    if let result = fruits.last as? String {
        return result
    }
    return "null"
}())
// fruits, last element: "orange"

print("fruits, last element:", { () -> String in
    // this is called optional binding
    guard let result = fruits.last as? String else {
        return "null"
    }
    return result
}())
// fruits, last element: "orange"

for (arrayItemIndex, arrayItem) in fruits.enumerated() {
    print("fruits, for loop, index: \(arrayItemIndex), value: \(jsonStringify(arrayItem ?? "null"))")
}
// fruits, for loop, index: 0, value: "apple"
// fruits, for loop, index: 1, value: "mango"
// fruits, for loop, index: 2, value: "orange"

// in Swift, JavaScript-like Array of Objects is called Array of Dictionaries

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
print("products: \(jsonStringify(products, pretty: true))")

for (arrayItemIndex, arrayItem) in products.enumerated() {
    // this is called optional binding, `as?` is called conditional casting
    if let arrayItem = arrayItem as? MyObject {
        for (objectEntryIndex, (objectKey, objectValue)) in arrayItem.enumerated() {
            print("products, for loop, array item index: \(arrayItemIndex), object iteration/entry index: \(objectEntryIndex), key: \(jsonStringify(objectKey)), value: \(jsonStringify(objectValue ?? "null"))")
        }
    }
}
// products, forEach loop, array item index: 0, object iteration/entry index: 0, key: "id", value: "P1"
// products, forEach loop, array item index: 0, object iteration/entry index: 1, key: "name", value: "bubble gum"
// products, forEach loop, array item index: 1, object iteration/entry index: 0, key: "id", value: "P2"
// products, forEach loop, array item index: 1, object iteration/entry index: 1, key: "name", value: "potato chips"

for (arrayItemIndex, arrayItem) in products.enumerated() {
    // this is called optional binding, `as?` is called conditional casting
    guard let arrayItem = arrayItem as? MyObject else {
        continue
    }
    for (objectEntryIndex, (objectKey, objectValue)) in arrayItem.enumerated() {
        print("products, for loop, array item index: \(arrayItemIndex), object iteration/entry index: \(objectEntryIndex), key: \(jsonStringify(objectKey)), value: \(jsonStringify(objectValue ?? "null"))")
    }
}
// products, forEach loop, array item index: 0, object iteration/entry index: 0, key: "id", value: "P1"
// products, forEach loop, array item index: 0, object iteration/entry index: 1, key: "name", value: "bubble gum"
// products, forEach loop, array item index: 1, object iteration/entry index: 0, key: "id", value: "P2"
// products, forEach loop, array item index: 1, object iteration/entry index: 1, key: "name", value: "potato chips"
