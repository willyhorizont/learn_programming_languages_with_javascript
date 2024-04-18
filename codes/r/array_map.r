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

createNewObject <- function(objectKey, objectValue) {
    newObject <- list()
    newObject[[as.character(objectKey)]] <- objectValue
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
cat(paste(sep = "", "numbers: ", jsonStringify(numbers), "\n"))

cat("# using JavaScript-like Array.map() function \"arrayMapV1\"\n")

numbersLabeled <- arrayMapV1(function(number, ...) createNewObject(as.character(number), (if ((number %% 2) == 0) "even" else "odd")), numbers)
cat(paste(sep = "", "labeled numbers: ", jsonStringify(numbersLabeled, pretty = TRUE), "\n"))
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

numbersLabeled <- arrayMapV2(function(number, ...) createNewObject(as.character(number), (if ((number %% 2) == 0) "even" else "odd")), numbers)
cat(paste(sep = "", "labeled numbers: ", jsonStringify(numbersLabeled, pretty = TRUE), "\n"))
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

numbersLabeled <- lapply(numbers, function(number) createNewObject(as.character(number), (if ((number %% 2) == 0) "even" else "odd")))
cat(paste(sep = "", "labeled numbers: ", jsonStringify(numbersLabeled, pretty = TRUE), "\n"))
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
cat(paste(sep = "", "products: ", jsonStringify(products, pretty = TRUE), "\n"))

cat("# using JavaScript-like Array.map() function \"arrayMapV1\"\n")

productsLabeled <- arrayMapV1(function(product, ...) cc(product, list(label = (if (product[["price"]] > 100) "expensive" else "cheap"))), products)
cat(paste(sep = "", "labeled products: ", jsonStringify(productsLabeled, pretty = TRUE), "\n"))
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

productsLabeled <- arrayMapV2(function(product, ...) cc(product, list(label = (if (product[["price"]] > 100) "expensive" else "cheap"))), products)
cat(paste(sep = "", "labeled products: ", jsonStringify(productsLabeled, pretty = TRUE), "\n"))
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

productsLabeled <- lapply(products, function(product) cc(product, list(label = (if (product[["price"]] > 100) "expensive" else "cheap"))))
cat(paste(sep = "", "labeled products: ", jsonStringify(productsLabeled, pretty = TRUE), "\n"))
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
