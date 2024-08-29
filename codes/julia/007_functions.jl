# ? function statement or function declaration

function get_rectangle_area_v1(rectangle_width, rectangle_length)
    return (rectangle_width * rectangle_length)
end
# call the function example: get_rectangle_area_v1(7, 5)

get_rectangle_area_v2(rectangle_width, rectangle_length) = (rectangle_width * rectangle_length)
# call the function example: get_rectangle_area_v2(7, 5)

# ? function expression

get_rectangle_area_v3::Any = function (rectangle_width, rectangle_length)
    return (rectangle_width * rectangle_length)
end
# call the function example: get_rectangle_area_v3(7, 5)

# ? anonymous function

function (rectangle_width, rectangle_length)
    return (rectangle_width * rectangle_length)
end

# ? named function expression 🤮

get_rectangle_area_v4::Any = function do_something(rectangle_width, rectangle_length)
    return (rectangle_width * rectangle_length)
end
# call the function example: get_rectangle_area_v4(7, 5)

# ? function expression with arrow function or named arrow function

get_rectangle_area_v5::Any = (rectangle_width, rectangle_length) -> begin
    return (rectangle_width * rectangle_length)
end
# call the function example: get_rectangle_area_v5(7, 5)

get_rectangle_area_v6::Any = (rectangle_width, rectangle_length) -> (rectangle_width * rectangle_length)
# call the function example: get_rectangle_area_v6(7, 5)

# ? anonymous arrow function

(rectangle_width, rectangle_length) -> begin
    return (rectangle_width * rectangle_length)
end

(rectangle_width, rectangle_length) -> (rectangle_width * rectangle_length)

# ? Passing functions as arguments to other functions

function say_hello(callback_function)
    println("hello")
    callback_function()
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

get_rectangle_area_v3::Any = function (rectangle_width, rectangle_length)
    return (rectangle_width * rectangle_length)
end

get_rectangle_area_v5::Any = (rectangle_width, rectangle_length) -> begin
    return (rectangle_width * rectangle_length)
end

get_rectangle_area_v6::Any = (rectangle_width, rectangle_length) -> (rectangle_width * rectangle_length)

my_array_of_get_rectangle_area_functions::Any = Any[
    get_rectangle_area_v1,
    function (rectangle_width, rectangle_length)
        return (rectangle_width * rectangle_length)
    end,
    (rectangle_width, rectangle_length) -> (rectangle_width * rectangle_length)
]
get_rectangle_area_function_result1::Any = my_array_of_get_rectangle_area_functions[1](7, 5)
get_rectangle_area_function_result2::Any = my_array_of_get_rectangle_area_functions[2](7, 5)
get_rectangle_area_function_result3::Any = my_array_of_get_rectangle_area_functions[3](7, 5)

function exponentiation(a, b)
    return (a ^ b)
end

simple_calculator::Any = Dict{String, Any}(
    "exponentiation" => exponentiation,
    "addition" => function (a, b)
        return (a + b)
    end,
    "subtraction" => (a, b) -> (a - b)
)
simple_calculator_result_1::Any = simple_calculator["exponentiation"](2, 4)
simple_calculator_result_2::Any = simple_calculator["addition"](9, 3)
simple_calculator_result_3::Any = simple_calculator["subtraction"](35, 8)

# ? Returning functions as values from other functions

function multiply_v1(a)
    function multiply_by(b)
        return (a * b)
    end
    return multiply_by
end
multiply_by2::Any = multiply_v1(2)
multiply_by2_result::Any = multiply_by2(10) # 20

function multiply_v2(a)
    multiply_by(b) = (a * b)
    return multiply_by
end
multiply_by3::Any = multiply_v2(3)
multiply_by3_result::Any = multiply_by3(10) # 30

function multiply_v3(a)
    multiply_by::Any = function (b)
        return (a * b)
    end
    return multiply_by
end
multiply_by4::Any = multiply_v3(4)
multiply_by4_result::Any = multiply_by4(10) # 40

function multiply_v3(a)
    return function multiply_by(b)
        return (a * b)
    end
end
multiply_by4::Any = multiply_v3(4)
multiply_by4_result::Any = multiply_by4(10) # 40

function multiply_v4(a)
    multiply_by::Any = (b) -> (a * b)
    return multiply_by
end
multiply_by5::Any = multiply_v4(5)
multiply_by5_result::Any = multiply_by5(10) # 50

function multiply_v5(a)
    return (b) -> (a * b)
end
multiply_by6::Any = multiply_v5(6)
multiply_by6_result::Any = multiply_by6(10) # 60

multiply_v6::Any = function (a)
    function multiply_by(b)
        return (a * b)
    end
    return multiply_by
end
multiply_by7::Any = multiply_v6(7)
multiply_by7_result::Any = multiply_by7(10) # 70

multiply_v7::Any = function (a)
    multiply_by(b) = (a * b)
    return multiply_by
end
multiply_by8::Any = multiply_v7(8)
multiply_by8_result::Any = multiply_by8(10) # 80

multiply_v8::Any = function (a)
    multiply_by::Any = function (b)
        return (a * b)
    end
    return multiply_by
end
multiply_by9::Any = multiply_v8(9)
multiply_by9_result::Any = multiply_by9(10) # 90

multiply_v9::Any = function (a)
    return function multiply_by(b)
        return (a * b)
    end
end
multiply_by10::Any = multiply_v9(10)
multiply_by10_result::Any = multiply_by10(10) # 100

multiply_v10::Any = function (a)
    multiply_by::Any = (b) -> (a * b)
    return multiply_by
end
multiply_by11::Any = multiply_v10(11)
multiply_by11_result::Any = multiply_by11(10) # 110

multiply_v11::Any = function (a)
    return (b) -> (a * b)
end
multiply_by12::Any = multiply_v11(12)
multiply_by12_result::Any = multiply_by12(10) # 120

multiply_v12(a) = (b) -> (a * b)
multiply_by13::Any = multiply_v12(13)
multiply_by13_result::Any = multiply_by13(10) # 130

multiply_v13::Any = (a) -> (b) -> (a * b)
multiply_by14::Any = multiply_v13(14)
multiply_by14_result::Any = multiply_by14(10) # 140
