require 'json'

array_map_v1 = ->(callback_function, an_array) do
    # JavaScript-like Array.map() function
    new_array = []
    an_array.each_with_index do |array_item, array_item_index|
        new_array_item = callback_function.(array_item, array_item_index, an_array)
        new_array = [*new_array, new_array_item]
    end
    return new_array
end

array_map_v2 = ->(callback_function, an_array) do
    # JavaScript-like Array.map() function
    new_array = []
    an_array.each_with_index do |array_item, array_item_index|
        new_array = [*new_array, callback_function.(array_item, array_item_index, an_array)]
    end
    return new_array
end

print("\n# JavaScript-like Array.map() in Ruby Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("\nnumbers: ", numbers)

print("\n# using JavaScript-like Array.map() function \"array_map_v1\"")

numbers_labeled = array_map_v1.(->(number, _, _) { { number => (((number % 2) == 0) ? "even" : "odd")} }, numbers)
print("\nlabeled numbers: ", JSON.pretty_generate(numbers_labeled, { "indent": " " * 4 }))
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

print("\n# using JavaScript-like Array.map() function \"array_map_v2\"")

numbers_labeled = array_map_v2.(->(number, _, _) { { number => (((number % 2) == 0) ? "even" : "odd")} }, numbers)
print("\nlabeled numbers: ", JSON.pretty_generate(numbers_labeled, { "indent": " " * 4 }))
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

print("\n# using Ruby Array.map() built-in method \"Array.map\"")

numbers_labeled = numbers.map { |number| { number => (((number % 2) == 0) ? "even" : "odd")} }
print("\nlabeled numbers: ", JSON.pretty_generate(numbers_labeled, { "indent": " " * 4 }))
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

print("\n# JavaScript-like Array.map() in Ruby Array of Hashes")

products = [
    {
        "code" => "pasta",
        "price" => 321
    },
    {
        "code" => "bubble_gum",
        "price" => 233
    },
    {
        "code" => "potato_chips",
        "price" => 5
    },
    {
        "code" => "towel",
        "price" => 499
    }
]
print("\nproducts: ", JSON.pretty_generate(products, { "indent": " " * 4 }))

print("\n# using JavaScript-like Array.map() function \"array_map_v1\"")

products_labeled = array_map_v1.(->(product, _, _) { {**product, "label" => ((product["price"] > 100) ? "expensive" : "cheap")} }, products)
print("\nlabeled products: ", JSON.pretty_generate(products_labeled, { "indent": " " * 4 }))
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

print("\n# using JavaScript-like Array.map() function \"array_map_v2\"")

products_labeled = array_map_v2.(->(product, _, _) { {**product, "label" => ((product["price"] > 100) ? "expensive" : "cheap")} }, products)
print("\nlabeled products: ", JSON.pretty_generate(products_labeled, { "indent": " " * 4 }))
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

print("\n# using Ruby Array.map() built-in method \"Array.map\"")

products_labeled = products.map { |product| {**product, "label" => ((product["price"] > 100) ? "expensive" : "cheap")} }
print("\nlabeled products: ", JSON.pretty_generate(products_labeled, { "indent": " " * 4 }))
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
