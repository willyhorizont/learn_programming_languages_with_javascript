using Printf
using Statistics
using JSON

pretty_array_of_primitives = (an_array_of_primitives) -> string("[", join(an_array_of_primitives, ", "), "]")

function array_every_v1(callback_function, an_array)
    # JavaScript-like Array.every() function
    is_condition_match = false
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if is_condition_match === false
            break
        end
    end
    return is_condition_match
end

function array_every_v2(callback_function, an_array)
    # JavaScript-like Array.every() function
    is_condition_match = false
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if is_condition_match === false
            return is_condition_match
        end
    end
    return is_condition_match
end

function array_every_v3(callback_function, an_array)
    # JavaScript-like Array.every() function
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if is_condition_match === false
            return false
        end
    end
    return true
end

function array_every_v4(callback_function, an_array)
    # JavaScript-like Array.every() function
    for (array_item_index, array_item) in enumerate(an_array)
        if callback_function(array_item, array_item_index, an_array) === false
            return false
        end
    end
    return true
end

println("\n# JavaScript-like Array.every() in Julia Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
println("numbers: ", pretty_array_of_primitives(numbers))

println("# using JavaScript-like Array.every() function \"array_every_v1\"")

is_all_number_less_than_500 = array_every_v1((number, _, _) -> (number < 500), numbers)
println("is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = array_every_v1((number, _, _) -> (number > 500), numbers)
println("is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v2\"")

is_all_number_less_than_500 = array_every_v2((number, _, _) -> (number < 500), numbers)
println("is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = array_every_v2((number, _, _) -> (number > 500), numbers)
println("is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v3\"")

is_all_number_less_than_500 = array_every_v3((number, _, _) -> (number < 500), numbers)
println("is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = array_every_v3((number, _, _) -> (number > 500), numbers)
println("is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v4\"")

is_all_number_less_than_500 = array_every_v4((number, _, _) -> (number < 500), numbers)
println("is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = array_every_v4((number, _, _) -> (number > 500), numbers)
println("is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

println("# using Julia Array.every() built-in function \"all\"")

is_all_number_less_than_500 = all((number) -> (number < 500), numbers)
println("is all number < 500: ", is_all_number_less_than_500)
# is all number < 500: true

is_all_number_more_than_500 = all((number) -> (number > 500), numbers)
println("is all number > 500: ", is_all_number_more_than_500)
# is all number > 500: false

println("\n# JavaScript-like Array.every() in Julia Array of Dicts")

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

println("# using JavaScript-like Array.every() function \"array_every_v1\"")

is_all_product_price_less_than_500 = array_every_v1((product, _, _) -> (product["price"] < 500), products)
println("is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v1((product, _, _) -> (product["price"] > 500), products)
println("is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v2\"")

is_all_product_price_less_than_500 = array_every_v2((product, _, _) -> (product["price"] < 500), products)
println("is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v2((product, _, _) -> (product["price"] > 500), products)
println("is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v3\"")

is_all_product_price_less_than_500 = array_every_v3((product, _, _) -> (product["price"] < 500), products)
println("is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v3((product, _, _) -> (product["price"] > 500), products)
println("is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

println("# using JavaScript-like Array.every() function \"array_every_v4\"")

is_all_product_price_less_than_500 = array_every_v4((product, _, _) -> (product["price"] < 500), products)
println("is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v4((product, _, _) -> (product["price"] > 500), products)
println("is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false

println("# using Julia Array.every() built-in function \"all\"")

is_all_product_price_less_than_500 = all((product) -> (product["price"] < 500), products)
println("is all product price < 500: ", is_all_product_price_less_than_500)
# is all product price < 500: true

is_all_product_price_more_than_500 = all((product) -> (product["price"] > 500), products)
println("is all product price > 500: ", is_all_product_price_more_than_500)
# is all product price > 500: false
