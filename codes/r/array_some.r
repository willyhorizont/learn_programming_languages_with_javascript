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

array_some_v1 <- function(callback_function, an_array) {
    # JavaScript-like Array.some() function
    is_condition_match <- FALSE
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        is_condition_match <- callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == TRUE) break
    }
    return(is_condition_match)
}

array_some_v2 <- function(callback_function, an_array) {
    # JavaScript-like Array.some() function
    is_condition_match <- FALSE
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        is_condition_match <- callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == TRUE) return(is_condition_match)
    }
    return(is_condition_match)
}

array_some_v3 <- function(callback_function, an_array) {
    # JavaScript-like Array.some() function
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        is_condition_match <- callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == TRUE) return(TRUE)
    }
    return(FALSE)
}

array_some_v4 <- function(callback_function, an_array) {
    # JavaScript-like Array.some() function
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        if (callback_function(array_item, array_item_index, an_array) == TRUE) return(TRUE)
    }
    return(FALSE)
}

cat("\n# JavaScript-like Array.some() in R list\n")

numbers <- list(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
cat(paste(sep = "", "numbers: ", json_stringify(numbers), "\n"))

cat("# using JavaScript-like Array.some() function \"array_some_v1\"\n")

is_any_number_less_than500 <- array_some_v1(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is any number < 500: ", json_stringify(is_any_number_less_than500), "\n"))
# is any number < 500: true

is_any_number_more_than500 <- array_some_v1(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is any number > 500: ", json_stringify(is_any_number_more_than500), "\n"))
# is any number > 500: false

cat("# using JavaScript-like Array.some() function \"array_some_v2\"\n")

is_any_number_less_than500 <- array_some_v2(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is any number < 500: ", json_stringify(is_any_number_less_than500), "\n"))
# is any number < 500: true

is_any_number_more_than500 <- array_some_v2(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is any number > 500: ", json_stringify(is_any_number_more_than500), "\n"))
# is any number > 500: false

cat("# using JavaScript-like Array.some() function \"array_some_v3\"\n")

is_any_number_less_than500 <- array_some_v3(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is any number < 500: ", json_stringify(is_any_number_less_than500), "\n"))
# is any number < 500: true

is_any_number_more_than500 <- array_some_v3(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is any number > 500: ", json_stringify(is_any_number_more_than500), "\n"))
# is any number > 500: false

cat("# using JavaScript-like Array.some() function \"array_some_v4\"\n")

is_any_number_less_than500 <- array_some_v4(function(number, ...) (number < 500), numbers)
cat(paste(sep = "", "is any number < 500: ", json_stringify(is_any_number_less_than500), "\n"))
# is any number < 500: true

is_any_number_more_than500 <- array_some_v4(function(number, ...) (number > 500), numbers)
cat(paste(sep = "", "is any number > 500: ", json_stringify(is_any_number_more_than500), "\n"))
# is any number > 500: false

cat("# using R Array.some() built-in function \"any\"\n")

is_any_product_price_less_than500 <- any(sapply(numbers, function(number) (number < 500)))
cat(paste(sep = "", "is any number < 500: ", json_stringify(is_any_product_price_less_than500), "\n"))
# is any number < 500: true

is_any_number_more_than500 <- any(sapply(numbers, function(number) (number > 500)))
cat(paste(sep = "", "is any number > 500: ", json_stringify(is_any_number_more_than500), "\n"))
# is any number > 500: false

is_any_product_price_less_than500 <- any((numbers < 500))
cat(paste(sep = "", "is any number < 500: ", json_stringify(is_any_product_price_less_than500), "\n"))
# is any number < 500: true

is_any_number_more_than500 <- any((numbers > 500))
cat(paste(sep = "", "is any number > 500: ", json_stringify(is_any_number_more_than500), "\n"))
# is any number > 500: false

cat("\n# JavaScript-like Array.some() in R list of Associative-list\n")

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

cat("# using JavaScript-like Array.some() function \"array_some_v1\"\n")

is_any_product_price_less_than500 <- array_some_v1(function(product, ...) (product[["price"]] < 500), products)
cat(paste(sep = "", "is any product price < 500: ", json_stringify(is_any_product_price_less_than500), "\n"))
# is any product price < 500: true

is_any_product_price_more_than500 <- array_some_v1(function(product, ...) (product[["price"]] > 500), products)
cat(paste(sep = "", "is any product price > 500: ", json_stringify(is_any_product_price_more_than500), "\n"))
# is any product price > 500: false

cat("# using JavaScript-like Array.some() function \"array_some_v2\"\n")

is_any_product_price_less_than500 <- array_some_v2(function(product, ...) (product[["price"]] < 500), products)
cat(paste(sep = "", "is any product price < 500: ", json_stringify(is_any_product_price_less_than500), "\n"))
# is any product price < 500: true

is_any_product_price_more_than500 <- array_some_v2(function(product, ...) (product[["price"]] > 500), products)
cat(paste(sep = "", "is any product price > 500: ", json_stringify(is_any_product_price_more_than500), "\n"))
# is any product price > 500: false

cat("# using JavaScript-like Array.some() function \"array_some_v3\"\n")

is_any_product_price_less_than500 <- array_some_v3(function(product, ...) (product[["price"]] < 500), products)
cat(paste(sep = "", "is any product price < 500: ", json_stringify(is_any_product_price_less_than500), "\n"))
# is any product price < 500: true

is_any_product_price_more_than500 <- array_some_v3(function(product, ...) (product[["price"]] > 500), products)
cat(paste(sep = "", "is any product price > 500: ", json_stringify(is_any_product_price_more_than500), "\n"))
# is any product price > 500: false

cat("# using JavaScript-like Array.some() function \"array_some_v4\"\n")

is_any_product_price_less_than500 <- array_some_v4(function(product, ...) (product[["price"]] < 500), products)
cat(paste(sep = "", "is any product price < 500: ", json_stringify(is_any_product_price_less_than500), "\n"))
# is any product price < 500: true

is_any_product_price_more_than500 <- array_some_v4(function(product, ...) (product[["price"]] > 500), products)
cat(paste(sep = "", "is any product price > 500: ", json_stringify(is_any_product_price_more_than500), "\n"))
# is any product price > 500: false

cat("# using R Array.some() built-in function \"any\"\n")

is_any_product_price_less_than500 <- any(sapply(products, function(product, ...) (product[["price"]] < 500)))
cat(paste(sep = "", "is any product price < 500: ", json_stringify(is_any_product_price_less_than500), "\n"))
# is any product price < 500: true

is_any_product_price_more_than500 <- any(sapply(products, function(product, ...) (product[["price"]] > 500)))
cat(paste(sep = "", "is any product price > 500: ", json_stringify(is_any_product_price_more_than500), "\n"))
# is any product price > 500: false
