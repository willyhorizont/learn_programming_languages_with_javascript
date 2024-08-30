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

create_new_object <- function(object_key, object_value) {
    new_object <- list()
    new_object[[as.character(object_key)]] <- object_value
    return(new_object)
}

array_map_v1 <- function(callback_function, an_array) {
    # JavaScript-like Array.map() function
    new_array <- list()
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        new_array_item <- callback_function(array_item, array_item_index, an_array)
        new_array <- append(new_array, list(new_array_item))
    }
    return(new_array)
}

array_map_v2 <- function(callback_function, an_array) {
    # JavaScript-like Array.map() function
    new_array <- list()
    for (array_item_index in seq_along(an_array)) {
        array_item <- an_array[[array_item_index]]
        new_array <- append(new_array, list(callback_function(array_item, array_item_index, an_array)))
    }
    return(new_array)
}

cat("\n# JavaScript-like Array.map() in R list\n")

numbers <- list(12, 34, 27, 23, 65, 93, 36, 87, 4, 254)
cat(paste(sep = "", "numbers: ", json_stringify(numbers), "\n"))

cat("# using JavaScript-like Array.map() function \"array_map_v1\"\n")

numbers_labeled <- array_map_v1(function(number, ...) create_new_object(as.character(number), (if ((number %% 2) == 0) "even" else "odd")), numbers)
cat(paste(sep = "", "labeled numbers: ", json_stringify(numbers_labeled, pretty = TRUE), "\n"))
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

cat("# using JavaScript-like Array.map() function \"array_map_v2\"\n")

numbers_labeled <- array_map_v2(function(number, ...) create_new_object(as.character(number), (if ((number %% 2) == 0) "even" else "odd")), numbers)
cat(paste(sep = "", "labeled numbers: ", json_stringify(numbers_labeled, pretty = TRUE), "\n"))
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

cat("# using R Array.map() built-in function \"lapply\"\n")

numbers_labeled <- lapply(numbers, function(number) create_new_object(as.character(number), (if ((number %% 2) == 0) "even" else "odd")))
cat(paste(sep = "", "labeled numbers: ", json_stringify(numbers_labeled, pretty = TRUE), "\n"))
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

cat("\n# JavaScript-like Array.map() in R list of Associative-list\n")

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

cat("# using JavaScript-like Array.map() function \"array_map_v1\"\n")

products_labeled <- array_map_v1(function(product, ...) cc(product, list(label = (if (product[["price"]] > 100) "expensive" else "cheap"))), products)
cat(paste(sep = "", "labeled products: ", json_stringify(products_labeled, pretty = TRUE), "\n"))
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

cat("# using JavaScript-like Array.map() function \"array_map_v2\"\n")

products_labeled <- array_map_v2(function(product, ...) cc(product, list(label = (if (product[["price"]] > 100) "expensive" else "cheap"))), products)
cat(paste(sep = "", "labeled products: ", json_stringify(products_labeled, pretty = TRUE), "\n"))
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

cat("# using R Array.map() built-in function \"lapply\"\n")

products_labeled <- lapply(products, function(product) cc(product, list(label = (if (product[["price"]] > 100) "expensive" else "cheap"))))
cat(paste(sep = "", "labeled products: ", json_stringify(products_labeled, pretty = TRUE), "\n"))
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]
