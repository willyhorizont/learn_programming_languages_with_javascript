library(jsonlite)

cat("\n# JavaScript-like Optional Chaining Operator (?.) in R\n")

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

# There's no JavaScript-like Optional Chaining Operator (?.) in R.
# But, we can use R built-in tryCatch function to mimic it in R.

JSON_OBJECT <- list(
    foo = list(
        bar = "baz"
    ),
    fruits = list("apple", "mango", "banana")
)
cat(paste(sep = "", "JSON_OBJECT: ", jsonStringify(JSON_OBJECT, pretty = TRUE), "\n"))

cat(paste(sep = "", "JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ", jsonStringify(tryCatch(JSON_OBJECT$foo$bar, error = function(err) NULL)), "\n"))
# JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: "baz"

cat(paste(sep = "", "JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ", jsonStringify(tryCatch(JSON_OBJECT$foo$baz, error = function(err) NULL)), "\n"))
# JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

cat(paste(sep = "", "JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ", jsonStringify(tryCatch(JSON_OBJECT$fruits[[2]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: "mango"

cat(paste(sep = "", "JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ", jsonStringify(tryCatch(JSON_OBJECT$fruits[[5]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null

cat(paste(sep = "", "JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ", jsonStringify(tryCatch(JSON_OBJECT[["foo"]][["bar"]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: "baz"

cat(paste(sep = "", "JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ", jsonStringify(tryCatch(JSON_OBJECT[["foo"]][["baz"]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

cat(paste(sep = "", "JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ", jsonStringify(tryCatch(JSON_OBJECT[["fruits"]][[2]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: "mango"

cat(paste(sep = "", "JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ", jsonStringify(tryCatch(JSON_OBJECT[["fruits"]][[5]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null
