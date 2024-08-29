function json_stringify(anything; pretty::Bool = false, indent::String = "    ")::String
    indent_level::Any = 0
    function json_stringify_inner(anything_inner, indent_inner::String)::String
        if (anything_inner === nothing) return "null" end
        if (isa(anything_inner, AbstractString) === true) return "\"$(anything_inner)\"" end
        if ((isa(anything_inner, Number) === true) || (isa(anything_inner, Bool) === true)) return "$(anything_inner)" end
        if (isa(anything_inner, Array) === true)
            if (length(anything_inner) == 0) return "[]" end
            indent_level += 1
            result_array::Any = ((pretty === true) ? "[\n$(repeat(indent_inner, indent_level))" : "[")
            for (array_item_index, array_item) in enumerate(anything_inner)
                result_array *= json_stringify_inner(array_item, indent_inner)
                if (array_item_index !== length(anything_inner)) result_array *= ((pretty === true) ? ",\n$(repeat(indent_inner, indent_level))" : ", ") end
            end
            indent_level -= 1
            result_array *= ((pretty === true) ? "\n$(repeat(indent_inner, indent_level))]" : "]")
            return result_array
        end
        if (isa(anything_inner, Dict) === true)
            if (length(anything_inner) == 0) return "{}" end
            indent_level += 1
            result_object::Any = ((pretty === true) ? "{\n$(repeat(indent_inner, indent_level))" : "{")
            for (object_entry_index, (object_key, object_value)) in enumerate(pairs(anything_inner))
                result_object *= "\"$(object_key)\": $(json_stringify_inner(object_value, indent_inner))"
                if (object_entry_index !== length(anything_inner)) result_object *= ((pretty === true) ? ",\n$(repeat(indent_inner, indent_level))" : ", ") end
            end
            indent_level -= 1
            result_object *= ((pretty === true) ? "\n$(repeat(indent_inner, indent_level))}" : "}")
            return result_object
        end
        return "null"
    end
    return json_stringify_inner(anything, indent)
end

function array_every_v1(callback_function, an_array)
    # JavaScript-like Array.every() function
    is_condition_match::Any = false
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === false)
            break
        end
    end
    return is_condition_match
end

function array_every_v2(callback_function, an_array)
    # JavaScript-like Array.every() function
    is_condition_match::Any = false
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === false)
            return is_condition_match
        end
    end
    return is_condition_match
end

function array_every_v3(callback_function, an_array)
    # JavaScript-like Array.every() function
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match::Any = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === false)
            return false
        end
    end
    return true
end

function array_every_v4(callback_function, an_array)
    # JavaScript-like Array.every() function
    for (array_item_index, array_item) in enumerate(an_array)
        if (callback_function(array_item, array_item_index, an_array) === false)
            return false
        end
    end
    return true
end

println("\n# JavaScript-like Array.every() in Julia Array")

numbers::Any = Any[12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
println("numbers: ", json_stringify(numbers))

println("# using JavaScript-like Array.every() function \"array_every_v1\"")

is_all_number_less_than_500::Any = array_every_v1((number, _, _) -> (number < 500), numbers)
println("is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500::Any = array_every_v1((number, _, _) -> (number > 500), numbers)
println("is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v2\"")

is_all_number_less_than_500::Any = array_every_v2((number, _, _) -> (number < 500), numbers)
println("is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500::Any = array_every_v2((number, _, _) -> (number > 500), numbers)
println("is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v3\"")

is_all_number_less_than_500::Any = array_every_v3((number, _, _) -> (number < 500), numbers)
println("is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500::Any = array_every_v3((number, _, _) -> (number > 500), numbers)
println("is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v4\"")

is_all_number_less_than_500::Any = array_every_v4((number, _, _) -> (number < 500), numbers)
println("is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500::Any = array_every_v4((number, _, _) -> (number > 500), numbers)
println("is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

println("# using Julia Array.every() built-in function \"all\"")

is_all_number_less_than_500::Any = all((number) -> (number < 500), numbers)
println("is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500::Any = all((number) -> (number > 500), numbers)
println("is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

println("\n# JavaScript-like Array.every() in Julia Array of Dictionaries")

products::Any = Any[
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
]
println("products: ", json_stringify(products, pretty=true))

println("# using JavaScript-like Array.every() function \"array_every_v1\"")

is_all_product_price_less_than_500::Any = array_every_v1((product, _, _) -> (product["price"] < 500), products)
println("is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500::Any = array_every_v1((product, _, _) -> (product["price"] > 500), products)
println("is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v2\"")

is_all_product_price_less_than_500::Any = array_every_v2((product, _, _) -> (product["price"] < 500), products)
println("is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500::Any = array_every_v2((product, _, _) -> (product["price"] > 500), products)
println("is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v3\"")

is_all_product_price_less_than_500::Any = array_every_v3((product, _, _) -> (product["price"] < 500), products)
println("is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500::Any = array_every_v3((product, _, _) -> (product["price"] > 500), products)
println("is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v4\"")

is_all_product_price_less_than_500::Any = array_every_v4((product, _, _) -> (product["price"] < 500), products)
println("is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500::Any = array_every_v4((product, _, _) -> (product["price"] > 500), products)
println("is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

println("# using Julia Array.every() built-in function \"all\"")

is_all_product_price_less_than_500::Any = all((product) -> (product["price"] < 500), products)
println("is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500::Any = all((product) -> (product["price"] > 500), products)
println("is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false
