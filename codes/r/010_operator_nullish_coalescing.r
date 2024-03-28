library(jsonlite)

cat("\n# JavaScript-like Nullish Coalescing Operator (??) in R\n")

prettyJsonStringify <- function(anything) {
    prettyJsonStringWithTrailingNewLine <- prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4)
    prettyJsonStringWithoutTrailingNewLine <- gsub("\\n$", "", prettyJsonStringWithTrailingNewLine, perl = TRUE)
    prettyJsonStringWithoutTrailingNewLineAndWithProperNull <- gsub("\\{\\s*\\n\\s*\\}", "null", prettyJsonStringWithoutTrailingNewLine, perl = TRUE)
    return(prettyJsonStringWithoutTrailingNewLineAndWithProperNull)
}

# There's no JavaScript-like Nullish Coalescing Operator (??) in R.
# But, we can create our own function to mimic it in R.

# JavaScript-like Nullish Coalescing Operator (??) function
nullishCoalescing <- function(anything, defaultValue) (if (is.null(anything) == TRUE) defaultValue else anything)

JSON_OBJECT <- list(
    foo = list(
        bar = "baz"
    ),
    fruits = list("apple", "mango", "banana")
)
cat(paste(sep = "", "JSON_OBJECT: ", prettyJsonStringify(JSON_OBJECT), "\n"))

cat(paste(sep = "", "(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): ", prettyJsonStringify(nullishCoalescing(tryCatch(JSON_OBJECT$foo$bar, error = function(err) NULL), "not found")), "\n"))
# (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): "baz"

cat(paste(sep = "", "(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): ", prettyJsonStringify(nullishCoalescing(tryCatch(JSON_OBJECT$foo$baz, error = function(err) NULL), "not found")), "\n"))
# (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): "not found"

cat(paste(sep = "", "(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): ", prettyJsonStringify(nullishCoalescing(tryCatch(JSON_OBJECT$fruits[[2]], error = function(err) NULL), "not found")), "\n"))
# (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): "mango"

cat(paste(sep = "", "(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): ", prettyJsonStringify(nullishCoalescing(tryCatch(JSON_OBJECT$fruits[[5]], error = function(err) NULL), "not found")), "\n"))
# (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): "not found"
