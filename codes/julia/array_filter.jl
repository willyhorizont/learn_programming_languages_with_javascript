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

function array_filter_v1(callback_function, an_array)
    # JavaScript-like Array.filter() function
    data_filtered::Any = Any[]
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match::Any = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === true)
            data_filtered = Any[data_filtered..., array_item]
        end
    end
    return data_filtered
end

function array_filter_v2(callback_function, an_array)
    # JavaScript-like Array.filter() function
    data_filtered::Any = Any[]
    for (array_item_index, array_item) in enumerate(an_array)
        if (callback_function(array_item, array_item_index, an_array) === true)
            data_filtered = Any[data_filtered..., array_item]
        end
    end
    return data_filtered
end

function array_filter_v3(callback_function, an_array)
    # JavaScript-like Array.filter() function
    return Any[array_item for (array_item_index, array_item) in enumerate(an_array) if (callback_function(array_item, array_item_index, an_array) === true)]
end

# JavaScript-like Array.filter() function
array_filter_v4::Any = (callback_function, an_array) -> Any[array_item for (array_item_index, array_item) in enumerate(an_array) if (callback_function(array_item, array_item_index, an_array) === true)]

println("\n# JavaScript-like Array.filter() in Julia Array")

numbers::Any = Any[12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
println("numbers: ", json_stringify(numbers))

println("# using JavaScript-like Array.filter() function \"array_filter_v1\"")

numbers_even::Any = array_filter_v1((number, _, _) -> ((number % 2) === 0), numbers)
println("even numbers only: ", json_stringify(numbers_even))
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd::Any = array_filter_v1((number, _, _) -> ((number % 2) !== 0), numbers)
println("odd numbers only: ", json_stringify(numbers_odd))
# odd numbers only: [27, 23, 65, 93, 87]

println("# using JavaScript-like Array.filter() function \"array_filter_v2\"")

numbers_even::Any = array_filter_v2((number, _, _) -> ((number % 2) === 0), numbers)
println("even numbers only: ", json_stringify(numbers_even))
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd::Any = array_filter_v2((number, _, _) -> ((number % 2) !== 0), numbers)
println("odd numbers only: ", json_stringify(numbers_odd))
# odd numbers only: [27, 23, 65, 93, 87]

println("# using JavaScript-like Array.filter() function \"array_filter_v3\"")

numbers_even::Any = array_filter_v3((number, _, _) -> ((number % 2) === 0), numbers)
println("even numbers only: ", json_stringify(numbers_even))
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd::Any = array_filter_v3((number, _, _) -> ((number % 2) !== 0), numbers)
println("odd numbers only: ", json_stringify(numbers_odd))
# odd numbers only: [27, 23, 65, 93, 87]

println("# using JavaScript-like Array.filter() function \"array_filter_v4\"")

numbers_even::Any = array_filter_v4((number, _, _) -> ((number % 2) === 0), numbers)
println("even numbers only: ", json_stringify(numbers_even))
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd::Any = array_filter_v4((number, _, _) -> ((number % 2) !== 0), numbers)
println("odd numbers only: ", json_stringify(numbers_odd))
# odd numbers only: [27, 23, 65, 93, 87]

println("# using Julia Array.filter() built-in function \"filter\"")

numbers_even::Any = filter((number) -> ((number % 2) === 0), numbers)
println("even numbers only: ", json_stringify(numbers_even))
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd::Any = filter((number) -> ((number % 2) !== 0), numbers)
println("odd numbers only: ", json_stringify(numbers_odd))
# odd numbers only: [27, 23, 65, 93, 87]

println("\n# JavaScript-like Array.filter() in Julia Array of Dictionaries")

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

println("# using JavaScript-like Array.filter() function \"array_filter_v1\"")

products_below_100::Any = array_filter_v1((product, _, _) -> (product["price"] <= 100), products)
println("products with price <= 100 only: ", json_stringify(products_below_100, pretty=true))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100::Any = array_filter_v1((product, _, _) -> (product["price"]  > 100), products)
println("products with price > 100 only: ", json_stringify(products_above_100, pretty=true))
# products with price > 100 only: [
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

products_below_100::Any = array_filter_v2((product, _, _) -> (product["price"] <= 100), products)
println("products with price <= 100 only: ", json_stringify(products_below_100, pretty=true))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100::Any = array_filter_v2((product, _, _) -> (product["price"]  > 100), products)
println("products with price > 100 only: ", json_stringify(products_above_100, pretty=true))
# products with price > 100 only: [
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

products_below_100::Any = array_filter_v3((product, _, _) -> (product["price"] <= 100), products)
println("products with price <= 100 only: ", json_stringify(products_below_100, pretty=true))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100::Any = array_filter_v3((product, _, _) -> (product["price"]  > 100), products)
println("products with price > 100 only: ", json_stringify(products_above_100, pretty=true))
# products with price > 100 only: [
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

products_below_100::Any = array_filter_v4((product, _, _) -> (product["price"] <= 100), products)
println("products with price <= 100 only: ", json_stringify(products_below_100, pretty=true))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100::Any = array_filter_v4((product, _, _) -> (product["price"]  > 100), products)
println("products with price > 100 only: ", json_stringify(products_above_100, pretty=true))
# products with price > 100 only: [
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

products_below_100::Any = filter((product) -> (product["price"] <= 100), products)
println("products with price <= 100 only: ", json_stringify(products_below_100, pretty=true))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100::Any = filter((product) -> (product["price"]  > 100), products)
println("products with price > 100 only: ", json_stringify(products_above_100, pretty=true))
# products with price > 100 only: [
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
