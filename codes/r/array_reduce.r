library(jsonlite)

jsonStringify <- function(anything, pretty = FALSE, indent = strrep(" ", 4)) {
    if (pretty == TRUE) {
        prettyJsonStringWithTrailingNewLine <- prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 3)
        prettyJsonStringWithCustomIndent <- gsub(strrep(" ", 3), indent, prettyJsonStringWithTrailingNewLine, perl = TRUE)
        prettyJsonStringWithoutTrailingNewLine <- gsub("\\n$", "", prettyJsonStringWithCustomIndent, perl = TRUE)
        prettyJsonStringWithoutTrailingNewLineAndWithProperNull <- gsub("\\{\\s*\\n\\s*\\}", "null", prettyJsonStringWithoutTrailingNewLine, perl = TRUE)
        return(prettyJsonStringWithoutTrailingNewLineAndWithProperNull)
    }
    jsonStringWithoutSpaceDelimiter <- toJSON(anything, pretty = FALSE, auto_unbox = TRUE)
    jsonStringWithSpaceDelimiterAfterComma <- gsub(",", ", ", jsonStringWithoutSpaceDelimiter, perl = TRUE)
    jsonStringWithSpaceDelimiterAfterCommaAndColon <- gsub(":", ": ", jsonStringWithSpaceDelimiterAfterComma, perl = TRUE)
    jsonStringWithSpaceDelimiterAfterCommaAndColonAndWithProperNull <- gsub("{}", "null", jsonStringWithSpaceDelimiterAfterCommaAndColon, perl = TRUE)
    return(jsonStringWithSpaceDelimiterAfterCommaAndColonAndWithProperNull)
}

typeOf <- function(anything) {
    if (is.list(anything) == FALSE) return(class(anything))
    if (length(anything) == 0) return("array")
    if (is.null(names(anything)) == TRUE) return("array")
    return("object")
}

mergeObject <- function(...) {
    parameters <- list(...)
    newObject <- list()
    for (parameterIndex in seq_along(parameters)) {
        parameter <- parameters[[parameterIndex]]
        parameterType <- typeOf(parameter)
        if (parameterType != "object") next
        for (objectKey in names(parameter)) {
            objectValue <- parameter[[objectKey]]
            newObject[[objectKey]] <- objectValue
        }
    }
    return(newObject)
}

arrayReduce <- function(callbackFunction, anArray, initialValue) {
    # JavaScript-like Array.reduce() function
    result <- initialValue
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        result <- callbackFunction(result, arrayItem, arrayItemIndex, anArray)
    }
    return(result)
}

cat("\n# JavaScript-like Array.reduce() in R list\n")

numbers <- list(36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3)
cat(paste(sep = "", "numbers: ", jsonStringify(numbers), "\n"))

cat("# using JavaScript-like Array.reduce() function \"arrayReduce\"\n")

numbersTotal <- arrayReduce(function(currentResult, currentNumber, ...) (currentResult + currentNumber), numbers, 0)
cat(paste(sep = "", "total number: ", jsonStringify(numbersTotal), "\n"))
# total number: 41.2

cat("# using R Array.reduce() built-in function \"Reduce\"\n")

numbersTotal <- Reduce(function(currentResult, currentNumber) (currentResult + currentNumber), numbers, 0)
cat(paste(sep = "", "total number: ", jsonStringify(numbersTotal), "\n"))
# total number: 41.2

cat("\n# JavaScript-like Array.reduce() in R list of Associative-list\n")

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
cat(paste(sep = "", "products: ", jsonStringify(products, pretty = TRUE), "\n"))

cat("# using JavaScript-like Array.reduce() function \"arrayReduce\"\n")

productsGrouped <- arrayReduce(function(currentResult, currentProduct, ...) (if (currentProduct[["price"]] > 100) mergeObject(currentResult, list(expensive = c(currentResult[["expensive"]], list(currentProduct)))) else mergeObject(currentResult, list(cheap = c(currentResult[["cheap"]], list(currentProduct))))), products, list(expensive = list(), cheap = list()))
cat(paste(sep = "", "grouped products test: ", jsonStringify(productsGrouped, pretty = TRUE), "\n"))

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

productsGrouped <- Reduce(function(currentResult, currentProduct) (if (currentProduct[["price"]] > 100) mergeObject(currentResult, list(expensive = c(currentResult[["expensive"]], list(currentProduct)))) else mergeObject(currentResult, list(cheap = c(currentResult[["cheap"]], list(currentProduct))))), products, list(expensive = list(), cheap = list()))
cat(paste(sep = "", "grouped products: ", jsonStringify(productsGrouped, pretty = TRUE), "\n"))
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
