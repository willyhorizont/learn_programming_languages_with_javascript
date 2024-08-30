# ? function statement or function declaration and function expression at the same time

get_rectangle_area_v1 <- function(rectangle_width, rectangle_length) {
    return(rectangle_width * rectangle_length)
}

get_rectangle_area_v2 <- function(rectangle_width, rectangle_length) (rectangle_width * rectangle_length)

# ? anonymous function
# function(rectangle_width, rectangle_length) {
#     return(rectangle_width * rectangle_length)
# }
# function(rectangle_width, rectangle_length) (rectangle_width * rectangle_length)

# ? Passing functions as arguments to other functions

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

say_hello(function() cat("how are you?\n"))

# ? Assigning functions to variables or storing them in data structures

get_rectangle_area_v1 <- function(rectangle_width, rectangle_length) {
    return(rectangle_width * rectangle_length)
}

get_rectangle_area_v2 <- function(rectangle_width, rectangle_length) (rectangle_width * rectangle_length)

my_array_of_get_rectangle_area_functions <- list(
    get_rectangle_area_v1,
    function(rectangle_width, rectangle_length) {
        return(rectangle_width * rectangle_length)
    },
    function(rectangle_width, rectangle_length) (rectangle_width * rectangle_length)
)

# In R, when we store functions in a list, we should use double square brackets [[ ]] to access and call them.
get_rectangle_area_function_result1 <- my_array_of_get_rectangle_area_functions[[1]](7, 5)
get_rectangle_area_function_result2 <- my_array_of_get_rectangle_area_functions[[2]](7, 5)
get_rectangle_area_function_result3 <- my_array_of_get_rectangle_area_functions[[3]](7, 5)

exponentiation <- function(a, b) {
    return(a ^ b)
}

simple_calculator <- list(
    exponentiation = exponentiation,
    multiplication = function(a, b) {
        return(a * b)
    },
    division = function(a, b) (a / b)
)

simple_calculator_result1 <- simple_calculator$exponentiation(2, 4)
simple_calculator_result2 <- simple_calculator$multiplication(7, 5)
simple_calculator_result3 <- simple_calculator$multiplication(81, 9)
simple_calculator_result1 <- simple_calculator[["exponentiation"]](2, 4)
simple_calculator_result2 <- simple_calculator[["multiplication"]](7, 5)
simple_calculator_result3 <- simple_calculator[["multiplication"]](81, 9)

# ? Returning functions as values from other functions

multiply_v1 <- function(a) {
    multiply_by <- function(b) {
        return(a * b)
    }
    return(multiply_by)
}
multiply_by2 <- multiply_v1(2)
multiply_by2_result <- multiply_by2(10) # 20

multiply_v2 <- function(a) {
    multiply_by <- function(b) (a * b)
    return(multiply_by)
}
multiply_by3 <- multiply_v2(3)
multiply_by3_result <- multiply_by3(10) # 30

multiply_v3 <- function(a) {
    return(function(b) (a * b))
}
multiply_by4 <- multiply_v3(4)
multiply_by4_result <- multiply_by4(10) # 40

multiply_v4 <- function(a) {
    return(function(b) {
        return(a * b)
    })
}
multiply_by5 <- multiply_v4(5)
multiply_by5_result <- multiply_by5(10) # 50

multiply_v5 <- function(a) function(b) (a * b)
multiply_by6 <- multiply_v5(6)
multiply_by6_result <- multiply_by6(10) # 60
