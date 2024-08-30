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

# Relational Operators / Comparison Operators:
# equal to (==)
# not equal to (!=)
# greater than (>)
# less than (<)
# greater than or equal to (>=)
# less than or equal to (<=)

# Logical Operators:
# Logical AND (&&)
# Logical OR (||)
# Logical NOT (!)

CORRECT_ANSWER <- 100

cat("\n# basic conditional control flow\n")

my_age <- 10
cat(paste(sep = "", "my_age: ", my_age, "\n"))
if (my_age > 24) {
    cat("you are old\n")
} else if (my_age > 17) {
    cat("you are young\n")
} else {
    cat("you are under age\n")
}

cat("\n# equal to (==)\n")

my_answer <- "100"
cat(paste(sep = "", "my_answer: ", my_answer, "\n"))
cat(paste(sep = "", "CORRECT_ANSWER: ", CORRECT_ANSWER, "\n"))
cat("(my_answer == CORRECT_ANSWER):\n")
if (my_answer == CORRECT_ANSWER) {
    cat("Your answer is correct\n")
} else {
    cat("Your answer is wrong\n")
}

cat("\n# not equal to (!=)\n")

my_answer <- "25"
cat(paste(sep = "", "my_answer: ", my_answer, "\n"))
cat(paste(sep = "", "CORRECT_ANSWER: ", CORRECT_ANSWER, "\n"))
cat("(my_answer != CORRECT_ANSWER):\n")
if (my_answer != CORRECT_ANSWER) {
    cat("Your answer is correct\n")
} else {
    cat("Your answer is wrong\n")
}

cat("\n# greater than (>)\n")

my_age <- 70
cat(paste(sep = "", "my_age: ", my_age, "\n"))
cat("(my_age > 50):\n")
if (my_age > 50) cat("You are old\n")

cat("\n# less than (<)\n")

my_age <- 16
cat(paste(sep = "", "my_age: ", my_age, "\n"))
cat("(my_age < 20):\n")
if (my_age < 20) cat("You are young\n")

cat("\n# greater than or equal to (>=)\n")

my_age <- 73
cat(paste(sep = "", "my_age: ", my_age, "\n"))
cat("(my_age >= 65):\n")
if (my_age >= 65) cat("You are allowed to retire\n")

cat("\n# less than or equal to (<=)\n")

my_age <- 14
cat(paste(sep = "", "my_age: ", my_age, "\n"))
cat("(my_age <= 16):\n")
if (my_age <= 16) cat("You are not allowed to drive\n")

cat("\n# Logical AND (&&)\n")

my_age <- 17
cat(paste(sep = "", "my_age: ", my_age, "\n"))
has_driving_license <- FALSE
cat(paste(sep = "", "has_driving_license: ", json_stringify(has_driving_license), "\n"))
cat("((my_age >= 17) && (has_driving_license == true)):\n")
if ((my_age >= 17) && (has_driving_license == TRUE)) {
    cat("You are allowed to drive\n")
} else {
    cat("You are not allowed to drive\n")
}

my_age <- 17
cat(paste(sep = "", "my_age: ", my_age, "\n"))
has_driving_license <- TRUE
cat(paste(sep = "", "has_driving_license: ", json_stringify(has_driving_license), "\n"))
cat("((my_age >= 17) && (has_driving_license == true)):\n")
if ((my_age >= 17) && (has_driving_license == TRUE)) {
    cat("You are allowed to drive\n")
} else {
    cat("You are not allowed to drive\n")
}

cat("\n# Logical OR (||)\n")

my_age <- 2
cat(paste(sep = "", "my_age: ", my_age, "\n"))
cat("((my_age <= 3) || (my_age >= 65)):\n")
if ((my_age <= 3) || (my_age >= 65)) cat("You should stay home\n")

my_age <- 89
cat(paste(sep = "", "my_age: ", my_age, "\n"))
cat("((my_age <= 3) || (my_age >= 65)):\n")
if ((my_age <= 3) || (my_age >= 65)) cat("You should stay home\n")

cat("\n# Logical NOT (!)\n")

can_drive <- FALSE
cat(paste(sep = "", "can_drive: ", json_stringify(can_drive), "\n"))
cat(paste(sep = "", "!can_drive: ", json_stringify(!can_drive), "\n"))

can_drive <- TRUE
cat(paste(sep = "", "can_drive: ", json_stringify(can_drive), "\n"))
cat(paste(sep = "", "!can_drive: ", json_stringify(!can_drive), "\n"))
