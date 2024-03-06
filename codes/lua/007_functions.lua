-- ? function statement or function declaration

function get_rectangle_area_v1(rectangle_width, rectangle_length)
    return (rectangle_width * rectangle_length)
end
-- call the function example: get_rectangle_area_v1(7, 5)

function get_rectangle_area_v2(rectangle_width, rectangle_length) return (rectangle_width * rectangle_length) end
-- call the function example: get_rectangle_area_v2(7, 5)

-- ? function expression

get_rectangle_area_v3 = function(rectangle_width, rectangle_length)
    return (rectangle_width * rectangle_length)
end
-- call the function example: get_rectangle_area_v3(7, 5)

get_rectangle_area_v4 = function(rectangle_width, rectangle_length) return (rectangle_width * rectangle_length) end
-- call the function example: get_rectangle_area_v4(7, 5)

-- ? anonymous function

--[[
    function (rectangle_width, rectangle_length)
        return (rectangle_width * rectangle_length)
    end
]]

-- function(rectangle_width, rectangle_length) return (rectangle_width * rectangle_length) end

-- ? Passing functions as arguments to other functions

function say_hello(callback_function)
    print("hello")
    callback_function()
end

function say_how_are_you()
    print("how are you?")
end

say_hello(say_how_are_you)

say_hello(function ()
    print("how are you?")
end)

say_hello(function() print("how are you?") end)

-- ? Assigning functions to variables or storing them in data structures

get_rectangle_area_v3 = function(rectangle_width, rectangle_length)
    return (rectangle_width * rectangle_length)
end

get_rectangle_area_v4 = function(rectangle_width, rectangle_length) return (rectangle_width * rectangle_length) end

my_array_of_get_rectangle_area_functions = {
    get_rectangle_area_v1,
    function (rectangle_width, rectangle_length)
        return (rectangle_width * rectangle_length)
    end,
    function(rectangle_width, rectangle_length) return (rectangle_width * rectangle_length) end
}
get_rectangle_area_function_result1 = my_array_of_get_rectangle_area_functions[1](7, 5)
get_rectangle_area_function_result2 = my_array_of_get_rectangle_area_functions[2](7, 5)
get_rectangle_area_function_result3 = my_array_of_get_rectangle_area_functions[3](7, 5)

function exponentiation(a, b)
    return (a ^ b)
end

simple_calculator = {
    exponentiation = exponentiation,
    addition = function (a, b)
        return (a + b)
    end,
    subtraction = function(a, b) return (a - b) end
}
simple_calculator_result1 = simple_calculator.exponentiation(2, 4)
simple_calculator_result2 = simple_calculator.addition(9, 3)
simple_calculator_result3 = simple_calculator.subtraction(35, 8)

-- ? Returning functions as values from other functions

function multiply_v1(a)
    function multiply_by(b)
        return (a * b)
    end
    return multiply_by
end
multiply_by2 = multiply_v1(2)
multiply_by2_result = multiply_by2(10) -- 20

function multiply_v2(a)
    function multiply_by(b) return (a * b) end
    return multiply_by
end
multiply_by3 = multiply_v2(3)
multiply_by3_result = multiply_by3(10) -- 30

function multiply_v3(a)
    local multiply_by = function (b)
        return (a * b)
    end
    return multiply_by
end
multiply_by4 = multiply_v3(4)
multiply_by4_result = multiply_by4(10) -- 40

function multiply_v4(a)
    local multiply_by = function (b) return (a * b) end
    return multiply_by
end
multiply_by5 = multiply_v4(5)
multiply_by5_result = multiply_by5(10) -- 50

function multiply_v5(a)
    return function (b)
        return (a * b)
    end
end
multiply_by6 = multiply_v5(6)
multiply_by6_result = multiply_by6(10) -- 60

function multiply_v6(a)
    return function (b) return (a * b) end
end
multiply_by7 = multiply_v6(7)
multiply_by7_result = multiply_by7(10) -- 70

function multiply_v7(a) return function (b) return (a * b) end end
multiply_by8 = multiply_v7(8)
multiply_by8_result = multiply_by8(10) -- 80

multiply_v8 = function (a)
    function multiply_by(b)
        return (a * b)
    end
    return multiply_by
end
multiply_by9 = multiply_v8(9)
multiply_by9_result = multiply_by9(10) -- 90

multiply_v9 = function (a)
    function multiply_by(b) return (a * b) end
    return multiply_by
end
multiply_by10 = multiply_v9(10)
multiply_by10_result = multiply_by10(10) -- 100

multiply_v10 = function (a)
    local multiply_by = function (b)
        return (a * b)
    end
    return multiply_by
end
multiply_by11 = multiply_v10(11)
multiply_by11_result = multiply_by11(10) -- 110

multiply_v11 = function (a)
    local multiply_by = function (b) return (a * b) end
    return multiply_by
end
multiply_by12 = multiply_v11(12)
multiply_by12_result = multiply_by12(10) -- 120

multiply_v12 = function (a)
    return function (b)
        return (a * b)
    end
end
multiply_by13 = multiply_v12(13)
multiply_by13_result = multiply_by13(10) -- 130

multiply_v13 = function (a)
    return function (b) return (a * b) end
end
multiply_by14 = multiply_v13(14)
multiply_by14_result = multiply_by14(10) -- 140

multiply_v14 = function (a) return function (b) return (a * b) end end
multiply_by15 = multiply_v14(15)
multiply_by15_result = multiply_by15(10) -- 150
