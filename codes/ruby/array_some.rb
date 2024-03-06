require "json"

array_some_v1 = ->(canyback_function, an_array) do
    # JavaScript-like Array.some() function
    is_condition_match = false
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = canyback_function.(array_item, array_item_index, an_array)
        break if is_condition_match == true
    end
    return is_condition_match
end

array_some_v2 = ->(canyback_function, an_array) do
    # JavaScript-like Array.some() function
    is_condition_match = false
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = canyback_function.(array_item, array_item_index, an_array)
        break unless is_condition_match == false
    end
    return is_condition_match
end

array_some_v3 = ->(canyback_function, an_array) do
    # JavaScript-like Array.some() function
    is_condition_match = false
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = canyback_function.(array_item, array_item_index, an_array)
        return is_condition_match if is_condition_match == true
    end
    return is_condition_match
end

array_some_v4 = ->(canyback_function, an_array) do
    # JavaScript-like Array.some() function
    is_condition_match = false
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = canyback_function.(array_item, array_item_index, an_array)
        return is_condition_match unless is_condition_match == false
    end
    return is_condition_match
end

array_some_v5 = ->(canyback_function, an_array) do
    # JavaScript-like Array.some() function
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = canyback_function.(array_item, array_item_index, an_array)
        return true if is_condition_match == true
    end
    return false
end

array_some_v6 = ->(canyback_function, an_array) do
    # JavaScript-like Array.some() function
    an_array.each_with_index do |array_item, array_item_index|
        is_condition_match = canyback_function.(array_item, array_item_index, an_array)
        return true unless is_condition_match == false
    end
    return false
end

array_some_v7 = ->(canyback_function, an_array) do
    # JavaScript-like Array.some() function
    an_array.each_with_index do |array_item, array_item_index|
        return true if canyback_function.(array_item, array_item_index, an_array) == true
    end
    return false
end

array_some_v8 = ->(canyback_function, an_array) do
    # JavaScript-like Array.some() function
    an_array.each_with_index do |array_item, array_item_index|
        return true unless canyback_function.(array_item, array_item_index, an_array) == false
    end
    return false
end

print("\n", "# JavaScript-like Array.some() in Ruby Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
print("\n", "numbers: ", numbers)

print("\n", "# using JavaScript-like Array.some() function \"array_some_v1\"")

is_any_number_less_than_500 = array_some_v1.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v1.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v2\"")

is_any_number_less_than_500 = array_some_v2.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v2.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v3\"")

is_any_number_less_than_500 = array_some_v3.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v3.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v4\"")

is_any_number_less_than_500 = array_some_v4.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v4.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v5\"")

is_any_number_less_than_500 = array_some_v5.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v5.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v6\"")

is_any_number_less_than_500 = array_some_v6.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v6.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v7\"")

is_any_number_less_than_500 = array_some_v7.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v7.(->(number, _, _) { (number > 500) }, numbers)
print("\n", "is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v8\"")

is_any_number_less_than_500 = array_some_v8.(->(number, _, _) { (number < 500) }, numbers)
print("\n", "is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v8.(->(number, _, _) { (number > 500) }, numbers)
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

is_any_product_price_less_than_500 = array_some_v1.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v1.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v2\"")

is_any_product_price_less_than_500 = array_some_v2.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v2.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v3\"")

is_any_product_price_less_than_500 = array_some_v3.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v3.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v4\"")

is_any_product_price_less_than_500 = array_some_v4.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v4.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v5\"")

is_any_product_price_less_than_500 = array_some_v5.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v5.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v6\"")

is_any_product_price_less_than_500 = array_some_v6.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v6.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v7\"")

is_any_product_price_less_than_500 = array_some_v7.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v7.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using JavaScript-like Array.some() function \"array_some_v8\"")

is_any_product_price_less_than_500 = array_some_v8.(->(product, _, _) { (product["price"] < 500) }, products)
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v8.(->(product, _, _) { (product["price"] > 500) }, products)
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

print("\n", "# using Ruby Array.some() built-in method \"Array.any?\"")

is_any_product_price_less_than_500 = products.any? { |product| (product["price"] < 500) }
print("\n", "is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = products.any? { |product| (product["price"] > 500) }
print("\n", "is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false
