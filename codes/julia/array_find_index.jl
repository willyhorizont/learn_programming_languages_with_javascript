struct js_like_type_julia_struct
    Null::Any
    Boolean::Any
    String::Any
    Numeric::Any
    Object::Any
    Array::Any
    Function::Any
end

js_like_type = js_like_type_julia_struct("Null", "Boolean", "String", "Numeric", "Object", "Array", "Function")

function is_like_js_null(anything::Any)::Any
    return ((anything === nothing) && (isnothing(anything) === true))::Any
end

function is_like_js_boolean(anything::Any)::Any
    return ((isa(anything, Bool) === true) && ((anything === true) || (anything === false)))::Any
end

function is_like_js_string(anything::Any)::Any
    return (isa(anything, AbstractString) === true)::Any
end

function is_like_js_numeric(anything::Any)::Any
    return (isa(anything, Number) === true)::Any
end

function is_like_js_object(anything::Any)::Any
    return (isa(anything, Dict{String, Any}) === true)::Any
end

function is_like_js_array(anything::Any)::Any
    return ((isa(anything, Array{Any, 1}) === true) && (isa(anything, Vector{Any}) === true))::Any
end

function is_like_js_function(anything::Any)::Any
    return (isa(anything, Function) === true)::Any
end

function get_type(anything::Any)::Any
    return (((is_like_js_null(anything) === true) ? ((js_like_type.Null)::Any) : ((is_like_js_boolean(anything) === true) ? ((js_like_type.Boolean)::Any) : ((is_like_js_string(anything) === true) ? ((js_like_type.String)::Any) : ((is_like_js_numeric(anything) === true) ? ((js_like_type.Numeric)::Any) : ((is_like_js_object(anything) === true) ? ((js_like_type.Object)::Any) : ((is_like_js_array(anything) === true) ? ((js_like_type.Array)::Any) : ((is_like_js_function(anything) === true) ? ((js_like_type.Function)::Any) : (("$(supertype(typeof(anything)))")::Any)))))))))::Any
end

function json_stringify(anything::Any; pretty::Any=false)::Any
    # custom JSON.stringify() function
    local indent::Any = repeat(" ", 4)
    local indent_level::Any = 0
    function json_stringify_inner(anything_inner::Any)::Any
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
    end
    return (json_stringify_inner(anything))::Any
end

function array_entries(any_array::Any)::Any
    return (Dict{String, Any}("$(array_item_index)" => array_item for (array_item_index, array_item) in enumerate(any_array)))::Any
end

function array_find(callback_function::Any, any_array::Any)::Any
    # JavaScript-like Array.find() function array_find_v4
    for (array_item_index, array_item) in enumerate(any_array)
        if (callback_function(array_item, array_item_index, any_array) === true) return (array_item)::Any end
    end
    return (nothing)::Any
end

function array_find_index_v1(callback_function::Any, any_array::Any)::Any
    # JavaScript-like Array.findIndex() function array_find_index_v1
    local data_found_index::Any = -1
    for (array_item_index, array_item) in enumerate(any_array)
        local is_condition_match::Any = callback_function(array_item, array_item_index, any_array)
        if (is_condition_match === true)
            data_found_index = array_item_index
            break
        end
    end
    return (data_found_index)::Any
end

function array_find_index_v2(callback_function::Any, any_array::Any)::Any
    # JavaScript-like Array.findIndex() function array_find_index_v2
    local data_found_index::Any = -1
    for (array_item_index, array_item) in enumerate(any_array)
        if (callback_function(array_item, array_item_index, any_array) === true)
            data_found_index = array_item_index
            break
        end
    end
    return (data_found_index)::Any
end

function array_find_index_v3(callback_function::Any, any_array::Any)::Any
    # JavaScript-like Array.findIndex() function array_find_index_v3
    for (array_item_index, array_item) in enumerate(any_array)
        local is_condition_match::Any = callback_function(array_item, array_item_index, any_array)
        if (is_condition_match === true) return (array_item_index)::Any end
    end
    return (-1)::Any
end

function array_find_index_v4(callback_function::Any, any_array::Any)::Any
    # JavaScript-like Array.findIndex() function array_find_index_v4
    for (array_item_index, array_item) in enumerate(any_array)
        if (callback_function(array_item, array_item_index, any_array) === true) return (array_item_index)::Any end
    end
    return (-1)::Any
end

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

product_found_index::Any = array_find_index_v1(((product::Any, _, _) -> ((try product["code"] catch (any_error) nothing end) === product_to_find)::Any), products)
println("product found index: $(product_found_index)")
# product found index: 1

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v2\"")

product_found_index::Any = array_find_index_v2(((product::Any, _, _) -> ((try product["code"] catch (any_error) nothing end) === product_to_find)::Any), products)
println("product found index: $(product_found_index)")
# product found index: 1

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v3\"")

product_found_index::Any = array_find_index_v3(((product::Any, _, _) -> ((try product["code"] catch (any_error) nothing end) === product_to_find)::Any), products)
println("product found index: $(product_found_index)")
# product found index: 1

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v4\"")

product_found_index::Any = array_find_index_v4(((product::Any, _, _) -> ((try product["code"] catch (any_error) nothing end) === product_to_find)::Any), products)
println("product found index: $(product_found_index)")
# product found index: 1

println("# using Julia Array.findIndex() built-in function \"findfirst\"")

product_found_index::Any = findfirst(((product::Any) -> ((try product["code"] catch (any_error) nothing end) === product_to_find)::Any), products)
println("product found index: $(product_found_index)")
# product found index: 1
