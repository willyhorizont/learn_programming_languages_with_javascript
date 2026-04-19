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

cat((function() {
    # multiline comment
    if (FALSE) {
        return('#
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
        #')
    }
    return("")
})())
something <- "foo"
cat(paste(sep = "", "something: ", json_stringify(something, pretty = TRUE), "\n"))
something <- 123
cat(paste(sep = "", "something: ", json_stringify(something, pretty = TRUE), "\n"))
something <- TRUE
cat(paste(sep = "", "something: ", json_stringify(something, pretty = TRUE), "\n"))
something <- NULL
cat(paste(sep = "", "something: ", json_stringify(something, pretty = TRUE), "\n"))
something <- list(1, 2, 3)
cat(paste(sep = "", "something: ", json_stringify(something, pretty = TRUE), "\n"))
something <- list("foo" = "bar")
cat(paste(sep = "", "something: ", json_stringify(something, pretty = TRUE), "\n"))

cat((function() {
    # multiline comment
    if (FALSE) {
        return('#
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
        #')
    }
    return("")
})())
get_modified_indent_level <- function() {
    indent_level <- 0
    change_indent_level <- function() {
        indent_level <<- (indent_level + 1)
        if (indent_level < 5) change_indent_level()
        return(indent_level)
    }
    return(change_indent_level())
}
cat(paste(sep = "", "get_modified_indent_level(): ", get_modified_indent_level(), "\n"))
create_new_game <- function(initial_credit) {
    current_credit <- initial_credit
    cat(paste(sep = "", "initial credit: ", initial_credit, "\n"))
    return(function() {
        current_credit <<- current_credit - 1
        if (current_credit == 0) {
            cat(paste(sep = "", "not enough credits", "\n"))
        } else {
            cat(paste(sep = "", "playing game, ", current_credit, " credit(s) remaining", "\n"))
        }
    })
}
play_game <- create_new_game(3)
play_game()
play_game()
play_game()

cat((function() {
    # multiline comment
    if (FALSE) {
        return('#
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
        #')
    }
    return("")
})())
my_object <- list(
    "my_string" = "foo",
    "my_number" = 123,
    "my_boolean" = TRUE,
    "my_null" = NULL,
    "my_array" = list(1, 2, 3),
    "my_object" = list(
        "foo" = "bar"
    )
)
cat(paste(sep = "", "my_object: ", json_stringify(my_object, pretty = TRUE), "\n"))

cat((function() {
    # multiline comment
    if (FALSE) {
        return('#
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
        #')
    }
    return("")
})())
my_array <- list("foo", 123, TRUE, NULL, list(1, 2, 3), list("foo" = "bar"))
cat(paste(sep = "", "my_array: ", json_stringify(my_array, pretty = TRUE), "\n"))

cat((function() {
    # multiline comment
    if (FALSE) {
        return('#
x. support passing functions as arguments to other functions
        #')
    }
    return("")
})())
say_hello <- function(callback_function) {
    cat("hello\n")
    callback_function()
}
say_how_are_you <- function() {
    cat("how are you?\n")
}
say_hello(say_how_are_you)
say_hello(function() {
    cat("how are you?\n")
})

cat((function() {
    # multiline comment
    if (FALSE) {
        return('#
x. support returning functions as values from other functions
        #')
    }
    return("")
})())
multiply <- function(a) {
    return(function(b) {
        return(a * b)
    })
}
multiply_by2 <- multiply(2)
multiply_by2_result <- multiply_by2(10)
cat(paste(sep = "", "multiply_by2_result: ", multiply_by2_result, "\n"))

cat((function() {
    # multiline comment
    if (FALSE) {
        return('#
x. support assigning functions to variables
        #')
    }
    return("")
})())
get_rectangle_area_v1 <- function(rectangle_width, rectangle_length) {
    return(rectangle_width * rectangle_length)
}
cat(paste(sep = "", "get_rectangle_area_v1(7, 5): ", get_rectangle_area_v1(7, 5), "\n"))
get_rectangle_area_v2 <- function(rectangle_width, rectangle_length) (rectangle_width * rectangle_length)
cat(paste(sep = "", "get_rectangle_area_v2(7, 5): ", get_rectangle_area_v2(7, 5), "\n"))

cat((function() {
    # multiline comment
    if (FALSE) {
        return('#
x. support storing functions in data structures like object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure or array/list/slice/ordered-list-data-structure
        #')
    }
    return("")
})())
my_array2 <- list(
    function(a, b) {
        return(a * b)
    },
    "foo",
    123,
    TRUE,
    NULL,
    list(1, 2, 3),
    list("foo" = "bar")
)
cat(paste(sep = "", "my_array2[0](7, 5): ", my_array2[[1]](7, 5), "\n"))
my_object2 <- list(
    "my_function" = function(a, b) {
        return(a * b)
    },
    "my_string" = "foo",
    "my_number" = 123,
    "my_boolean" = TRUE,
    "my_null" = NULL,
    "my_array" = list(1, 2, 3),
    "my_object" = list(
        "foo" = "bar"
    )
)
cat(paste(sep = "", "my_object2[0](7, 5): ", my_object2[["my_function"]](7, 5), "\n"))
