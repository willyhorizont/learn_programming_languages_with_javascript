library(jsonlite)

cat("\n# JavaScript-like Optional Chaining Operator (?.) in R\n")

prettyJsonStringify <- function(anything) (if (is.null(anything) == TRUE) "NULL" else if (is.character(anything) == TRUE) paste(sep = "", "\"", anything, "\"") else prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4))

# There's no JavaScript-like Optional Chaining Operator (?.) in R.
# But, we can use R built-in tryCatch function to mimic it in R.

JSON_OBJECT <- list(
    foo = list(
        bar = "baz"
    ),
    fruits = list("apple", "mango", "banana")
)
cat(paste(sep = "", "JSON_OBJECT: ", prettyJsonStringify(JSON_OBJECT), "\n"))

cat(paste(sep = "", "JSON_OBJECT?.foo?.bar: ", prettyJsonStringify(tryCatch(JSON_OBJECT$foo$bar, error = function(err) NULL)), "\n"))
# JSON_OBJECT?.foo?.bar: "baz"

cat(paste(sep = "", "JSON_OBJECT?.foo?.baz: ", prettyJsonStringify(tryCatch(JSON_OBJECT$foo$baz, error = function(err) NULL)), "\n"))
# JSON_OBJECT?.foo?.baz: NULL

cat(paste(sep = "", "JSON_OBJECT?.fruits?.[2]: ", prettyJsonStringify(tryCatch(JSON_OBJECT$fruits[[2]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.fruits?.[2]: "mango"

cat(paste(sep = "", "JSON_OBJECT?.fruits?.[5]: ", prettyJsonStringify(tryCatch(JSON_OBJECT$fruits[[5]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.fruits?.[5]: NULL
