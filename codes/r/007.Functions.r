# ? function statement or function declaration and function expression at the same time

getRectangleAreaV1 <- function(rectangleWidth, rectangleLength) {
    return(rectangleWidth * rectangleLength)
}

getRectangleAreaV2 <- function(rectangleWidth, rectangleLength) rectangleWidth * rectangleLength

# ? anonymous function
function(rectangleWidth, rectangleLength) {
    return(rectangleWidth * rectangleLength)
}
function(rectangleWidth, rectangleLength) rectangleWidth * rectangleLength

# ? Passing functions as arguments to other functions

sayHello <- function(doSomething) {
    cat("hello\n")
    doSomething()
}

sayHowAreYou <- function() {
    cat("how are you?\n")
}

sayHello(sayHowAreYou)

sayHello(function() {
    cat("how are you?\n")
})

sayHello(function() cat("how are you?\n"))

# ? Assigning functions to variables or storing them in data structures

getRectangleAreaV1 <- function(rectangleWidth, rectangleLength) {
    return(rectangleWidth * rectangleLength)
}

getRectangleAreaV2 <- function(rectangleWidth, rectangleLength) rectangleWidth * rectangleLength

myArrayOfGetRectangleAreaFunctions <- list(
    getRectangleAreaV1,
    function(rectangleWidth, rectangleLength) {
        return(rectangleWidth * rectangleLength)
    },
    function(rectangleWidth, rectangleLength) rectangleWidth * rectangleLength
)

# In R, when we store functions in a list, we should use double square brackets [[ ]] to access and call them.
getRectangleAreaFunctionResult1 <- myArrayOfGetRectangleAreaFunctions[[1]](7, 5)
getRectangleAreaFunctionResult2 <- myArrayOfGetRectangleAreaFunctions[[2]](7, 5)
getRectangleAreaFunctionResult3 <- myArrayOfGetRectangleAreaFunctions[[3]](7, 5)

exponentiation <- function(a, b) {
    return(a ^ b)
}

simpleCalculator <- list(
    exponentiation = exponentiation,
    multiplication = function(a, b) {
        return(a * b)
    },
    division = function(a, b) a / b
)

simpleCalculatorResult1 <- simpleCalculator$exponentiation(2, 4)
simpleCalculatorResult2 <- simpleCalculator$multiplication(7, 5)
simpleCalculatorResult3 <- simpleCalculator$multiplication(81, 9)

# ? Returning functions as values from other functions

multiplyV1 <- function(a) {
    multiplyBy <- function(b) {
        return(a * b)
    }
    return(multiplyBy)
}
multiplyBy2 <- multiplyV1(2)
multiplyBy2Result <- multiplyBy2(10) # 20

multiplyV2 <- function(a) {
    multiplyBy <- function(b) a * b
    return(multiplyBy)
}
multiplyBy3 <- multiplyV2(3)
multiplyBy3Result <- multiplyBy3(10) # 30

multiplyV3 <- function(a) {
    return(function(b) a * b)
}
multiplyBy4 <- multiplyV3(4)
multiplyBy4Result <- multiplyBy4(10) # 40

multiplyV4 <- function(a) function(b) a * b
multiplyBy5 <- multiplyV4(5)
multiplyBy5Result <- multiplyBy5(10) # 50
