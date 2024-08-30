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

# in R, JavaScript-like Array is called list

fruits <- list("apple", "mango", "orange")
cat(paste(sep = "", "fruits: ", json_stringify(fruits), "\n"))

cat(paste(sep = "", "fruits, length: ", length(fruits), "\n"))
# fruits, length: 3

cat(paste(sep = "", "fruits, get mango: ", fruits[[2]], "\n"))
# fruits, get mango: mango

cat(paste(sep = "", "fruits, first element: ", fruits[[1]], "\n"))
# fruits, first element: apple

cat(paste(sep = "", "fruits, last element: ", fruits[[length(fruits)]], "\n"))
# fruits, last element: orange

for (array_item_index in seq_along(fruits)) {
    array_item <- fruits[[array_item_index]]
    cat(paste(sep = "", "fruits, for loop, index: ", array_item_index, ", value: ", array_item, "\n"))
}
# fruits, forEach loop, index: 1, value: apple
# fruits, forEach loop, index: 2, value: mango
# fruits, forEach loop, index: 3, value: orange

# in R, JavaScript-like Array of Objects is called list of Associative-list

products <- list(
    list(
        id = "P1",
        name = "bubble gum"
    ),
    list(
        id = "P2",
        name = "potato chips"
    )
)
cat(paste(sep = "", "products: ", json_stringify(products, pretty = TRUE), "\n"))

for (array_item_index in seq_along(products)) {
    array_item <- products[[array_item_index]]
    for (object_entry_index in seq_along(array_item)) {
        object_key <- names(array_item)[object_entry_index]
        object_value <- array_item[[object_entry_index]]
        cat(paste(sep = "", "products, for loop, array item index: ", array_item_index, ", object iteration/entry index: ", object_entry_index, ", key: ", object_key, ", value: ", object_value, "\n"))
    }
}
# products, for loop, array item index: 1, object iteration/entry index: 1, key: id, value: P1
# products, for loop, array item index: 1, object iteration/entry index: 2, key: name, value: bubble gum
# products, for loop, array item index: 2, object iteration/entry index: 1, key: id, value: P2
# products, for loop, array item index: 2, object iteration/entry index: 2, key: name, value: potato chips
