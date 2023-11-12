JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

-- There's no JavaScript-like Array.findIndex() in Lua.
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

function array_find_index_v1(callback_function, an_array)
    -- JavaScript-like Array.findIndex() function
    local item_index = -1
    for array_item_index, array_item in ipairs(an_array) do
        local is_condition_match = callback_function(array_item, array_item_index, an_array)
        if is_condition_match == true then
            item_index = array_item_index
            break
        end
    end
    return item_index
end

function array_find_index_v2(callback_function, an_array)
    -- JavaScript-like Array.findIndex() function
    local item_index = -1
    for array_item_index, array_item in ipairs(an_array) do
        if callback_function(array_item, array_item_index, an_array) == true then
            item_index = array_item_index
            break
        end
    end
    return item_index
end

function array_find_index_v3(callback_function, an_array)
    -- JavaScript-like Array.findIndex() function
    local item_index = -1
    for array_item_index, array_item in ipairs(an_array) do
        local is_condition_match = callback_function(array_item, array_item_index, an_array)
        if is_condition_match == true then
            return array_item_index
        end
    end
    return item_index
end

function array_find_index_v4(callback_function, an_array)
    -- JavaScript-like Array.findIndex() function
    local item_index = -1
    for array_item_index, array_item in ipairs(an_array) do
        if callback_function(array_item, array_item_index, an_array) == true then
            return array_item_index
        end
    end
    return item_index
end

function array_find_index_v5(callback_function, an_array)
    -- JavaScript-like Array.findIndex() function
    for array_item_index, array_item in ipairs(an_array) do
        local is_condition_match = callback_function(array_item, array_item_index, an_array)
        if is_condition_match == true then
            return array_item_index
        end
    end
    return -1
end

function array_find_index_v6(callback_function, an_array)
    -- JavaScript-like Array.findIndex() function
    for array_item_index, array_item in ipairs(an_array) do
        if callback_function(array_item, array_item_index, an_array) == true then
            return array_item_index
        end
    end
    return -1
end

print('\n-- JavaScript-like Array.findIndex() in JavaScript-like-Array Lua table')

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
print("numbers: " .. pretty_array_of_primitives(numbers))

number_to_find = 27
print("number to find: " .. number_to_find)

print("-- using JavaScript-like Array.findIndex() function \"array_find_index_v1\"")

number_found_index = array_find_index_v1(function (number) return (number == number_to_find) end, numbers)
print("number found index: " .. number_found_index)
-- number found index: 3

print("-- using JavaScript-like Array.findIndex() function \"array_find_index_v2\"")

number_found_index = array_find_index_v2(function (number) return (number == number_to_find) end, numbers)
print("number found index: " .. number_found_index)
-- number found index: 3

print("-- using JavaScript-like Array.findIndex() function \"array_find_index_v3\"")

number_found_index = array_find_index_v3(function (number) return (number == number_to_find) end, numbers)
print("number found index: " .. number_found_index)
-- number found index: 3

print("-- using JavaScript-like Array.findIndex() function \"array_find_index_v4\"")

number_found_index = array_find_index_v4(function (number) return (number == number_to_find) end, numbers)
print("number found index: " .. number_found_index)
-- number found index: 3

print("-- using JavaScript-like Array.findIndex() function \"array_find_index_v5\"")

number_found_index = array_find_index_v5(function (number) return (number == number_to_find) end, numbers)
print("number found index: " .. number_found_index)
-- number found index: 3

print("-- using JavaScript-like Array.findIndex() function \"array_find_index_v6\"")

number_found_index = array_find_index_v6(function (number) return (number == number_to_find) end, numbers)
print("number found index: " .. number_found_index)
-- number found index: 3

print('\n-- JavaScript-like Array.findIndex() in JavaScript-like-Array-of-Objects Lua table')

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

product_to_find = "pasta"
print("product to find: " .. product_to_find)

print("-- using JavaScript-like Array.findIndex() function \"array_find_index_v1\"")

product_found_index = array_find_index_v1(function (product) return (product.code == product_to_find) end, products)
print("product found index: " .. product_found_index)
-- product found index: 1

print("-- using JavaScript-like Array.findIndex() function \"array_find_index_v2\"")

product_found_index = array_find_index_v2(function (product) return (product.code == product_to_find) end, products)
print("product found index: " .. product_found_index)
-- product found index: 1

print("-- using JavaScript-like Array.findIndex() function \"array_find_index_v3\"")

product_found_index = array_find_index_v3(function (product) return (product.code == product_to_find) end, products)
print("product found index: " .. product_found_index)
-- product found index: 1

print("-- using JavaScript-like Array.findIndex() function \"array_find_index_v4\"")

product_found_index = array_find_index_v4(function (product) return (product.code == product_to_find) end, products)
print("product found index: " .. product_found_index)
-- product found index: 1

print("-- using JavaScript-like Array.findIndex() function \"array_find_index_v5\"")

product_found_index = array_find_index_v5(function (product) return (product.code == product_to_find) end, products)
print("product found index: " .. product_found_index)
-- product found index: 1

print("-- using JavaScript-like Array.findIndex() function \"array_find_index_v6\"")

product_found_index = array_find_index_v6(function (product) return (product.code == product_to_find) end, products)
print("product found index: " .. product_found_index)
-- product found index: 1
