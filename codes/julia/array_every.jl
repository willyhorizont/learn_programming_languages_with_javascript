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

array_every_v1::Any = (callback_function::Any, an_array::Any) -> (begin
    # JavaScript-like Array.every() function array_every_v1
    local is_condition_match::Any = false
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === false) break end
    end
    return (is_condition_match)::Any
end)::Any

array_every_v2::Any = (callback_function::Any, an_array::Any) -> (begin
    # JavaScript-like Array.every() function array_every_v2
    local is_condition_match::Any = false
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === false) return is_condition_match end
    end
    return (is_condition_match)::Any
end)::Any

array_every_v3::Any = (callback_function::Any, an_array::Any) -> (begin
    # JavaScript-like Array.every() function array_every_v3
    for (array_item_index, array_item) in enumerate(an_array)
        local is_condition_match::Any = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === false) return false end
    end
    return true
end)::Any

array_every_v4::Any = (callback_function::Any, an_array::Any) -> (begin
    # JavaScript-like Array.every() function array_every_v4
    for (array_item_index, array_item) in enumerate(an_array)
        if (callback_function(array_item, array_item_index, an_array) === false) return false end
    end
    return true
end)::Any

println("\n# JavaScript-like Array.every() in Julia Vector")

numbers::Any = Vector{Any}([12, 34, 27, 23, 65, 93, 36, 87, 4, 254])
println("numbers: $(json_stringify(numbers))")

println("# using JavaScript-like Array.every() function \"array_every_v1\"")

is_all_number_less_than_500::Any = array_every_v1(((number::Any, _, _) -> (number < 500)::Any), numbers)
println("is all number < 500: $(is_all_number_less_than_500)")
# is all number < 500: true

is_all_number_more_than_500::Any = array_every_v1(((number::Any, _, _) -> (number > 500)::Any), numbers)
println("is all number > 500: $(is_all_number_more_than_500)")
# is all number > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v2\"")

is_all_number_less_than_500::Any = array_every_v2(((number::Any, _, _) -> (number < 500)::Any), numbers)
println("is all number < 500: $(is_all_number_less_than_500)")
# is all number < 500: true

is_all_number_more_than_500::Any = array_every_v2(((number::Any, _, _) -> (number > 500)::Any), numbers)
println("is all number > 500: $(is_all_number_more_than_500)")
# is all number > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v3\"")

is_all_number_less_than_500::Any = array_every_v3(((number::Any, _, _) -> (number < 500)::Any), numbers)
println("is all number < 500: $(is_all_number_less_than_500)")
# is all number < 500: true

is_all_number_more_than_500::Any = array_every_v3(((number::Any, _, _) -> (number > 500)::Any), numbers)
println("is all number > 500: $(is_all_number_more_than_500)")
# is all number > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v4\"")

is_all_number_less_than_500::Any = array_every_v4(((number::Any, _, _) -> (number < 500)::Any), numbers)
println("is all number < 500: $(is_all_number_less_than_500)")
# is all number < 500: true

is_all_number_more_than_500::Any = array_every_v4(((number::Any, _, _) -> (number > 500)::Any), numbers)
println("is all number > 500: $(is_all_number_more_than_500)")
# is all number > 500: false

println("# using Julia Array.every() built-in function \"all\"")

is_all_number_less_than_500::Any = all(((number::Any) -> (number < 500)::Any), numbers)
println("is all number < 500: $(is_all_number_less_than_500)")
# is all number < 500: true

is_all_number_more_than_500::Any = all(((number::Any) -> (number > 500)::Any), numbers)
println("is all number > 500: $(is_all_number_more_than_500)")
# is all number > 500: false

println("\n# JavaScript-like Array.every() in Julia Vector of Dictionaries")

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

println("# using JavaScript-like Array.every() function \"array_every_v1\"")

is_all_product_price_less_than_500::Any = array_every_v1(((product::Any, _, _) -> ((try product["price"] catch (e) nothing end) < 500)::Any), products)
println("is all product price < 500: $(is_all_product_price_less_than_500)")
# is all product price < 500: true

is_all_product_price_more_than_500::Any = array_every_v1(((product::Any, _, _) -> ((try product["price"] catch (e) nothing end) > 500)::Any), products)
println("is all product price > 500: $(is_all_product_price_more_than_500)")
# is all product price > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v2\"")

is_all_product_price_less_than_500::Any = array_every_v2(((product::Any, _, _) -> ((try product["price"] catch (e) nothing end) < 500)::Any), products)
println("is all product price < 500: $(is_all_product_price_less_than_500)")
# is all product price < 500: true

is_all_product_price_more_than_500::Any = array_every_v2(((product::Any, _, _) -> ((try product["price"] catch (e) nothing end) > 500)::Any), products)
println("is all product price > 500: $(is_all_product_price_more_than_500)")
# is all product price > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v3\"")

is_all_product_price_less_than_500::Any = array_every_v3(((product::Any, _, _) -> ((try product["price"] catch (e) nothing end) < 500)::Any), products)
println("is all product price < 500: $(is_all_product_price_less_than_500)")
# is all product price < 500: true

is_all_product_price_more_than_500::Any = array_every_v3(((product::Any, _, _) -> ((try product["price"] catch (e) nothing end) > 500)::Any), products)
println("is all product price > 500: $(is_all_product_price_more_than_500)")
# is all product price > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v4\"")

is_all_product_price_less_than_500::Any = array_every_v4(((product::Any, _, _) -> ((try product["price"] catch (e) nothing end) < 500)::Any), products)
println("is all product price < 500: $(is_all_product_price_less_than_500)")
# is all product price < 500: true

is_all_product_price_more_than_500::Any = array_every_v4(((product::Any, _, _) -> ((try product["price"] catch (e) nothing end) > 500)::Any), products)
println("is all product price > 500: $(is_all_product_price_more_than_500)")
# is all product price > 500: false

println("# using Julia Array.every() built-in function \"all\"")

is_all_product_price_less_than_500::Any = all(((product::Any) -> ((try product["price"] catch (e) nothing end) < 500)::Any), products)
println("is all product price < 500: $(is_all_product_price_less_than_500)")
# is all product price < 500: true

is_all_product_price_more_than_500::Any = all(((product::Any) -> ((try product["price"] catch (e) nothing end) > 500)::Any), products)
println("is all product price > 500: $(is_all_product_price_more_than_500)")
# is all product price > 500: false
