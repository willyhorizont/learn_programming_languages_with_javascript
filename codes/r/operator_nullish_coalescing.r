library(jsonlite)

cat("\n# JavaScript-like Nullish Coalescing Operator (??) in R\n")

# There's no JavaScript-like Nullish Coalescing Operator (??) in R.
# But, we can create our own function to mimic it in R.

prettyJsonStringify <- function(anything) (if (is.null(anything) == TRUE) "NULL" else if (is.character(anything) == TRUE) paste(sep = "", "\"", anything, "\"") else prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4))

    # JavaScript-like Nullish Coalescing Operator (??) function
nullishCoalescing <- function(anything, defaultValue) (if (is.null(anything) == TRUE) defaultValue else anything)

JSON_OBJECT <- list(
    foo = list(
        bar = "baz"
    )
)
cat(paste(sep = "", "JSON_OBJECT: ", prettyJsonStringify(JSON_OBJECT), "\n"))

cat(paste(sep = "", "JSON_OBJECT?.foo?.bar: ", prettyJsonStringify(nullishCoalescing(JSON_OBJECT$foo$bar, "not found")), "\n"))
# JSON_OBJECT?.foo?.bar: "baz"

cat(paste(sep = "", "JSON_OBJECT?.foo?.baz: ", prettyJsonStringify(nullishCoalescing(JSON_OBJECT$foo$baz, "not found")), "\n"))
# JSON_OBJECT?.foo?.baz: "not found"
