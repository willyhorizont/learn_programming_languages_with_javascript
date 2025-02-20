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

function array_some_v1(callback_function::Any, any_array::Any)::Any
    # JavaScript-like Array.some() function array_some_v1
    local is_condition_match::Any = false
    for (array_item_index, array_item) in enumerate(any_array)
        is_condition_match = callback_function(array_item, array_item_index, any_array)
        if (is_condition_match === true) break end
    end
    return (is_condition_match)::Any
end

function array_some_v2(callback_function::Any, any_array::Any)::Any
    # JavaScript-like Array.some() function array_some_v2
    local is_condition_match::Any = false
    for (array_item_index, array_item) in enumerate(any_array)
        is_condition_match = callback_function(array_item, array_item_index, any_array)
        if (is_condition_match === true) return (is_condition_match)::Any end
    end
    return (is_condition_match)::Any
end

function array_some_v3(callback_function::Any, any_array::Any)::Any
    # JavaScript-like Array.some() function array_some_v3
    for (array_item_index, array_item) in enumerate(any_array)
        local is_condition_match::Any = callback_function(array_item, array_item_index, any_array)
        if (is_condition_match === true) return true end
    end
    return (false)::Any
end

function array_some_v4(callback_function::Any, any_array::Any)::Any
    # JavaScript-like Array.some() function array_some_v4
    for (array_item_index, array_item) in enumerate(any_array)
        if (callback_function(array_item, array_item_index, any_array) === true) return true end
    end
    return (false)::Any
end

println("\n# JavaScript-like Array.some() in Julia Vector")

numbers::Any = Vector{Any}([12, 34, 27, 23, 65, 93, 36, 87, 4, 254])
println("numbers: $(json_stringify(numbers))")

println("# using JavaScript-like Array.some() function \"array_some_v1\"")

is_any_number_less_than_500::Any = array_some_v1(((number::Any, _, _) -> (number < 500)::Any), numbers)
println("is any number < 500: $(is_any_number_less_than_500)")
# is any number < 500: true

is_any_number_more_than_500::Any = array_some_v1(((number::Any, _, _) -> (number > 500)::Any), numbers)
println("is any number > 500: $(is_any_number_more_than_500)")
# is any number > 500: false

println("# using JavaScript-like Array.some() function \"array_some_v2\"")

is_any_number_less_than_500::Any = array_some_v2(((number::Any, _, _) -> (number < 500)::Any), numbers)
println("is any number < 500: $(is_any_number_less_than_500)")
# is any number < 500: true

is_any_number_more_than_500::Any = array_some_v2(((number::Any, _, _) -> (number > 500)::Any), numbers)
println("is any number > 500: $(is_any_number_more_than_500)")
# is any number > 500: false

println("# using JavaScript-like Array.some() function \"array_some_v3\"")

is_any_number_less_than_500::Any = array_some_v3(((number::Any, _, _) -> (number < 500)::Any), numbers)
println("is any number < 500: $(is_any_number_less_than_500)")
# is any number < 500: true

is_any_number_more_than_500::Any = array_some_v3(((number::Any, _, _) -> (number > 500)::Any), numbers)
println("is any number > 500: $(is_any_number_more_than_500)")
# is any number > 500: false

println("# using JavaScript-like Array.some() function \"array_some_v4\"")

is_any_number_less_than_500::Any = array_some_v4(((number::Any, _, _) -> (number < 500)::Any), numbers)
println("is any number < 500: $(is_any_number_less_than_500)")
# is any number < 500: true

is_any_number_more_than_500::Any = array_some_v4(((number::Any, _, _) -> (number > 500)::Any), numbers)
println("is any number > 500: $(is_any_number_more_than_500)")
# is any number > 500: false

println("# using Julia Array.some() built-in function \"any\"")

is_any_number_less_than_500::Any = any([(number < 500)::Any for number in numbers])
println("is any number < 500: $(is_any_number_less_than_500)")
# is any number < 500: true

is_any_number_more_than_500::Any = any([(number > 500)::Any for number in numbers])
println("is any number > 500: $(is_any_number_more_than_500)")
# is any number > 500: false

println("\n# JavaScript-like Array.some() in Julia Vector of Dictionaries")

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

println("# using JavaScript-like Array.some() function \"array_some_v1\"")

is_any_product_price_less_than_500::Any = array_some_v1(((product::Any, _, _) -> ((try product["price"] catch (any_error) nothing end) < 500)::Any), products)
println("is any product price < 500: $(is_any_product_price_less_than_500)")
# is any product price < 500: true

is_any_product_price_more_than_500::Any = array_some_v1(((product::Any, _, _) -> ((try product["price"] catch (any_error) nothing end) > 500)::Any), products)
println("is any product price > 500: $(is_any_product_price_more_than_500)")
# is any product price > 500: false

println("# using JavaScript-like Array.some() function \"array_some_v2\"")

is_any_product_price_less_than_500::Any = array_some_v2(((product::Any, _, _) -> ((try product["price"] catch (any_error) nothing end) < 500)::Any), products)
println("is any product price < 500: $(is_any_product_price_less_than_500)")
# is any product price < 500: true

is_any_product_price_more_than_500::Any = array_some_v2(((product::Any, _, _) -> ((try product["price"] catch (any_error) nothing end) > 500)::Any), products)
println("is any product price > 500: $(is_any_product_price_more_than_500)")
# is any product price > 500: false

println("# using JavaScript-like Array.some() function \"array_some_v3\"")

is_any_product_price_less_than_500::Any = array_some_v3(((product::Any, _, _) -> ((try product["price"] catch (any_error) nothing end) < 500)::Any), products)
println("is any product price < 500: $(is_any_product_price_less_than_500)")
# is any product price < 500: true

is_any_product_price_more_than_500::Any = array_some_v3(((product::Any, _, _) -> ((try product["price"] catch (any_error) nothing end) > 500)::Any), products)
println("is any product price > 500: $(is_any_product_price_more_than_500)")
# is any product price > 500: false

println("# using JavaScript-like Array.some() function \"array_some_v4\"")

is_any_product_price_less_than_500::Any = array_some_v4(((product::Any, _, _) -> ((try product["price"] catch (any_error) nothing end) < 500)::Any), products)
println("is any product price < 500: $(is_any_product_price_less_than_500)")
# is any product price < 500: true

is_any_product_price_more_than_500::Any = array_some_v4(((product::Any, _, _) -> ((try product["price"] catch (any_error) nothing end) > 500)::Any), products)
println("is any product price > 500: $(is_any_product_price_more_than_500)")
# is any product price > 500: false

println("# using Julia Array.some() built-in function \"any\"")

is_any_product_price_less_than_500::Any = any([((try product["price"] catch (any_error) nothing end) < 500)::Any for product in products])
println("is any product price < 500: $(is_any_product_price_less_than_500)")
# is any product price < 500: true

is_any_product_price_more_than_500::Any = any([((try product["price"] catch (any_error) nothing end) > 500)::Any for product in products])
println("is any product price > 500: $(is_any_product_price_more_than_500)")
# is any product price > 500: false
