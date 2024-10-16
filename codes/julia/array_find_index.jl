struct js_like_type_struct
    Null::Any
    Boolean::Any
    String::Any
    Numeric::Any
    Object::Any
    Array::Any
    Function::Any
end

js_like_type::Any = js_like_type_struct(
    "Null",
    "Boolean",
    "String",
    "Numeric",
    "Object",
    "Array",
    "Function"
)

is_like_js_null::Any = (anything::Any) -> ((anything === nothing) && (isnothing(anything) === true))::Any

is_like_js_boolean::Any = (anything::Any) -> ((isa(anything, Bool) === true) && ((anything === true) || (anything === false)))::Any

is_like_js_string::Any = (anything::Any) -> (isa(anything, AbstractString) === true)::Any

is_like_js_numeric::Any = (anything::Any) -> (isa(anything, Number) === true)::Any

is_like_js_object::Any = (anything::Any) -> (isa(anything, Dict{String, Any}) === true)::Any

is_like_js_array::Any = (anything::Any) -> ((isa(anything, Array{Any, 1}) === true) && (isa(anything, Vector{Any}) === true))::Any

is_like_js_function::Any = (anything::Any) -> (isa(anything, Function) === true)::Any

get_type::Any = (anything::Any) -> (begin
    if (is_like_js_null(anything) === true) return (js_like_type.Null)::Any end
    if (is_like_js_boolean(anything) === true) return (js_like_type.Boolean)::Any end
    if (is_like_js_string(anything) === true) return (js_like_type.String)::Any end
    if (is_like_js_numeric(anything) === true) return (js_like_type.Numeric)::Any end
    if (is_like_js_object(anything) === true) return (js_like_type.Object)::Any end
    if (is_like_js_array(anything) === true) return (js_like_type.Array)::Any end
    if (is_like_js_function(anything) === true) return (js_like_type.Function)::Any end
    return ("\"$(typeof(anything))\"")::Any
end)::Any

json_stringify::Any = (anything::Any; pretty::Any=false) -> (begin
    # custom JSON.stringify() function
    local indent::Any = repeat(" ", 4)
    local indent_level::Any = 0
    local json_stringify_inner::Any = (anything_inner::Any) -> (begin
        if (get_type(anything_inner) === js_like_type.Null) return ("null")::Any end
        if (get_type(anything_inner) === js_like_type.String) return ("\"$(anything_inner)\"")::Any end
        if ((get_type(anything_inner) === js_like_type.Numeric) || (get_type(anything_inner) === js_like_type.Boolean)) return ("$(anything_inner)")::Any end
        if (get_type(anything_inner) === js_like_type.Array)
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
        if (get_type(anything_inner) === js_like_type.Object)
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
        if (get_type(anything_inner) === js_like_type.Function) return ("\"[object Function]\"")::Any end
        return ("\"$(typeof(anything))\"")::Any
    end)::Any
    return (json_stringify_inner(anything))::Any
end)::Any

array_find_index_v1::Any = (callback_function::Any, an_array::Any) -> (begin
    # JavaScript-like Array.findIndex() function array_find_index_v1
    local data_found_index::Any = -1
    for (array_item_index, array_item) in enumerate(an_array)
        local is_condition_match::Any = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === true)
            data_found_index = array_item_index
            break
        end
    end
    return (data_found_index)::Any
end)::Any

array_find_index_v2::Any = (callback_function::Any, an_array::Any) -> (begin
    # JavaScript-like Array.findIndex() function array_find_index_v2
    local data_found_index::Any = -1
    for (array_item_index, array_item) in enumerate(an_array)
        if (callback_function(array_item, array_item_index, an_array) === true)
            data_found_index = array_item_index
            break
        end
    end
    return (data_found_index)::Any
end)::Any

array_find_index_v3::Any = (callback_function::Any, an_array::Any) -> (begin
    # JavaScript-like Array.findIndex() function array_find_index_v3
    for (array_item_index, array_item) in enumerate(an_array)
        local is_condition_match::Any = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === true) return (array_item_index)::Any end
    end
    return (-1)::Any
end)::Any

array_find_index_v4::Any = (callback_function::Any, an_array::Any) -> (begin
    # JavaScript-like Array.findIndex() function array_find_index_v4
    for (array_item_index, array_item) in enumerate(an_array)
        if (callback_function(array_item, array_item_index, an_array) === true) return (array_item_index)::Any end
    end
    return (-1)::Any
end)::Any

println("\n# JavaScript-like Array.findIndex() in Julia Vector")

numbers::Any = Vector{Any}([12, 34, 27, 23, 65, 93, 36, 87, 4, 254])
println("numbers: $(json_stringify(numbers))")

number_to_find::Any = 27
println("number to find: $(number_to_find)")

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v1\"")

number_found_index::Any = array_find_index_v1(((number::Any, _, _) -> (number === number_to_find)::Any), numbers)
println("number found index: $(number_found_index)")
# number found index: 3

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v2\"")

number_found_index::Any = array_find_index_v2(((number::Any, _, _) -> (number === number_to_find)::Any), numbers)
println("number found index: $(number_found_index)")
# number found index: 3

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v3\"")

number_found_index::Any = array_find_index_v3(((number::Any, _, _) -> (number === number_to_find)::Any), numbers)
println("number found index: $(number_found_index)")
# number found index: 3

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v4\"")

number_found_index::Any = array_find_index_v4(((number::Any, _, _) -> (number === number_to_find)::Any), numbers)
println("number found index: $(number_found_index)")
# number found index: 3

println("# using Julia Array.findIndex() built-in function \"findfirst\"")

number_found_index::Any = findfirst(((number::Any) -> (number === number_to_find)::Any), numbers)
println("number found index: $(number_found_index)")
# number found index: 3

println("\n# JavaScript-like Array.findIndex() in Julia Vector of Dictionaries")

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

product_to_find::Any = "pasta"
println("product to find: $(json_stringify(product_to_find))")

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v1\"")

product_found_index::Any = array_find_index_v1(((product::Any, _, _) -> ((try product["code"] catch (e) nothing end) === product_to_find)::Any), products)
println("product found index: $(product_found_index)")
# product found index: 1

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v2\"")

product_found_index::Any = array_find_index_v2(((product::Any, _, _) -> ((try product["code"] catch (e) nothing end) === product_to_find)::Any), products)
println("product found index: $(product_found_index)")
# product found index: 1

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v3\"")

product_found_index::Any = array_find_index_v3(((product::Any, _, _) -> ((try product["code"] catch (e) nothing end) === product_to_find)::Any), products)
println("product found index: $(product_found_index)")
# product found index: 1

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v4\"")

product_found_index::Any = array_find_index_v4(((product::Any, _, _) -> ((try product["code"] catch (e) nothing end) === product_to_find)::Any), products)
println("product found index: $(product_found_index)")
# product found index: 1

println("# using Julia Array.findIndex() built-in function \"findfirst\"")

product_found_index::Any = findfirst(((product::Any) -> ((try product["code"] catch (e) nothing end) === product_to_find)::Any), products)
println("product found index: $(product_found_index)")
# product found index: 1
