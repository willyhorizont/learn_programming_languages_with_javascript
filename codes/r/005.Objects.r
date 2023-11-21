library(jsonlite)

prettyJsonStringify <- function(anything) (if (is.null(anything) == TRUE) "NULL" else if (is.character(anything) == TRUE) paste(sep = "", "\"", anything, "\"") else prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4))

friend <- list(
    name = "Alisa",
    country = "Finland",
    age = 25
)
cat(paste(sep = "", "friend: ", prettyJsonStringify(friend)))

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

# iterate over and get each key-value pair and iteration/entry index
for (iterationIndex in seq_along(friend)) {
    objectKey <- names(friend)[iterationIndex]
    objectValue <- friend[[iterationIndex]]
    cat(paste(sep = "", "friend, for loop, index: ", iterationIndex, ", key: ", objectKey, ", value: ", objectValue, "\n"))
}
# friend, for loop, index: 1, key: name, value: Alisa
# friend, for loop, index: 2, key: country, value: Finland
# friend, for loop, index: 3, key: age, value: 25
