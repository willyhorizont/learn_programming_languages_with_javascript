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

func prettyJsonStringify(_ anything: Any? = nil, indent: String = "    ") -> String {
    var indentLevel = 0
    func prettyJsonStringifyInner(_ anythingInner: Any?, _ indentInner: String) -> String {
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
                return "{}"
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
        return "null"
    }
    return prettyJsonStringifyInner(anything, indent)
}

// Array in Swift

let fruits: MyArray = ["apple", "mango", "orange"]
print("fruits: \(prettyArrayOfPrimitives(fruits))")

print("fruits, length:", fruits.count)
// fruits, length: 3

print("fruits, get mango:", prettyJsonStringify(fruits[1] ?? "nil"))
// fruits, get mango: "mango"

print("fruits, get mango:", prettyJsonStringify({ () -> Any? in
    // this is called optional binding
    if let result = fruits[1] {
        return result
    }
    return nil
}()))
// fruits, get mango: "mango"

print("fruits, get mango:", prettyJsonStringify({ () -> Any? in
    // this is called optional binding
    guard let result = fruits[1] else {
        return nil
    }
    return result
}()))
// fruits, get mango: "mango"

print("fruits, first element:", prettyJsonStringify((fruits.first ?? "nil") ?? "nil"))
// fruits, first element: "apple"

print("fruits, first element:", prettyJsonStringify({ () -> Any? in
    // this is called optional binding
    if let result = fruits.first {
        if let result = result {
            return result
        }
    }
    return nil
}()))
// fruits, first element: "apple"

print("fruits, first element:", prettyJsonStringify({ () -> Any? in
    // this is called optional binding
    guard let result = fruits.first, let result = result else {
        return nil
    }
    return result
}()))
// fruits, first element: "apple"

print("fruits, first element:", prettyJsonStringify(fruits[0] ?? "nil"))
// fruits, first element: "apple"

print("fruits, first element:", prettyJsonStringify({ () -> Any? in
    // this is called optional binding
    if let result = fruits[0] {
        return result
    }
    return nil
}()))
// fruits, first element: "apple"

print("fruits, first element:", prettyJsonStringify({ () -> Any? in
    // this is called optional binding
    guard let result = fruits[0] else {
        return nil
    }
    return result
}()))
// fruits, first element: "apple"

print("fruits, last element:", prettyJsonStringify(fruits[fruits.count - 1] ?? "nil"))
// fruits, last element: "orange"

print("fruits, last element:", prettyJsonStringify({ () -> Any? in
    // this is called optional binding
    if let result = fruits[fruits.count - 1] {
        return result
    }
    return nil
}()))
// fruits, last element: "orange"

print("fruits, last element:", prettyJsonStringify({ () -> Any? in
    // this is called optional binding
    guard let result = fruits[fruits.count - 1] else {
        return nil
    }
    return result
}()))
// fruits, last element: "orange"

print("fruits, last element:", prettyJsonStringify((fruits.last ?? "nil") ?? "nil"))
// fruits, last element: "orange"

print("fruits, last element:", prettyJsonStringify({ () -> Any? in
    // this is called optional binding
    if let result = fruits.last {
        if let result = result {
            return result
        }
    }
    return nil
}()))
// fruits, last element: "orange"

print("fruits, last element:", prettyJsonStringify({ () -> Any? in
    // this is called optional binding
    guard let result = fruits.last, let result = result else {
        return nil
    }
    return result
}()))
// fruits, last element: "orange"

for (arrayItemIndex, arrayItem) in fruits.enumerated() {
    print("fruits, for loop, index: \(arrayItemIndex), value: \(prettyJsonStringify(arrayItem ?? "nil"))")
}
// fruits, for loop, index: 0, value: "apple"
// fruits, for loop, index: 1, value: "mango"
// fruits, for loop, index: 2, value: "orange"

// Array of Objects in Swift

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
print("products: \(prettyJsonStringify(products))")

for (arrayItemIndex, arrayItem) in products.enumerated() {
    // this is called optional binding, `as?` is called conditional casting
    if let arrayItem = arrayItem as? MyObject {
        for (entryIndex, (objectKey, objectValue)) in arrayItem.enumerated() {
            print("products, for loop, array item index: \(arrayItemIndex), iteration/entry index: \(entryIndex), key: \(prettyJsonStringify(objectKey)), value: \(prettyJsonStringify(objectValue ?? "nil"))")
        }
    }
}
// products, foreach loop, array item index: 0, iteration/entry index: 0, key: "id", value: "P1"
// products, foreach loop, array item index: 0, iteration/entry index: 1, key: "name", value: "bubble gum"
// products, foreach loop, array item index: 1, iteration/entry index: 0, key: "id", value: "P2"
// products, foreach loop, array item index: 1, iteration/entry index: 1, key: "name", value: "potato chips"

for (arrayItemIndex, arrayItem) in products.enumerated() {
    // this is called optional binding, `as?` is called conditional casting
    guard let arrayItem = arrayItem as? MyObject else {
        continue
    }
    for (entryIndex, (objectKey, objectValue)) in arrayItem.enumerated() {
        print("products, for loop, array item index: \(arrayItemIndex), iteration/entry index: \(entryIndex), key: \(prettyJsonStringify(objectKey)), value: \(prettyJsonStringify(objectValue ?? "nil"))")
    }
}
// products, foreach loop, array item index: 0, iteration/entry index: 0, key: "id", value: "P1"
// products, foreach loop, array item index: 0, iteration/entry index: 1, key: "name", value: "bubble gum"
// products, foreach loop, array item index: 1, iteration/entry index: 0, key: "id", value: "P2"
// products, foreach loop, array item index: 1, iteration/entry index: 1, key: "name", value: "potato chips"
