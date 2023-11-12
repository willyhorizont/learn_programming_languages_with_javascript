library(jsonlite)

prettyJsonStringify <- function(anything) (if (is.null(anything) == TRUE) "NULL" else if (is.character(anything) == TRUE) paste(sep = "", "\"", anything, "\"") else prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4))

prettyArrayOfPrimitives <- function(anArrayOfPrimitives) {
    result <- "["
    for (arrayItemIndex in seq_along(anArrayOfPrimitives)) {
        arrayItem <- anArrayOfPrimitives[[arrayItemIndex]]
        if ((is.character(arrayItem) == FALSE) && (is.numeric(arrayItem) == FALSE)) next
        if (is.character(arrayItem) == TRUE) {
            result <- paste(sep = "", result, "\"", arrayItem, "\"")
        }
        if (is.numeric(arrayItem) == TRUE) {
            result <- paste(sep = "", result, arrayItem)
        }
        if (arrayItemIndex != length(anArrayOfPrimitives)) {
            result <- paste(sep = "", result, ", ")
        }
    }
    result <- paste(sep = "", result, "]")
    return(result)
}

getType <- function(anything) {
    if (is.list(anything) == FALSE) return(class(anything))
    if (length(anything) == 0) return("empty_list")
    if (is.null(names(anything)) == TRUE) return("array")
    return("object")
}

spreadSyntaxObject <- function(...) {
    parameters <- list(...)
    newObject <- list()
    for (parameterIndex in seq_along(parameters)) {
        parameter <- parameters[[parameterIndex]]
        parameterType <- getType(parameter)
        if (parameterType == "object") {
            for (objectKey in names(parameter)) {
                objectValue <- parameter[[objectKey]]
                newObject[[objectKey]] <- objectValue
            }
            next
        }
        if (parameterType == "array") {
            for (arrayItemIndex in seq_along(parameter)) {
                arrayItem <- parameter[[arrayItemIndex]]
                newObject[[as.character(arrayItemIndex)]] <- arrayItem
            }
            next
        }
    }
    return(newObject)
}

spreadSyntaxArray <- function(...) {
    parameters <- list(...)
    newArray <- list()
    for (parameterIndex in seq_along(parameters)) {
        parameter <- parameters[[parameterIndex]]
        parameterType <- getType(parameter)
        if (parameterType == "object") {
            objectLength <- length(parameter)
            if (objectLength == 1) {
                for (objectKey in names(parameter)) {
                    objectValue <- parameter[[objectKey]]
                    newArray <- append(newArray, list(objectValue))
                }
                next
            }
            newArray <- append(newArray, parameter)
            next
        }
        if (parameterType == "array") {
            for (arrayItemIndex in seq_along(parameter)) {
                arrayItem <- parameter[[arrayItemIndex]]
                newArray <- append(newArray, list(arrayItem))
            }
            next
        }
    }
    return(newArray)
}

arrayReduce <- function(callbackFunction, anArray, initialValue) {
    # JavaScript-like Array.reduce() function
    result <- NULL
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        if (arrayItemIndex == 1) {
            result <- callbackFunction(initialValue, arrayItem, arrayItemIndex, anArray)
        } else {
            result <- callbackFunction(result, arrayItem, arrayItemIndex, anArray)
        }
    }
    return(result)
}

cat("\n# JavaScript-like Array.reduce() in JavaScript-like-Array R list\n")

numbers <- list(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
cat(paste(sep = "", "numbers: ", prettyArrayOfPrimitives(numbers), "\n"))

cat("# using JavaScript-like Array.reduce() function \"arrayReduce\"\n")

numbersTotal <- arrayReduce(function(currentResult, currentNumber, ...) (currentResult + currentNumber), numbers, 0)
cat(paste(sep = "", "total number: ", prettyJsonStringify(numbersTotal), "\n"))
# total number: 635

cat("# using R Array.reduce() built-in function \"Reduce\"\n")

numbersTotal <- Reduce(function(currentResult, currentNumber) (currentResult + currentNumber), numbers, 0)
cat(paste(sep = "", "total number: ", prettyJsonStringify(numbersTotal), "\n"))
# total number: 635

cat("\n# JavaScript-like Array.map() in JavaScript-like-Array-of-Objects R list\n")

products <- list(
    list(
        code = "pasta",
        price = 321
    ),
    list(
        code = "bubble_gum",
        price = 233
    ),
    list(
        code = "potato_chips",
        price = 5
    ),
    list(
        code = "towel",
        price = 499
    )
)
cat(paste(sep = "", "products: ", prettyJsonStringify(products), "\n"))

cat("# using JavaScript-like Array.reduce() function \"arrayReduce\"\n")

productsGrouped <- arrayReduce(function(currentResult, currentProduct, ...) (if (currentProduct$price > 100) spreadSyntaxObject(currentResult, list(expensive = spreadSyntaxArray(currentResult$expensive, list(currentProduct = currentProduct)))) else spreadSyntaxObject(currentResult, list(cheap = spreadSyntaxArray(currentResult$cheap, list(currentProduct = currentProduct))))), products, list(expensive = list(), cheap = list()))
cat(paste(sep = "", "grouped products: ", prettyJsonStringify(productsGrouped), "\n"))
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }

cat("# using R Array.reduce() built-in function \"Reduce\"\n")

productsGrouped <- Reduce(function(currentResult, currentProduct) (if (currentProduct$price > 100) spreadSyntaxObject(currentResult, list(expensive = spreadSyntaxArray(currentResult$expensive, list(currentProduct = currentProduct)))) else spreadSyntaxObject(currentResult, list(cheap = spreadSyntaxArray(currentResult$cheap, list(currentProduct = currentProduct))))), products, list(expensive = list(), cheap = list()))
cat(paste(sep = "", "grouped products: ", prettyJsonStringify(productsGrouped), "\n"))
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }
