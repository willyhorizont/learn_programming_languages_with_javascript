library(jsonlite)

# There's no JavaScript-like Array.find() in R.
# But, we can create our own function to mimic it in R.

prettyJsonStringify <- function(anything) {
    prettyJsonStringWithTrailingNewLine <- prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4)
    prettyJsonStringWithoutTrailingNewLine <- gsub("\\n$", "", prettyJsonStringWithTrailingNewLine, perl = TRUE)
    prettyJsonStringWithoutTrailingNewLineAndWithProperNull <- gsub("\\{\\s*\\n\\s*\\}", "null", prettyJsonStringWithoutTrailingNewLine, perl = TRUE)
    return(prettyJsonStringWithoutTrailingNewLineAndWithProperNull)
}

prettyArrayOfPrimitives <- function(anArrayOfPrimitives) {
    result <- "["
    for (arrayItemIndex in seq_along(anArrayOfPrimitives)) {
        arrayItem <- anArrayOfPrimitives[[arrayItemIndex]]
        if ((is.character(arrayItem) == FALSE) && (is.numeric(arrayItem) == FALSE) && (is.logical(arrayItem) == FALSE) && (is.null(arrayItem) == FALSE)) next
        if (is.character(arrayItem) == TRUE) {
            result <- paste(sep = "", result, "\"", arrayItem, "\"")
        }
        if ((is.numeric(arrayItem) == TRUE) || (is.logical(arrayItem) == TRUE)) {
            result <- paste(sep = "", result, arrayItem)
        }
        if (is.null(arrayItem) == TRUE) {
            result <- paste(sep = "", result, "null")
        }
        if (arrayItemIndex != length(anArrayOfPrimitives)) {
            result <- paste(sep = "", result, ", ")
        }
    }
    result <- paste(sep = "", result, "]")
    return(result)
}

arrayFindV1 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.find() function
    dataFound <- NULL
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == TRUE) {
            dataFound <- arrayItem
            break
        }
    }
    return(dataFound)
}

arrayFindV2 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.find() function
    dataFound <- NULL
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == TRUE) {
            dataFound <- arrayItem
            break
        }
    }
    return(dataFound)
}

arrayFindV3 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.find() function
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == TRUE) return(arrayItem)
    }
    return(NULL)
}

arrayFindV4 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.find() function
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == TRUE) return(arrayItem)
    }
    return(NULL)
}

cat("\n# JavaScript-like Array.find() in R list\n")

numbers <- list(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
cat(paste(sep = "", "numbers: ", prettyArrayOfPrimitives(numbers), "\n"))

cat("# using JavaScript-like Array.find() function \"arrayFindV1\"\n")

evenNumberFound <- arrayFindV1(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even number found: ", evenNumberFound, "\n"))
# even number found: 12

oddNumbersFound <- arrayFindV1(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd number found: ", oddNumbersFound, "\n"))
# odd number found: 27

cat("# using JavaScript-like Array.find() function \"arrayFindV2\"\n")

evenNumberFound <- arrayFindV2(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even number found: ", evenNumberFound, "\n"))
# even number found: 12

oddNumbersFound <- arrayFindV2(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd number found: ", oddNumbersFound, "\n"))
# odd number found: 27

cat("# using JavaScript-like Array.find() function \"arrayFindV3\"\n")

evenNumberFound <- arrayFindV3(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even number found: ", evenNumberFound, "\n"))
# even number found: 12

oddNumbersFound <- arrayFindV3(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd number found: ", oddNumbersFound, "\n"))
# odd number found: 27

cat("# using JavaScript-like Array.find() function \"arrayFindV4\"\n")

evenNumberFound <- arrayFindV4(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even number found: ", evenNumberFound, "\n"))
# even number found: 12

oddNumbersFound <- arrayFindV4(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd number found: ", oddNumbersFound, "\n"))
# odd number found: 27

cat("\n# JavaScript-like Array.find() in R list of Associative-list\n")

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

productToFind <- "bubble_gum"
cat(paste(sep = "", "product to find: ", productToFind, "\n"))

cat("# using JavaScript-like Array.find() function \"arrayFindV1\"\n")

productFound <- arrayFindV1(function(product, ...) (product$code == productToFind), products)
cat(paste(sep = "", "product found: ", prettyJsonStringify(productFound), "\n"))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

cat("# using JavaScript-like Array.find() function \"arrayFindV2\"\n")

productFound <- arrayFindV2(function(product, ...) (product$code == productToFind), products)
cat(paste(sep = "", "product found: ", prettyJsonStringify(productFound), "\n"))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

cat("# using JavaScript-like Array.find() function \"arrayFindV3\"\n")

productFound <- arrayFindV3(function(product, ...) (product$code == productToFind), products)
cat(paste(sep = "", "product found: ", prettyJsonStringify(productFound), "\n"))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

cat("# using JavaScript-like Array.find() function \"arrayFindV4\"\n")

productFound <- arrayFindV4(function(product, ...) (product$code == productToFind), products)
cat(paste(sep = "", "product found: ", prettyJsonStringify(productFound), "\n"))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }
