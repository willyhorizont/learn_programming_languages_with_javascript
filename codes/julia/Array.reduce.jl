using Printf
using Statistics
using JSON

pretty_array_of_primitives = (an_array_of_primitives) -> string("[", join(an_array_of_primitives, ", "), "]")

function array_reduce(callback_function, an_array, initial_value)
    # JavaScript-like Array.reduce() function
    result = nothing
    for (array_item_index, array_item) in enumerate(an_array)
        result = ((result === nothing) ? initial_value : result)
        if isa(initial_value, AbstractArray)
            result = ((result === nothing) ? [] : result)
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        end
        if isa(initial_value, AbstractDict)
            result = ((result === nothing) ? Dict() : result)
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        end
        if isa(initial_value, Number)
            result = ((result === nothing) ? 0 : result)
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        end
        if isa(initial_value, AbstractString)
            result = ((result === nothing) ? "" : result)
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        end
        if isa(initial_value, Bool)
            result = ((result === nothing) ? false : result)
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        end
        if initial_value === nothing
            result = ((result === nothing) ? nothing : result)
            result = callback_function(result, array_item, array_item_index, an_array)
            continue
        end
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

products_grouped = array_reduce((current_result, current_product, _, _) -> ((current_product["price"] > 100) ? merge(current_result, Dict("expensive" => vcat(current_result["expensive"], current_product))) : merge(current_result, Dict("cheap" => vcat(current_result["cheap"], current_product)))), products, Dict("expensive" => [], "cheap" => []))
println("grouped products: ", JSON.json(products_grouped, 4))
# grouped products: {
#     "expensive": [
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
#             "code": "pasta",
#             "price": 30
#         },
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }

println("# using Julia Array.reduce() built-in function \"reduce\"")

products_grouped = reduce((current_result, current_product) -> ((current_product["price"] > 100) ? merge(current_result, Dict("expensive" => vcat(current_result["expensive"], current_product))) : merge(current_result, Dict("cheap" => vcat(current_result["cheap"], current_product)))), products; init=Dict("expensive" => [], "cheap" => []))
println("grouped products: ", JSON.json(products_grouped, 4))
# grouped products: {
#     "expensive": [
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
#             "code": "pasta",
#             "price": 30
#         },
#         {
#             "code": "potato_chips",
#             "price": 5
#         }
#     ]
# }
