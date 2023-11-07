using Printf
using Statistics
using JSON

function pretty_array_of_primitives(an_array_of_primitives)
    result = "["
    for (array_item_index, array_item) in enumerate(an_array_of_primitives)
        if isa(array_item, AbstractString) === false && isa(array_item, Number) === false
            continue
        end
        if isa(array_item, AbstractString) === true
            result = string(result, "\"", array_item, "\"")
        end
        if isa(array_item, Number) === true
            result = string(result, array_item)
        end
        if array_item_index != length(an_array_of_primitives)
            result = string(result, ", ")
        end
    end
    result = string(result, "]")
    return result
end

function array_reduce(callback_function, an_array, initial_value)
    # JavaScript-like Array.reduce() function
    result = nothing
    for (array_item_index, array_item) in enumerate(an_array)
        result = callback_function(((array_item_index === 1) ? initial_value : result), array_item, array_item_index, an_array)
    end
    return result
end

println("\n# JavaScript-like Array.reduce() in Julia Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
println("numbers: ", pretty_array_of_primitives(numbers))

println("# using JavaScript-like Array.reduce() function \"array_reduce\"")

numbers_total = array_reduce((current_result, current_number, _, _) -> (current_result + current_number), numbers, 0)
println("total number: ", numbers_total)
# total number: 635

println("# using Julia Array.reduce() built-in function \"reduce\"")

numbers_total = reduce((current_result, current_number) -> (current_result + current_number), numbers; init=0)
println("total number: ", numbers_total)
# total number: 635

println("# using Julia Array.reduce() built-in function \"foldl\"")

numbers_total = foldl((current_result, current_number) -> (current_result + current_number), numbers; init=0)
println("total number: ", numbers_total)
# total number: 635

println("\n# JavaScript-like Array.reduce() in Julia Array of Dicts")

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

println("# using JavaScript-like Array.reduce() function \"array_reduce\"")

products_grouped = array_reduce((current_result, current_product, _, _) -> ((current_product["price"] > 100) ? Dict(current_result..., "expensive" => [current_result["expensive"]..., current_product]) : Dict(current_result..., "cheap" => [current_result["cheap"]..., current_product])), products, Dict("expensive" => [], "cheap" => []))
println("grouped products: ", JSON.json(products_grouped, 4))
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }

println("# using Julia Array.reduce() built-in function \"reduce\"")

products_grouped = reduce((current_result, current_product) -> ((current_product["price"] > 100) ? Dict(current_result..., "expensive" => [current_result["expensive"]..., current_product]) : Dict(current_result..., "cheap" => [current_result["cheap"]..., current_product])), products; init=Dict("expensive" => [], "cheap" => []))
println("grouped products: ", JSON.json(products_grouped, 4))
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }

println("# using Julia Array.reduce() built-in function \"foldl\"")

products_grouped = foldl((current_result, current_product) -> ((current_product["price"] > 100) ? Dict(current_result..., "expensive" => [current_result["expensive"]..., current_product]) : Dict(current_result..., "cheap" => [current_result["cheap"]..., current_product])), products; init=Dict("expensive" => [], "cheap" => []))
println("grouped products: ", JSON.json(products_grouped, 4))
# grouped products: {
#     "expensive": [
#         {
#             "code": "pasta",
#             "price": 321
#         },
#         {
#             "code": "bubble_gum",
#             "price": 233
#         },
#         {
#             "code": "towel",
#             "price": 499
#         }
#     ],
#     "cheap": [
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }
