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

array_filter_v1 <- function(callback_function, an_array) {
    # JavaScript-like Array.filter() function
    data_filtered <- list()
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        is_condition_match <- callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == TRUE) {
            data_filtered <- append(data_filtered, list(array_item))
        }
    }
    return(data_filtered)
}

array_filter_v2 <- function(callback_function, an_array) {
    # JavaScript-like Array.filter() function
    data_filtered <- list()
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        if (callback_function(array_item, array_item_index, an_array) == TRUE) {
            data_filtered <- append(data_filtered, list(array_item))
        }
    }
    return(data_filtered)
}

cat("\n# JavaScript-like Array.filter() in R list\n")

numbers <- list(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
cat(paste(sep = "", "numbers: ", json_stringify(numbers), "\n"))

cat("# using JavaScript-like Array.filter() function \"array_filter_v1\"\n")

numbers_even <- array_filter_v1(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even numbers only: ", json_stringify(numbers_even), "\n"))
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd <- array_filter_v1(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd numbers only: ", json_stringify(numbers_odd), "\n"))
# odd numbers only: [27, 23, 65, 93, 87]

cat("# using JavaScript-like Array.filter() function \"array_filter_v2\"\n")

numbers_even <- array_filter_v2(function(number, ...) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even numbers only: ", json_stringify(numbers_even), "\n"))
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd <- array_filter_v2(function(number, ...) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd numbers only: ", json_stringify(numbers_odd), "\n"))
# odd numbers only: [27, 23, 65, 93, 87]

cat("# using R Array.filter() built-in function \"Filter\"\n")

numbers_even <- Filter(function(number) ((number %% 2) == 0), numbers)
cat(paste(sep = "", "even numbers only: ", json_stringify(numbers_even), "\n"))
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd <- Filter(function(number) ((number %% 2) != 0), numbers)
cat(paste(sep = "", "odd numbers only: ", json_stringify(numbers_odd), "\n"))
# odd numbers only: [27, 23, 65, 93, 87]

cat("\n# JavaScript-like Array.filter() in R list of Associative-list\n")

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

cat("# using JavaScript-like Array.filter() function \"array_filter_v1\"\n")

products_below100 <- array_filter_v1(function(product, ...) (product[["price"]] <= 100), products)
cat(paste(sep = "", "products with price <= 100 only: ", json_stringify(products_below100, pretty = TRUE), "\n"))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above100 <- array_filter_v1(function(product, ...) (product[["price"]] > 100), products)
cat(paste(sep = "", "products with price > 100 only: ", json_stringify(products_above100, pretty = TRUE), "\n"))
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

cat("# using JavaScript-like Array.filter() function \"array_filter_v2\"\n")

products_below100 <- array_filter_v2(function(product, ...) (product[["price"]] <= 100), products)
cat(paste(sep = "", "products with price <= 100 only: ", json_stringify(products_below100, pretty = TRUE), "\n"))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above100 <- array_filter_v2(function(product, ...) (product[["price"]] > 100), products)
cat(paste(sep = "", "products with price > 100 only: ", json_stringify(products_above100, pretty = TRUE), "\n"))
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

cat("# using R Array.filter() built-in function \"Filter\"\n")

products_below100 <- Filter(function(product, ...) (product[["price"]] <= 100), products)
cat(paste(sep = "", "products with price <= 100 only: ", json_stringify(products_below100, pretty = TRUE), "\n"))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above100 <- Filter(function(product, ...) (product[["price"]] > 100), products)
cat(paste(sep = "", "products with price > 100 only: ", json_stringify(products_above100, pretty = TRUE), "\n"))
# products with price > 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]
