library(jsonlite)

cat("\n# JavaScript-like Optional Chaining Operator (?.) in R\n")

prettyJsonStringify <- function(anything) (if (is.null(anything) == TRUE) "NULL" else if (is.character(anything) == TRUE) paste(sep = "", "\"", anything, "\"") else prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4))

# There's no JavaScript-like Optional Chaining Operator (?.) in R.
# But, we don't need that in R.

JSON_OBJECT <- list(
    foo = list(
        bar = "baz"
    )
)
cat(paste(sep = "", "JSON_OBJECT: ", prettyJsonStringify(JSON_OBJECT), "\n"))

cat(paste(sep = "", "JSON_OBJECT?.foo?.bar: ", prettyJsonStringify(JSON_OBJECT$foo$bar), "\n"))
# JSON_OBJECT?.foo?.bar: "baz"

cat(paste(sep = "", "JSON_OBJECT?.foo?.baz: ", prettyJsonStringify(JSON_OBJECT$foo$baz), "\n"))
# JSON_OBJECT?.foo?.baz: NULL
