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

# There's no JavaScript-like Array.find() in R.
# But, we can create our own function to mimic it in R.

array_find_v1 <- function(callback_function, an_array) {
    # JavaScript-like Array.find() function
    data_found <- NULL
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        is_condition_match <- callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == TRUE) {
            data_found <- array_item
            break
        }
    }
    return(data_found)
}

array_find_v2 <- function(callback_function, an_array) {
    # JavaScript-like Array.find() function
    data_found <- NULL
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        if (callback_function(array_item, array_item_index, an_array) == TRUE) {
            data_found <- array_item
            break
        }
    }
    return(data_found)
}

array_find_v3 <- function(callback_function, an_array) {
    # JavaScript-like Array.find() function
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        is_condition_match <- callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == TRUE) return(array_item)
    }
    return(NULL)
}

array_find_v4 <- function(callback_function, an_array) {
    # JavaScript-like Array.find() function
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        if (callback_function(array_item, array_item_index, an_array) == TRUE) return(array_item)
    }
    return(NULL)
}

cat("\n# JavaScript-like Array.find() in R list\n")

numbers <- list(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
cat(paste(sep = "", "numbers: ", json_stringify(numbers), "\n"))

cat("# using JavaScript-like Array.find() function \"array_find_v1\"\n")

even_number_found <- array_find_v1(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even number found: ", even_number_found, "\n"))
# even number found: 12

odd_numbers_found <- array_find_v1(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd number found: ", odd_numbers_found, "\n"))
# odd number found: 27

cat("# using JavaScript-like Array.find() function \"array_find_v2\"\n")

even_number_found <- array_find_v2(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even number found: ", even_number_found, "\n"))
# even number found: 12

odd_numbers_found <- array_find_v2(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd number found: ", odd_numbers_found, "\n"))
# odd number found: 27

cat("# using JavaScript-like Array.find() function \"array_find_v3\"\n")

even_number_found <- array_find_v3(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even number found: ", even_number_found, "\n"))
# even number found: 12

odd_numbers_found <- array_find_v3(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd number found: ", odd_numbers_found, "\n"))
# odd number found: 27

cat("# using JavaScript-like Array.find() function \"array_find_v4\"\n")

even_number_found <- array_find_v4(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even number found: ", even_number_found, "\n"))
# even number found: 12

odd_numbers_found <- array_find_v4(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd number found: ", odd_numbers_found, "\n"))
# odd number found: 27

cat("\n# JavaScript-like Array.find() in R list of Associative-list\n")

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
cat(paste(sep = "", "products: ", json_stringify(products, pretty = TRUE), "\n"))

product_to_find <- "bubble_gum"
cat(paste(sep = "", "product to find: ", product_to_find, "\n"))

cat("# using JavaScript-like Array.find() function \"array_find_v1\"\n")

product_found <- array_find_v1(function(product, ...) (product[["code"]] == product_to_find), products)
cat(paste(sep = "", "product found: ", json_stringify(product_found, pretty = TRUE), "\n"))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

cat("# using JavaScript-like Array.find() function \"array_find_v2\"\n")

product_found <- array_find_v2(function(product, ...) (product[["code"]] == product_to_find), products)
cat(paste(sep = "", "product found: ", json_stringify(product_found, pretty = TRUE), "\n"))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

cat("# using JavaScript-like Array.find() function \"array_find_v3\"\n")

product_found <- array_find_v3(function(product, ...) (product[["code"]] == product_to_find), products)
cat(paste(sep = "", "product found: ", json_stringify(product_found, pretty = TRUE), "\n"))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

cat("# using JavaScript-like Array.find() function \"array_find_v4\"\n")

product_found <- array_find_v4(function(product, ...) (product[["code"]] == product_to_find), products)
cat(paste(sep = "", "product found: ", json_stringify(product_found, pretty = TRUE), "\n"))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }
