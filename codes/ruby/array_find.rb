require "json"

array_find_v1 = ->(callback_function, an_array) do
    # JavaScript-like Array.find() function
    data_found = nil
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.call(array_item, array_item_index, an_array)
        if (is_condition_match == true)
            data_found = array_item
            break
        end
    end
    return data_found
end

array_find_v2 = ->(callback_function, an_array) do
    # JavaScript-like Array.find() function
    data_found = nil
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.call(array_item, array_item_index, an_array)
        unless (is_condition_match == false)
            data_found = array_item
            break
        end
    end
    return data_found
end

array_find_v3 = ->(callback_function, an_array) do
    # JavaScript-like Array.find() function
    data_found = nil
    an_array.each_with_index do |array_item, array_item_index|
        if (callback_function.call(array_item, array_item_index, an_array) == true)
            data_found = array_item
            break
        end
    end
    return data_found
end

array_find_v4 = ->(callback_function, an_array) do
    # JavaScript-like Array.find() function
    data_found = nil
    an_array.each_with_index do |array_item, array_item_index|
        unless (callback_function.call(array_item, array_item_index, an_array) == false)
            data_found = array_item
            break
        end
    end
    return data_found
end

array_find_v5 = ->(callback_function, an_array) do
    # JavaScript-like Array.find() function
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.call(array_item, array_item_index, an_array)
        return array_item if (is_condition_match == true)
    end
    return nil
end

array_find_v6 = ->(callback_function, an_array) do
    # JavaScript-like Array.find() function
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.call(array_item, array_item_index, an_array)
        return array_item unless (is_condition_match == false)
    end
    return nil
end

array_find_v7 = ->(callback_function, an_array) do
    # JavaScript-like Array.find() function
    an_array.each_with_index do |array_item, array_item_index|
        return array_item if (callback_function.call(array_item, array_item_index, an_array) == true)
    end
    return nil
end

array_find_v8 = ->(callback_function, an_array) do
    # JavaScript-like Array.find() function
    an_array.each_with_index do |array_item, array_item_index|
        return array_item unless (callback_function.call(array_item, array_item_index, an_array) == false)
    end
    return nil
end

print("\n", "# JavaScript-like Array.find() in Ruby Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("\n", "numbers: ", JSON.generate(numbers).gsub(",", ", "))

print("\n", "# using JavaScript-like Array.find() function \"array_find_v1\"")

even_number_found = array_find_v1.call(->(number, _, _) { ((number % 2) == 0) }, numbers)
print("\n", "even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v1.call(->(number, _, _) { ((number % 2) != 0) }, numbers)
print("\n", "odd number found: ", odd_numbers_found)
# odd number found: 27

print("\n", "# using JavaScript-like Array.find() function \"array_find_v2\"")

even_number_found = array_find_v2.call(->(number, _, _) { ((number % 2) == 0) }, numbers)
print("\n", "even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v2.call(->(number, _, _) { ((number % 2) != 0) }, numbers)
print("\n", "odd number found: ", odd_numbers_found)
# odd number found: 27

print("\n", "# using JavaScript-like Array.find() function \"array_find_v3\"")

even_number_found = array_find_v3.call(->(number, _, _) { ((number % 2) == 0) }, numbers)
print("\n", "even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v3.call(->(number, _, _) { ((number % 2) != 0) }, numbers)
print("\n", "odd number found: ", odd_numbers_found)
# odd number found: 27

print("\n", "# using JavaScript-like Array.find() function \"array_find_v4\"")

even_number_found = array_find_v4.call(->(number, _, _) { ((number % 2) == 0) }, numbers)
print("\n", "even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v4.call(->(number, _, _) { ((number % 2) != 0) }, numbers)
print("\n", "odd number found: ", odd_numbers_found)
# odd number found: 27

print("\n", "# using JavaScript-like Array.find() function \"array_find_v5\"")

even_number_found = array_find_v5.call(->(number, _, _) { ((number % 2) == 0) }, numbers)
print("\n", "even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v5.call(->(number, _, _) { ((number % 2) != 0) }, numbers)
print("\n", "odd number found: ", odd_numbers_found)
# odd number found: 27

print("\n", "# using JavaScript-like Array.find() function \"array_find_v6\"")

even_number_found = array_find_v6.call(->(number, _, _) { ((number % 2) == 0) }, numbers)
print("\n", "even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v6.call(->(number, _, _) { ((number % 2) != 0) }, numbers)
print("\n", "odd number found: ", odd_numbers_found)
# odd number found: 27

print("\n", "# using JavaScript-like Array.find() function \"array_find_v7\"")

even_number_found = array_find_v7.call(->(number, _, _) { ((number % 2) == 0) }, numbers)
print("\n", "even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v7.call(->(number, _, _) { ((number % 2) != 0) }, numbers)
print("\n", "odd number found: ", odd_numbers_found)
# odd number found: 27

print("\n", "# using JavaScript-like Array.find() function \"array_find_v8\"")

even_number_found = array_find_v8.call(->(number, _, _) { ((number % 2) == 0) }, numbers)
print("\n", "even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = array_find_v8.call(->(number, _, _) { ((number % 2) != 0) }, numbers)
print("\n", "odd number found: ", odd_numbers_found)
# odd number found: 27

print("\n", "# using Ruby Array.find() built-in method \"Array.find\"")

even_number_found = numbers.find { |number| ((number % 2) == 0) }
print("\n", "even number found: ", even_number_found)
# even number found: 12

odd_numbers_found = numbers.find { |number| ((number % 2) != 0) }
print("\n", "odd number found: ", odd_numbers_found)
# odd number found: 27

print("\n", "# JavaScript-like Array.find() in Ruby Array of Hashes")

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

product_to_find = "bubble_gum"
print("\n", "product to find: #{product_to_find}")

print("\n", "# using JavaScript-like Array.find() function \"array_find_v1\"")

product_found = array_find_v1.call(->(product, _, _) { (product["code"] == product_to_find) }, products)
print("\n", "product found: ", JSON.pretty_generate(product_found, { "indent": " " * 4 }))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("\n", "# using JavaScript-like Array.find() function \"array_find_v2\"")

product_found = array_find_v2.call(->(product, _, _) { (product["code"] == product_to_find) }, products)
print("\n", "product found: ", JSON.pretty_generate(product_found, { "indent": " " * 4 }))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("\n", "# using JavaScript-like Array.find() function \"array_find_v3\"")

product_found = array_find_v3.call(->(product, _, _) { (product["code"] == product_to_find) }, products)
print("\n", "product found: ", JSON.pretty_generate(product_found, { "indent": " " * 4 }))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("\n", "# using JavaScript-like Array.find() function \"array_find_v4\"")

product_found = array_find_v4.call(->(product, _, _) { (product["code"] == product_to_find) }, products)
print("\n", "product found: ", JSON.pretty_generate(product_found, { "indent": " " * 4 }))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("\n", "# using JavaScript-like Array.find() function \"array_find_v5\"")

product_found = array_find_v5.call(->(product, _, _) { (product["code"] == product_to_find) }, products)
print("\n", "product found: ", JSON.pretty_generate(product_found, { "indent": " " * 4 }))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("\n", "# using JavaScript-like Array.find() function \"array_find_v6\"")

product_found = array_find_v6.call(->(product, _, _) { (product["code"] == product_to_find) }, products)
print("\n", "product found: ", JSON.pretty_generate(product_found, { "indent": " " * 4 }))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("\n", "# using JavaScript-like Array.find() function \"array_find_v7\"")

product_found = array_find_v7.call(->(product, _, _) { (product["code"] == product_to_find) }, products)
print("\n", "product found: ", JSON.pretty_generate(product_found, { "indent": " " * 4 }))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("\n", "# using JavaScript-like Array.find() function \"array_find_v8\"")

product_found = array_find_v8.call(->(product, _, _) { (product["code"] == product_to_find) }, products)
print("\n", "product found: ", JSON.pretty_generate(product_found, { "indent": " " * 4 }))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }

print("\n", "# using Ruby Array.find() built-in method \"Array.find\"")

product_found = products.find { |product| (product["code"] == product_to_find) }
print("\n", "product found: ", JSON.pretty_generate(product_found, { "indent": " " * 4 }))
# product found: {
#     "code": "bubble_gum",
#     "price": 233
# }
#
