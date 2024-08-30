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

cc <- function(...) {
    parameters <- list(...)
    new_object <- list()
    for (parameter_index in seq_along(parameters)) {
        parameter <- parameters[[parameter_index]]
        parameter_type <- type_of(parameter)
        if (parameter_type == "object") {
            for (object_key in names(parameter)) {
                object_value <- parameter[[object_key]]
                new_object[[object_key]] <- object_value
            }
            next
        }
        if (parameter_type == "array") {
            for (array_item_index in seq_along(parameter)) {
                array_item <- parameter[[array_item_index]]
                new_object[[as.character(array_item_index)]] <- array_item
            }
            next
        }
    }
    return(new_object)
}

array_reduce <- function(callback_function, an_array, initial_value) {
    # JavaScript-like Array.reduce() function
    result <- initial_value
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        result <- callback_function(result, array_item, array_item_index, an_array)
    }
    return(result)
}

cat("\n# JavaScript-like Array.reduce() in R list\n")

numbers <- list(36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3)
cat(paste(sep = "", "numbers: ", json_stringify(numbers), "\n"))

cat("# using JavaScript-like Array.reduce() function \"array_reduce\"\n")

numbers_total <- array_reduce(function(current_result, current_number, ...) (current_result + current_number), numbers, 0)
cat(paste(sep = "", "total number: ", json_stringify(numbers_total), "\n"))
# total number: 41.2

cat("# using R Array.reduce() built-in function \"Reduce\"\n")

numbers_total <- Reduce(function(current_result, current_number) (current_result + current_number), numbers, 0)
cat(paste(sep = "", "total number: ", json_stringify(numbers_total), "\n"))
# total number: 41.2

cat("\n# JavaScript-like Array.reduce() in R list of Associative-list\n")

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

cat("# using JavaScript-like Array.reduce() function \"array_reduce\"\n")

products_grouped <- array_reduce(function(current_result, current_product, ...) (if (current_product[["price"]] > 100) cc(current_result, list(expensive = c(current_result[["expensive"]], list(current_product)))) else cc(current_result, list(cheap = c(current_result[["cheap"]], list(current_product))))), products, list(expensive = list(), cheap = list()))
cat(paste(sep = "", "grouped products test: ", json_stringify(products_grouped, pretty = TRUE), "\n"))

# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }

cat("# using R Array.reduce() built-in function \"Reduce\"\n")

products_grouped <- Reduce(function(current_result, current_product) (if (current_product[["price"]] > 100) cc(current_result, list(expensive = c(current_result[["expensive"]], list(current_product)))) else cc(current_result, list(cheap = c(current_result[["cheap"]], list(current_product))))), products, list(expensive = list(), cheap = list()))
cat(paste(sep = "", "grouped products: ", json_stringify(products_grouped, pretty = TRUE), "\n"))
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }
