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

cat("\n# JavaScript-like Array.every() in R list\n")

numbers <- list(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
cat(paste(sep = "", "numbers: ", jsonStringify(numbers), "\n"))

cat("# using JavaScript-like Array.every() function \"arrayEveryV1\"\n")

isAllNumberLessThan500 <- arrayEveryV1(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is all number < 500: ", jsonStringify(isAllNumberLessThan500), "\n"))
# is all number < 500: true

isAllNumberMoreThan500 <- arrayEveryV1(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is all number > 500: ", jsonStringify(isAllNumberMoreThan500), "\n"))
# is all number > 500: false

cat("# using JavaScript-like Array.every() function \"arrayEveryV2\"\n")

isAllNumberLessThan500 <- arrayEveryV2(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is all number < 500: ", jsonStringify(isAllNumberLessThan500), "\n"))
# is all number < 500: true

isAllNumberMoreThan500 <- arrayEveryV2(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is all number > 500: ", jsonStringify(isAllNumberMoreThan500), "\n"))
# is all number > 500: false

cat("# using JavaScript-like Array.every() function \"arrayEveryV3\"\n")

isAllNumberLessThan500 <- arrayEveryV3(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is all number < 500: ", jsonStringify(isAllNumberLessThan500), "\n"))
# is all number < 500: true

isAllNumberMoreThan500 <- arrayEveryV3(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is all number > 500: ", jsonStringify(isAllNumberMoreThan500), "\n"))
# is all number > 500: false

cat("# using JavaScript-like Array.every() function \"arrayEveryV4\"\n")

isAllNumberLessThan500 <- arrayEveryV4(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is all number < 500: ", jsonStringify(isAllNumberLessThan500), "\n"))
# is all number < 500: true

isAllNumberMoreThan500 <- arrayEveryV4(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is all number > 500: ", jsonStringify(isAllNumberMoreThan500), "\n"))
# is all number > 500: false

cat("# using R Array.every() built-in function \"all\"\n")

isAllNumberLessThan500 <- all(sapply(numbers, function(number) (number < 500)))
cat(paste(sep = "", "is all number < 500: ", jsonStringify(isAllNumberLessThan500), "\n"))
# is all number < 500: true

isAllNumberMoreThan500 <- all(sapply(numbers, function(number) (number > 500)))
cat(paste(sep = "", "is all number > 500: ", jsonStringify(isAllNumberMoreThan500), "\n"))
# is all number > 500: false

isAllNumberLessThan500 <- all((numbers < 500))
cat(paste(sep = "", "is all number < 500: ", jsonStringify(isAllNumberLessThan500), "\n"))
# is all number < 500: true

isAllNumberMoreThan500 <- all((numbers > 500))
cat(paste(sep = "", "is all number > 500: ", jsonStringify(isAllNumberMoreThan500), "\n"))
# is all number > 500: false

cat("\n# JavaScript-like Array.every() in R list of Associative-list\n")

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

cat("# using JavaScript-like Array.every() function \"arrayEveryV1\"\n")

isAllProductPriceLessThan500 <- arrayEveryV1(function(product, ...) (product[["price"]] < 500), products)
cat(paste(sep = "", "is all product price < 500: ", jsonStringify(isAllProductPriceLessThan500), "\n"))
# is all product price < 500: true

isAllProductPriceMoreThan500 <- arrayEveryV1(function(product, ...) (product[["price"]] > 500), products)
cat(paste(sep = "", "is all product price > 500: ", jsonStringify(isAllProductPriceMoreThan500), "\n"))
# is all product price > 500: false

cat("# using JavaScript-like Array.every() function \"arrayEveryV2\"\n")

isAllProductPriceLessThan500 <- arrayEveryV2(function(product, ...) (product[["price"]] < 500), products)
cat(paste(sep = "", "is all product price < 500: ", jsonStringify(isAllProductPriceLessThan500), "\n"))
# is all product price < 500: true

isAllProductPriceMoreThan500 <- arrayEveryV2(function(product, ...) (product[["price"]] > 500), products)
cat(paste(sep = "", "is all product price > 500: ", jsonStringify(isAllProductPriceMoreThan500), "\n"))
# is all product price > 500: false

cat("# using JavaScript-like Array.every() function \"arrayEveryV3\"\n")

isAllProductPriceLessThan500 <- arrayEveryV3(function(product, ...) (product[["price"]] < 500), products)
cat(paste(sep = "", "is all product price < 500: ", jsonStringify(isAllProductPriceLessThan500), "\n"))
# is all product price < 500: true

isAllProductPriceMoreThan500 <- arrayEveryV3(function(product, ...) (product[["price"]] > 500), products)
cat(paste(sep = "", "is all product price > 500: ", jsonStringify(isAllProductPriceMoreThan500), "\n"))
# is all product price > 500: false

cat("# using JavaScript-like Array.every() function \"arrayEveryV4\"\n")

isAllProductPriceLessThan500 <- arrayEveryV4(function(product, ...) (product[["price"]] < 500), products)
cat(paste(sep = "", "is all product price < 500: ", jsonStringify(isAllProductPriceLessThan500), "\n"))
# is all product price < 500: true

isAllProductPriceMoreThan500 <- arrayEveryV4(function(product, ...) (product[["price"]] > 500), products)
cat(paste(sep = "", "is all product price > 500: ", jsonStringify(isAllProductPriceMoreThan500), "\n"))
# is all product price > 500: false

cat("# using R Array.every() built-in function \"all\"\n")

isAllProductPriceLessThan500 <- all(sapply(products, function(product, ...) (product[["price"]] < 500)))
cat(paste(sep = "", "is all product price < 500: ", jsonStringify(isAllProductPriceLessThan500), "\n"))
# is all product price < 500: true

isAllProductPriceMoreThan500 <- all(sapply(products, function(product, ...) (product[["price"]] > 500)))
cat(paste(sep = "", "is all product price > 500: ", jsonStringify(isAllProductPriceMoreThan500), "\n"))
# is all product price > 500: false
