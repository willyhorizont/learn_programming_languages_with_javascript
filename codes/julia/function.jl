# ? function statement or function declaration

function get_rectangle_area_v1(rectangle_width, rectangle_length)
    return rectangle_width * rectangle_length
end
# call the function example: get_rectangle_area_v1(3, 4)

get_rectangle_area_v2(rectangle_width, rectangle_length) = rectangle_width * rectangle_length
# call the function example: get_rectangle_area_v2(3, 4)

# ? function expression

get_rectangle_area_v3 = function (rectangle_width, rectangle_length)
    return rectangle_width * rectangle_length
end
# call the function example: get_rectangle_area_v3(3, 4)

# ? anonymous function

function (rectangle_width, rectangle_length)
    return rectangle_width * rectangle_length
end

# ? named function expression 🤮

get_rectangle_area_v4 = function do_something1(rectangle_width, rectangle_length)
    return rectangle_width * rectangle_length
end
# call the function example: get_rectangle_area_v4(3, 4)

# ? function expression with arrow function or named arrow function

get_rectangle_area_v5 = (rectangle_width, rectangle_length) ->
    begin
        return rectangle_width * rectangle_length
    end
# call the function example: get_rectangle_area_v5(3, 4)

get_rectangle_area_v6 = (rectangle_width, rectangle_length) -> rectangle_width * rectangle_length
# call the function example: get_rectangle_area_v6(3, 4)

# ? anonymous arrow function

(rectangle_width, rectangle_length) ->
    begin
        return rectangle_width * rectangle_length
    end

(rectangle_width, rectangle_length) -> rectangle_width * rectangle_length

#=
    ? In Julia, a function is a first-class citizen, which means it supports:
    ? • Passing functions as arguments to other functions
    ? • Assigning functions to variables or storing them in data structures
    ? • Returning functions as values from other functions (closure)
=#

# ? Passing functions as arguments to other functions

function say_hello(do_something2)
    println("hello")
    do_something2()
end

function say_how_are_you()
    println("how are you ?")
end

say_hello(say_how_are_you)

say_hello(function ()
    println("how are you ?")
end)

say_hello(() -> println("how are you ?"))

# ? Assigning functions to variables or storing them in data structures

get_rectangle_area_v3 = function (rectangle_width, rectangle_length)
    return rectangle_width * rectangle_length
end

get_rectangle_area_v5 = (rectangle_width, rectangle_length) ->
    begin
        return rectangle_width * rectangle_length
    end

get_rectangle_area_v6 = (rectangle_width, rectangle_length) -> rectangle_width * rectangle_length

my_array_of_get_rectangle_area_functions = [
    get_rectangle_area_v1,
    function (rectangle_width, rectangle_length)
        return rectangle_width * rectangle_length
    end,
    (rectangle_width, rectangle_length) -> rectangle_width * rectangle_length
]
get_rectangle_area_function1 = my_array_of_get_rectangle_area_functions[1](3, 4)
get_rectangle_area_function2 = my_array_of_get_rectangle_area_functions[2](3, 4)
get_rectangle_area_function3 = my_array_of_get_rectangle_area_functions[3](3, 4)

function exponentiation(a, b)
    return a ^ b
end

simple_calculator = Dict(
    "exponentiation" => exponentiation,
    "addition" => function (a, b)
        return a + b
    end,
    "subtraction" => (a, b) -> a - b
)
simple_calculator_result_1 = simple_calculator["exponentiation"](2, 4)
simple_calculator_result_2 = simple_calculator["addition"](9, 3)
simple_calculator_result_3 = simple_calculator["subtraction"](35, 8)

# ? Returning functions as values from other functions (closure)

function multiply_v1(a)
    function multiply_by(b)
        return a * b
    end
    return multiply_by
end
multiply_by_2 = multiply_v1(2)
multiply_by_2_result = multiply_by_2(10) # 20

function multiply_v2(a)
    multiply_by(b) = a * b
    return multiply_by
end
multiply_by_3 = multiply_v2(3)
multiply_by_3_result = multiply_by_3(10) # 30

function multiply_v3(a)
    multiply_by = function (b)
        return a * b
    end
    return multiply_by
end
multiply_by_4 = multiply_v3(4)
multiply_by_4_result = multiply_by_4(10) # 40

function multiply_v3(a)
    return function multiply_by(b)
        return a * b
    end
end
multiply_by_4 = multiply_v3(4)
multiply_by_4_result = multiply_by_4(10) # 40

function multiply_v4(a)
    multiply_by = (b) -> a * b
    return multiply_by
end
multiply_by_5 = multiply_v4(5)
multiply_by_5_result = multiply_by_5(10) # 50

function multiply_v5(a)
    return (b) -> a * b
end
multiply_by_6 = multiply_v5(6)
multiply_by_6_result = multiply_by_6(10) # 60

multiply_v6 = function (a)
    function multiply_by(b)
        return a * b
    end
    return multiply_by
end
multiply_by_7 = multiply_v6(7)
multiply_by_7_result = multiply_by_7(10) # 70

multiply_v7 = function (a)
    multiply_by(b) = a * b
    return multiply_by
end
multiply_by_8 = multiply_v7(8)
multiply_by_8_result = multiply_by_8(10) # 80

multiply_v8 = function (a)
    multiply_by = function (b)
        return a * b
    end
    return multiply_by
end
multiply_by_9 = multiply_v8(9)
multiply_by_9_result = multiply_by_9(10) # 90

multiply_v9 = function (a)
    return function multiply_by(b)
        return a * b
    end
end
multiply_by_10 = multiply_v9(10)
multiply_by_10_result = multiply_by_10(10) # 100

multiply_v10 = function (a)
    multiply_by = (b) -> a * b
    return multiply_by
end
multiply_by_11 = multiply_v10(11)
multiply_by_11_result = multiply_by_11(10) # 110

multiply_v11 = function (a)
    return (b) -> a * b
end
multiply_by_12 = multiply_v11(12)
multiply_by_12_result = multiply_by_12(10) # 120

multiply_v12(a) = (b) -> a * b
multiply_by_13 = multiply_v12(13)
multiply_by_13_result = multiply_by_13(10) # 130

multiply_v13 = (a) -> (b) -> a * b
multiply_by_14 = multiply_v13(14)
multiply_by_14_result = multiply_by_14(10) # 140
