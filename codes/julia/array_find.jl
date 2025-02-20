struct js_like_type_struct
    Null::Any
    Boolean::Any
    String::Any
    Numeric::Any
    Object::Any
    Array::Any
    Function::Any
end

js_like_type::Any = js_like_type_struct("Null", "Boolean", "String", "Numeric", "Object", "Array", "Function")

is_like_js_null::Any = (anything::Any) -> ((anything === nothing) && (isnothing(anything) === true))::Any

is_like_js_boolean::Any = (anything::Any) -> ((isa(anything, Bool) === true) && ((anything === true) || (anything === false)))::Any

is_like_js_string::Any = (anything::Any) -> (isa(anything, AbstractString) === true)::Any

is_like_js_numeric::Any = (anything::Any) -> (isa(anything, Number) === true)::Any

is_like_js_object::Any = (anything::Any) -> (isa(anything, Dict{String, Any}) === true)::Any

is_like_js_array::Any = (anything::Any) -> ((isa(anything, Array{Any, 1}) === true) && (isa(anything, Vector{Any}) === true))::Any

is_like_js_function::Any = (anything::Any) -> (isa(anything, Function) === true)::Any

get_type::Any = (anything::Any) -> (((is_like_js_null(anything) === true) ? ((js_like_type.Null)::Any) : ((is_like_js_boolean(anything) === true) ? ((js_like_type.Boolean)::Any) : ((is_like_js_string(anything) === true) ? ((js_like_type.String)::Any) : ((is_like_js_numeric(anything) === true) ? ((js_like_type.Numeric)::Any) : ((is_like_js_object(anything) === true) ? ((js_like_type.Object)::Any) : ((is_like_js_array(anything) === true) ? ((js_like_type.Array)::Any) : ((is_like_js_function(anything) === true) ? ((js_like_type.Function)::Any) : (("$(supertype(typeof(anything)))")::Any)))))))))::Any

json_stringify::Any = (anything::Any; pretty::Any=false) -> (begin
    # custom JSON.stringify() function
    local indent::Any = repeat(" ", 4)
    local indent_level::Any = 0
    local json_stringify_inner::Any = (anything_inner::Any) -> (begin
        local anything_inner_type::Any = get_type(anything_inner)
        if (anything_inner_type === js_like_type.Null) return ("null")::Any end
        if (anything_inner_type === js_like_type.String) return ("\"$(anything_inner)\"")::Any end
        if ((anything_inner_type === js_like_type.Numeric) || (anything_inner_type === js_like_type.Boolean)) return ("$(anything_inner)")::Any end
        if (anything_inner_type === js_like_type.Array)
            return ((() -> begin
                if (length(anything_inner) === 0) return ("[]")::Any end
                indent_level += 1
                local result::Any = ((pretty === true) ? "[\n$(repeat(indent, indent_level))" : "[")
                for (array_item_index, array_item) in enumerate(anything_inner)
                    result *= json_stringify_inner(array_item)
                    if (array_item_index !== length(anything_inner))
                        result *= ((pretty === true) ? ",\n$(repeat(indent, indent_level))" : ", ")
                    end
                end
                indent_level -= 1
                result *= ((pretty === true) ? "\n$(repeat(indent, indent_level))]" : "]")
                return (result)::Any
            end)())::Any
        end
        if (anything_inner_type === js_like_type.Object)
            return ((() -> begin
                if (length(anything_inner) === 0) return ("{}")::Any end
                indent_level += 1
                local result::Any = ((pretty === true) ? "{\n$(repeat(indent, indent_level))" : "{ ")
                for (object_entry_index, (object_key, object_value)) in enumerate(pairs(anything_inner))
                    result *= "\"$(object_key)\": $(json_stringify_inner(object_value))"
                    if (object_entry_index !== length(anything_inner))
                        result *= ((pretty === true) ? ",\n$(repeat(indent, indent_level))" : ", ")
                    end
                end
                indent_level -= 1
                result *= ((pretty === true) ? "\n$(repeat(indent, indent_level))}" : " }")
                return (result)::Any
            end)())::Any
        end
        if (anything_inner_type === js_like_type.Function) return ("[object Function]")::Any end
        return (anything_inner_type)::Any
    end)::Any
    return (json_stringify_inner(anything))::Any
end)::Any

# There's no JavaScript-like Array.find() in Julia.
# But, we can create our own function to mimic it in Julia.

array_find_v1::Any = (callback_function::Any, any_array::Any) -> (begin
    # JavaScript-like Array.find() function array_find_v1
    local data_found::Any = nothing
    for (array_item_index, array_item) in enumerate(any_array)
        local is_condition_match::Any = callback_function(array_item, array_item_index, any_array)
        if (is_condition_match === true)
            data_found = array_item
            break
        end
    end
    return (data_found)::Any
end)::Any

array_find_v2::Any = (callback_function::Any, any_array::Any) -> (begin
    # JavaScript-like Array.find() function array_find_v2
    local data_found::Any = nothing
    for (array_item_index, array_item) in enumerate(any_array)
        if (callback_function(array_item, array_item_index, any_array) === true)
            data_found = array_item
            break
        end
    end
    return (data_found)::Any
end)::Any

array_find_v3::Any = (callback_function::Any, any_array::Any) -> (begin
    # JavaScript-like Array.find() function array_find_v3
    for (array_item_index, array_item) in enumerate(any_array)
        local is_condition_match::Any = callback_function(array_item, array_item_index, any_array)
        if (is_condition_match === true) return (array_item)::Any end
    end
    return (nothing)::Any
end)::Any

array_find_v4::Any = (callback_function::Any, any_array::Any) -> (begin
    # JavaScript-like Array.find() function array_find_v4
    for (array_item_index, array_item) in enumerate(any_array)
        if (callback_function(array_item, array_item_index, any_array) === true) return (array_item)::Any end
    end
    return (nothing)::Any
end)::Any

println("\n# JavaScript-like Array.find() in Julia Vector")

numbers::Any = Vector{Any}([12, 34, 27, 23, 65, 93, 36, 87, 4, 254])
println("numbers: $(json_stringify(numbers))")

println("# using JavaScript-like Array.find() function \"array_find_v1\"")

even_number_found::Any = array_find_v1(((number::Any, _, _) -> ((number % 2) === 0)::Any), numbers)
println("even number found: $(even_number_found)")
# even number found: 12

odd_numbers_found::Any = array_find_v1(((number::Any, _, _) -> ((number % 2) !== 0)::Any), numbers)
println("odd number found: $(odd_numbers_found)")
# odd number found: 27

println("# using JavaScript-like Array.find() function \"array_find_v2\"")

even_number_found::Any = array_find_v2(((number::Any, _, _) -> ((number % 2) === 0)::Any), numbers)
println("even number found: $(even_number_found)")
# even number found: 12

odd_numbers_found::Any = array_find_v2(((number::Any, _, _) -> ((number % 2) !== 0)::Any), numbers)
println("odd number found: $(odd_numbers_found)")
# odd number found: 27

println("# using JavaScript-like Array.find() function \"array_find_v3\"")

even_number_found::Any = array_find_v3(((number::Any, _, _) -> ((number % 2) === 0)::Any), numbers)
println("even number found: $(even_number_found)")
# even number found: 12

odd_numbers_found::Any = array_find_v3(((number::Any, _, _) -> ((number % 2) !== 0)::Any), numbers)
println("odd number found: $(odd_numbers_found)")
# odd number found: 27

println("# using JavaScript-like Array.find() function \"array_find_v4\"")

even_number_found::Any = array_find_v4(((number::Any, _, _) -> ((number % 2) === 0)::Any), numbers)
println("even number found: $(even_number_found)")
# even number found: 12

odd_numbers_found::Any = array_find_v4(((number::Any, _, _) -> ((number % 2) !== 0)::Any), numbers)
println("odd number found: $(odd_numbers_found)")
# odd number found: 27

println("\n# JavaScript-like Array.find() in Julia Vector of Dictionaries")

products::Any = Vector{Any}([
    Dict{String, Any}(
        "code" => "pasta",
        "price" => 321
    ),
    Dict{String, Any}(
        "code" => "bubble_gum",
        "price" => 233
    ),
    Dict{String, Any}(
        "code" => "potato_chips",
        "price" => 5
    ),
    Dict{String, Any}(
        "code" => "towel",
        "price" => 499
    )
])
println("products: $(json_stringify(products, pretty=true))")

product_to_find::Any = "bubble_gum"
println("product to find: $(product_to_find)")

println("# using JavaScript-like Array.find() function \"array_find_v1\"")

product_found::Any = array_find_v1(((product::Any, _, _) -> ((try product["code"] catch (e) nothing end) === product_to_find)::Any), products)
println("product found: $(json_stringify(product_found, pretty=true))")
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

println("# using JavaScript-like Array.find() function \"array_find_v2\"")

product_found::Any = array_find_v2(((product::Any, _, _) -> ((try product["code"] catch (e) nothing end) === product_to_find)::Any), products)
println("product found: $(json_stringify(product_found, pretty=true))")
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

println("# using JavaScript-like Array.find() function \"array_find_v3\"")

product_found::Any = array_find_v3(((product::Any, _, _) -> ((try product["code"] catch (e) nothing end) === product_to_find)::Any), products)
println("product found: $(json_stringify(product_found, pretty=true))")
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

println("# using JavaScript-like Array.find() function \"array_find_v4\"")

product_found::Any = array_find_v4(((product::Any, _, _) -> ((try product["code"] catch (e) nothing end) === product_to_find)::Any), products)
println("product found: $(json_stringify(product_found, pretty=true))")
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }
