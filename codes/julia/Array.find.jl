using Printf
using Statistics
using JSON

# There's no JavaScript-like Array.find() in Julia.
# But, we can create our own function to mimic it in Julia.

pretty_array_of_primitives = (an_array_of_primitives) -> string("[", join(an_array_of_primitives, ", "), "]")

function array_find_v1(callback_function, an_array)
    # JavaScript-like Array.find() function
    data_found = nothing
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if is_condition_match === true
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
        if callback_function(array_item, array_item_index, an_array) === true
            data_found = array_item
            break
        end
    end
    return data_found
end

function array_find_v3(callback_function, an_array)
    # JavaScript-like Array.find() function
    data_found = nothing
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if is_condition_match === true
            return array_item
        end
    end
    return data_found
end

function array_find_v4(callback_function, an_array)
    # JavaScript-like Array.find() function
    data_found = nothing
    for (array_item_index, array_item) in enumerate(an_array)
        if callback_function(array_item, array_item_index, an_array) === true
            return array_item
        end
    end
    return data_found
end

function array_find_v5(callback_function, an_array)
    # JavaScript-like Array.find() function
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if is_condition_match === true
            return array_item
        end
    end
    return nothing
end

function array_find_v6(callback_function, an_array)
    # JavaScript-like Array.find() function
    for (array_item_index, array_item) in enumerate(an_array)
        if callback_function(array_item, array_item_index, an_array) === true
            return array_item
        end
    end
    return nothing
end

function array_find_v7(callback_function, an_array)
    # JavaScript-like Array.find() callback_function
    data_found_index = findfirst(callback_function, an_array)
    return ((data_found_index === nothing) ? nothing : an_array[data_found_index])
end

println("\n# JavaScript-like Array.find() in Julia Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
println("numbers: ", pretty_array_of_primitives(numbers))

println("# using JavaScript-like Array.find() function \"array_find_v1\"")

even_number_found = array_find_v1((number, _, _) -> ((number % 2) === 0), numbers)
println("even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v1((number, _, _) -> ((number % 2) != 0), numbers)
println("odd number found: ", odd_numbers_found)
# odd number found: 27

println("# using JavaScript-like Array.find() function \"array_find_v2\"")

even_number_found = array_find_v2((number, _, _) -> ((number % 2) === 0), numbers)
println("even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v2((number, _, _) -> ((number % 2) != 0), numbers)
println("odd number found: ", odd_numbers_found)
# odd number found: 27

println("# using JavaScript-like Array.find() function \"array_find_v3\"")

even_number_found = array_find_v3((number, _, _) -> ((number % 2) === 0), numbers)
println("even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v3((number, _, _) -> ((number % 2) != 0), numbers)
println("odd number found: ", odd_numbers_found)
# odd number found: 27

println("# using JavaScript-like Array.find() function \"array_find_v4\"")

even_number_found = array_find_v4((number, _, _) -> ((number % 2) === 0), numbers)
println("even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v4((number, _, _) -> ((number % 2) != 0), numbers)
println("odd number found: ", odd_numbers_found)
# odd number found: 27

println("# using JavaScript-like Array.find() function \"array_find_v5\"")

even_number_found = array_find_v5((number, _, _) -> ((number % 2) === 0), numbers)
println("even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v5((number, _, _) -> ((number % 2) != 0), numbers)
println("odd number found: ", odd_numbers_found)
# odd number found: 27

println("# using JavaScript-like Array.find() function \"array_find_v6\"")

even_number_found = array_find_v6((number, _, _) -> ((number % 2) === 0), numbers)
println("even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v6((number, _, _) -> ((number % 2) != 0), numbers)
println("odd number found: ", odd_numbers_found)
# odd number found: 27

println("# using JavaScript-like Array.find() function \"array_find_v7\"")

even_number_found = array_find_v7((number) -> ((number % 2) === 0), numbers)
println("even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v7((number) -> ((number % 2) != 0), numbers)
println("odd number found: ", odd_numbers_found)
# odd number found: 27

println("\n# JavaScript-like Array.find() in Julia Array of Dicts")

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
println("products: ", JSON.json(products, 4))

println("# using JavaScript-like Array.find() function \"array_find_v1\"")

product_found = array_find_v1((product, _, _) -> (product["code"] === "bubble_gum"), products)
println("product found: ", JSON.json(product_found, 4))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

println("# using JavaScript-like Array.find() function \"array_find_v2\"")

product_found = array_find_v2((product, _, _) -> (product["code"] === "bubble_gum"), products)
println("product found: ", JSON.json(product_found, 4))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

println("# using JavaScript-like Array.find() function \"array_find_v3\"")

product_found = array_find_v3((product, _, _) -> (product["code"] === "bubble_gum"), products)
println("product found: ", JSON.json(product_found, 4))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

println("# using JavaScript-like Array.find() function \"array_find_v4\"")

product_found = array_find_v4((product, _, _) -> (product["code"] === "bubble_gum"), products)
println("product found: ", JSON.json(product_found, 4))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

println("# using JavaScript-like Array.find() function \"array_find_v5\"")

product_found = array_find_v5((product, _, _) -> (product["code"] === "bubble_gum"), products)
println("product found: ", JSON.json(product_found, 4))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

println("# using JavaScript-like Array.find() function \"array_find_v6\"")

product_found = array_find_v6((product, _, _) -> (product["code"] === "bubble_gum"), products)
println("product found: ", JSON.json(product_found, 4))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

println("# using JavaScript-like Array.find() function \"array_find_v7\"")

product_found = array_find_v7((product) -> (product["code"] === "bubble_gum"), products)
println("product found: ", JSON.json(product_found, 4))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }
