using Printf
using Statistics
using JSON

function pretty_array_of_primitives(an_array_of_primitives)
    result = "["
    for (array_item_index, array_item) in enumerate(an_array_of_primitives)
        if ((isa(array_item, AbstractString) === false) && (isa(array_item, Number) === false) && (isa(array_item, Bool) === false) && array_item !== nothing)
            continue
        end
        if (isa(array_item, AbstractString) === true)
            result = string(result, "\"", array_item, "\"")
        end
        if (array_item === nothing)
            result = string(result, "null")
        end
        if ((isa(array_item, Number) === true) || (isa(array_item, Bool) === true))
            result = string(result, array_item)
        end
        if (array_item_index !== length(an_array_of_primitives))
            result = string(result, ", ")
        end
    end
    result = string(result, "]")
    return result
end

function array_some_v1(callback_function, an_array)
    # JavaScript-like Array.some() function
    is_condition_match = false
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === true)
            break
        end
    end
    return is_condition_match
end

function array_some_v2(callback_function, an_array)
    # JavaScript-like Array.some() function
    is_condition_match = false
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === true)
            return is_condition_match
        end
    end
    return is_condition_match
end

function array_some_v3(callback_function, an_array)
    # JavaScript-like Array.some() function
    for (array_item_index, array_item) in enumerate(an_array)
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match === true)
            return true
        end
    end
    return false
end

function array_some_v4(callback_function, an_array)
    # JavaScript-like Array.some() function
    for (array_item_index, array_item) in enumerate(an_array)
        if (callback_function(array_item, array_item_index, an_array) === true)
            return true
        end
    end
    return false
end

println("\n# JavaScript-like Array.some() in Julia Array")

numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254]
println("numbers: ", pretty_array_of_primitives(numbers))

println("# using JavaScript-like Array.some() function \"array_some_v1\"")

is_any_number_less_than_500 = array_some_v1((number, _, _) -> (number < 500), numbers)
println("is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v1((number, _, _) -> (number > 500), numbers)
println("is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

println("# using JavaScript-like Array.some() function \"array_some_v2\"")

is_any_number_less_than_500 = array_some_v2((number, _, _) -> (number < 500), numbers)
println("is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v2((number, _, _) -> (number > 500), numbers)
println("is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

println("# using JavaScript-like Array.some() function \"array_some_v3\"")

is_any_number_less_than_500 = array_some_v3((number, _, _) -> (number < 500), numbers)
println("is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v3((number, _, _) -> (number > 500), numbers)
println("is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

println("# using JavaScript-like Array.some() function \"array_some_v4\"")

is_any_number_less_than_500 = array_some_v4((number, _, _) -> (number < 500), numbers)
println("is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = array_some_v4((number, _, _) -> (number > 500), numbers)
println("is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

println("# using Julia Array.some() built-in function \"any\"")

is_any_number_less_than_500 = any([number < 500 for number in numbers])
println("is any number < 500: ", is_any_number_less_than_500)
# is any number < 500: true

is_any_number_more_than_500 = any([number > 500 for number in numbers])
println("is any number > 500: ", is_any_number_more_than_500)
# is any number > 500: false

println("\n# JavaScript-like Array.some() in Julia Array of Dicts")

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

println("# using JavaScript-like Array.some() function \"array_some_v1\"")

is_any_product_price_less_than_500 = array_some_v1((product, _, _) -> (product["price"] < 500), products)
println("is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v1((product, _, _) -> (product["price"] > 500), products)
println("is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

println("# using JavaScript-like Array.some() function \"array_some_v2\"")

is_any_product_price_less_than_500 = array_some_v2((product, _, _) -> (product["price"] < 500), products)
println("is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v2((product, _, _) -> (product["price"] > 500), products)
println("is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

println("# using JavaScript-like Array.some() function \"array_some_v3\"")

is_any_product_price_less_than_500 = array_some_v3((product, _, _) -> (product["price"] < 500), products)
println("is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v3((product, _, _) -> (product["price"] > 500), products)
println("is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

println("# using JavaScript-like Array.some() function \"array_some_v4\"")

is_any_product_price_less_than_500 = array_some_v4((product, _, _) -> (product["price"] < 500), products)
println("is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v4((product, _, _) -> (product["price"] > 500), products)
println("is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false

println("# using Julia Array.some() built-in function \"any\"")

is_any_product_price_less_than_500 = any([(product["price"] < 500) for product in products])
println("is any product price < 500: ", is_any_product_price_less_than_500)
# is any product price < 500: true

is_any_product_price_more_than_500 = any([(product["price"] > 500) for product in products])
println("is any product price > 500: ", is_any_product_price_more_than_500)
# is any product price > 500: false
