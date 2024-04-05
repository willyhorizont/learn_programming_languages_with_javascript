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

arrayFilterV1 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.filter() function
    dataFiltered <- list()
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- callbackFunction(arrayItem, arrayItemIndex, anArray)
        if (isConditionMatch == TRUE) {
            dataFiltered <- append(dataFiltered, list(arrayItem))
        }
    }
    return(dataFiltered)
}

arrayFilterV2 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.filter() function
    dataFiltered <- list()
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        if (callbackFunction(arrayItem, arrayItemIndex, anArray) == TRUE) {
            dataFiltered <- append(dataFiltered, list(arrayItem))
        }
    }
    return(dataFiltered)
}

cat("\n# JavaScript-like Array.filter() in R list\n")

numbers <- list(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
cat(paste(sep = "", "numbers: ", jsonStringify(numbers), "\n"))

cat("# using JavaScript-like Array.filter() function \"arrayFilterV1\"\n")

numbersEven <- arrayFilterV1(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even numbers only: ", jsonStringify(numbersEven), "\n"))
# even numbers only: [12, 34, 36, 4, 254]

numbersOdd <- arrayFilterV1(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd numbers only: ", jsonStringify(numbersOdd), "\n"))
# odd numbers only: [27, 23, 65, 93, 87]

cat("# using JavaScript-like Array.filter() function \"arrayFilterV2\"\n")

numbersEven <- arrayFilterV2(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even numbers only: ", jsonStringify(numbersEven), "\n"))
# even numbers only: [12, 34, 36, 4, 254]

numbersOdd <- arrayFilterV2(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd numbers only: ", jsonStringify(numbersOdd), "\n"))
# odd numbers only: [27, 23, 65, 93, 87]

cat("# using R Array.filter() built-in function \"Filter\"\n")

numbersEven <- Filter(function(number) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even numbers only: ", jsonStringify(numbersEven), "\n"))
# even numbers only: [12, 34, 36, 4, 254]

numbersOdd <- Filter(function(number) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd numbers only: ", jsonStringify(numbersOdd), "\n"))
# odd numbers only: [27, 23, 65, 93, 87]

cat("\n# JavaScript-like Array.filter() in R list of Associative-list\n")

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

cat("# using JavaScript-like Array.filter() function \"arrayFilterV1\"\n")

productsBelow100 <- arrayFilterV1(function(product, ...) (product[["price"]] <= 100), products)
cat(paste(sep = "", "products with price <= 100 only: ", jsonStringify(productsBelow100, pretty = TRUE), "\n"))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

productsAbove100 <- arrayFilterV1(function(product, ...) (product[["price"]] > 100), products)
cat(paste(sep = "", "products with price > 100 only: ", jsonStringify(productsAbove100, pretty = TRUE), "\n"))
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

cat("# using JavaScript-like Array.filter() function \"arrayFilterV2\"\n")

productsBelow100 <- arrayFilterV2(function(product, ...) (product[["price"]] <= 100), products)
cat(paste(sep = "", "products with price <= 100 only: ", jsonStringify(productsBelow100, pretty = TRUE), "\n"))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

productsAbove100 <- arrayFilterV2(function(product, ...) (product[["price"]] > 100), products)
cat(paste(sep = "", "products with price > 100 only: ", jsonStringify(productsAbove100, pretty = TRUE), "\n"))
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

cat("# using R Array.filter() built-in function \"Filter\"\n")

productsBelow100 <- Filter(function(product, ...) (product[["price"]] <= 100), products)
cat(paste(sep = "", "products with price <= 100 only: ", jsonStringify(productsBelow100, pretty = TRUE), "\n"))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

productsAbove100 <- Filter(function(product, ...) (product[["price"]] > 100), products)
cat(paste(sep = "", "products with price > 100 only: ", jsonStringify(productsAbove100, pretty = TRUE), "\n"))
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]
