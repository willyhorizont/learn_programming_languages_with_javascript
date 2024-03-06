require "json"

array_filter_v1 = ->(callback_function, an_array) do
    # JavaScript-like Array.filter() function
    data_filtered = []
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        data_filtered = [*data_filtered, array_item] if is_condition_match == true
    end
    return data_filtered
end

array_filter_v2 = ->(callback_function, an_array) do
    # JavaScript-like Array.filter() function
    data_filtered = []
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        data_filtered = [*data_filtered, array_item] unless is_condition_match == false
    end
    return data_filtered
end

array_filter_v3 = ->(callback_function, an_array) do
    # JavaScript-like Array.filter() function
    data_filtered = []
    an_array.each_with_index do |array_item, array_item_index|
        data_filtered = [*data_filtered, array_item] if callback_function.(array_item, array_item_index, an_array) == true
    end
    return data_filtered
end

array_filter_v4 = ->(callback_function, an_array) do
    # JavaScript-like Array.filter() function
    data_filtered = []
    an_array.each_with_index do |array_item, array_item_index|
        data_filtered = [*data_filtered, array_item] unless callback_function.(array_item, array_item_index, an_array) == false
    end
    return data_filtered
end

print("\n", "# JavaScript-like Array.filter() in Ruby Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("\n", "numbers: ", numbers)

print("\n", "# using JavaScript-like Array.filter() function \"array_filter_v1\"")

numbers_even = array_filter_v1.(->(number, _, _) { ((number % 2) == 0) }, numbers)
print("\n", "even numbers only: ", numbers_even)
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v1.(->(number, _, _) { ((number % 2) != 0) }, numbers)
print("\n", "odd numbers only: ", numbers_odd)
# odd numbers only: [27, 23, 65, 93, 87]

print("\n", "# using JavaScript-like Array.filter() function \"array_filter_v2\"")

numbers_even = array_filter_v2.(->(number, _, _) { ((number % 2) == 0) }, numbers)
print("\n", "even numbers only: ", numbers_even)
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v2.(->(number, _, _) { ((number % 2) != 0) }, numbers)
print("\n", "odd numbers only: ", numbers_odd)
# odd numbers only: [27, 23, 65, 93, 87]

print("\n", "# using JavaScript-like Array.filter() function \"array_filter_v3\"")

numbers_even = array_filter_v3.(->(number, _, _) { ((number % 2) == 0) }, numbers)
print("\n", "even numbers only: ", numbers_even)
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v3.(->(number, _, _) { ((number % 2) != 0) }, numbers)
print("\n", "odd numbers only: ", numbers_odd)
# odd numbers only: [27, 23, 65, 93, 87]

print("\n", "# using JavaScript-like Array.filter() function \"array_filter_v4\"")

numbers_even = array_filter_v4.(->(number, _, _) { ((number % 2) == 0) }, numbers)
print("\n", "even numbers only: ", numbers_even)
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v4.(->(number, _, _) { ((number % 2) != 0) }, numbers)
print("\n", "odd numbers only: ", numbers_odd)
# odd numbers only: [27, 23, 65, 93, 87]

print("\n", "# using Ruby Array.filter() built-in method \"Array.select\"")

numbers_even = numbers.select { |number| ((number % 2) == 0) }
print("\n", "even numbers only: ", numbers_even)
# even numbers only: [12, 34, 36, 4, 254]

numbers_odd = numbers.select { |number| ((number % 2) != 0) }
print("\n", "odd numbers only: ", numbers_odd)
# odd numbers only: [27, 23, 65, 93, 87]

print("\n", "# JavaScript-like Array.filter() in Ruby Array of Hashes")

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
print("\n", "products: ", JSON.pretty_generate(products, { "indent": " " * 4 }))

print("\n", "# using JavaScript-like Array.filter() function \"array_filter_v1\"")

products_below_100 = array_filter_v1.(->(product, _, _) { (product["price"] <= 100) }, products)
print("\n", "products with price <= 100 only: ", JSON.pretty_generate(products_below_100, { "indent": " " * 4 }))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v1.(->(product, _, _) { (product["price"]  >= 100) }, products)
print("\n", "products with price >= 100 only: ", JSON.pretty_generate(products_above_100, { "indent": " " * 4 }))
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

print("\n", "# using JavaScript-like Array.filter() function \"array_filter_v2\"")

products_below_100 = array_filter_v2.(->(product, _, _) { (product["price"] <= 100) }, products)
print("\n", "products with price <= 100 only: ", JSON.pretty_generate(products_below_100, { "indent": " " * 4 }))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v2.(->(product, _, _) { (product["price"]  >= 100) }, products)
print("\n", "products with price >= 100 only: ", JSON.pretty_generate(products_above_100, { "indent": " " * 4 }))
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

print("\n", "# using JavaScript-like Array.filter() function \"array_filter_v3\"")

products_below_100 = array_filter_v3.(->(product, _, _) { (product["price"] <= 100) }, products)
print("\n", "products with price <= 100 only: ", JSON.pretty_generate(products_below_100, { "indent": " " * 4 }))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v3.(->(product, _, _) { (product["price"]  >= 100) }, products)
print("\n", "products with price >= 100 only: ", JSON.pretty_generate(products_above_100, { "indent": " " * 4 }))
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

print("\n", "# using JavaScript-like Array.filter() function \"array_filter_v4\"")

products_below_100 = array_filter_v4.(->(product, _, _) { (product["price"] <= 100) }, products)
print("\n", "products with price <= 100 only: ", JSON.pretty_generate(products_below_100, { "indent": " " * 4 }))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = array_filter_v4.(->(product, _, _) { (product["price"]  >= 100) }, products)
print("\n", "products with price >= 100 only: ", JSON.pretty_generate(products_above_100, { "indent": " " * 4 }))
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

print("\n", "# using Ruby Array.filter() built-in method \"Array.select\"")

products_below_100 = products.select { |product| (product["price"] <= 100) }
print("\n", "products with price <= 100 only: ", JSON.pretty_generate(products_below_100, { "indent": " " * 4 }))
# products with price <= 100 only: [
#     {
#         "code": "potato_chips",
#         "price": 5
#     }
# ]

products_above_100 = products.select { |product| (product["price"]  >= 100) }
print("\n", "products with price >= 100 only: ", JSON.pretty_generate(products_above_100, { "indent": " " * 4 }))
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
