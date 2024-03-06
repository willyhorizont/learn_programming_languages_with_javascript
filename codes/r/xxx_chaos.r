library(jsonlite)

# prettyJsonStringify <- function(anything) (if (is.null(anything) == TRUE) "null" else gsub("\\n$", "", prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4)))
# prettyJsonStringify <- function(anything) {
#     if (is.null(anything) == TRUE) return("null")
#     return(gsub("\\n$", "", prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4)))
# }
prettyJsonStringify <- function(anything) {
    prettyJsonStringWithTrailingNewLine <- prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4)
    prettyJsonStringWithoutTrailingNewLine <- gsub("\\n$", "", prettyJsonStringWithTrailingNewLine, perl = TRUE)
    prettyJsonStringWithoutTrailingNewLineAndWithProperNull <- gsub("\\{\\s*\\n\\s*\\}", "null", prettyJsonStringWithoutTrailingNewLine, perl = TRUE)
    return(prettyJsonStringWithoutTrailingNewLineAndWithProperNull)
}

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
cat(paste(sep = "", "start", "\n"))
cat(paste(sep = "", gsub("\\n$", "", prettyJsonStringify(products)), "\n"))
cat(paste(sep = "", "end", "\n"))

myObject <- list(
    "my_string" = "foo",
    "my_number" = 123,
    "my_bool" = TRUE,
    "my_null" = NULL,
    "my_object" = list(
        "foo" = "bar",
        "my_null" = NULL
    ),
    "my_array" = list(1, 2, 3)
)
cat(paste(sep = "", "myObject: ", prettyJsonStringify(myObject), "\n"))
