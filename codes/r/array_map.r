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

getType <- function(anything) {
    if (is.list(anything) == FALSE) return(class(anything))
    if (length(anything) == 0) return("empty_list")
    if (is.null(names(anything)) == TRUE) return("array")
    return("object")
}

spreadSyntaxObject <- function(...) {
    parameters <- list(...)
    newObject <- list()
    for (parameterIndex in seq_along(parameters)) {
        parameter <- parameters[[parameterIndex]]
        parameterType <- getType(parameter)
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

arrayMapV1 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.map() function
    newArray <- list()
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        newArrayItem <- callbackFunction(arrayItem, arrayItemIndex, anArray)
        newArray <- append(newArray, list(newArrayItem))
    }
    return(newArray)
}

arrayMapV2 <- function(callbackFunction, anArray) {
    # JavaScript-like Array.map() function
    newArray <- list()
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        newArray <- append(newArray, list(callbackFunction(arrayItem, arrayItemIndex, anArray)))
    }
    return(newArray)
}

cat("\n# JavaScript-like Array.map() in R list\n")

numbers <- list(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
cat(paste(sep = "", "numbers: ", prettyArrayOfPrimitives(numbers), "\n"))

cat("# using JavaScript-like Array.map() function \"arrayMapV1\"\n")

numbersLabeled <- arrayMapV1(function(number, ...) setNames(list((if ((number %% 2) == 0) "even" else "odd")), as.character(number)), numbers)
cat(paste(sep = "", "labeled numbers: ", prettyJsonStringify(numbersLabeled), "\n"))
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

cat("# using JavaScript-like Array.map() function \"arrayMapV2\"\n")

numbersLabeled <- arrayMapV2(function(number, ...) setNames(list((if ((number %% 2) == 0) "even" else "odd")), as.character(number)), numbers)
cat(paste(sep = "", "labeled numbers: ", prettyJsonStringify(numbersLabeled), "\n"))
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

cat("# using R Array.map() built-in function \"lapply\"\n")

numbersLabeled <- lapply(numbers, function(number) setNames(list((if ((number %% 2) == 0) "even" else "odd")), as.character(number)))
cat(paste(sep = "", "labeled numbers: ", prettyJsonStringify(numbersLabeled), "\n"))
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

cat("\n# JavaScript-like Array.map() in R list of Associative-list\n")

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

cat("# using JavaScript-like Array.map() function \"arrayMapV1\"\n")

productsLabeled <- arrayMapV1(function(product, ...) spreadSyntaxObject(product, list(label = (if (product$price > 100) "expensive" else "cheap"))), products)
cat(paste(sep = "", "labeled products: ", prettyJsonStringify(productsLabeled), "\n"))
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

cat("# using JavaScript-like Array.map() function \"arrayMapV2\"\n")

productsLabeled <- arrayMapV2(function(product, ...) spreadSyntaxObject(product, list(label = (if (product$price > 100) "expensive" else "cheap"))), products)
cat(paste(sep = "", "labeled products: ", prettyJsonStringify(productsLabeled), "\n"))
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

cat("# using R Array.map() built-in function \"lapply\"\n")

productsLabeled <- lapply(products, function(product) spreadSyntaxObject(product, list(label = (if (product$price > 100) "expensive" else "cheap"))))
cat(paste(sep = "", "labeled products: ", prettyJsonStringify(productsLabeled), "\n"))
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]
