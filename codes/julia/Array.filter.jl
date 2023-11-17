using Printf
using Statistics
using JSON

function pretty_array_of_primitives(an_array_of_primitives)
    result = "["
    for (array_item_index, array_item) in enumerate(an_array_of_primitives)
        if ((isa(array_item, AbstractString) === false) && (isa(array_item, Number) === false))
            continue
        end
        if (isa(array_item, AbstractString) === true)
            result = string(result, "\"", array_item, "\"")
        end
        if (isa(array_item, Number) === true)
            result = string(result, array_item)
        end
        if (array_item_index !== length(an_array_of_primitives))
            result = string(result, ", ")
        end
    end
    result = string(result, "]")
    return result
end

function array_filter_v1(callback_function, an_array)
    # JavaScript-like Array.filter() function
    data_filtered = []
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === true)
            data_filtered = [data_filtered..., array_item]
        end
    end
    return data_filtered
end

function array_filter_v2(callback_function, an_array)
    # JavaScript-like Array.filter() function
    data_filtered = []
    for (array_item_index, array_item) in enumerate(an_array)
        if (callback_function(array_item, array_item_index, an_array) === true)
            data_filtered = [data_filtered..., array_item]
        end
    end
    return data_filtered
end

function array_filter_v3(callback_function, an_array)
    # JavaScript-like Array.filter() function
    return [array_item for (array_item_index, array_item) in enumerate(an_array) if (callback_function(array_item, array_item_index, an_array) === true)]
end

# JavaScript-like Array.filter() function
array_filter_v4 = (callback_function, an_array) -> [array_item for (array_item_index, array_item) in enumerate(an_array) if (callback_function(array_item, array_item_index, an_array) === true)]

println("\n# JavaScript-like Array.filter() in Julia Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
println("numbers: ", pretty_array_of_primitives(numbers))

println("# using JavaScript-like Array.filter() function \"array_filter_v1\"")

numbers_even = array_filter_v1((number, _, _) -> ((number % 2) === 0), numbers)
println("even numbers only: ", pretty_array_of_primitives(numbers_even))
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v1((number, _, _) -> ((number % 2) !== 0), numbers)
println("odd numbers only: ", pretty_array_of_primitives(numbers_odd))
# odd numbers only: [27, 23, 65, 93, 87]

println("# using JavaScript-like Array.filter() function \"array_filter_v2\"")

numbers_even = array_filter_v2((number, _, _) -> ((number % 2) === 0), numbers)
println("even numbers only: ", pretty_array_of_primitives(numbers_even))
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v2((number, _, _) -> ((number % 2) !== 0), numbers)
println("odd numbers only: ", pretty_array_of_primitives(numbers_odd))
# odd numbers only: [27, 23, 65, 93, 87]

println("# using JavaScript-like Array.filter() function \"array_filter_v3\"")

numbers_even = array_filter_v3((number, _, _) -> ((number % 2) === 0), numbers)
println("even numbers only: ", pretty_array_of_primitives(numbers_even))
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v3((number, _, _) -> ((number % 2) !== 0), numbers)
println("odd numbers only: ", pretty_array_of_primitives(numbers_odd))
# odd numbers only: [27, 23, 65, 93, 87]

println("# using JavaScript-like Array.filter() function \"array_filter_v4\"")

numbers_even = array_filter_v4((number, _, _) -> ((number % 2) === 0), numbers)
println("even numbers only: ", pretty_array_of_primitives(numbers_even))
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v4((number, _, _) -> ((number % 2) !== 0), numbers)
println("odd numbers only: ", pretty_array_of_primitives(numbers_odd))
# odd numbers only: [27, 23, 65, 93, 87]

println("# using Julia Array.filter() built-in function \"filter\"")

numbers_even = filter((number) -> ((number % 2) === 0), numbers)
println("even numbers only: ", pretty_array_of_primitives(numbers_even))
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = filter((number) -> ((number % 2) !== 0), numbers)
println("odd numbers only: ", pretty_array_of_primitives(numbers_odd))
# odd numbers only: [27, 23, 65, 93, 87]

println("\n# JavaScript-like Array.filter() in Julia Array of Dicts")

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

println("# using JavaScript-like Array.filter() function \"array_filter_v1\"")

products_below_100 = array_filter_v1((product, _, _) -> (product["price"] <= 100), products)
println("products with price <= 100 only: ", JSON.json(products_below_100, 4))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v1((product, _, _) -> (product["price"]  >= 100), products)
println("products with price >= 100 only: ", JSON.json(products_above_100, 4))
# products with price >= 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

println("# using JavaScript-like Array.filter() function \"array_filter_v2\"")

products_below_100 = array_filter_v2((product, _, _) -> (product["price"] <= 100), products)
println("products with price <= 100 only: ", JSON.json(products_below_100, 4))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v2((product, _, _) -> (product["price"]  >= 100), products)
println("products with price >= 100 only: ", JSON.json(products_above_100, 4))
# products with price >= 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

println("# using JavaScript-like Array.filter() function \"array_filter_v3\"")

products_below_100 = array_filter_v3((product, _, _) -> (product["price"] <= 100), products)
println("products with price <= 100 only: ", JSON.json(products_below_100, 4))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v3((product, _, _) -> (product["price"]  >= 100), products)
println("products with price >= 100 only: ", JSON.json(products_above_100, 4))
# products with price >= 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

println("# using JavaScript-like Array.filter() function \"array_filter_v4\"")

products_below_100 = array_filter_v4((product, _, _) -> (product["price"] <= 100), products)
println("products with price <= 100 only: ", JSON.json(products_below_100, 4))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v4((product, _, _) -> (product["price"]  >= 100), products)
println("products with price >= 100 only: ", JSON.json(products_above_100, 4))
# products with price >= 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]

println("# using Julia Array.filter() built-in function \"filter\"")

products_below_100 = filter((product) -> (product["price"] <= 100), products)
println("products with price <= 100 only: ", JSON.json(products_below_100, 4))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = filter((product) -> (product["price"]  >= 100), products)
println("products with price >= 100 only: ", JSON.json(products_above_100, 4))
# products with price >= 100 only: [
#     {
#         "code": "pasta",
#         "price": 321
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233
#     },
#     {
#         "code": "towel",
#         "price": 499
#     }
# ]
