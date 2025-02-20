# ? function statement or function declaration

function get_rectangle_area_v1(rectangle_width::Any, rectangle_length::Any)::Any
    return (rectangle_width * rectangle_length)::Any
end
println("get_rectangle_area_v1(7, 5): $(get_rectangle_area_v1(7, 5))")

get_rectangle_area_v2(rectangle_width::Any, rectangle_length::Any)::Any = (rectangle_width * rectangle_length)::Any
println("get_rectangle_area_v2(7, 5): $(get_rectangle_area_v2(7, 5))")

# ? function expression

get_rectangle_area_v3::Any = function (rectangle_width::Any, rectangle_length::Any)
    return (rectangle_width * rectangle_length)::Any
end
println("get_rectangle_area_v3(7, 5): $(get_rectangle_area_v3(7, 5))")

# ? anonymous function

function (rectangle_width::Any, rectangle_length::Any)
    return (rectangle_width * rectangle_length)::Any
end

# ? named function expression 🤮

get_rectangle_area_v4::Any = function do_something(rectangle_width::Any, rectangle_length::Any)::Any
    return (rectangle_width * rectangle_length)::Any
end
println("get_rectangle_area_v4(7, 5): $(get_rectangle_area_v4(7, 5))")

# ? function expression with arrow function or named arrow function

get_rectangle_area_v5::Any = (rectangle_width::Any, rectangle_length::Any) -> (begin
    return (rectangle_width * rectangle_length)::Any
end)::Any
println("get_rectangle_area_v5(7, 5): $(get_rectangle_area_v5(7, 5))")

get_rectangle_area_v6::Any = (rectangle_width::Any, rectangle_length::Any) -> (rectangle_width * rectangle_length)::Any
println("get_rectangle_area_v6(7, 5): $(get_rectangle_area_v6(7, 5))")

# ? anonymous arrow function

(rectangle_width::Any, rectangle_length::Any) -> (begin
    return (rectangle_width * rectangle_length)::Any
end)::Any

(rectangle_width::Any, rectangle_length::Any) -> (rectangle_width * rectangle_length)::Any

# ? Passing functions as arguments to other functions

function say_hello(callback_function::Any)::Any
    println("hello")
    callback_function()
end

function say_how_are_you()::Any
    println("how are you ?")
end

say_hello(say_how_are_you)

say_hello(function ()
    println("how are you ?")
end)

say_hello(() -> println("how are you ?"))

# ? Assigning functions to variables or storing them in data structures

get_rectangle_area_v3_copy::Any = function (rectangle_width::Any, rectangle_length::Any)
    return (rectangle_width * rectangle_length)::Any
end
println("get_rectangle_area_v3_copy(7, 5): $(get_rectangle_area_v3_copy(7, 5))")

get_rectangle_area_v5_copy::Any = (rectangle_width::Any, rectangle_length::Any) -> (begin
    return (rectangle_width * rectangle_length)::Any
end)::Any
println("get_rectangle_area_v5_copy(7, 5): $(get_rectangle_area_v5_copy(7, 5))")

get_rectangle_area_v6_copy::Any = (rectangle_width::Any, rectangle_length::Any) -> (rectangle_width * rectangle_length)::Any
println("get_rectangle_area_v6_copy(7, 5): $(get_rectangle_area_v6_copy(7, 5))")


my_array_of_get_rectangle_area_functions::Any = Vector{Any}([
    get_rectangle_area_v1,
    function (rectangle_width::Any, rectangle_length::Any)
        return (rectangle_width * rectangle_length)::Any
    end,
    (rectangle_width::Any, rectangle_length::Any) -> (rectangle_width * rectangle_length)::Any
])
println("my_array_of_get_rectangle_area_functions[1](7, 5): $(my_array_of_get_rectangle_area_functions[1](7, 5))")
println("my_array_of_get_rectangle_area_functions[2](7, 5): $(my_array_of_get_rectangle_area_functions[2](7, 5))")
println("my_array_of_get_rectangle_area_functions[3](7, 5): $(my_array_of_get_rectangle_area_functions[3](7, 5))")
println("try my_array_of_get_rectangle_area_functions[1](7, 5) catch (any_error) nothing end: $(try my_array_of_get_rectangle_area_functions[1](7, 5) catch (any_error) nothing end)")
println("try my_array_of_get_rectangle_area_functions[2](7, 5) catch (any_error) nothing end: $(try my_array_of_get_rectangle_area_functions[2](7, 5) catch (any_error) nothing end)")
println("try my_array_of_get_rectangle_area_functions[3](7, 5) catch (any_error) nothing end: $(try my_array_of_get_rectangle_area_functions[3](7, 5) catch (any_error) nothing end)")

function exponentiation(a::Any, b::Any)::Any
    return (a ^ b)::Any
end

simple_calculator::Any = Dict{String, Any}(
    "exponentiation" => exponentiation,
    "addition" => function (a::Any, b::Any)
        return (a + b)::Any
    end,
    "subtraction" => (a::Any, b::Any) -> (a - b)::Any
)
println("simple_calculator[\"exponentiation\"](2, 4): $(simple_calculator["exponentiation"](2, 4))")
println("simple_calculator[\"addition\"](9, 3): $(simple_calculator["addition"](9, 3))")
println("simple_calculator[\"subtraction\"](35, 8): $(simple_calculator["subtraction"](35, 8))")
println("try simple_calculator[\"exponentiation\"](2, 4) catch (any_error) nothing end: $(try simple_calculator["exponentiation"](2, 4) catch (any_error) nothing end)")
println("try simple_calculator[\"addition\"](9, 3) catch (any_error) nothing end: $(try simple_calculator["addition"](9, 3) catch (any_error) nothing end)")
println("try simple_calculator[\"subtraction\"](35, 8) catch (any_error) nothing end: $(try simple_calculator["subtraction"](35, 8) catch (any_error) nothing end)")

# ? Returning functions as values from other functions

function multiply_v1(a::Any)::Any
    function multiply_by(b::Any)::Any
        return (a * b)::Any
    end
    return (multiply_by)::Any
end
multiply_by2::Any = multiply_v1(2)
multiply_by2_result::Any = multiply_by2(10)
println("multiply_by2(10): $(multiply_by2_result)")

function multiply_v2(a::Any)::Any
    local multiply_by::Any = function (b::Any)
        return (a * b)::Any
    end
    return (multiply_by)::Any
end
multiply_by3::Any = multiply_v2(3)
multiply_by3_result::Any = multiply_by3(10)
println("multiply_by3(10): $(multiply_by3_result)")

function multiply_v3(a::Any)::Any
    local multiply_by::Any = (b::Any) -> (begin
        return (a * b)::Any
    end)::Any
    return (multiply_by)::Any
end
multiply_by4::Any = multiply_v3(4)
multiply_by4_result::Any = multiply_by4(10)
println("multiply_by4(10): $(multiply_by4_result)")

function multiply_v4(a::Any)::Any
    local multiply_by::Any = (b::Any) -> (a * b)::Any
    return (multiply_by)::Any
end
multiply_by5::Any = multiply_v4(5)
multiply_by5_result::Any = multiply_by5(10)
println("multiply_by5(10): $(multiply_by5_result)")

multiply_v5::Any = function (a::Any)
    local multiply_by::Any = function (b::Any)
        return (a * b)::Any
    end
    return (multiply_by)::Any
end
multiply_by6::Any = multiply_v5(6)
multiply_by6_result::Any = multiply_by6(10)
println("multiply_by6(10): $(multiply_by6_result)")

multiply_v6::Any = function (a::Any)
    local multiply_by::Any = (b::Any) -> (begin
        return (a * b)::Any
    end)::Any
    return (multiply_by)::Any
end
multiply_by7::Any = multiply_v6(7)
multiply_by7_result::Any = multiply_by7(10)
println("multiply_by7(10): $(multiply_by7_result)")

multiply_v7::Any = function (a::Any)
    local multiply_by::Any = (b::Any) -> (a * b)::Any
    return (multiply_by)::Any
end
multiply_by8::Any = multiply_v7(8)
multiply_by8_result::Any = multiply_by8(10)
println("multiply_by8(10): $(multiply_by8_result)")

multiply_v8::Any = (a::Any) -> (begin
    local multiply_by::Any = function (b::Any)
        return (a * b)::Any
    end
    return (multiply_by)::Any
end)::Any
multiply_by9::Any = multiply_v8(9)
multiply_by9_result::Any = multiply_by9(10)
println("multiply_by9(10): $(multiply_by9_result)")

multiply_v9::Any = (a::Any) -> (begin
    local multiply_by::Any = (b::Any) -> (begin
        return (a * b)::Any
    end)::Any
    return (multiply_by)::Any
end)::Any
multiply_by10::Any = multiply_v9(10)
multiply_by10_result::Any = multiply_by10(10)
println("multiply_by10(10): $(multiply_by10_result)")

multiply_v10::Any = (a::Any) -> (begin
    local multiply_by::Any = (b::Any) -> (a * b)::Any
    return (multiply_by)::Any
end)::Any
multiply_by11::Any = multiply_v10(11)
multiply_by11_result::Any = multiply_by11(10)
println("multiply_by11(10): $(multiply_by11_result)")

multiply_v11::Any = function (a::Any)
    return (function (b::Any)
        return (a * b)::Any
    end)::Any
end
multiply_by12::Any = multiply_v11(12)
multiply_by12_result::Any = multiply_by12(10)
println("multiply_by12(10): $(multiply_by12_result)")

multiply_v12::Any = function (a::Any)
    return ((b::Any) -> (begin
        return (a * b)::Any
    end)::Any)::Any
end
multiply_by13::Any = multiply_v12(13)
multiply_by13_result::Any = multiply_by13(10)
println("multiply_by13(10): $(multiply_by13_result)")

multiply_v13::Any = function (a::Any)
    return ((b::Any) -> (a * b)::Any)::Any
end
multiply_by14::Any = multiply_v13(14)
multiply_by14_result::Any = multiply_by14(10)
println("multiply_by14(10): $(multiply_by14_result)")

multiply_v14::Any = (a::Any) -> (begin
    return (function (b::Any)
        return (a * b)::Any
    end)::Any
end)::Any
multiply_by15::Any = multiply_v14(15)
multiply_by15_result::Any = multiply_by15(10)
println("multiply_by15(10): $(multiply_by15_result)")

multiply_v15::Any = (a::Any) -> (begin
    return ((b::Any) -> (begin
        return (a * b)::Any
    end)::Any)::Any
end)::Any
multiply_by16::Any = multiply_v15(16)
multiply_by16_result::Any = multiply_by16(10)
println("multiply_by16(10): $(multiply_by16_result)")

multiply_v16::Any = (a::Any) -> (begin
    return ((b::Any) -> (a * b)::Any)::Any
end)::Any
multiply_by17::Any = multiply_v16(17)
multiply_by17_result::Any = multiply_by17(10)
println("multiply_by17(10): $(multiply_by17_result)")

multiply_v17::Any = (a::Any) -> ((b::Any) -> (a * b)::Any)::Any
multiply_by18::Any = multiply_v17(18)
multiply_by18_result::Any = multiply_by18(10)
println("multiply_by18(10): $(multiply_by18_result)")
