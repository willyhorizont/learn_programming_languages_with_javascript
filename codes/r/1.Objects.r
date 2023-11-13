friend <- list(
    name = "Alisa",
    country = "Finland",
    age = 25
)

for (objectKey in names(friend)) {
    objectValue <- friend[[objectKey]]
    cat(paste(sep="", "friend, for loop, key: ", objectKey, ", value: ", objectValue, "\n"))
}
# friend, for loop, key: name, value: Alisa
# friend, for loop, key: country, value: Finland
# friend, for loop, key: age, value: 25
