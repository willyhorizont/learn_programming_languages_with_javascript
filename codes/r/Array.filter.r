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
            dataFiltered <- append(dataFiltered, arrayItem)
        }
    }
    return(dataFiltered)
}

cat("\n# JavaScript-like Array.filter() in JavaScript-like-Array R list\n")

numbers <- list(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
cat(paste(sep = "", "numbers: ", prettyArrayOfPrimitives(numbers), "\n"))

cat("# using JavaScript-like Array.filter() function \"arrayFilterV1\"\n")

numbersEven <- arrayFilterV1(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even numbers only: ", prettyArrayOfPrimitives(numbersEven), "\n"))
# even numbers only: [12, 34, 36, 4, 254]

numbersOdd <- arrayFilterV1(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd numbers only: ", prettyArrayOfPrimitives(numbersOdd), "\n"))
# odd numbers only: [27, 23, 65, 93, 87]

cat("# using JavaScript-like Array.filter() function \"arrayFilterV2\"\n")

numbersEven <- arrayFilterV2(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even numbers only: ", prettyArrayOfPrimitives(numbersEven), "\n"))
# even numbers only: [12, 34, 36, 4, 254]

numbersOdd <- arrayFilterV2(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd numbers only: ", prettyArrayOfPrimitives(numbersOdd), "\n"))
# odd numbers only: [27, 23, 65, 93, 87]

cat("# using R Array.filter() built-in function \"Filter\"\n")

numbersEven <- Filter(function(number) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even numbers only: ", prettyArrayOfPrimitives(numbersEven), "\n"))
# even numbers only: [12, 34, 36, 4, 254]

numbersOdd <- Filter(function(number) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd numbers only: ", prettyArrayOfPrimitives(numbersOdd), "\n"))
# odd numbers only: [27, 23, 65, 93, 87]

cat("\n# JavaScript-like Array.filter() in JavaScript-like-Array-of-Objects R list\n")

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

cat("# using JavaScript-like Array.filter() function \"arrayFilterV1\"\n")

productsBelow100 <- arrayFilterV1(function(product, ...) (product$price <= 100), products)
cat(paste(sep = "", "products with price <= 100 only: ", prettyJsonStringify(productsBelow100), "\n"))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

productsAbove100 <- arrayFilterV1(function(product, ...) (product$price >= 100), products)
cat(paste(sep = "", "products with price >= 100 only: ", prettyJsonStringify(productsAbove100), "\n"))
# products with price >= 100 only: [
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

productsBelow100 <- arrayFilterV2(function(product, ...) (product$price <= 100), products)
cat(paste(sep = "", "products with price <= 100 only: ", prettyJsonStringify(productsBelow100), "\n"))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

productsAbove100 <- arrayFilterV2(function(product, ...) (product$price >= 100), products)
cat(paste(sep = "", "products with price >= 100 only: ", prettyJsonStringify(productsAbove100), "\n"))
# products with price >= 100 only: [
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

productsBelow100 <- Filter(function(product, ...) (product$price <= 100), products)
cat(paste(sep = "", "products with price <= 100 only: ", prettyJsonStringify(productsBelow100), "\n"))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

productsAbove100 <- Filter(function(product, ...) (product$price >= 100), products)
cat(paste(sep = "", "products with price >= 100 only: ", prettyJsonStringify(productsAbove100), "\n"))
# products with price >= 100 only: [
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
