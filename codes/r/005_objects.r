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

# in R, JavaScript-like Object is called Associative-list

friend <- list(
    name = "Alisa",
    country = "Finland",
    age = 25
)
cat(paste(sep = "", "friend: ", json_stringify(friend, pretty = TRUE), "\n"))

cat(paste(sep = "", "friend, get total object keys: ", length(names(friend)), "\n"))
# friend, get total object keys: 3

cat(paste(sep = "", "friend, get total object keys: ", length(friend), "\n"))
# friend, get total object keys: 3

cat(paste(sep = "", "friend, get country: ", friend[["country"]], "\n"))
# friend, get country: Finland

# iterate over and get each key-value pair
for (object_key in names(friend)) {
    object_value <- friend[[object_key]]
    cat(paste(sep = "", "friend, for loop, key: ", object_key, ", value: ", object_value, "\n"))
}
# friend, for loop, key: name, value: Alisa
# friend, for loop, key: country, value: Finland
# friend, for loop, key: age, value: 25

# iterate over and get each key-value pair and object iteration/entry index
for (object_entry_index in seq_along(friend)) {
    object_key <- names(friend)[object_entry_index]
    object_value <- friend[[object_entry_index]]
    cat(paste(sep = "", "friend, for loop, object iteration/entry index: ", object_entry_index, ", key: ", object_key, ", value: ", object_value, "\n"))
}
# friend, for loop, object iteration/entry index: 1, key: name, value: Alisa
# friend, for loop, object iteration/entry index: 2, key: country, value: Finland
# friend, for loop, object iteration/entry index: 3, key: age, value: 25

friend$age <- 27
cat(paste(sep = "", "friend: ", json_stringify(friend, pretty = TRUE), "\n"))

friend[["gender"]] <- "Female"
cat(paste(sep = "", "friend: ", json_stringify(friend, pretty = TRUE), "\n"))

friend$country <- NULL
cat(paste(sep = "", "friend: ", json_stringify(friend, pretty = TRUE), "\n"))

friend[["name"]] <- NULL
cat(paste(sep = "", "friend: ", json_stringify(friend, pretty = TRUE), "\n"))

# Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
delivery_response_key_message <- "message"
# delivery_response <- list(
#     delivery_response_key_message = "ok" # this is not working in R, the result is `{"delivery_response_key_message": "ok"}`
# )
delivery_response <- list(
    message = "ok"
)
cat(paste(sep = "", "delivery_response: ", json_stringify(delivery_response, pretty = TRUE), "\n"))
delivery_response_key_status <- "status"
delivery_response[[delivery_response_key_status]] <- 200
cat(paste(sep = "", "delivery_response: ", json_stringify(delivery_response, pretty = TRUE), "\n"))
