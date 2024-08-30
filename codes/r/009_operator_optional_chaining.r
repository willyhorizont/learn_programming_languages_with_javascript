type_of <- function(anything) {
    if (is.list(anything) == FALSE) return(class(anything))
    if (length(anything) == 0) return("array")
    if (is.null(names(anything)) == TRUE) return("array")
    return("object")
}

json_stringify <- function(anything, pretty = FALSE, indent = strrep(" ", 4)) {
    indent_level <- 0
    json_stringify_inner <- function(anything_inner, indent_inner) {
        if (is.null(anything_inner)) return("null")
        if (is.character(anything_inner)) return(paste(sep = "", "\"", anything_inner, "\""))
        if (is.numeric(anything_inner) || is.logical(anything_inner)) return(paste(sep = "", anything_inner))
        if (type_of(anything_inner) == "array") {
            if (length(anything_inner) == 0) return("[]")
            indent_level <<- (indent_level + 1)
            result <- (if (pretty == TRUE) paste(sep = "", "[\n", strrep(indent_inner, indent_level)) else "[")
            for (array_item_index in seq_along(anything_inner)) {
                array_item <- anything_inner[[array_item_index]]
                result <- paste(sep = "", result, json_stringify_inner(array_item, indent_inner))
                if (array_item_index != length(anything_inner)) result <- (if (pretty == TRUE) paste(sep = "", result, ",\n", strrep(indent_inner, indent_level)) else paste(sep = "", result, ", "))
            }
            indent_level <<- (indent_level - 1)
            result <- (if (pretty == TRUE) paste(sep = "", result, "\n", strrep(indent_inner, indent_level), "]") else paste(sep = "", result, "]"))
            return(result)
        }
        if (type_of(anything_inner) == "object") {
            if (length(names(anything_inner)) == 0) return("{}")
            indent_level <<- (indent_level + 1)
            result <- (if (pretty == TRUE) paste(sep = "", "{\n", strrep(indent_inner, indent_level)) else "{")
            for (object_entry_index in seq_along(anything_inner)) {
                object_key <- names(anything_inner)[object_entry_index]
                object_value <- anything_inner[[object_entry_index]]
                result <- paste(sep = "", result, "\"", object_key, "\": ", json_stringify_inner(object_value, indent_inner))
                if (object_entry_index != length(names(anything_inner))) result <- (if (pretty == TRUE) paste(sep = "", result, ",\n", strrep(indent_inner, indent_level)) else paste(sep = "", result, ", "))
            }
            indent_level <<- (indent_level - 1)
            result <- (if (pretty == TRUE) paste(sep = "", result, "\n", strrep(indent_inner, indent_level), "}") else paste(sep = "", result, "}"))
            return(result)
        }
        return("null")
    }
    return(json_stringify_inner(anything, indent))
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
cat(paste(sep = "", "JSON_OBJECT: ", json_stringify(JSON_OBJECT, pretty = TRUE), "\n"))

cat(paste(sep = "", "JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ", json_stringify(tryCatch(JSON_OBJECT$foo$bar, error = function(err) NULL)), "\n"))
# JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: "baz"

cat(paste(sep = "", "JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ", json_stringify(tryCatch(JSON_OBJECT$foo$baz, error = function(err) NULL)), "\n"))
# JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

cat(paste(sep = "", "JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ", json_stringify(tryCatch(JSON_OBJECT$fruits[[2]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: "mango"

cat(paste(sep = "", "JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ", json_stringify(tryCatch(JSON_OBJECT$fruits[[5]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null

cat(paste(sep = "", "JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: ", json_stringify(tryCatch(JSON_OBJECT[["foo"]][["bar"]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: "baz"

cat(paste(sep = "", "JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: ", json_stringify(tryCatch(JSON_OBJECT[["foo"]][["baz"]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

cat(paste(sep = "", "JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: ", json_stringify(tryCatch(JSON_OBJECT[["fruits"]][[2]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: "mango"

cat(paste(sep = "", "JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: ", json_stringify(tryCatch(JSON_OBJECT[["fruits"]][[5]], error = function(err) NULL)), "\n"))
# JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null
