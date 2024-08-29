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

function array_map_v1(callback_function, an_array)
    # JavaScript-like Array.map() function
    new_array::Any = Any[]
    for (array_item_index, array_item) in enumerate(an_array)
        new_array_item::Any = callback_function(array_item, array_item_index, an_array)
        new_array = Any[new_array..., new_array_item]
    end
    return new_array
end

function array_map_v2(callback_function, an_array)
    # JavaScript-like Array.map() function
    new_array::Any = Any[]
    for (array_item_index, array_item) in enumerate(an_array)
        new_array = Any[new_array..., callback_function(array_item, array_item_index, an_array)]
    end
    return new_array
end

function array_map_v3(callback_function, an_array)
    # JavaScript-like Array.map() function
    return Any[callback_function(array_item, array_item_index, an_array) for (array_item_index, array_item) in enumerate(an_array)]
end

# JavaScript-like Array.map() function
array_map_v4::Any = (callback_function, an_array) -> Any[callback_function(array_item, array_item_index, an_array) for (array_item_index, array_item) in enumerate(an_array)]

println("\n# JavaScript-like Array.map() in Julia Array")

numbers::Any = Any[12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
println("numbers: ", json_stringify(numbers))

println("# using JavaScript-like Array.map() function \"array_map_v1\"")

numbers_labeled::Any = array_map_v1((number, _, _) -> Dict{String, Any}(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", json_stringify(numbers_labeled, pretty=true))
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

println("# using JavaScript-like Array.map() function \"array_map_v2\"")

numbers_labeled::Any = array_map_v2((number, _, _) -> Dict{String, Any}(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", json_stringify(numbers_labeled, pretty=true))
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

println("# using JavaScript-like Array.map() function \"array_map_v3\"")

numbers_labeled::Any = array_map_v3((number, _, _) -> Dict{String, Any}(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", json_stringify(numbers_labeled, pretty=true))
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

println("# using JavaScript-like Array.map() function \"array_map_v4\"")

numbers_labeled::Any = array_map_v4((number, _, _) -> Dict{String, Any}(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", json_stringify(numbers_labeled, pretty=true))
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

println("# using Julia Array.map() built-in function \"map\"")

numbers_labeled::Any = map((number) -> Dict{String, Any}(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", json_stringify(numbers_labeled, pretty=true))
# labeled numbers: [
#     {
#         "12": "even"
#     },
#     {
#         "34": "even"
#     },
#     {
#         "27": "odd"
#     },
#     {
#         "23": "odd"
#     },
#     {
#         "65": "odd"
#     },
#     {
#         "93": "odd"
#     },
#     {
#         "36": "even"
#     },
#     {
#         "87": "odd"
#     },
#     {
#         "4": "even"
#     },
#     {
#         "254": "even"
#     }
# ]

println("\n# JavaScript-like Array.map() in Julia Array of Dictionaries")

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

println("# using JavaScript-like Array.map() function \"array_map_v1\"")

products_labeled::Any = array_map_v1((product, _, _) -> Dict{String, Any}(product..., "label" => ((product["price"] > 100) ? "expensive" : "cheap")), products)
println("labeled products: ", json_stringify(products_labeled, pretty=true))
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

println("# using JavaScript-like Array.map() function \"array_map_v2\"")

products_labeled::Any = array_map_v2((product, _, _) -> Dict{String, Any}(product..., "label" => ((product["price"] > 100) ? "expensive" : "cheap")), products)
println("labeled products: ", json_stringify(products_labeled, pretty=true))
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

println("# using JavaScript-like Array.map() function \"array_map_v3\"")

products_labeled::Any = array_map_v3((product, _, _) -> Dict{String, Any}(product..., "label" => ((product["price"] > 100) ? "expensive" : "cheap")), products)
println("labeled products: ", json_stringify(products_labeled, pretty=true))
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

println("# using JavaScript-like Array.map() function \"array_map_v4\"")

products_labeled::Any = array_map_v4((product, _, _) -> Dict{String, Any}(product..., "label" => ((product["price"] > 100) ? "expensive" : "cheap")), products)
println("labeled products: ", json_stringify(products_labeled, pretty=true))
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]

println("# using Julia Array.map() built-in function \"map\"")

products_labeled::Any = map((product) -> Dict{String, Any}(product..., "label" => ((product["price"] > 100) ? "expensive" : "cheap")), products)
println("labeled products: ", json_stringify(products_labeled, pretty=true))
# labeled products: [
#     {
#         "code": "pasta",
#         "price": 321,
#         "label": "expensive"
#     },
#     {
#         "code": "bubble_gum",
#         "price": 233,
#         "label": "expensive"
#     },
#     {
#         "code": "potato_chips",
#         "price": 5,
#         "label": "cheap"
#     },
#     {
#         "code": "towel",
#         "price": 499,
#         "label": "expensive"
#     }
# ]
