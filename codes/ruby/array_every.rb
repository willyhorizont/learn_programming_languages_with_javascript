require "json"

array_every_v1 = ->(callback_function, an_array) do
    # JavaScript-like Array.every() function
    is_condition_match = false
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        break if is_condition_match == false
    end
    return is_condition_match
end

array_every_v2 = ->(callback_function, an_array) do
    # JavaScript-like Array.every() function
    is_condition_match = false
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        break unless is_condition_match == true
    end
    return is_condition_match
end

array_every_v3 = ->(callback_function, an_array) do
    # JavaScript-like Array.every() function
    is_condition_match = false
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        return is_condition_match if is_condition_match == false
    end
    return is_condition_match
end

array_every_v4 = ->(callback_function, an_array) do
    # JavaScript-like Array.every() function
    is_condition_match = false
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        return is_condition_match unless is_condition_match == true
    end
    return is_condition_match
end

array_every_v5 = ->(callback_function, an_array) do
    # JavaScript-like Array.every() function
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        return false if is_condition_match == false
    end
    return true
end

array_every_v6 = ->(callback_function, an_array) do
    # JavaScript-like Array.every() function
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = callback_function.(array_item, array_item_index, an_array)
        return false unless is_condition_match == true
    end
    return true
end

array_every_v7 = ->(callback_function, an_array) do
    # JavaScript-like Array.every() function
    an_array.each_with_index do |array_item, array_item_index|
        return false if callback_function.(array_item, array_item_index, an_array) == false
    end
    return true
end

array_every_v8 = ->(callback_function, an_array) do
    # JavaScript-like Array.every() function
    an_array.each_with_index do |array_item, array_item_index|
        return false unless callback_function.(array_item, array_item_index, an_array) == true
    end
    return true
end

print("\n", "# JavaScript-like Array.every() in Ruby Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("\n", "numbers: ", numbers)

print("\n", "# using JavaScript-like Array.every() function \"array_every_v1\"")

is_all_number_less_than_500 = array_every_v1.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = array_every_v1.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v2\"")

is_all_number_less_than_500 = array_every_v2.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = array_every_v2.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v3\"")

is_all_number_less_than_500 = array_every_v3.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = array_every_v3.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v4\"")

is_all_number_less_than_500 = array_every_v4.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = array_every_v4.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v5\"")

is_all_number_less_than_500 = array_every_v5.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = array_every_v5.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v6\"")

is_all_number_less_than_500 = array_every_v6.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = array_every_v6.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v7\"")

is_all_number_less_than_500 = array_every_v7.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = array_every_v7.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v8\"")

is_all_number_less_than_500 = array_every_v8.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = array_every_v8.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

print("\n", "# using Ruby Array.every() built-in method \"Array.all?\"")

is_all_number_less_than_500 = numbers.all? { |number| (number < 500) }
print("\n", "is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = numbers.all? { |number| (number > 500) }
print("\n", "is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

print("\n", "# JavaScript-like Array.every() in Ruby Array of Hashes")

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

print("\n", "# using JavaScript-like Array.every() function \"array_every_v1\"")

is_all_product_price_less_than_500 = array_every_v1.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v1.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v2\"")

is_all_product_price_less_than_500 = array_every_v2.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v2.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v3\"")

is_all_product_price_less_than_500 = array_every_v3.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v3.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v4\"")

is_all_product_price_less_than_500 = array_every_v4.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v4.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v5\"")

is_all_product_price_less_than_500 = array_every_v5.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v5.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v6\"")

is_all_product_price_less_than_500 = array_every_v6.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v6.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v7\"")

is_all_product_price_less_than_500 = array_every_v7.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v7.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

print("\n", "# using JavaScript-like Array.every() function \"array_every_v8\"")

is_all_product_price_less_than_500 = array_every_v8.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v8.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

print("\n", "# using Ruby Array.every() built-in method \"Array.all?\"")

is_all_product_price_less_than_500 = products.all? { |product| (product["price"] < 500) }
print("\n", "is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = products.all? { |product| (product["price"] > 500) }
print("\n", "is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false
