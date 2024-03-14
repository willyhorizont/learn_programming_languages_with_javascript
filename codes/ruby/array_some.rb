require "json"

array_some_v1 = ->(callback_function, an_array) do
    # JavaScript-like Array.some() function
    is_condition_match = false
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.call(array_item, array_item_index, an_array)
        break if (is_condition_match == true)
    end
    return is_condition_match
end

array_some_v2 = ->(callback_function, an_array) do
    # JavaScript-like Array.some() function
    is_condition_match = false
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.call(array_item, array_item_index, an_array)
        break unless (is_condition_match == false)
    end
    return is_condition_match
end

array_some_v3 = ->(callback_function, an_array) do
    # JavaScript-like Array.some() function
    is_condition_match = false
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.call(array_item, array_item_index, an_array)
        return is_condition_match if (is_condition_match == true)
    end
    return is_condition_match
end

array_some_v4 = ->(callback_function, an_array) do
    # JavaScript-like Array.some() function
    is_condition_match = false
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.call(array_item, array_item_index, an_array)
        return is_condition_match unless (is_condition_match == false)
    end
    return is_condition_match
end

array_some_v5 = ->(callback_function, an_array) do
    # JavaScript-like Array.some() function
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.call(array_item, array_item_index, an_array)
        return true if (is_condition_match == true)
    end
    return false
end

array_some_v6 = ->(callback_function, an_array) do
    # JavaScript-like Array.some() function
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.call(array_item, array_item_index, an_array)
        return true unless (is_condition_match == false)
    end
    return false
end

array_some_v7 = ->(callback_function, an_array) do
    # JavaScript-like Array.some() function
    an_array.each_with_index do |array_item, array_item_index|
        return true if (callback_function.call(array_item, array_item_index, an_array) == true)
    end
    return false
end

array_some_v8 = ->(callback_function, an_array) do
    # JavaScript-like Array.some() function
    an_array.each_with_index do |array_item, array_item_index|
        return true unless (callback_function.call(array_item, array_item_index, an_array) == false)
    end
    return false
end

print("\n", "# JavaScript-like Array.some() in Ruby Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("\n", "numbers: ", numbers)

print("\n", "# using JavaScript-like Array.some() function \"array_some_v1\"")

is_any_number_less_than_500 = array_some_v1.call(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v1.call(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v2\"")

is_any_number_less_than_500 = array_some_v2.call(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v2.call(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v3\"")

is_any_number_less_than_500 = array_some_v3.call(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v3.call(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v4\"")

is_any_number_less_than_500 = array_some_v4.call(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v4.call(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v5\"")

is_any_number_less_than_500 = array_some_v5.call(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v5.call(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v6\"")

is_any_number_less_than_500 = array_some_v6.call(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v6.call(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v7\"")

is_any_number_less_than_500 = array_some_v7.call(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v7.call(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v8\"")

is_any_number_less_than_500 = array_some_v8.call(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v8.call(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using Ruby Array.some() built-in method \"Array.any?\"")

is_any_number_less_than_500 = numbers.any? { |number| (number < 500) }
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = numbers.any? { |number| (number > 500) }
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# JavaScript-like Array.some() in Ruby Array of Hashes")

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

print("\n", "# using JavaScript-like Array.some() function \"array_some_v1\"")

is_any_product_price_less_than_500 = array_some_v1.call(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v1.call(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v2\"")

is_any_product_price_less_than_500 = array_some_v2.call(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v2.call(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v3\"")

is_any_product_price_less_than_500 = array_some_v3.call(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v3.call(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v4\"")

is_any_product_price_less_than_500 = array_some_v4.call(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v4.call(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v5\"")

is_any_product_price_less_than_500 = array_some_v5.call(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v5.call(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v6\"")

is_any_product_price_less_than_500 = array_some_v6.call(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v6.call(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v7\"")

is_any_product_price_less_than_500 = array_some_v7.call(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v7.call(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v8\"")

is_any_product_price_less_than_500 = array_some_v8.call(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v8.call(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using Ruby Array.some() built-in method \"Array.any?\"")

is_any_product_price_less_than_500 = products.any? { |product| (product["price"] < 500) }
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = products.any? { |product| (product["price"] > 500) }
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false
