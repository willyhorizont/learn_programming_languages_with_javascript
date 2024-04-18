typeOf <- function(anything) {
    if (is.list(anything) == FALSE) return(class(anything))
    if (length(anything) == 0) return("array")
    if (is.null(names(anything)) == TRUE) return("array")
    return("object")
}

jsonStringify <- function(anything, pretty = FALSE, indent = strrep(" ", 4)) {
    indentLevel <- 0
    jsonStringifyInner <- function(anythingInner, indentInner) {
        if (is.null(anythingInner)) return("null")
        if (is.character(anythingInner)) return(paste(sep = "", "\"", anythingInner, "\""))
        if (is.numeric(anythingInner) || is.logical(anythingInner)) return(paste(sep = "", anythingInner))
        if (typeOf(anythingInner) == "array") {
            if (length(anythingInner) == 0) return("[]")
            indentLevel <<- (indentLevel + 1)
            result <- (if (pretty == TRUE) paste(sep = "", "[\n", strrep(indentInner, indentLevel)) else "[")
            for (arrayItemIndex in seq_along(anythingInner)) {
                arrayItem <- anythingInner[[arrayItemIndex]]
                result <- paste(sep = "", result, jsonStringifyInner(arrayItem, indentInner))
                if (arrayItemIndex != length(anythingInner)) result <- (if (pretty == TRUE) paste(sep = "", result, ",\n", strrep(indentInner, indentLevel)) else paste(sep = "", result, ", "))
            }
            indentLevel <<- (indentLevel - 1)
            result <- (if (pretty == TRUE) paste(sep = "", result, "\n", strrep(indentInner, indentLevel), "]") else paste(sep = "", result, "]"))
            return(result)
        }
        if (typeOf(anythingInner) == "object") {
            if (length(names(anythingInner)) == 0) return("{}")
            indentLevel <<- (indentLevel + 1)
            result <- (if (pretty == TRUE) paste(sep = "", "{\n", strrep(indentInner, indentLevel)) else "{")
            for (objectEntryIndex in seq_along(anythingInner)) {
                objectKey <- names(anythingInner)[objectEntryIndex]
                objectValue <- anythingInner[[objectEntryIndex]]
                result <- paste(sep = "", result, "\"", objectKey, "\": ", jsonStringifyInner(objectValue, indentInner))
                if (objectEntryIndex != length(names(anythingInner))) result <- (if (pretty == TRUE) paste(sep = "", result, ",\n", strrep(indentInner, indentLevel)) else paste(sep = "", result, ", "))
            }
            indentLevel <<- (indentLevel - 1)
            result <- (if (pretty == TRUE) paste(sep = "", result, "\n", strrep(indentInner, indentLevel), "}") else paste(sep = "", result, "}"))
            return(result)
        }
        return("null")
    }
    return(jsonStringifyInner(anything, indent))
}

cat("\n# JavaScript-like Optional Chaining Operator (?.) in R\n")

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
