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

# In R, we can use "c()" function to mimic JavaScript-like Spread Syntax (...) for Arrays
# But for Objects, we need to create custom function because "c()" function doesn't merge Objects.

cc <- function(...) {
    arguments <- list(...)
    new_object <- list()
    for (argument_index in seq_along(arguments)) {
        argument <- arguments[[argument_index]]
        argument_type <- type_of(argument)
        if (argument_type == "object") {
            for (object_key in names(argument)) {
                object_value <- argument[[object_key]]
                new_object[[object_key]] <- object_value
            }
            next
        }
        if (argument_type == "array") {
            for (array_item_index in seq_along(argument)) {
                array_item <- argument[[array_item_index]]
                new_object[[as.character(array_item_index)]] <- array_item
            }
            next
        }
    }
    return(new_object)
}

cat("\n# JavaScript-like Spread Syntax (...) in R\n")

fruits <- list("Mango", "Melon", "Banana")
cat(paste(sep = "", "fruits: ", json_stringify(fruits), "\n"))

vegetables <- list("Carrot", "Tomato")
cat(paste(sep = "", "vegetables: ", json_stringify(vegetables), "\n"))

country_capitals_in_asia <- list(
    Thailand = "Bangkok",
    China = "Beijing",
    Japan = "Tokyo"
)
cat(paste(sep = "", "country_capitals_in_asia: ", json_stringify(country_capitals_in_asia, pretty = TRUE), "\n"))

country_capitals_in_europe <- list(
    France = "Paris",
    England = "London"
)
cat(paste(sep = "", "country_capitals_in_europe: ", json_stringify(country_capitals_in_europe, pretty = TRUE), "\n"))

cat("\n# [...array1, ...array2]:\n")

combination1 <- c(fruits, vegetables)
cat(paste(sep = "", "combination1: ", json_stringify(combination1, pretty = TRUE), "\n"))
# combination1: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Carrot",
#     "Tomato"
# ]

combination2 <- c(fruits, list("Cucumber", "Cabbage"))
cat(paste(sep = "", "combination2: ", json_stringify(combination2, pretty = TRUE), "\n"))
# combination2: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Cucumber",
#     "Cabbage"
# ]

cat("\n# { ...object1, ...object2 }:\n")

combination3 <- cc(country_capitals_in_asia, country_capitals_in_europe)
cat(paste(sep = "", "combination3: ", json_stringify(combination3, pretty = TRUE), "\n"))
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

combination4 <- cc(country_capitals_in_asia, list(Germany = "Berlin", Italy = "Rome"))
cat(paste(sep = "", "combination4: ", json_stringify(combination4, pretty = TRUE), "\n"))
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

cat("\n# [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n")

combination5 <- c(fruits, list(vegetables))
cat(paste(sep = "", "combination5: ", json_stringify(combination5, pretty = TRUE), "\n"))
# combination5: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Carrot",
#         "Tomato"
#     ]
# ]

combination6 <- c(fruits, list(list("Cucumber", "Cabbage")))
cat(paste(sep = "", "combination6: ", json_stringify(combination6, pretty = TRUE), "\n"))
# combination6: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Cucumber",
#         "Cabbage"
#     ]
# ]

cat("\n# [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n")

combination7 <- c(fruits, list(country_capitals_in_asia))
cat(paste(sep = "", "combination7: ", json_stringify(combination7, pretty = TRUE), "\n"))
# combination7: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Thailand": "Bangkok",
#         "China": "Beijing",
#         "Japan": "Tokyo"
#     }
# ]

combination8 <- c(fruits, list(list(Germany = "Berlin", Italy = "Rome")))
cat(paste(sep = "", "combination8: ", json_stringify(combination8, pretty = TRUE), "\n"))
# combination8: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# ]

cat("\n# { ...object1, object2 } || { ...object1, object_key: object_value }:\n")

combination9 <- cc(country_capitals_in_asia, list(country_capitals_in_europe = country_capitals_in_europe))
cat(paste(sep = "", "combination9: ", json_stringify(combination9, pretty = TRUE), "\n"))
# combination9: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "country_capitals_in_europe" : {
#       "France" : "Paris",
#       "England" : "London"
#    }
# }

combination10 <- cc(country_capitals_in_asia, list(country_capitals_in_europe = list(Germany = "Berlin", Italy = "Rome")))
cat(paste(sep = "", "combination10: ", json_stringify(combination10, pretty = TRUE), "\n"))
# combination10: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "country_capitals_in_europe": {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# }

cat("\n# { ...object1, array2 } || { ...object1, object_key: object_value }:\n")

combination11 <- cc(country_capitals_in_asia, list(vegetables = vegetables))
cat(paste(sep = "", "combination11: ", json_stringify(combination11, pretty = TRUE), "\n"))
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

combination12 <- cc(country_capitals_in_asia, list(vegetables = list("Cucumber", "Cabbage")))
cat(paste(sep = "", "combination12: ", json_stringify(combination12, pretty = TRUE), "\n"))
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Cabbage"
#     ]
# }

cat("\n# { ...object1, ...array2 }:\n")

combination13 <- cc(country_capitals_in_asia, vegetables)
cat(paste(sep = "", "combination13: ", json_stringify(combination13, pretty = TRUE), "\n"))
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Carrot",
#    "2" : "Tomato"
# }

combination14 <- cc(country_capitals_in_asia, list("Cucumber", "Cabbage"))
cat(paste(sep = "", "combination14: ", json_stringify(combination14, pretty = TRUE), "\n"))
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Cucumber",
#    "2" : "Cabbage"
# }

# cat("\n# [...array1, ...object1]: // this combination throw an error in JavaScript\n")

# this combination throw an error in JavaScript
# combination_error_in_javascript1 <- c(fruits, country_capitals_in_asia)
# cat(paste(sep = "", "combination_error_in_javascript1: ", json_stringify(combination_error_in_javascript1, pretty = TRUE), "\n"))

# this combination throw an error in JavaScript
# combination_error_in_javascript2 <- c(fruits, list(Germany = "Berlin", Italy = "Rome"))
# cat(paste(sep = "", "combination_error_in_javascript2: ", json_stringify(combination_error_in_javascript2, pretty = TRUE), "\n"))
