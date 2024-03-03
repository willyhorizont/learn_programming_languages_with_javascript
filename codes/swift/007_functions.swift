typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

// ? function statement or function declaration

func getRectangleAreaV1(rectangleWidth: Int, rectangleLength: Int) -> Int {
    return rectangleWidth * rectangleLength
}
// call the function example: getRectangleAreaV1(7, 5)

// ? function expression with anonymous function

let getRectangleAreaV2: (Int, Int) -> Int = { (rectangleWidth, rectangleLength) in
    return rectangleWidth * rectangleLength
}
// call the function example: getRectangleAreaV2(7, 5)

let getRectangleAreaV3: (Int, Int) -> Int = { (rectangleWidth, rectangleLength) in rectangleWidth * rectangleLength }
// call the function example: getRectangleAreaV3(7, 5)

let getRectangleAreaV4 = { (rectangleWidth: Int, rectangleLength: Int) -> Int in
    return rectangleWidth * rectangleLength
}
// call the function example: getRectangleAreaV4(7, 5)

let getRectangleAreaV5 = { (rectangleWidth: Int, rectangleLength: Int) -> Int in rectangleWidth * rectangleLength }
// call the function example: getRectangleAreaV5(7, 5)

// ? anonymous function
// { (rectangleWidth: Int, rectangleLength: Int) -> Int in
//     return rectangleWidth * rectangleLength
// }
// { (rectangleWidth: Int, rectangleLength: Int) -> Int in rectangleWidth * rectangleLength }

// ? Passing functions as arguments to other functions

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

// ? Assigning functions to variables or storing them in data structures

let getRectangleAreaV2Copy: (Int, Int) -> Int = { (rectangleWidth, rectangleLength) in
    return rectangleWidth * rectangleLength
}

let getRectangleAreaV3Copy: (Int, Int) -> Int = { (rectangleWidth, rectangleLength) in rectangleWidth * rectangleLength }

let getRectangleAreaV4Copy = { (rectangleWidth: Int, rectangleLength: Int) -> Int in
    return rectangleWidth * rectangleLength
}

let getRectangleAreaV5Copy = { (rectangleWidth: Int, rectangleLength: Int) -> Int in rectangleWidth * rectangleLength }

let myArrayOfGetRectangleAreaFunctions: MyArray = [
    getRectangleAreaV1,
    { (rectangleWidth: Int, rectangleLength: Int) -> Int in
        return rectangleWidth * rectangleLength
    }
]
var getRectangleAreaFunctionResult1: Any?
if let getRectangleAreaFunction1 = myArrayOfGetRectangleAreaFunctions[0] as? (Int, Int) -> Int {
    getRectangleAreaFunctionResult1 = getRectangleAreaFunction1(7, 5)
}
var getRectangleAreaFunctionResult2: Any?
if let getRectangleAreaFunction2 = myArrayOfGetRectangleAreaFunctions[1] as? (Int, Int) -> Int {
    getRectangleAreaFunctionResult2 = getRectangleAreaFunction2(7, 5)
}

func addition(a: Int, b: Int) -> Int {
    return a + b
}

let simpleCalculator: MyObject = [
    "addition": addition,
    "subtraction": { (a: Int, b: Int) -> Int in
        return a - b
    }
]
var simpleCalculatorResult1: Any?
if let simpleCalculatorFunction1 = simpleCalculator["addition"] as? (Int, Int) -> Int {
    simpleCalculatorResult1 = simpleCalculatorFunction1(9, 3)
}
var simpleCalculatorResult2: Any?
if let simpleCalculatorFunction2 = simpleCalculator["subtraction"] as? (Int, Int) -> Int {
    simpleCalculatorResult2 = simpleCalculatorFunction2(35, 8)
}

// ? Returning functions as values from other functions

func multiplyV1(_ a: Int) -> (Int) -> Int {
    func multiplyBy(_ b: Int) -> Int {
        return a * b
    }
    return multiplyBy
}
let multiplyBy2 = multiplyV1(2);
let multiplyBy2Result = multiplyBy2(10); // 20

func multiplyV2(_ a: Int) -> (Int) -> Int {
    let multiplyBy = { (_ b: Int) -> Int in
        return a * b
    }
    return multiplyBy
}
let multiplyBy3 = multiplyV2(3);
let multiplyBy3Result = multiplyBy3(10); // 30

func multiplyV3(_ a: Int) -> (Int) -> Int {
    return { (_ b: Int) -> Int in
        return a * b
    }
}
let multiplyBy4 = multiplyV3(4);
let multiplyBy4Result = multiplyBy4(10); // 40

let multiplyV4 = { (_ a: Int) -> (Int) -> Int in
    return { (_ b: Int) -> Int in
        return a * b
    }
}
let multiplyBy5 = multiplyV4(5);
let multiplyBy5Result = multiplyBy5(10); // 50

let multiplyV5 = { (_ a: Int) -> (Int) -> Int in { (_ b: Int) -> Int in a * b }}
let multiplyBy6 = multiplyV5(6);
let multiplyBy6Result = multiplyBy6(10); // 60
