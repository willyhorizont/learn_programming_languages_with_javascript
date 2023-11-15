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

arrayEveryV1 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.every() function
    isConditionMatch <- FALSE
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == FALSE) break
    }
    return(isConditionMatch)
}

arrayEveryV2 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.every() function
    isConditionMatch <- FALSE
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == FALSE) return(isConditionMatch)
    }
    return(isConditionMatch)
}

arrayEveryV3 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.every() function
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == FALSE) return(FALSE)
    }
    return(TRUE)
}

arrayEveryV4 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.every() function
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == FALSE) return(FALSE)
    }
    return(TRUE)
}

cat("\n# JavaScript-like Array.every() in JavaScript-like-Array R list\n")

numbers <- list(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
cat(paste(sep = "", "numbers: ", prettyArrayOfPrimitives(numbers), "\n"))

cat("# using JavaScript-like Array.every() function \"arrayEveryV1\"\n")

isAllNumberLessThan500 <- arrayEveryV1(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is all number < 500: ", isAllNumberLessThan500, "\n"))
# is all number < 500: TRUE

isAllNumberMoreThan500 <- arrayEveryV1(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is all number > 500: ", isAllNumberMoreThan500, "\n"))
# is all number > 500: FALSE

cat("# using JavaScript-like Array.every() function \"arrayEveryV2\"\n")

isAllNumberLessThan500 <- arrayEveryV2(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is all number < 500: ", isAllNumberLessThan500, "\n"))
# is all number < 500: TRUE

isAllNumberMoreThan500 <- arrayEveryV2(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is all number > 500: ", isAllNumberMoreThan500, "\n"))
# is all number > 500: FALSE

cat("# using JavaScript-like Array.every() function \"arrayEveryV3\"\n")

isAllNumberLessThan500 <- arrayEveryV3(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is all number < 500: ", isAllNumberLessThan500, "\n"))
# is all number < 500: TRUE

isAllNumberMoreThan500 <- arrayEveryV3(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is all number > 500: ", isAllNumberMoreThan500, "\n"))
# is all number > 500: FALSE

cat("# using JavaScript-like Array.every() function \"arrayEveryV4\"\n")

isAllNumberLessThan500 <- arrayEveryV4(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is all number < 500: ", isAllNumberLessThan500, "\n"))
# is all number < 500: TRUE

isAllNumberMoreThan500 <- arrayEveryV4(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is all number > 500: ", isAllNumberMoreThan500, "\n"))
# is all number > 500: FALSE

cat("# using R Array.every() built-in function \"all\"\n")

isAllNumberLessThan500 <- all(sapply(numbers, function(number) (number < 500)))
cat(paste(sep = "", "is all number < 500: ", isAllNumberLessThan500, "\n"))
# is all number < 500: TRUE

isAllNumberMoreThan500 <- all(sapply(numbers, function(number) (number > 500)))
cat(paste(sep = "", "is all number > 500: ", isAllNumberMoreThan500, "\n"))
# is all number > 500: FALSE

isAllNumberLessThan500 <- all((numbers < 500))
cat(paste(sep = "", "is all number < 500: ", isAllNumberLessThan500, "\n"))
# is all number < 500: TRUE

isAllNumberMoreThan500 <- all((numbers > 500))
cat(paste(sep = "", "is all number > 500: ", isAllNumberMoreThan500, "\n"))
# is all number > 500: FALSE

cat("\n# JavaScript-like Array.every() in JavaScript-like-Array-of-Objects R list\n")

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

cat("# using JavaScript-like Array.every() function \"arrayEveryV1\"\n")

isAllProductPriceLessThan500 <- arrayEveryV1(function(product, ...) (product$price < 500), products)
cat(paste(sep = "", "is all product price < 500: ", isAllProductPriceLessThan500, "\n"))
# is all product price < 500: TRUE

isAllProductPriceMoreThan500 <- arrayEveryV1(function(product, ...) (product$price > 500), products)
cat(paste(sep = "", "is all product price > 500: ", isAllProductPriceMoreThan500, "\n"))
# # is all product price > 500: FALSE

cat("# using JavaScript-like Array.every() function \"arrayEveryV2\"\n")

isAllProductPriceLessThan500 <- arrayEveryV2(function(product, ...) (product$price < 500), products)
cat(paste(sep = "", "is all product price < 500: ", isAllProductPriceLessThan500, "\n"))
# is all product price < 500: TRUE

isAllProductPriceMoreThan500 <- arrayEveryV2(function(product, ...) (product$price > 500), products)
cat(paste(sep = "", "is all product price > 500: ", isAllProductPriceMoreThan500, "\n"))
# # is all product price > 500: FALSE

cat("# using JavaScript-like Array.every() function \"arrayEveryV3\"\n")

isAllProductPriceLessThan500 <- arrayEveryV3(function(product, ...) (product$price < 500), products)
cat(paste(sep = "", "is all product price < 500: ", isAllProductPriceLessThan500, "\n"))
# is all product price < 500: TRUE

isAllProductPriceMoreThan500 <- arrayEveryV3(function(product, ...) (product$price > 500), products)
cat(paste(sep = "", "is all product price > 500: ", isAllProductPriceMoreThan500, "\n"))
# # is all product price > 500: FALSE

cat("# using JavaScript-like Array.every() function \"arrayEveryV4\"\n")

isAllProductPriceLessThan500 <- arrayEveryV4(function(product, ...) (product$price < 500), products)
cat(paste(sep = "", "is all product price < 500: ", isAllProductPriceLessThan500, "\n"))
# is all product price < 500: TRUE

isAllProductPriceMoreThan500 <- arrayEveryV4(function(product, ...) (product$price > 500), products)
cat(paste(sep = "", "is all product price > 500: ", isAllProductPriceMoreThan500, "\n"))
# # is all product price > 500: FALSE

cat("# using R Array.every() built-in function \"all\"\n")

isAllProductPriceLessThan500 <- all(sapply(products, function(product, ...) (product$price < 500)))
cat(paste(sep = "", "is all product price < 500: ", isAllProductPriceLessThan500, "\n"))
# is all product price < 500: TRUE

isAllProductPriceMoreThan500 <- all(sapply(products, function(product, ...) (product$price > 500)))
cat(paste(sep = "", "is all product price > 500: ", isAllProductPriceMoreThan500, "\n"))
# is all product price > 500: FALSE
