require 'json'

array_find_index_v1 = ->(callback_function, an_array) do
    # JavaScript-like Array.findIndex() function
    item_index = -1
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        if is_condition_match == true
            item_index = array_item_index
            break
        end
    end
    return item_index
end

array_find_index_v2 = ->(callback_function, an_array) do
    # JavaScript-like Array.findIndex() function
    item_index = -1
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        unless is_condition_match == false
            item_index = array_item_index
            break
        end
    end
    return item_index
end

array_find_index_v3 = ->(callback_function, an_array) do
    # JavaScript-like Array.findIndex() function
    item_index = -1
    an_array.each_with_index do |array_item, array_item_index|
        if callback_function.(array_item, array_item_index, an_array) == true
            item_index = array_item_index
            break
        end
    end
    return item_index
end

array_find_index_v4 = ->(callback_function, an_array) do
    # JavaScript-like Array.findIndex() function
    item_index = -1
    an_array.each_with_index do |array_item, array_item_index|
        unless callback_function.(array_item, array_item_index, an_array) == false
            item_index = array_item_index
            break
        end
    end
    return item_index
end

array_find_index_v5 = ->(callback_function, an_array) do
    # JavaScript-like Array.findIndex() function
    item_index = -1
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        if is_condition_match == true
            return array_item_index
        end
    end
    return item_index
end

array_find_index_v6 = ->(callback_function, an_array) do
    # JavaScript-like Array.findIndex() function
    item_index = -1
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        unless is_condition_match == false
            return array_item_index
        end
    end
    return item_index
end

array_find_index_v7 = ->(callback_function, an_array) do
    # JavaScript-like Array.findIndex() function
    item_index = -1
    an_array.each_with_index do |array_item, array_item_index|
        if callback_function.(array_item, array_item_index, an_array) == true
            return array_item_index
        end
    end
    return item_index
end

array_find_index_v8 = ->(callback_function, an_array) do
    # JavaScript-like Array.findIndex() function
    item_index = -1
    an_array.each_with_index do |array_item, array_item_index|
        unless callback_function.(array_item, array_item_index, an_array) == false
            return array_item_index
        end
    end
    return item_index
end

array_find_index_v9 = ->(callback_function, an_array) do
    # JavaScript-like Array.findIndex() function
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        if is_condition_match == true
            return array_item_index
        end
    end
    return -1
end

array_find_index_v10 = ->(callback_function, an_array) do
    # JavaScript-like Array.findIndex() function
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        unless is_condition_match == false
            return array_item_index
        end
    end
    return -1
end

array_find_index_v11 = ->(callback_function, an_array) do
    # JavaScript-like Array.findIndex() function
    an_array.each_with_index do |array_item, array_item_index|
        if callback_function.(array_item, array_item_index, an_array) == true
            return array_item_index
        end
    end
    return -1
end

array_find_index_v12 = ->(callback_function, an_array) do
    # JavaScript-like Array.findIndex() function
    an_array.each_with_index do |array_item, array_item_index|
        unless callback_function.(array_item, array_item_index, an_array) == false
            return array_item_index
        end
    end
    return -1
end

print("\n# JavaScript-like Array.findIndex() in Ruby Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("\nnumbers: ", numbers)

my_lucky_number = 27
print("\nmy lucky numbers: ", my_lucky_number)

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v1\"")

my_lucky_number_index = array_find_index_v1.(->(number, _, _) { (number === my_lucky_number) }, numbers)
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v2\"")

my_lucky_number_index = array_find_index_v2.(->(number, _, _) { (number === my_lucky_number) }, numbers)
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v3\"")

my_lucky_number_index = array_find_index_v3.(->(number, _, _) { (number === my_lucky_number) }, numbers)
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v4\"")

my_lucky_number_index = array_find_index_v4.(->(number, _, _) { (number === my_lucky_number) }, numbers)
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v5\"")

my_lucky_number_index = array_find_index_v5.(->(number, _, _) { (number === my_lucky_number) }, numbers)
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v6\"")

my_lucky_number_index = array_find_index_v6.(->(number, _, _) { (number === my_lucky_number) }, numbers)
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v7\"")

my_lucky_number_index = array_find_index_v7.(->(number, _, _) { (number === my_lucky_number) }, numbers)
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v8\"")

my_lucky_number_index = array_find_index_v8.(->(number, _, _) { (number === my_lucky_number) }, numbers)
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v9\"")

my_lucky_number_index = array_find_index_v9.(->(number, _, _) { (number === my_lucky_number) }, numbers)
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v10\"")

my_lucky_number_index = array_find_index_v10.(->(number, _, _) { (number === my_lucky_number) }, numbers)
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v11\"")

my_lucky_number_index = array_find_index_v11.(->(number, _, _) { (number === my_lucky_number) }, numbers)
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v12\"")

my_lucky_number_index = array_find_index_v12.(->(number, _, _) { (number === my_lucky_number) }, numbers)
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# using Ruby Array.findIndex() built-in function \"find_index\"")

my_lucky_number_index = numbers.find_index { |number| (number === my_lucky_number) }
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# using Ruby Array.findIndex() built-in function \"index\"")

my_lucky_number_index = numbers.index { |number| (number === my_lucky_number) }
print("\nmy lucky number is at index: ", my_lucky_number_index)
# my lucky number is at index: 2

print("\n# JavaScript-like Array.findIndex() in Ruby Array of Hashes")

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

product_found = "pasta"
print("\nproduct to buy: ", product_found)

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v1\"")

product_found_index = array_find_index_v1.(->(product, _, _) { (product["code"] == product_found) }, products)
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
# product found index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v2\"")

product_found_index = array_find_index_v2.(->(product, _, _) { (product["code"] == product_found) }, products)
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
# product found index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v3\"")

product_found_index = array_find_index_v3.(->(product, _, _) { (product["code"] == product_found) }, products)
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
# product found index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v4\"")

product_found_index = array_find_index_v4.(->(product, _, _) { (product["code"] == product_found) }, products)
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
# product found index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v5\"")

product_found_index = array_find_index_v5.(->(product, _, _) { (product["code"] == product_found) }, products)
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
# product found index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v6\"")

product_found_index = array_find_index_v6.(->(product, _, _) { (product["code"] == product_found) }, products)
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
# product found index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v7\"")

product_found_index = array_find_index_v7.(->(product, _, _) { (product["code"] == product_found) }, products)
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
# product found index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v8\"")

product_found_index = array_find_index_v8.(->(product, _, _) { (product["code"] == product_found) }, products)
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
# product found index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v9\"")

product_found_index = array_find_index_v9.(->(product, _, _) { (product["code"] == product_found) }, products)
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
# product found index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v10\"")

product_found_index = array_find_index_v10.(->(product, _, _) { (product["code"] == product_found) }, products)
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
# product found index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v11\"")

product_found_index = array_find_index_v11.(->(product, _, _) { (product["code"] == product_found) }, products)
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
# product found index: 2

print("\n# using JavaScript-like Array.findIndex() function \"array_find_index_v12\"")

product_found_index = array_find_index_v12.(->(product, _, _) { (product["code"] == product_found) }, products)
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
# product found index: 2

print("\n# using Ruby Array.findIndex() built-in function \"find_index\"")

product_found_index = products.find_index { |product| (product["code"] == product_found) }
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
## product found index: 2

print("\n# using Ruby Array.findIndex() built-in function \"index\"")

product_found_index = products.index { |product| (product["code"] == product_found) }
print("\nproduct to buy is at index: ", JSON.pretty_generate(product_found_index, { "indent": " " * 4 }))
## product found index: 2
