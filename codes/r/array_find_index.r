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

# There's no JavaScript-like Array.findIndex() in R.
# But, we can create our own function to mimic it in R.

arrayFindIndexV1 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.findIndex() function
    dataFoundIndex <- -1
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == TRUE) {
            dataFoundIndex <- arrayItemIndex
            break
        }
    }
    return(dataFoundIndex)
}

arrayFindIndexV2 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.findIndex() function
    dataFoundIndex <- -1
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == TRUE) {
            dataFoundIndex <- arrayItemIndex
            break
        }
    }
    return(dataFoundIndex)
}

arrayFindIndexV3 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.findIndex() function
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == TRUE) return(arrayItemIndex)
    }
    return(-1)
}

arrayFindIndexV4 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.findIndex() function
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == TRUE) return(arrayItemIndex)
    }
    return(-1)
}

cat("\n# JavaScript-like Array.findIndex() in R list\n")

numbers <- list(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
cat(paste(sep = "", "numbers: ", jsonStringify(numbers), "\n"))

numberToFind <- 27
cat(paste(sep = "", "number to find: ", numberToFind, "\n"))

cat("# using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"\n")

numberFoundIndex <- arrayFindIndexV1(function(number, ...) (number == numberToFind), numbers)
cat(paste(sep = "", "number found index: ", numberFoundIndex, "\n"))
# number found index: 3

cat("# using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"\n")

numberFoundIndex <- arrayFindIndexV2(function(number, ...) (number == numberToFind), numbers)
cat(paste(sep = "", "number found index: ", numberFoundIndex, "\n"))
# number found index: 3

cat("# using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"\n")

numberFoundIndex <- arrayFindIndexV3(function(number, ...) (number == numberToFind), numbers)
cat(paste(sep = "", "number found index: ", numberFoundIndex, "\n"))
# number found index: 3

cat("# using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"\n")

numberFoundIndex <- arrayFindIndexV4(function(number, ...) (number == numberToFind), numbers)
cat(paste(sep = "", "number found index: ", numberFoundIndex, "\n"))
# number found index: 3

cat("\n# JavaScript-like Array.findIndex() in R list of Associative-list\n")

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

productToFind <- "pasta"
cat(paste(sep = "", "product to find: ", productToFind, "\n"))

cat("# using JavaScript-like Array.findIndex() function \"arrayFindIndexV1\"\n")

productFoundIndex <- arrayFindIndexV1(function(product, ...) (product[["code"]] == productToFind), products)
cat(paste(sep = "", "product found index: ", productFoundIndex, "\n"))
# product found index: 1

cat("# using JavaScript-like Array.findIndex() function \"arrayFindIndexV2\"\n")

productFoundIndex <- arrayFindIndexV2(function(product, ...) (product[["code"]] == productToFind), products)
cat(paste(sep = "", "product found index: ", productFoundIndex, "\n"))
# product found index: 1

cat("# using JavaScript-like Array.findIndex() function \"arrayFindIndexV3\"\n")

productFoundIndex <- arrayFindIndexV3(function(product, ...) (product[["code"]] == productToFind), products)
cat(paste(sep = "", "product found index: ", productFoundIndex, "\n"))
# product found index: 1

cat("# using JavaScript-like Array.findIndex() function \"arrayFindIndexV4\"\n")

productFoundIndex <- arrayFindIndexV4(function(product, ...) (product[["code"]] == productToFind), products)
cat(paste(sep = "", "product found index: ", productFoundIndex, "\n"))
# product found index: 1
