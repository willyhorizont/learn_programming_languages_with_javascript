@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc 1.Functions.kt -include-runtime -d 1.Functions.jar && kotlin 1.Functions.jar

fun main() {
    // ? function statement or function declaration

    fun getRectangleAreaV1(rectangleWidth: Int, rectangleLength: Int): Int {
        return rectangleWidth * rectangleLength
    }
    // call the function example: getRectangleAreaV1(7, 5)

    // ? function expression

    val getRectangleAreaV2 = fun(rectangleWidth: Int, rectangleLength: Int): Int {
        return rectangleWidth * rectangleLength
    }
    // call the function example: getRectangleAreaV2(7, 5)

    // ? anonymous function

    // fun(rectangleWidth: Int, rectangleLength: Int): Int {
    //     return rectangleWidth * rectangleLength
    // }

    // ? function expression with lambda function

    val getRectangleAreaV3: (Int, Int) -> Int = { rectangleWidth, rectangleLength -> rectangleWidth * rectangleLength }
    // call the function example: getRectangleAreaV3(7, 5)

    // ? anonymous lambda function

    // { rectangleWidth: Int, rectangleLength: Int -> rectangleWidth * rectangleLength }

    // Passing functions as arguments to other functions

    fun sayHello(callbackFunction: () -> Unit) {
        println("hello")
        callbackFunction()
    }

    fun sayHowAreYou() {
        println("how are you?")
    }

    sayHello(::sayHowAreYou)
    
    sayHello(fun() {
        println("how are you?")
    })

    sayHello({ -> println("how are you?") })

    // Assigning functions to variables or storing them in data structures

    val getRectangleAreaV2Copy = fun(rectangleWidth: Int, rectangleLength: Int): Int {
        return rectangleWidth * rectangleLength
    }

    val getRectangleAreaV3Copy: (Int, Int) -> Int = { rectangleWidth, rectangleLength -> rectangleWidth * rectangleLength }

    val myArrayOfGetRectangleAreaFunctions = mutableListOf<Any?>(
        ::getRectangleAreaV1,
        getRectangleAreaV2,
        fun(rectangleWidth: Int, rectangleLength: Int): Int {
            return rectangleWidth * rectangleLength
        },
        { rectangleWidth: Int, rectangleLength: Int -> rectangleWidth * rectangleLength }
    )
    val getRectangleAreaFunctionResult1 = (myArrayOfGetRectangleAreaFunctions[0] as (Int, Int) -> Int)(7, 5)
    val getRectangleAreaFunctionResult2 = (myArrayOfGetRectangleAreaFunctions[1] as (Int, Int) -> Int)(7, 5)
    val getRectangleAreaFunctionResult3 = (myArrayOfGetRectangleAreaFunctions[2] as (Int, Int) -> Int)(7, 5)
    val getRectangleAreaFunctionResult4 = (myArrayOfGetRectangleAreaFunctions[3] as (Int, Int) -> Int)(7, 5)

    fun exponentiation(a: Double, b: Double): Double {
        return Math.pow(a, b)
    }

    val modulus = fun(a: Int, b: Int): Int {
        return a % b
    }

    val simpleCalculator = mutableMapOf<String, Any?>(
        "exponentiation" to ::exponentiation,
        "modulus" to modulus,
        "multiplication" to fun(a: Int, b: Int): Int {
            return a * b
        },
        "division" to { a: Int, b: Int -> a.toDouble() / b }
    )
    val simpleCalculatorResult1 = (simpleCalculator["exponentiation"] as (Double, Double) -> Double)(2.0, 4.0)
    val simpleCalculatorResult2 = (simpleCalculator["modulus"] as (Int, Int) -> Int)(5, 3)
    val simpleCalculatorResult3 = (simpleCalculator["multiplication"] as (Int, Int) -> Int)(7, 5)
    val simpleCalculatorResult4 = (simpleCalculator["division"] as (Int, Int) -> Int)(81, 9)

    // Returning functions as values from other functions

    fun multiplyV1(a: Int): (Int) -> Int {
        fun multiplyBy(b: Int): Int {
            return a * b
        }
        return ::multiplyBy
    }
    val multiplyBy2 = multiplyV1(2)
    val multiplyBy2Result = multiplyBy2(10) // 20

    fun multiplyV2(a: Int): (Int) -> Int {
        val multiplyBy = fun(b: Int): Int {
            return a * b
        }
        return multiplyBy
    }
    val multiplyBy3 = multiplyV2(3)
    val multiplyBy3Result = multiplyBy3(10) // 30

    fun multiplyV3(a: Int): (Int) -> Int {
        return fun(b: Int): Int {
            return a * b
        }
    }
    val multiplyBy4 = multiplyV3(4)
    val multiplyBy4Result = multiplyBy4(10) // 40
    
    fun multiplyV4(a: Int): (Int) -> Int {
        return { b: Int -> a * b }
    }
    val multiplyBy5 = multiplyV4(5)
    val multiplyBy5Result = multiplyBy5(10) // 50

    val multiplyV5 = fun(a: Int): (Int) -> Int {
        fun multiplyBy(b: Int): Int {
            return a * b
        }
        return ::multiplyBy
    }
    val multiplyBy6 = multiplyV5(6)
    val multiplyBy6Result = multiplyBy6(10) // 60

    val multiplyV6 = fun(a: Int): (Int) -> Int {
        val multiplyBy = fun(b: Int): Int {
            return a * b
        }
        return multiplyBy
    }
    val multiplyBy7 = multiplyV6(7)
    val multiplyBy7Result = multiplyBy7(10) // 70

    val multiplyV7 = fun(a: Int): (Int) -> Int {
        return fun(b: Int): Int {
            return a * b
        }
    }
    val multiplyBy8 = multiplyV7(8)
    val multiplyBy8Result = multiplyBy8(10) // 80
    
    val multiplyV8 = fun(a: Int): (Int) -> Int {
        return { b: Int -> a * b }
    }
    val multiplyBy9 = multiplyV8(9)
    val multiplyBy9Result = multiplyBy9(10) // 90

    val multiplyV9 = { a: Int -> { b: Int -> a * b } }
    val multiplyBy10 = multiplyV9(10)
    val multiplyBy10Result = multiplyBy10(10) // 100
}
