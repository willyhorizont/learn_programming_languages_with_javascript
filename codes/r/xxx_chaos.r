library(jsonlite)

type_of <- function(anything) {
    if (is.list(anything) == FALSE) return(class(anything))
    if (length(anything) == 0) return("array")
    if (is.null(names(anything)) == TRUE) return("array")
    return("object")
}

# pretty_json_stringify <- function(anything) (if (is.null(anything) == TRUE) "null" else gsub("\\n$", "", prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4)))
# pretty_json_stringify <- function(anything) {
#     if (is.null(anything) == TRUE) return("null")
#     return(gsub("\\n$", "", prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4)))
# }
pretty_json_stringify <- function(anything) {
    pretty_json_string_with_trailing_new_line <- prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4)
    pretty_json_string_without_trailing_new_line <- gsub("\\n$", "", pretty_json_string_with_trailing_new_line, perl = TRUE)
    pretty_json_string_without_trailing_new_line_and_with_proper_null <- gsub("\\{\\s*\\n\\s*\\}", "null", pretty_json_string_without_trailing_new_line, perl = TRUE)
    return(pretty_json_string_without_trailing_new_line_and_with_proper_null)
}

products <- list(
    list(
        code = "pasta",
        price = 321
    ),
    list(
        code = "bubble_gum",
        price = 233
    ),
    list(
        code = "potato_chips",
        price = 5
    ),
    list(
        code = "towel",
        price = 499
    )
)
cat(paste(sep = "", "start", "\n"))
cat(paste(sep = "", gsub("\\n$", "", pretty_json_stringify(products)), "\n"))
cat(paste(sep = "", "end", "\n"))

my_object <- list(
    "my_string" = "foo",
    "my_number" = 123,
    "my_bool" = TRUE,
    "my_null" = NULL,
    "my_object" = list(
        "foo" = "bar",
        "my_null" = NULL
    ),
    "my_array" = list(1, 2, 3)
)
cat(paste(sep = "", "my_object: ", pretty_json_stringify(my_object), "\n"))

friend <- list(
    name = "Alisa",
    country = "Finland",
    age = 25,
    gender = "woman"
)

friend <- friend[!names(friend) == "country"]
# friend <- subset(friend, select = -gender) // error
friend <- friend[setdiff(names(friend), "age")]
cat(paste(sep = "", "friend: ", pretty_json_stringify(friend), "\n"))

json_stringify_v1 <- function(anything, pretty = FALSE, indent = strrep(" ", 4)) {
    if (pretty == TRUE) {
        pretty_json_string_with_trailing_new_line <- prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 3)
        pretty_json_string_with_custom_indent <- gsub(strrep(" ", 3), indent, pretty_json_string_with_trailing_new_line, perl = TRUE)
        pretty_json_string_without_trailing_new_line <- gsub("\\n$", "", pretty_json_string_with_custom_indent, perl = TRUE)
        pretty_json_string_without_trailing_new_line_and_with_proper_null <- gsub("\\{\\s*\\n\\s*\\}", "null", pretty_json_string_without_trailing_new_line, perl = TRUE)
        return(pretty_json_string_without_trailing_new_line_and_with_proper_null)
    }
    json_string_without_space_delimiter <- toJSON(anything, pretty = FALSE, auto_unbox = TRUE)
    json_string_with_space_delimiter_after_comma <- gsub(",", ", ", json_string_without_space_delimiter, perl = TRUE)
    json_string_with_space_delimiter_after_comma_and_colon <- gsub(":", ": ", json_string_with_space_delimiter_after_comma, perl = TRUE)
    json_string_with_space_delimiter_after_comma_and_colon_and_with_proper_null <- gsub("{}", "null", json_string_with_space_delimiter_after_comma_and_colon, perl = TRUE)
    return(json_string_with_space_delimiter_after_comma_and_colon_and_with_proper_null)
}

json_stringify_v2 <- function(anything, pretty = FALSE, indent = strrep(" ", 4)) {
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

# Variable and function name style should match snake_case or symbols. lintr(object_name_linter)
# Indentation should be 2 spaces but is 4 spaces. lintr(indentation_linter)
# Lines should not be more than 80 characters. lintr(line_length_linter)
# Functions should have cyclomatic complexity of less than 15, this has 33. lintr(cyclocomp_linter)

# \b[a-z0-9]+([A-Z][a-z0-9]+)+
