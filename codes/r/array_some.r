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
cat(paste(sep = "", "numbers: ", jsonStringify(numbers), "\n"))

cat("# using JavaScript-like Array.some() function \"arraySomeV1\"\n")

isAnyNumberLessThan500 <- arraySomeV1(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is any number < 500: ", jsonStringify(isAnyNumberLessThan500), "\n"))
# is any number < 500: true

isAnyNumberMoreThan500 <- arraySomeV1(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is any number > 500: ", jsonStringify(isAnyNumberMoreThan500), "\n"))
# is any number > 500: false

cat("# using JavaScript-like Array.some() function \"arraySomeV2\"\n")

isAnyNumberLessThan500 <- arraySomeV2(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is any number < 500: ", jsonStringify(isAnyNumberLessThan500), "\n"))
# is any number < 500: true

isAnyNumberMoreThan500 <- arraySomeV2(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is any number > 500: ", jsonStringify(isAnyNumberMoreThan500), "\n"))
# is any number > 500: false

cat("# using JavaScript-like Array.some() function \"arraySomeV3\"\n")

isAnyNumberLessThan500 <- arraySomeV3(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is any number < 500: ", jsonStringify(isAnyNumberLessThan500), "\n"))
# is any number < 500: true

isAnyNumberMoreThan500 <- arraySomeV3(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is any number > 500: ", jsonStringify(isAnyNumberMoreThan500), "\n"))
# is any number > 500: false

cat("# using JavaScript-like Array.some() function \"arraySomeV4\"\n")

isAnyNumberLessThan500 <- arraySomeV4(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is any number < 500: ", jsonStringify(isAnyNumberLessThan500), "\n"))
# is any number < 500: true

isAnyNumberMoreThan500 <- arraySomeV4(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is any number > 500: ", jsonStringify(isAnyNumberMoreThan500), "\n"))
# is any number > 500: false

cat("# using R Array.some() built-in function \"any\"\n")

isAnyProductPriceLessThan500 <- any(sapply(numbers, function(number) (number < 500)))
cat(paste(sep = "", "is any number < 500: ", jsonStringify(isAnyProductPriceLessThan500), "\n"))
# is any number < 500: true

isAnyNumberMoreThan500 <- any(sapply(numbers, function(number) (number > 500)))
cat(paste(sep = "", "is any number > 500: ", jsonStringify(isAnyNumberMoreThan500), "\n"))
# is any number > 500: false

isAnyProductPriceLessThan500 <- any((numbers < 500))
cat(paste(sep = "", "is any number < 500: ", jsonStringify(isAnyProductPriceLessThan500), "\n"))
# is any number < 500: true

isAnyNumberMoreThan500 <- any((numbers > 500))
cat(paste(sep = "", "is any number > 500: ", jsonStringify(isAnyNumberMoreThan500), "\n"))
# is any number > 500: false

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
cat(paste(sep = "", "products: ", jsonStringify(products, pretty = TRUE), "\n"))

cat("# using JavaScript-like Array.some() function \"arraySomeV1\"\n")

isAnyProductPriceLessThan500 <- arraySomeV1(function(product, ...) (product[["price"]] < 500), products)
cat(paste(sep = "", "is any product price < 500: ", jsonStringify(isAnyProductPriceLessThan500), "\n"))
# is any product price < 500: true

isAnyProductPriceMoreThan500 <- arraySomeV1(function(product, ...) (product[["price"]] > 500), products)
cat(paste(sep = "", "is any product price > 500: ", jsonStringify(isAnyProductPriceMoreThan500), "\n"))
# is any product price > 500: false

cat("# using JavaScript-like Array.some() function \"arraySomeV2\"\n")

isAnyProductPriceLessThan500 <- arraySomeV2(function(product, ...) (product[["price"]] < 500), products)
cat(paste(sep = "", "is any product price < 500: ", jsonStringify(isAnyProductPriceLessThan500), "\n"))
# is any product price < 500: true

isAnyProductPriceMoreThan500 <- arraySomeV2(function(product, ...) (product[["price"]] > 500), products)
cat(paste(sep = "", "is any product price > 500: ", jsonStringify(isAnyProductPriceMoreThan500), "\n"))
# is any product price > 500: false

cat("# using JavaScript-like Array.some() function \"arraySomeV3\"\n")

isAnyProductPriceLessThan500 <- arraySomeV3(function(product, ...) (product[["price"]] < 500), products)
cat(paste(sep = "", "is any product price < 500: ", jsonStringify(isAnyProductPriceLessThan500), "\n"))
# is any product price < 500: true

isAnyProductPriceMoreThan500 <- arraySomeV3(function(product, ...) (product[["price"]] > 500), products)
cat(paste(sep = "", "is any product price > 500: ", jsonStringify(isAnyProductPriceMoreThan500), "\n"))
# is any product price > 500: false

cat("# using JavaScript-like Array.some() function \"arraySomeV4\"\n")

isAnyProductPriceLessThan500 <- arraySomeV4(function(product, ...) (product[["price"]] < 500), products)
cat(paste(sep = "", "is any product price < 500: ", jsonStringify(isAnyProductPriceLessThan500), "\n"))
# is any product price < 500: true

isAnyProductPriceMoreThan500 <- arraySomeV4(function(product, ...) (product[["price"]] > 500), products)
cat(paste(sep = "", "is any product price > 500: ", jsonStringify(isAnyProductPriceMoreThan500), "\n"))
# is any product price > 500: false

cat("# using R Array.some() built-in function \"any\"\n")

isAnyProductPriceLessThan500 <- any(sapply(products, function(product, ...) (product[["price"]] < 500)))
cat(paste(sep = "", "is any product price < 500: ", jsonStringify(isAnyProductPriceLessThan500), "\n"))
# is any product price < 500: true

isAnyProductPriceMoreThan500 <- any(sapply(products, function(product, ...) (product[["price"]] > 500)))
cat(paste(sep = "", "is any product price > 500: ", jsonStringify(isAnyProductPriceMoreThan500), "\n"))
# is any product price > 500: false
