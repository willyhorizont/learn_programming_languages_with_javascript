using Printf
using Statistics
using JSON

pretty_array_of_primitives = (an_array_of_primitives) -> string("[", join(an_array_of_primitives, ", "), "]")

function array_map_v1(callback_function, an_array)
    # JavaScript-like Array.map() function
    new_array = []
    for (array_item_index, array_item) in enumerate(an_array)
        new_array_item = callback_function(array_item, array_item_index, an_array)
        push!(new_array, new_array_item)
    end
    return new_array
end

function array_map_v2(callback_function, an_array)
    # JavaScript-like Array.map() function
    new_array = []
    for (array_item_index, array_item) in enumerate(an_array)
        new_array_item = callback_function(array_item, array_item_index, an_array)
        append!(new_array, [new_array_item])
    end
    return new_array
end

function array_map_v3(callback_function, an_array)
    # JavaScript-like Array.map() function
    new_array = []
    for (array_item_index, array_item) in enumerate(an_array)
        new_array_item = callback_function(array_item, array_item_index, an_array)
        new_array = [new_array; [new_array_item]]
    end
    return new_array
end

function array_map_v4(callback_function, an_array)
    # JavaScript-like Array.map() function
    new_array = []
    for (array_item_index, array_item) in enumerate(an_array)
        new_array_item = callback_function(array_item, array_item_index, an_array)
        new_array = vcat(new_array, new_array_item)
    end
    return new_array
end

function array_map_v5(callback_function, an_array)
    # JavaScript-like Array.map() function
    new_array = []
    for (array_item_index, array_item) in enumerate(an_array)
        push!(new_array, callback_function(array_item, array_item_index, an_array))
    end
    return new_array
end

function array_map_v6(callback_function, an_array)
    # JavaScript-like Array.map() function
    new_array = []
    for (array_item_index, array_item) in enumerate(an_array)
        append!(new_array, [callback_function(array_item, array_item_index, an_array)])
    end
    return new_array
end

function array_map_v7(callback_function, an_array)
    # JavaScript-like Array.map() function
    new_array = []
    for (array_item_index, array_item) in enumerate(an_array)
        new_array = [new_array; [callback_function(array_item, array_item_index, an_array)]]
    end
    return new_array
end

function array_map_v8(callback_function, an_array)
    # JavaScript-like Array.map() function
    new_array = []
    for (array_item_index, array_item) in enumerate(an_array)
        new_array = vcat(new_array, callback_function(array_item, array_item_index, an_array))
    end
    return new_array
end

function array_map_v9(callback_function, an_array)
    # JavaScript-like Array.map() function
    return [callback_function(array_item, array_item_index, an_array) for (array_item_index, array_item) in enumerate(an_array)]
end

# JavaScript-like Array.map() function
array_map_v10 = (callback_function, an_array) -> [callback_function(array_item, array_item_index, an_array) for (array_item_index, array_item) in enumerate(an_array)]

println("\n# JavaScript-like Array.map() in Julia Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
println("numbers: ", pretty_array_of_primitives(numbers))

println("# using JavaScript-like Array.map() function \"array_map_v1\"")

numbers_labeled = array_map_v1((number, _, _) -> Dict(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", JSON.json(numbers_labeled, 4))
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

numbers_labeled = array_map_v2((number, _, _) -> Dict(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", JSON.json(numbers_labeled, 4))
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

numbers_labeled = array_map_v3((number, _, _) -> Dict(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", JSON.json(numbers_labeled, 4))
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

numbers_labeled = array_map_v4((number, _, _) -> Dict(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", JSON.json(numbers_labeled, 4))
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

println("# using JavaScript-like Array.map() function \"array_map_v5\"")

numbers_labeled = array_map_v5((number, _, _) -> Dict(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", JSON.json(numbers_labeled, 4))
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

println("# using JavaScript-like Array.map() function \"array_map_v6\"")

numbers_labeled = array_map_v6((number, _, _) -> Dict(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", JSON.json(numbers_labeled, 4))
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

println("# using JavaScript-like Array.map() function \"array_map_v7\"")

numbers_labeled = array_map_v7((number, _, _) -> Dict(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", JSON.json(numbers_labeled, 4))
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

println("# using JavaScript-like Array.map() function \"array_map_v8\"")

numbers_labeled = array_map_v8((number, _, _) -> Dict(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", JSON.json(numbers_labeled, 4))
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

println("# using JavaScript-like Array.map() function \"array_map_v9\"")

numbers_labeled = array_map_v9((number, _, _) -> Dict(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", JSON.json(numbers_labeled, 4))
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

println("# using JavaScript-like Array.map() function \"array_map_v10\"")

numbers_labeled = array_map_v10((number, _, _) -> Dict(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", JSON.json(numbers_labeled, 4))
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

numbers_labeled = map((number) -> Dict(string(number) => (((number % 2) === 0) ? "even" : "odd")), numbers)
println("labeled numbers: ", JSON.json(numbers_labeled, 4))
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

println("\n# JavaScript-like Array.map() in Julia Array of Dicts")

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

println("# using JavaScript-like Array.map() function \"array_map_v1\"")

products_labeled = array_map_v1((product, _, _) -> merge(product, Dict("label" => ((product["price"] > 100) ? "expensive" : "cheap"))), products)
println("labeled products: ", JSON.json(products_labeled, 4))
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

products_labeled = array_map_v2((product, _, _) -> merge(product, Dict("label" => ((product["price"] > 100) ? "expensive" : "cheap"))), products)
println("labeled products: ", JSON.json(products_labeled, 4))
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

products_labeled = array_map_v3((product, _, _) -> merge(product, Dict("label" => ((product["price"] > 100) ? "expensive" : "cheap"))), products)
println("labeled products: ", JSON.json(products_labeled, 4))
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

products_labeled = array_map_v4((product, _, _) -> merge(product, Dict("label" => ((product["price"] > 100) ? "expensive" : "cheap"))), products)
println("labeled products: ", JSON.json(products_labeled, 4))
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

println("# using JavaScript-like Array.map() function \"array_map_v5\"")

products_labeled = array_map_v5((product, _, _) -> merge(product, Dict("label" => ((product["price"] > 100) ? "expensive" : "cheap"))), products)
println("labeled products: ", JSON.json(products_labeled, 4))
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

println("# using JavaScript-like Array.map() function \"array_map_v6\"")

products_labeled = array_map_v6((product, _, _) -> merge(product, Dict("label" => ((product["price"] > 100) ? "expensive" : "cheap"))), products)
println("labeled products: ", JSON.json(products_labeled, 4))
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

println("# using JavaScript-like Array.map() function \"array_map_v7\"")

products_labeled = array_map_v7((product, _, _) -> merge(product, Dict("label" => ((product["price"] > 100) ? "expensive" : "cheap"))), products)
println("labeled products: ", JSON.json(products_labeled, 4))
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

println("# using JavaScript-like Array.map() function \"array_map_v8\"")

products_labeled = array_map_v8((product, _, _) -> merge(product, Dict("label" => ((product["price"] > 100) ? "expensive" : "cheap"))), products)
println("labeled products: ", JSON.json(products_labeled, 4))
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

println("# using JavaScript-like Array.map() function \"array_map_v9\"")

products_labeled = array_map_v9((product, _, _) -> merge(product, Dict("label" => ((product["price"] > 100) ? "expensive" : "cheap"))), products)
println("labeled products: ", JSON.json(products_labeled, 4))
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

println("# using JavaScript-like Array.map() function \"array_map_v10\"")

products_labeled = array_map_v10((product, _, _) -> merge(product, Dict("label" => ((product["price"] > 100) ? "expensive" : "cheap"))), products)
println("labeled products: ", JSON.json(products_labeled, 4))
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

products_labeled = map((product) -> merge(product, Dict("label" => ((product["price"] > 100) ? "expensive" : "cheap"))), products)
println("labeled products: ", JSON.json(products_labeled, 4))
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