JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

function sprint(...)
    local parameters = {...}
    local result = ""
    for _, parameter in ipairs(parameters) do
        result = result .. tostring(parameter)
    end
    print(result)
end

-- There's no JavaScript-like Array.find() in Lua.
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

function array_find_v1(callback_function, an_array)
    -- JavaScript-like Array.find() function
    local data_found = nil
    for array_item_index, array_item in ipairs(an_array) do
        local is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == true) then
            data_found = array_item
            break
        end
    end
    return data_found
end

function array_find_v2(callback_function, an_array)
    -- JavaScript-like Array.find() function
    local data_found = nil
    for array_item_index, array_item in ipairs(an_array) do
        if (callback_function(array_item, array_item_index, an_array) == true) then
            data_found = array_item
            break
        end
    end
    return data_found
end

function array_find_v3(callback_function, an_array)
    -- JavaScript-like Array.find() function
    for array_item_index, array_item in ipairs(an_array) do
        local is_condition_match = callback_function(array_item, array_item_index, an_array)
        if (is_condition_match == true) then
            return array_item
        end
    end
    return nil
end

function array_find_v4(callback_function, an_array)
    -- JavaScript-like Array.find() function
    for array_item_index, array_item in ipairs(an_array) do
        if (callback_function(array_item, array_item_index, an_array) == true) then
            return array_item
        end
    end
    return nil
end

print('\n-- JavaScript-like Array.find() in JavaScript-like-Array Lua table')

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
sprint("numbers: ", pretty_array_of_primitives(numbers))

print("-- using JavaScript-like Array.find() function \"array_find_v1\"")

even_number_found = array_find_v1(function (number) return ((number % 2) == 0) end, numbers)
sprint("even number found: ", even_number_found)
-- even number found: 12

odd_numbers_found = array_find_v1(function (number) return ((number % 2) ~= 0) end, numbers)
sprint("odd number found: ", odd_numbers_found)
-- odd number found: 27

print("-- using JavaScript-like Array.find() function \"array_find_v2\"")

even_number_found = array_find_v2(function (number) return ((number % 2) == 0) end, numbers)
sprint("even number found: ", even_number_found)
-- even number found: 12

odd_numbers_found = array_find_v2(function (number) return ((number % 2) ~= 0) end, numbers)
sprint("odd number found: ", odd_numbers_found)
-- odd number found: 27

print("-- using JavaScript-like Array.find() function \"array_find_v3\"")

even_number_found = array_find_v3(function (number) return ((number % 2) == 0) end, numbers)
sprint("even number found: ", even_number_found)
-- even number found: 12

odd_numbers_found = array_find_v3(function (number) return ((number % 2) ~= 0) end, numbers)
sprint("odd number found: ", odd_numbers_found)
-- odd number found: 27

print("-- using JavaScript-like Array.find() function \"array_find_v4\"")

even_number_found = array_find_v4(function (number) return ((number % 2) == 0) end, numbers)
sprint("even number found: ", even_number_found)
-- even number found: 12

odd_numbers_found = array_find_v4(function (number) return ((number % 2) ~= 0) end, numbers)
sprint("odd number found: ", odd_numbers_found)
-- odd number found: 27

print('\n-- JavaScript-like Array.find() in JavaScript-like-Array-of-Objects Lua table')

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
sprint("products: ", pretty_json_stringify(products))

product_to_find = "bubble_gum"
sprint("product to find: ", product_to_find)

print("-- using JavaScript-like Array.find() function \"array_find_v1\"")

product_found = array_find_v1(function (product) return (product.code == product_to_find) end, products)
sprint("products with price <= 100 only: ", pretty_json_stringify(product_found))
-- product found: {
--     "code": "bubble_gum",
--     "price": 233
-- }

print("-- using JavaScript-like Array.find() function \"array_find_v2\"")

product_found = array_find_v2(function (product) return (product.code == product_to_find) end, products)
sprint("products with price <= 100 only: ", pretty_json_stringify(product_found))
-- product found: {
--     "code": "bubble_gum",
--     "price": 233
-- }

print("-- using JavaScript-like Array.find() function \"array_find_v3\"")

product_found = array_find_v3(function (product) return (product.code == product_to_find) end, products)
sprint("products with price <= 100 only: ", pretty_json_stringify(product_found))
-- product found: {
--     "code": "bubble_gum",
--     "price": 233
-- }

print("-- using JavaScript-like Array.find() function \"array_find_v4\"")

product_found = array_find_v4(function (product) return (product.code == product_to_find) end, products)
sprint("products with price <= 100 only: ", pretty_json_stringify(product_found))
-- product found: {
--     "code": "bubble_gum",
--     "price": 233
-- }
