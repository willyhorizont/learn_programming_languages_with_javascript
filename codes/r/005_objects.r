library(jsonlite)

prettyJsonStringify <- function(anything) {
    prettyJsonStringWithTrailingNewLine <- prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4)
    prettyJsonStringWithoutTrailingNewLine <- gsub("\\n$", "", prettyJsonStringWithTrailingNewLine, perl = TRUE)
    prettyJsonStringWithoutTrailingNewLineAndWithProperNull <- gsub("\\{\\s*\\n\\s*\\}", "null", prettyJsonStringWithoutTrailingNewLine, perl = TRUE)
    return(prettyJsonStringWithoutTrailingNewLineAndWithProperNull)
}

# in R, JavaScript-like Object is called Associative-list

friend <- list(
    name = "Alisa",
    country = "Finland",
    age = 25
)
cat(paste(sep = "", "friend: ", prettyJsonStringify(friend), "\n"))

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
