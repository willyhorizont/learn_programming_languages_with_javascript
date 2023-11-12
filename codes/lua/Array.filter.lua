JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

-- There's no JavaScript-like Array.filter() in Lua.
-- But, we can create our own function to mimic it in Lua.

function pretty_json_stringify(anything) return JSON:encode_pretty(anything, 'etc', { pretty=true, indent="    ", array_newline=true }) end

function pretty_array_of_primitives(an_array_of_primitives)
    local result = "["
    for array_item_index, array_item in ipairs(an_array_of_primitives) do
        if ((type(array_item) ~= "string") and (type(array_item) ~= "number")) then
            goto next
        end
        if (type(array_item) == "string") then
            result = result .. "\"" .. array_item .. "\""
        end
        if (type(array_item) == "number") then
            result = result .. array_item
        end
        if (array_item_index ~= #an_array_of_primitives) then
            result = result .. ", "
        end
        ::next::
    end
    result = result .. "]"
    return result
end

function array_filter_v1(callback_function, an_array)
    -- JavaScript-like Array.filter() function
    local data_filtered = {}
    for array_item_index, array_item in ipairs(an_array) do
        local is_condition_match = callback_function(array_item, array_item_index, an_array)
        if is_condition_match == true then
            table.insert(data_filtered, array_item)
        end
    end
    return data_filtered
end

function array_filter_v2(callback_function, an_array)
    -- JavaScript-like Array.filter() function
    local data_filtered = {}
    for array_item_index, array_item in ipairs(an_array) do
        if callback_function(array_item, array_item_index, an_array) == true then
            table.insert(data_filtered, array_item)
        end
    end
    return data_filtered
end

print('\n-- JavaScript-like Array.filter() in JavaScript-like-Array Lua table')

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
print("numbers: " .. pretty_array_of_primitives(numbers))

print("-- using JavaScript-like Array.filter() function \"array_filter_v1\"")

numbers_even = array_filter_v1(function (number) return ((number % 2) == 0) end, numbers)
print("even numbers only: " .. pretty_array_of_primitives(numbers_even))
-- even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v1(function (number) return ((number % 2) ~= 0) end, numbers)
print("odd numbers only: " .. pretty_array_of_primitives(numbers_odd))
-- odd numbers only: [27, 23, 65, 93, 87]

print("-- using JavaScript-like Array.filter() function \"array_filter_v2\"")

numbers_even = array_filter_v2(function (number) return ((number % 2) == 0) end, numbers)
print("even numbers only: " .. pretty_array_of_primitives(numbers_even))
-- even numbers only: [12, 34, 36, 4, 254]

numbers_odd = array_filter_v2(function (number) return ((number % 2) ~= 0) end, numbers)
print("odd numbers only: " .. pretty_array_of_primitives(numbers_odd))
-- odd numbers only: [27, 23, 65, 93, 87]

print('\n-- JavaScript-like Array.filter() in JavaScript-like-Array-of-Objects Lua table')

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
print("products: " .. pretty_json_stringify(products))

print("-- using JavaScript-like Array.filter() function \"array_filter_v1\"")

products_below_100 = array_filter_v1(function (product) return (product.price <= 100) end, products)
print("products with price <= 100 only: " .. pretty_json_stringify(products_below_100))
-- products with price <= 100 only: [
--     {
--         "code": "potato_chips",
--         "price": 5
--     }
-- ]

products_above_100 = array_filter_v1(function (product) return (product.price >= 100) end, products)
print("products with price >= 100 only: " .. pretty_json_stringify(products_above_100))
-- products with price >= 100 only: [
--     {
--         "code": "pasta",
--         "price": 321
--     },
--     {
--         "code": "bubble_gum",
--         "price": 233
--     },
--     {
--         "code": "towel",
--         "price": 499
--     }
-- ]

print("-- using JavaScript-like Array.filter() function \"array_filter_v2\"")

products_below_100 = array_filter_v2(function (product) return (product.price <= 100) end, products)
print("products with price <= 100 only: " .. pretty_json_stringify(products_below_100))
-- products with price <= 100 only: [
--     {
--         "code": "potato_chips",
--         "price": 5
--     }
-- ]

products_above_100 = array_filter_v2(function (product) return (product.price >= 100) end, products)
print("products with price >= 100 only: " .. pretty_json_stringify(products_above_100))
-- products with price >= 100 only: [
--     {
--         "code": "pasta",
--         "price": 321
--     },
--     {
--         "code": "bubble_gum",
--         "price": 233
--     },
--     {
--         "code": "towel",
--         "price": 499
--     }
-- ]
