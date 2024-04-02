library(jsonlite)

prettyJsonStringify <- function(anything) {
    prettyJsonStringWithTrailingNewLine <- prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4)
    prettyJsonStringWithoutTrailingNewLine <- gsub("\\n$", "", prettyJsonStringWithTrailingNewLine, perl = TRUE)
    prettyJsonStringWithoutTrailingNewLineAndWithProperNull <- gsub("\\{\\s*\\n\\s*\\}", "null", prettyJsonStringWithoutTrailingNewLine, perl = TRUE)
    return(prettyJsonStringWithoutTrailingNewLineAndWithProperNull)
}

# 1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
# ```javascript
# let something = "foo";
# console.log("something:", something);
# something = 123;
# console.log("something:", something);
# something = true;
# console.log("something:", something);
# something = null;
# console.log("something:", something);
# something = [1, 2, 3];
# console.log("something:", something);
# something = { "foo": "bar" };
# console.log("something:", something);
# ```
# ```go
# type Any interface{}
# ```
something <- "foo"
cat(paste(sep = "", "something: ", prettyJsonStringify(something), "\n"))
something <- 123
cat(paste(sep = "", "something: ", prettyJsonStringify(something), "\n"))
something <- TRUE
cat(paste(sep = "", "something: ", prettyJsonStringify(something), "\n"))
something <- NULL
cat(paste(sep = "", "something: ", prettyJsonStringify(something), "\n"))
something <- list(1, 2, 3)
cat(paste(sep = "", "something: ", prettyJsonStringify(something), "\n"))
something <- list("foo" = "bar")
cat(paste(sep = "", "something: ", prettyJsonStringify(something), "\n"))

# 2. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
# ```javascript
# function getModifiedIndentLevel() {
#     let indentLevel = 0;
#     function changeIndentLevel() {
#         indentLevel += 1;
#         if (indentLevel < 5) changeIndentLevel();
#         return indentLevel;
#     }
#     return changeIndentLevel();
# }
# console.log("getModifiedIndentLevel():", getModifiedIndentLevel());
# function createNewGame(initialCredit) {
#     let currentCredit = initialCredit;
#     console.log("initial credit:", initialCredit);
#     return function () {
#         currentCredit -= 1;
#         if (currentCredit === 0) {
#             console.log("not enough credits");
#             return;
#         }
#         console.log(`playing game, ${currentCredit} credit(s) remaining`);
#     };
# }
# const playGame = createNewGame(3);
# playGame();
# playGame();
# playGame();
# ```
getModifiedIndentLevel <- function() {
    indentLevel <- 0
    changeIndentLevel <- function() {
        indentLevel <<- indentLevel + 1
        if (indentLevel < 5) changeIndentLevel()
        return(indentLevel)
    }
    return(changeIndentLevel())
}
cat(paste(sep = "", "getModifiedIndentLevel(): ", getModifiedIndentLevel(), "\n"))
createNewGame <- function(initialCredit) {
    currentCredit <- initialCredit
    cat(paste(sep = "", "initial credit: ", initialCredit, "\n"))
    return(function() {
        currentCredit <<- currentCredit - 1
        if (currentCredit == 0) {
            cat(paste(sep = "", "not enough credits", "\n"))
        } else {
            cat(paste(sep = "", "playing game, ", currentCredit, " credit(s) remaining", "\n"))
        }
    })
}
playGame <- createNewGame(3)
playGame()
playGame()
playGame()

# 3. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
# ```javascript
# const myObject = {
#     "my_string": "foo",
#     "my_number": 123,
#     "my_bool": true,
#     "my_null": null,
#     "my_array": [1, 2, 3],
#     "my_object": {
#         "foo": "bar"
#     }
# };
# console.log("myObject:", myObject);
# ```
myObject <- list(
    "my_string" = "foo",
    "my_number" = 123,
    "my_bool" = TRUE,
    "my_null" = NULL,
    "my_array" = list(1, 2, 3),
    "my_object" = list(
        "foo" = "bar"
    )
)
cat(paste(sep = "", "myObject: ", prettyJsonStringify(myObject), "\n"))

# 4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
# ```javascript
# const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
# console.log("myArray:", myArray);
# ```
myArray <- list("foo", 123, TRUE, NULL, list(1, 2, 3), list("foo" = "bar"))
cat(paste(sep = "", "myArray: ", prettyJsonStringify(myArray), "\n"))

# 5. support passing functions as arguments to other functions
# ```javascript
# function sayHello(callbackFunction) {
#     console.log("hello");
#     callbackFunction();
# }
# function sayHowAreYou() {
#     console.log("how are you?");
# }
# sayHello(sayHowAreYou);
# sayHello(function () {
#     console.log("how are you?");
# });
# ```
sayHello <- function(callbackFunction) {
    cat("hello\n")
    callbackFunction()
}
sayHowAreYou <- function() {
    cat("how are you?\n")
}
sayHello(sayHowAreYou)
sayHello(function() {
    cat("how are you?\n")
})

# 6. support returning functions as values from other functions
# ```javascript
# function multiply(a) {
#     return function (b) {
#         return (a * b);
#     };
# }
# const multiplyBy2 = multiply(2);
# const multiplyBy2Result = multiplyBy2(10);
# console.log("multiplyBy2Result:", multiplyBy2Result);
# ```
multiply <- function(a) {
    return(function(b) {
        return(a * b)
    })
}
multiplyBy2 <- multiply(2)
multiplyBy2Result <- multiplyBy2(10)
cat(paste(sep = "", "multiplyBy2Result: ", multiplyBy2Result, "\n"))

# 7. support assigning functions to variables
# ```javascript
# const getRectangleAreaV1 = function (rectangleWidth, rectangleLength) {
#     return (rectangleWidth * rectangleLength);
# };
# console.log(`getRectangleAreaV1(7, 5): ${getRectangleAreaV1(7, 5)}`);
# const getRectangleAreaV2 = (rectangleWidth, rectangleLength) => {
#     return (rectangleWidth * rectangleLength);
# };
# console.log(`getRectangleAreaV2(7, 5): ${getRectangleAreaV2(7, 5)}`);
# const getRectangleAreaV3 = (rectangleWidth, rectangleLength) => (rectangleWidth * rectangleLength);
# console.log(`getRectangleAreaV3(7, 5): ${getRectangleAreaV3(7, 5)}`);
# ```
getRectangleAreaV1 <- function(rectangleWidth, rectangleLength) {
    return(rectangleWidth * rectangleLength)
}
cat(paste(sep = "", "getRectangleAreaV1(7, 5): ", getRectangleAreaV1(7, 5), "\n"))
getRectangleAreaV2 <- function(rectangleWidth, rectangleLength) (rectangleWidth * rectangleLength)
cat(paste(sep = "", "getRectangleAreaV2(7, 5): ", getRectangleAreaV2(7, 5), "\n"))

# 8. support storing functions in data structures like array/list/slice/ordered-list-data-structure or object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure
# ```javascript
# const myArray2 = [
#     function (a, b) {
#         return (a * b);
#     },
#     "foo",
#     123,
#     true,
#     null,
#     [1, 2, 3],
#     { "foo": "bar" }
# ];
# console.log("myArray2[0](7, 5):", myArray2[0](7, 5));

# const myObject2 = {
#     "my_function": function (a, b) {
#         return (a * b);
#     },
#     "my_string": "foo",
#     "my_number": 123,
#     "my_bool": true,
#     "my_null": null,
#     "my_array": [1, 2, 3],
#     "my_object": {
#         "foo": "bar"
#     }
# };
# console.log("myObject2["my_function"](7, 5):", myObject2["my_function"](7, 5));
# ```
myArray2 <- list(
    function(a, b) {
        return(a * b)
    },
    "foo",
    123,
    TRUE,
    NULL,
    list(1, 2, 3),
    list("foo" = "bar")
)
cat(paste(sep = "", "myArray2[0](7, 5): ", myArray2[[1]](7, 5), "\n"))

myObject2 <- list(
    "my_function" = function(a, b) {
        return(a * b)
    },
    "my_string" = "foo",
    "my_number" = 123,
    "my_bool" = TRUE,
    "my_null" = NULL,
    "my_array" = list(1, 2, 3),
    "my_object" = list(
        "foo" = "bar"
    )
)
cat(paste(sep = "", "myObject2[0](7, 5): ", myObject2[["my_function"]](7, 5), "\n"))
