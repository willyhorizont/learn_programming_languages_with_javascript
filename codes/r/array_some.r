library(jsonlite)

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

arraySomeV1 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.some() function
    isConditionMatch <- FALSE
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == TRUE) break
    }
    return(isConditionMatch)
}

arraySomeV2 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.some() function
    isConditionMatch <- FALSE
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == TRUE) return(isConditionMatch)
    }
    return(isConditionMatch)
}

arraySomeV3 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.some() function
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == TRUE) return(TRUE)
    }
    return(FALSE)
}

arraySomeV4 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.some() function
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == TRUE) return(TRUE)
    }
    return(FALSE)
}

cat("\n# JavaScript-like Array.some() in R list\n")

numbers <- list(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
cat(paste(sep = "", "numbers: ", prettyArrayOfPrimitives(numbers), "\n"))

cat("# using JavaScript-like Array.some() function \"arraySomeV1\"\n")

isAnyProductPriceLessThan500 <- arraySomeV1(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is any number < 500: ", isAnyProductPriceLessThan500, "\n"))
# is any number < 500: TRUE

isAnyNumberMoreThan500 <- arraySomeV1(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is any number > 500: ", isAnyNumberMoreThan500, "\n"))
# is any number > 500: FALSE

cat("# using JavaScript-like Array.some() function \"arraySomeV2\"\n")

isAnyProductPriceLessThan500 <- arraySomeV2(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is any number < 500: ", isAnyProductPriceLessThan500, "\n"))
# is any number < 500: TRUE

isAnyNumberMoreThan500 <- arraySomeV2(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is any number > 500: ", isAnyNumberMoreThan500, "\n"))
# is any number > 500: FALSE

cat("# using JavaScript-like Array.some() function \"arraySomeV3\"\n")

isAnyProductPriceLessThan500 <- arraySomeV3(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is any number < 500: ", isAnyProductPriceLessThan500, "\n"))
# is any number < 500: TRUE

isAnyNumberMoreThan500 <- arraySomeV3(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is any number > 500: ", isAnyNumberMoreThan500, "\n"))
# is any number > 500: FALSE

cat("# using JavaScript-like Array.some() function \"arraySomeV4\"\n")

isAnyProductPriceLessThan500 <- arraySomeV4(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is any number < 500: ", isAnyProductPriceLessThan500, "\n"))
# is any number < 500: TRUE

isAnyNumberMoreThan500 <- arraySomeV4(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is any number > 500: ", isAnyNumberMoreThan500, "\n"))
# is any number > 500: FALSE

cat("# using R Array.some() built-in function \"any\"\n")

isAnyProductPriceLessThan500 <- any(sapply(numbers, function(number) (number < 500)))
cat(paste(sep = "", "is any number < 500: ", isAnyProductPriceLessThan500, "\n"))
# is any number < 500: TRUE

isAnyNumberMoreThan500 <- any(sapply(numbers, function(number) (number > 500)))
cat(paste(sep = "", "is any number > 500: ", isAnyNumberMoreThan500, "\n"))
# is any number > 500: FALSE

isAnyProductPriceLessThan500 <- any((numbers < 500))
cat(paste(sep = "", "is any number < 500: ", isAnyProductPriceLessThan500, "\n"))
# is any number < 500: TRUE

isAnyNumberMoreThan500 <- any((numbers > 500))
cat(paste(sep = "", "is any number > 500: ", isAnyNumberMoreThan500, "\n"))
# is any number > 500: FALSE

cat("\n# JavaScript-like Array.some() in R list of Associative-list\n")

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

cat("# using JavaScript-like Array.some() function \"arraySomeV1\"\n")

isAnyProductPriceLessThan500 <- arraySomeV1(function(product, ...) (product$price < 500), products)
cat(paste(sep = "", "is any product price < 500: ", isAnyProductPriceLessThan500, "\n"))
# is any product price < 500: TRUE

isAnyProductPriceMoreThan500 <- arraySomeV1(function(product, ...) (product$price > 500), products)
cat(paste(sep = "", "is any product price > 500: ", isAnyProductPriceMoreThan500, "\n"))
# # is any product price > 500: FALSE

cat("# using JavaScript-like Array.some() function \"arraySomeV2\"\n")

isAnyProductPriceLessThan500 <- arraySomeV2(function(product, ...) (product$price < 500), products)
cat(paste(sep = "", "is any product price < 500: ", isAnyProductPriceLessThan500, "\n"))
# is any product price < 500: TRUE

isAnyProductPriceMoreThan500 <- arraySomeV2(function(product, ...) (product$price > 500), products)
cat(paste(sep = "", "is any product price > 500: ", isAnyProductPriceMoreThan500, "\n"))
# # is any product price > 500: FALSE

cat("# using JavaScript-like Array.some() function \"arraySomeV3\"\n")

isAnyProductPriceLessThan500 <- arraySomeV3(function(product, ...) (product$price < 500), products)
cat(paste(sep = "", "is any product price < 500: ", isAnyProductPriceLessThan500, "\n"))
# is any product price < 500: TRUE

isAnyProductPriceMoreThan500 <- arraySomeV3(function(product, ...) (product$price > 500), products)
cat(paste(sep = "", "is any product price > 500: ", isAnyProductPriceMoreThan500, "\n"))
# # is any product price > 500: FALSE

cat("# using JavaScript-like Array.some() function \"arraySomeV4\"\n")

isAnyProductPriceLessThan500 <- arraySomeV4(function(product, ...) (product$price < 500), products)
cat(paste(sep = "", "is any product price < 500: ", isAnyProductPriceLessThan500, "\n"))
# is any product price < 500: TRUE

isAnyProductPriceMoreThan500 <- arraySomeV4(function(product, ...) (product$price > 500), products)
cat(paste(sep = "", "is any product price > 500: ", isAnyProductPriceMoreThan500, "\n"))
# # is any product price > 500: FALSE

cat("# using R Array.some() built-in function \"any\"\n")

isAnyProductPriceLessThan500 <- any(sapply(products, function(product, ...) (product$price < 500)))
cat(paste(sep = "", "is any product price < 500: ", isAnyProductPriceLessThan500, "\n"))
# is any product price < 500: TRUE

isAnyProductPriceMoreThan500 <- any(sapply(products, function(product, ...) (product$price > 500)))
cat(paste(sep = "", "is any product price > 500: ", isAnyProductPriceMoreThan500, "\n"))
# is any product price > 500: FALSE
