function json_stringify(anything; pretty::Bool = false, indent::String = "    ")::String
    indent_level = 0
    function json_stringify_inner(anything_inner, indent_inner::String)::String
        if (anything_inner === nothing) return "null" end
        if (isa(anything_inner, AbstractString) === true) return "\"$(anything_inner)\"" end
        if ((isa(anything_inner, Number) === true) || (isa(anything_inner, Bool) === true)) return "$(anything_inner)" end
        if (isa(anything_inner, Array) === true)
            if (length(anything_inner) == 0) return "[]" end
            indent_level += 1
            result = ((pretty === true) ? "[\n$(repeat(indent_inner, indent_level))" : "[")
            for (array_item_index, array_item) in enumerate(anything_inner)
                result *= json_stringify_inner(array_item, indent_inner)
                if (array_item_index !== length(anything_inner)) result *= ((pretty === true) ? ",\n$(repeat(indent_inner, indent_level))" : ", ") end
            end
            indent_level -= 1
            result *= ((pretty === true) ? "\n$(repeat(indent_inner, indent_level))]" : "]")
            return result
        end
        if (isa(anything_inner, Dict) === true)
            if (length(anything_inner) == 0) return "{}" end
            indent_level += 1
            result = ((pretty === true) ? "{\n$(repeat(indent_inner, indent_level))" : "{")
            for (object_entry_index, (object_key, object_value)) in enumerate(pairs(anything_inner))
                result *= "\"$(object_key)\": $(json_stringify_inner(object_value, indent_inner))"
                if (object_entry_index !== length(anything_inner)) result *= ((pretty === true) ? ",\n$(repeat(indent_inner, indent_level))" : ", ") end
            end
            indent_level -= 1
            result *= ((pretty === true) ? "\n$(repeat(indent_inner, indent_level))}" : "}")
            return result
        end
        return "null"
    end
    return json_stringify_inner(anything, indent)
end

# There's no JavaScript-like Array.find() in Julia.
# But, we can create our own function to mimic it in Julia.

function array_find_v1(callback_function, an_array)
    # JavaScript-like Array.find() function
    data_found = nothing
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === true)
            data_found = array_item
            break
        end
    end
    return data_found
end

function array_find_v2(callback_function, an_array)
    # JavaScript-like Array.find() function
    data_found = nothing
    for (array_item_index, array_item) in enumerate(an_array)
        if (callback_function(array_item, array_item_index, an_array) === true)
            data_found = array_item
            break
        end
    end
    return data_found
end

function array_find_v3(callback_function, an_array)
    # JavaScript-like Array.find() function
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === true)
            return array_item
        end
    end
    return nothing
end

function array_find_v4(callback_function, an_array)
    # JavaScript-like Array.find() function
    for (array_item_index, array_item) in enumerate(an_array)
        if (callback_function(array_item, array_item_index, an_array) === true)
            return array_item
        end
    end
    return nothing
end

function array_find_v5(callback_function, an_array)
    # Array.find() function using Julia Array.find() built-in function "findfirst"
    data_found_index = findfirst(callback_function, an_array)
    return ((data_found_index === nothing) ? nothing : an_array[data_found_index])
end

println("\n# JavaScript-like Array.find() in Julia Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
println("numbers: ", json_stringify(numbers))

println("# using JavaScript-like Array.find() function \"array_find_v1\"")

even_number_found = array_find_v1((number, _, _) -> ((number % 2) === 0), numbers)
println("even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v1((number, _, _) -> ((number % 2) !== 0), numbers)
println("odd number found: ", odd_numbers_found)
# odd number found: 27

println("# using JavaScript-like Array.find() function \"array_find_v2\"")

even_number_found = array_find_v2((number, _, _) -> ((number % 2) === 0), numbers)
println("even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v2((number, _, _) -> ((number % 2) !== 0), numbers)
println("odd number found: ", odd_numbers_found)
# odd number found: 27

println("# using JavaScript-like Array.find() function \"array_find_v3\"")

even_number_found = array_find_v3((number, _, _) -> ((number % 2) === 0), numbers)
println("even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v3((number, _, _) -> ((number % 2) !== 0), numbers)
println("odd number found: ", odd_numbers_found)
# odd number found: 27

println("# using JavaScript-like Array.find() function \"array_find_v4\"")

even_number_found = array_find_v4((number, _, _) -> ((number % 2) === 0), numbers)
println("even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v4((number, _, _) -> ((number % 2) !== 0), numbers)
println("odd number found: ", odd_numbers_found)
# odd number found: 27

println("# using JavaScript-like Array.find() function \"array_find_v5\"")

even_number_found = array_find_v5((number) -> ((number % 2) === 0), numbers)
println("even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v5((number) -> ((number % 2) !== 0), numbers)
println("odd number found: ", odd_numbers_found)
# odd number found: 27

println("\n# JavaScript-like Array.find() in Julia Array of Dictionaries")

products = [
    Dict(
        "code" => "pasta",
        "price" => 321
    ),
    Dict(
        "code" => "bubble_gum",
        "price" => 233
    ),
    Dict(
        "code" => "potato_chips",
        "price" => 5
    ),
    Dict(
        "code" => "towel",
        "price" => 499
    )
]
println("products: ", json_stringify(products, pretty=true))

product_to_find = "bubble_gum"
println("product to find: $product_to_find")

println("# using JavaScript-like Array.find() function \"array_find_v1\"")

product_found = array_find_v1((product, _, _) -> (product["code"] === product_to_find), products)
println("product found: ", json_stringify(product_found, pretty=true))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

println("# using JavaScript-like Array.find() function \"array_find_v2\"")

product_found = array_find_v2((product, _, _) -> (product["code"] === product_to_find), products)
println("product found: ", json_stringify(product_found, pretty=true))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

println("# using JavaScript-like Array.find() function \"array_find_v3\"")

product_found = array_find_v3((product, _, _) -> (product["code"] === product_to_find), products)
println("product found: ", json_stringify(product_found, pretty=true))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

println("# using JavaScript-like Array.find() function \"array_find_v4\"")

product_found = array_find_v4((product, _, _) -> (product["code"] === product_to_find), products)
println("product found: ", json_stringify(product_found, pretty=true))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

println("# using JavaScript-like Array.find() function \"array_find_v5\"")

product_found = array_find_v5((product) -> (product["code"] === product_to_find), products)
println("product found: ", json_stringify(product_found, pretty=true))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }
