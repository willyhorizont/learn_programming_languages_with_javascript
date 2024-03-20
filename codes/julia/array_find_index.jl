using JSON

function pretty_array_of_primitives(an_array_of_primitives)
    result = "["
    for (array_item_index, array_item) in enumerate(an_array_of_primitives)
        if ((isa(array_item, AbstractString) === false) && (isa(array_item, Number) === false) && (isa(array_item, Bool) === false) && array_item !== nothing)
            continue
        end
        if (isa(array_item, AbstractString) === true)
            result = string(result, "\"", array_item, "\"")
        end
        if (array_item === nothing)
            result = string(result, "null")
        end
        if ((isa(array_item, Number) === true) || (isa(array_item, Bool) === true))
            result = string(result, array_item)
        end
        if (array_item_index !== length(an_array_of_primitives))
            result = string(result, ", ")
        end
    end
    result = string(result, "]")
    return result
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
println("numbers: ", pretty_array_of_primitives(numbers))

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
println("products: ", chomp(JSON.json(products, 4)))

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
