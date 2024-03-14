JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

function s_print(...)
    local parameters = {...}
    local result = ""
    for _, parameter in ipairs(parameters) do
        result = result .. tostring(parameter)
    end
    print(result)
end

-- There's no JavaScript-like Array.some() in Lua.
-- But, we can create our own function to mimic it in Lua.

function pretty_json_stringify(anything) return JSON:encode_pretty(anything, 'etc', { pretty=true, indent="    ", array_newline=true }) end

function pretty_array_of_primitives(an_array_of_primitives)
    local result = "["
    for array_item_index, array_item in ipairs(an_array_of_primitives) do
        if ((type(array_item) ~= "string") and (type(array_item) ~= "number") and (type(array_item) ~= "boolean") and (array_item ~= "nil")) then
            goto next
        end
        if (array_item == "nil") then
            result = result .. "null"
        end
        if ((type(array_item) == "string") and (array_item ~= "nil")) then
            result = result .. "\"" .. array_item .. "\""
        end
        if (type(array_item) == "number") then
            result = result .. array_item
        end
        if (type(array_item) == "boolean") then
            result = result .. tostring(array_item)
        end
        if (array_item_index ~= #an_array_of_primitives) then
            result = result .. ", "
        end
        ::next::
    end
    result = result .. "]"
    return result
end

function array_some_v1(callback_function, an_array)
    -- JavaScript-like Array.some() function
    local is_condition_match = false
    for array_item_index, array_item in ipairs(an_array) do
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == true) then
            break
        end
    end
    return is_condition_match
end

function array_some_v2(callback_function, an_array)
    -- JavaScript-like Array.some() function
    local is_condition_match = false
    for array_item_index, array_item in ipairs(an_array) do
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == true) then
            return is_condition_match
        end
    end
    return is_condition_match
end

function array_some_v3(callback_function, an_array)
    -- JavaScript-like Array.some() function
    for array_item_index, array_item in ipairs(an_array) do
        local is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == true) then
            return true
        end
    end
    return false
end

function array_some_v4(callback_function, an_array)
    -- JavaScript-like Array.some() function
    for array_item_index, array_item in ipairs(an_array) do
        if (callback_function(array_item, array_item_index, an_array) == true) then
            return true
        end
    end
    return false
end

print('\n-- JavaScript-like Array.some() in JavaScript-like-Array Lua table')

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
s_print("numbers: ", pretty_array_of_primitives(numbers))

print("-- using JavaScript-like Array.some() function \"array_some_v1\"")

is_any_number_less_than_500 = array_some_v1(function (number) return (number < 500) end, numbers)
s_print("is any number < 500: ", is_any_number_less_than_500)
-- is any number < 500: true

is_any_number_more_than_500 = array_some_v1(function (number) return (number > 500) end, numbers)
s_print("is any number > 500: ", is_any_number_more_than_500)
-- is any number > 500: false

print("-- using JavaScript-like Array.some() function \"array_some_v2\"")

is_any_number_less_than_500 = array_some_v2(function (number) return (number < 500) end, numbers)
s_print("is any number < 500: ", is_any_number_less_than_500)
-- is any number < 500: true

is_any_number_more_than_500 = array_some_v2(function (number) return (number > 500) end, numbers)
s_print("is any number > 500: ", is_any_number_more_than_500)
-- is any number > 500: false

print("-- using JavaScript-like Array.some() function \"array_some_v3\"")

is_any_number_less_than_500 = array_some_v3(function (number) return (number < 500) end, numbers)
s_print("is any number < 500: ", is_any_number_less_than_500)
-- is any number < 500: true

is_any_number_more_than_500 = array_some_v3(function (number) return (number > 500) end, numbers)
s_print("is any number > 500: ", is_any_number_more_than_500)
-- is any number > 500: false

print("-- using JavaScript-like Array.some() function \"array_some_v4\"")

is_any_number_less_than_500 = array_some_v4(function (number) return (number < 500) end, numbers)
s_print("is any number < 500: ", is_any_number_less_than_500)
-- is any number < 500: true

is_any_number_more_than_500 = array_some_v4(function (number) return (number > 500) end, numbers)
s_print("is any number > 500: ", is_any_number_more_than_500)
-- is any number > 500: false

print('\n-- JavaScript-like Array.some() in JavaScript-like-Array-of-Objects Lua table')

products = {
    {
        code = "pasta",
        price = 321
    },
    {
        code = "bubble_gum",
        price = 233
    },
    {
        code = "potato_chips",
        price = 5
    },
    {
        code = "towel",
        price = 499
    }
}
s_print("products: ", pretty_json_stringify(products))

print("-- using JavaScript-like Array.some() function \"array_some_v1\"")

is_any_product_price_less_than_500 = array_some_v1(function (product) return (product.price < 500) end, products)
s_print("is any product price < 500: ", is_any_product_price_less_than_500)
-- is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v1(function (product) return (product.price > 500) end, products)
s_print("is any product price < 500: ", is_any_product_price_more_than_500)
-- is any product price > 500: false

print("-- using JavaScript-like Array.some() function \"array_some_v2\"")

is_any_product_price_less_than_500 = array_some_v2(function (product) return (product.price < 500) end, products)
s_print("is any product price < 500: ", is_any_product_price_less_than_500)
-- is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v2(function (product) return (product.price > 500) end, products)
s_print("is any product price < 500: ", is_any_product_price_more_than_500)
-- is any product price > 500: false

print("-- using JavaScript-like Array.some() function \"array_some_v3\"")

is_any_product_price_less_than_500 = array_some_v3(function (product) return (product.price < 500) end, products)
s_print("is any product price < 500: ", is_any_product_price_less_than_500)
-- is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v3(function (product) return (product.price > 500) end, products)
s_print("is any product price < 500: ", is_any_product_price_more_than_500)
-- is any product price > 500: false

print("-- using JavaScript-like Array.some() function \"array_some_v4\"")

is_any_product_price_less_than_500 = array_some_v4(function (product) return (product.price < 500) end, products)
s_print("is any product price < 500: ", is_any_product_price_less_than_500)
-- is any product price < 500: true

is_any_product_price_more_than_500 = array_some_v4(function (product) return (product.price > 500) end, products)
s_print("is any product price < 500: ", is_any_product_price_more_than_500)
-- is any product price > 500: false
