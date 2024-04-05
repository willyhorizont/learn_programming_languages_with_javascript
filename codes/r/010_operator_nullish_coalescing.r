library(jsonlite)

cat("\n# JavaScript-like Nullish Coalescing Operator (??) in R\n")

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
cat(paste(sep = "", "JSON_OBJECT: ", jsonStringify(JSON_OBJECT, pretty = TRUE), "\n"))

cat(paste(sep = "", "(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): ", jsonStringify(nullishCoalescing(tryCatch(JSON_OBJECT$foo$bar, error = function(err) NULL), "not found")), "\n"))
# (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): "baz"

cat(paste(sep = "", "(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): ", jsonStringify(nullishCoalescing(tryCatch(JSON_OBJECT$foo$baz, error = function(err) NULL), "not found")), "\n"))
# (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): "not found"

cat(paste(sep = "", "(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): ", jsonStringify(nullishCoalescing(tryCatch(JSON_OBJECT$fruits[[2]], error = function(err) NULL), "not found")), "\n"))
# (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): "mango"

cat(paste(sep = "", "(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): ", jsonStringify(nullishCoalescing(tryCatch(JSON_OBJECT$fruits[[5]], error = function(err) NULL), "not found")), "\n"))
# (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): "not found"

cat(paste(sep = "", "(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): ", jsonStringify(nullishCoalescing(tryCatch(JSON_OBJECT[["foo"]][["bar"]], error = function(err) NULL), "not found")), "\n"))
# (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): "baz"

cat(paste(sep = "", "(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): ", jsonStringify(nullishCoalescing(tryCatch(JSON_OBJECT[["foo"]][["baz"]], error = function(err) NULL), "not found")), "\n"))
# (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): "not found"

cat(paste(sep = "", "(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): ", jsonStringify(nullishCoalescing(tryCatch(JSON_OBJECT[["fruits"]][[2]], error = function(err) NULL), "not found")), "\n"))
# (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): "mango"

cat(paste(sep = "", "(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): ", jsonStringify(nullishCoalescing(tryCatch(JSON_OBJECT[["fruits"]][[5]], error = function(err) NULL), "not found")), "\n"))
# (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): "not found"
