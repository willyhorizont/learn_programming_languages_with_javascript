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

object_keys_v1 <- function(an_object) {
    # JavaScript-like Object.keys() function
    new_array <- list()
    for (object_entry_index in seq_along(an_object)) {
        object_key <- names(an_object)[object_entry_index]
        object_value <- an_object[[object_entry_index]]
        new_array <- append(new_array, list(object_key))
    }
    return(new_array)
}

object_keys_v2 <- function(an_object) (as.list(names(an_object)))

cat("\n# JavaScript-like Object.keys() in R Associative-list\n")

friend <- list(
    name = "Alisa",
    country = "Finland",
    age = 25
)
cat(paste(sep = "", "friend: ", json_stringify(friend, pretty = TRUE), "\n"))

cat("# using JavaScript-like Object.keys() function \"object_keys_v1\"\n")

cat(paste(sep = "", "friend keys: ", json_stringify(object_keys_v1(friend)), "\n"))
# friend keys: ["name", "country", "age"]

cat("# using JavaScript-like Object.keys() function \"object_keys_v2\"\n")

cat(paste(sep = "", "friend keys: ", json_stringify(object_keys_v2(friend)), "\n"))
# friend keys: ["name", "country", "age"]

cat("# using R Object.keys() built-in function \"as.list(names)\"\n")

cat(paste(sep = "", "friend keys: ", json_stringify(as.list(names(friend))), "\n"))
# friend keys: ["name", "country", "age"]
