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

function array_find_index_v1(callback_function, an_array)
    # JavaScript-like Array.findIndex() function
    data_found_index = -1
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === true)
            data_found_index = array_item_index
            break
        end
    end
    return data_found_index
end

function array_find_index_v2(callback_function, an_array)
    # JavaScript-like Array.findIndex() function
    data_found_index = -1
    for (array_item_index, array_item) in enumerate(an_array)
        if (callback_function(array_item, array_item_index, an_array) === true)
            data_found_index = array_item_index
            break
        end
    end
    return data_found_index
end

function array_find_index_v3(callback_function, an_array)
    # JavaScript-like Array.findIndex() function
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === true)
            return array_item_index
        end
    end
    return -1
end

function array_find_index_v4(callback_function, an_array)
    # JavaScript-like Array.findIndex() function
    for (array_item_index, array_item) in enumerate(an_array)
        if (callback_function(array_item, array_item_index, an_array) === true)
            return array_item_index
        end
    end
    return -1
end

println("\n# JavaScript-like Array.findIndex() in Julia Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
println("numbers: ", json_stringify(numbers))

number_to_find = 27
println("number to find: ", number_to_find)

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v1\"")

number_found_index = array_find_index_v1((number, _, _) -> (number === number_to_find), numbers)
println("number found index: ", number_found_index)
# number found index: 3

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v2\"")

number_found_index = array_find_index_v2((number, _, _) -> (number === number_to_find), numbers)
println("number found index: ", number_found_index)
# number found index: 3

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v3\"")

number_found_index = array_find_index_v3((number, _, _) -> (number === number_to_find), numbers)
println("number found index: ", number_found_index)
# number found index: 3

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v4\"")

number_found_index = array_find_index_v4((number, _, _) -> (number === number_to_find), numbers)
println("number found index: ", number_found_index)
# number found index: 3

println("# using Julia Array.findIndex() built-in function \"findfirst\"")

number_found_index = findfirst((number) -> (number === number_to_find), numbers)
println("number found index: ", number_found_index)
# number found index: 3

println("\n# JavaScript-like Array.findIndex() in Julia Array of Dictionaries")

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

product_to_find = "pasta"
println("product to find: ", product_to_find)

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v1\"")

product_found_index = array_find_index_v1((product, _, _) -> (product["code"] === product_to_find), products)
println("product found index: ", product_found_index)
# product found index: 1

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v2\"")

product_found_index = array_find_index_v2((product, _, _) -> (product["code"] === product_to_find), products)
println("product found index: ", product_found_index)
# product found index: 1

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v3\"")

product_found_index = array_find_index_v3((product, _, _) -> (product["code"] === product_to_find), products)
println("product found index: ", product_found_index)
# product found index: 1

println("# using JavaScript-like Array.findIndex() function \"array_find_index_v4\"")

product_found_index = array_find_index_v4((product, _, _) -> (product["code"] === product_to_find), products)
println("product found index: ", product_found_index)
# product found index: 1

println("# using Julia Array.findIndex() built-in function \"findfirst\"")

product_found_index = findfirst((product) -> (product["code"] === product_to_find), products)
println("product found index: ", product_found_index)
# product found index: 1
