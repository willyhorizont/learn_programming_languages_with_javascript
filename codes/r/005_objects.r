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

# in R, JavaScript-like Object is called Associative-list

friend <- list(
    name = "Alisa",
    country = "Finland",
    age = 25
)
cat(paste(sep = "", "friend: ", jsonStringify(friend, pretty = TRUE), "\n"))

cat(paste(sep = "", "friend, get country: ", friend[["country"]], "\n"))
# friend, get country: Finland

# iterate over and get each key-value pair
for (objectKey in names(friend)) {
    objectValue <- friend[[objectKey]]
    cat(paste(sep = "", "friend, for loop, key: ", objectKey, ", value: ", objectValue, "\n"))
}
# friend, for loop, key: name, value: Alisa
# friend, for loop, key: country, value: Finland
# friend, for loop, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
for (objectEntryIndex in seq_along(friend)) {
    objectKey <- names(friend)[objectEntryIndex]
    objectValue <- friend[[objectEntryIndex]]
    cat(paste(sep = "", "friend, for loop, object iteration/entry index: ", objectEntryIndex, ", key: ", objectKey, ", value: ", objectValue, "\n"))
}
# friend, for loop, object iteration/entry index: 1, key: name, value: Alisa
# friend, for loop, object iteration/entry index: 2, key: country, value: Finland
# friend, for loop, object iteration/entry index: 3, key: age, value: 25
