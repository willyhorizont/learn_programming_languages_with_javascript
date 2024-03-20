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

# in R, JavaScript-like Array is called list

fruits <- list("apple", "mango", "orange")
cat(paste(sep = "", "fruits: ", prettyArrayOfPrimitives(fruits), "\n"))

cat(paste(sep = "", "fruits, length: ", length(fruits), "\n"))
# fruits, length: 3

cat(paste(sep = "", "fruits, get mango: ", fruits[2], "\n"))
# fruits, get mango: mango

cat(paste(sep = "", "fruits, first element: ", fruits[1], "\n"))
# fruits, first element: apple

cat(paste(sep = "", "fruits, last element: ", fruits[length(fruits)], "\n"))
# fruits, last element: orange

for (arrayItemIndex in seq_along(fruits)) {
    arrayItem <- fruits[[arrayItemIndex]]
    cat(paste(sep = "", "fruits, for loop, index: ", arrayItemIndex, ", value: ", arrayItem, "\n"))
}
# fruits, foreach loop, index: 1, value: apple
# fruits, foreach loop, index: 2, value: mango
# fruits, foreach loop, index: 3, value: orange

# in R, JavaScript-like Array of Objects is called list of Associative-list

products <- list(
    list(
        id = "P1",
        name = "bubble gum"
    ),
    list(
        id = "P2",
        name = "potato chips"
    )
)
cat(paste(sep = "", "products: ", prettyJsonStringify(products), "\n"))

for (arrayItemIndex in seq_along(products)) {
    arrayItem <- products[[arrayItemIndex]]
    for (entryIndex in seq_along(arrayItem)) {
        objectKey <- names(arrayItem)[entryIndex]
        objectValue <- arrayItem[[entryIndex]]
        cat(paste(sep = "", "products, for loop, array item index: ", arrayItemIndex, ", iteration/entry index: ", entryIndex, ", key: ", objectKey, ", value: ", objectValue, "\n"))
    }
}
# products, for loop, array item index: 1, iteration/entry index: 1, key: id, value: P1
# products, for loop, array item index: 1, iteration/entry index: 2, key: name, value: bubble gum
# products, for loop, array item index: 2, iteration/entry index: 1, key: id, value: P2
# products, for loop, array item index: 2, iteration/entry index: 2, key: name, value: potato chips
