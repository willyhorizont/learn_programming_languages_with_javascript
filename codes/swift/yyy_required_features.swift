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

/*
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
*/
var something: Any? = "foo"
print("something: \(jsonStringify(something, pretty: true))")
something = 123
print("something: \(jsonStringify(something, pretty: true))")
something = true
print("something: \(jsonStringify(something, pretty: true))")
something = nil
print("something: \(jsonStringify(something, pretty: true))")
something = [1, 2, 3] as MyArray
print("something: \(jsonStringify(something, pretty: true))")
something = ["foo": "bar"] as MyObject
print("something: \(jsonStringify(something, pretty: true))")

/*
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
*/
func getModifiedIndentLevel() -> Int {
    var indentLevel: Int = 0
    func changeIndentLevel() -> Int {
        indentLevel += 1
        if (indentLevel < 5) {
            let _ = changeIndentLevel()
        }
        return indentLevel
    }
    return changeIndentLevel()
}
print("getModifiedIndentLevel(): \(getModifiedIndentLevel())")
func createNewGame(_ initialCredit: Int) -> () -> Void {
    var currentCredit: Int = initialCredit
    print("initial credit: \(initialCredit)")
    return { () -> Void in
        currentCredit -= 1
        if (currentCredit == 0) {
            print("not enough credits")
            return
        }
        print("playing game, \(currentCredit) credit(s) remaining")
    }
}
let playGame = createNewGame(3)
playGame()
playGame()
playGame()

/*
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
*/
var myObject: MyObject = [
    "my_string": "foo",
    "my_number": 123,
    "my_boolean": true,
    "my_null": nil,
    "my_array": [1, 2, 3] as MyArray,
    "my_object": [
        "foo": "bar"
    ] as MyObject
]
print("myObject: \(jsonStringify(myObject, pretty: true))")

/*
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
*/
var myArray: MyArray = ["foo", 123, true, nil, [1, 2, 3] as MyArray, ["foo": "bar"] as MyObject]
print("myArray: \(jsonStringify(myArray, pretty: true))")

/*
x. support passing functions as arguments to other functions
*/
func sayHello(_ callbackFunction: () -> Void) {
    print("hello")
    callbackFunction()
}
func sayHowAreYou() {
    print("how are you?")
}
sayHello(sayHowAreYou)
sayHello({ () in
    print("how are you?")
})

/*
x. support returning functions as values from other functions
*/
func multiply(_ a: Int) -> (Int) -> Int {
    return { (b: Int) -> Int in
        return (a * b)
    }
}
let multiplyBy2 = multiply(2)
let multiplyBy2Result = multiplyBy2(10)
print("multiplyBy2Result: \(multiplyBy2Result)")

/*
x. support assigning functions to variables
*/
let getRectangleAreaV1 = { (rectangleWidth: Int, rectangleLength: Int) -> Int in
    return (rectangleWidth * rectangleLength)
}
print("getRectangleAreaV1(7, 5): \(getRectangleAreaV1(7, 5))")
let getRectangleAreaV2 = { (rectangleWidth: Int, rectangleLength: Int) -> Int in (rectangleWidth * rectangleLength) }
print("getRectangleAreaV2(7, 5): \(getRectangleAreaV2(7, 5))")

/*
x. support storing functions in data structures like object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure or array/list/slice/ordered-list-data-structure
*/
var myArray2: MyArray = [
    { (a: Int, b: Int) -> Int in
        return (a * b)
    },
    "foo",
    123,
    true,
    nil,
    [1, 2, 3] as MyArray,
    ["foo": "bar"] as MyObject
]
print("myArray2[0](7, 5): \((myArray2[0] as! (Int, Int) -> Int)(7, 5))")
var myObject2: MyObject = [
    "my_function": { (a: Int, b: Int) -> Int in
        return (a * b)
    },
    "my_string": "foo",
    "my_number": 123,
    "my_boolean": true,
    "my_null": nil,
    "my_array": [1, 2, 3] as MyArray,
    "my_object": [
        "foo": "bar"
    ] as MyObject
]
print("myObject2[\"my_function\"](7, 5): \((myObject2["my_function"] as! (Int, Int) -> Int)(7, 5))")
