typeOf <- function(anything) {
    if (is.list(anything) == FALSE) return(class(anything))
    if (length(anything) == 0) return("array")
    if (is.null(names(anything)) == TRUE) return("array")
    return("object")
}

jsonStringify <- function(anything, pretty = FALSE, indent = strrep(" ", 4)) {
    indentLevel <- 0
    jsonStringifyInner <- function(anythingInner, indentInner) {
        if (is.null(anythingInner)) return("null")
        if (is.character(anythingInner)) return(paste(sep = "", "\"", anythingInner, "\""))
        if (is.numeric(anythingInner) || is.logical(anythingInner)) return(paste(sep = "", anythingInner))
        if (typeOf(anythingInner) == "array") {
            if (length(anythingInner) == 0) return("[]")
            indentLevel <<- (indentLevel + 1)
            result <- (if (pretty == TRUE) paste(sep = "", "[\n", strrep(indentInner, indentLevel)) else "[")
            for (arrayItemIndex in seq_along(anythingInner)) {
                arrayItem <- anythingInner[[arrayItemIndex]]
                result <- paste(sep = "", result, jsonStringifyInner(arrayItem, indentInner))
                if (arrayItemIndex != length(anythingInner)) result <- (if (pretty == TRUE) paste(sep = "", result, ",\n", strrep(indentInner, indentLevel)) else paste(sep = "", result, ", "))
            }
            indentLevel <<- (indentLevel - 1)
            result <- (if (pretty == TRUE) paste(sep = "", result, "\n", strrep(indentInner, indentLevel), "]") else paste(sep = "", result, "]"))
            return(result)
        }
        if (typeOf(anythingInner) == "object") {
            if (length(names(anythingInner)) == 0) return("{}")
            indentLevel <<- (indentLevel + 1)
            result <- (if (pretty == TRUE) paste(sep = "", "{\n", strrep(indentInner, indentLevel)) else "{")
            for (objectEntryIndex in seq_along(anythingInner)) {
                objectKey <- names(anythingInner)[objectEntryIndex]
                objectValue <- anythingInner[[objectEntryIndex]]
                result <- paste(sep = "", result, "\"", objectKey, "\": ", jsonStringifyInner(objectValue, indentInner))
                if (objectEntryIndex != length(names(anythingInner))) result <- (if (pretty == TRUE) paste(sep = "", result, ",\n", strrep(indentInner, indentLevel)) else paste(sep = "", result, ", "))
            }
            indentLevel <<- (indentLevel - 1)
            result <- (if (pretty == TRUE) paste(sep = "", result, "\n", strrep(indentInner, indentLevel), "}") else paste(sep = "", result, "}"))
            return(result)
        }
        return("null")
    }
    return(jsonStringifyInner(anything, indent))
}

cc <- function(...) {
    parameters <- list(...)
    newObject <- list()
    for (parameterIndex in seq_along(parameters)) {
        parameter <- parameters[[parameterIndex]]
        parameterType <- typeOf(parameter)
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

productsGrouped <- arrayReduce(function(currentResult, currentProduct, ...) (if (currentProduct[["price"]] > 100) cc(currentResult, list(expensive = c(currentResult[["expensive"]], list(currentProduct)))) else cc(currentResult, list(cheap = c(currentResult[["cheap"]], list(currentProduct))))), products, list(expensive = list(), cheap = list()))
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

productsGrouped <- Reduce(function(currentResult, currentProduct) (if (currentProduct[["price"]] > 100) cc(currentResult, list(expensive = c(currentResult[["expensive"]], list(currentProduct)))) else cc(currentResult, list(cheap = c(currentResult[["cheap"]], list(currentProduct))))), products, list(expensive = list(), cheap = list()))
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
