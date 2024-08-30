require "json"

array_reduce = ->(callback_function, an_array, initial_value) do
    # JavaScript-like Array.reduce() function
    result = initial_value
    an_array.each_with_index do |array_item, array_item_index|
        result = callback_function.call(result, array_item, array_item_index, an_array)
    end
    return result
end

print("\n", "# JavaScript-like Array.reduce() in Ruby Array")

numbers = [36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3]
print("\n", "numbers: ", JSON.generate(numbers).gsub(",", ", "))

print("\n", "# using JavaScript-like Array.reduce() function \"array_reduce\"")

numbers_total = array_reduce.call(->(current_result, current_number, _, _) { (current_result + current_number) }, numbers, 0)
print("\n", "total number: ", numbers_total)
# total number: 41.2

print("\n", "# using Ruby Array.reduce() built-in method \"Array.reduce\"")

numbers_total = numbers.reduce(0) { |current_result, current_number| (current_result + current_number) }
print("\n", "total number: ", numbers_total)
# total number: 41.2

print("\n", "# JavaScript-like Array.reduce() in Ruby Array of Hashes")

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

print("\n", "# using JavaScript-like Array.reduce() function \"array_reduce\"")

products_grouped = array_reduce.call(->(current_result, current_product, _, _) { ((current_product["price"] > 100) ? {**current_result, "expensive" => [*current_result["expensive"], current_product]} : {**current_result, "cheap" => [*current_result["cheap"], current_product]}) }, products, {"expensive" => [], "cheap" => []})
print("\n", "grouped products: ", JSON.pretty_generate(products_grouped, { "indent": " " * 4 }))
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

print("\n", "# using Ruby Array.reduce() built-in method \"Array.reduce\"")

products_grouped = products.reduce({"expensive" => [], "cheap" => []}) { |current_result, current_product| ((current_product["price"] > 100) ? {**current_result, "expensive" => [*current_result["expensive"], current_product]} : {**current_result, "cheap" => [*current_result["cheap"], current_product]}) }
print("\n", "grouped products: ", JSON.pretty_generate(products_grouped, { "indent": " " * 4 }))
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
