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

# in R, JavaScript-like Array is called list

fruits <- list("apple", "mango", "orange")
cat(paste(sep = "", "fruits: ", jsonStringify(fruits), "\n"))

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
# fruits, forEach loop, index: 1, value: apple
# fruits, forEach loop, index: 2, value: mango
# fruits, forEach loop, index: 3, value: orange

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
cat(paste(sep = "", "products: ", jsonStringify(products, pretty = TRUE), "\n"))

for (arrayItemIndex in seq_along(products)) {
    arrayItem <- products[[arrayItemIndex]]
    for (objectEntryIndex in seq_along(arrayItem)) {
        objectKey <- names(arrayItem)[objectEntryIndex]
        objectValue <- arrayItem[[objectEntryIndex]]
        cat(paste(sep = "", "products, for loop, array item index: ", arrayItemIndex, ", object iteration/entry index: ", objectEntryIndex, ", key: ", objectKey, ", value: ", objectValue, "\n"))
    }
}
# products, for loop, array item index: 1, object iteration/entry index: 1, key: id, value: P1
# products, for loop, array item index: 1, object iteration/entry index: 2, key: name, value: bubble gum
# products, for loop, array item index: 2, object iteration/entry index: 1, key: id, value: P2
# products, for loop, array item index: 2, object iteration/entry index: 2, key: name, value: potato chips
