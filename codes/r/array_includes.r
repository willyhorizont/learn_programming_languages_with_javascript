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

# There's no JavaScript-like Array.includes() in R.
# But, we can create our own function to mimic it in R.

array_includes_v1 <- function(search_element, an_array) {
    # JavaScript-like Array.includes() function
    is_element_found <- FALSE
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        if (array_item == search_element) {
            is_element_found <- TRUE
            break
        }
    }
    return(is_element_found)
}

array_includes_v2 <- function(search_element, an_array) {
    # JavaScript-like Array.includes() function
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        if (array_item == search_element) return(TRUE)
    }
    return(FALSE)
}

cat("\n# JavaScript-like Array.includes() in R\n")

my_friends <- list("Alisa", "Trivia")
cat(paste(sep = "", "my friends: ", json_stringify(my_friends), "\n"))

cat("# using JavaScript-like Array.includes() function \"array_includes_v1\"\n")

a_name <- "Alisa"
is_my_friend <- array_includes_v1(a_name, my_friends)
cat(paste(sep = "", "is my friends includes ", json_stringify(a_name), ": ", json_stringify(is_my_friend), "\n"))
# is my friends includes "Alisa": true

a_name <- "Trivia"
is_my_friend <- array_includes_v1(a_name, my_friends)
cat(paste(sep = "", "is my friends includes ", json_stringify(a_name), ": ", json_stringify(is_my_friend), "\n"))
# is my friends includes "Trivia": true

a_name <- "Tony"
is_my_friend <- array_includes_v1(a_name, my_friends)
cat(paste(sep = "", "is my friends includes ", json_stringify(a_name), ": ", json_stringify(is_my_friend), "\n"))
# is my friends includes "Tony": false

a_name <- "Ezekiel"
is_my_friend <- array_includes_v1(a_name, my_friends)
cat(paste(sep = "", "is my friends includes ", json_stringify(a_name), ": ", json_stringify(is_my_friend), "\n"))
# is my friends includes "Ezekiel": false

cat("# using JavaScript-like Array.includes() function \"array_includes_v2\"\n")

a_name <- "Alisa"
is_my_friend <- array_includes_v2(a_name, my_friends)
cat(paste(sep = "", "is my friends includes ", json_stringify(a_name), ": ", json_stringify(is_my_friend), "\n"))
# is my friends includes "Alisa": true

a_name <- "Trivia"
is_my_friend <- array_includes_v2(a_name, my_friends)
cat(paste(sep = "", "is my friends includes ", json_stringify(a_name), ": ", json_stringify(is_my_friend), "\n"))
# is my friends includes "Trivia": true

a_name <- "Tony"
is_my_friend <- array_includes_v2(a_name, my_friends)
cat(paste(sep = "", "is my friends includes ", json_stringify(a_name), ": ", json_stringify(is_my_friend), "\n"))
# is my friends includes "Tony": false

a_name <- "Ezekiel"
is_my_friend <- array_includes_v2(a_name, my_friends)
cat(paste(sep = "", "is my friends includes ", json_stringify(a_name), ": ", json_stringify(is_my_friend), "\n"))
# is my friends includes "Ezekiel": false
