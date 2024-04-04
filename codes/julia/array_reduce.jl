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

function array_reduce(callback_function, an_array, initial_value)
    # JavaScript-like Array.reduce() function
    result = initial_value
    for (array_item_index, array_item) in enumerate(an_array)
        result = callback_function(result, array_item, array_item_index, an_array)
    end
    return result
end

println("\n# JavaScript-like Array.reduce() in Julia Array")

numbers = [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3]
println("numbers: ", json_stringify(numbers))

println("# using JavaScript-like Array.reduce() function \"array_reduce\"")

numbers_total = array_reduce((current_result, current_number, _, _) -> (current_result + current_number), numbers, 0)
println("total number: ", numbers_total)
# total number: 41.2

println("# using Julia Array.reduce() built-in function \"reduce\"")

numbers_total = reduce((current_result, current_number) -> (current_result + current_number), numbers; init=0)
println("total number: ", numbers_total)
# total number: 41.2

println("# using Julia Array.reduce() built-in function \"foldl\"")

numbers_total = foldl((current_result, current_number) -> (current_result + current_number), numbers; init=0)
println("total number: ", numbers_total)
# total number: 41.2

println("\n# JavaScript-like Array.reduce() in Julia Array of Dictionaries")

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

println("# using JavaScript-like Array.reduce() function \"array_reduce\"")

products_grouped = array_reduce((current_result, current_product, _, _) -> ((current_product["price"] > 100) ? Dict(current_result..., "expensive" => [current_result["expensive"]..., current_product]) : Dict(current_result..., "cheap" => [current_result["cheap"]..., current_product])), products, Dict("expensive" => [], "cheap" => []))
println("grouped products: ", json_stringify(products_grouped, pretty=true))
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
println("grouped products: ", json_stringify(products_grouped, pretty=true))
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
println("grouped products: ", json_stringify(products_grouped, pretty=true))
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
