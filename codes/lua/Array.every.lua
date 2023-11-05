JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

-- There's no JavaScript-like Array.every() in Lua.
-- But, we can create our own function to mimic it in Lua.

function pretty_json_stringify(aJson) return JSON:encode_pretty(aJson, 'etc', { pretty=true, indent="    ", array_newline=true }) end

function pretty_array_of_primitives(an_array_of_primitives)
    local result = "["
    for array_item_index, array_item in ipairs(an_array_of_primitives) do
        if type(array_item) ~= "string" and type(array_item) ~= "number" then
            goto next
        end
        if type(array_item) == "string" then
            result = result .. "\"" .. array_item .. "\""
        end
        if type(array_item) == "number" then
            result = result .. array_item
        end
        if array_item_index ~= #an_array_of_primitives then
            result = result .. ", "
        end
        ::next::
    end
    result = result .. "]"
    return result
end

function array_every_v1(callback_function, an_array)
    -- JavaScript-like Array.every() function
    local is_condition_match = true
    for array_item_index, array_item in ipairs(an_array) do
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if is_condition_match == false then
            break
        end
    end
    return is_condition_match
end

function array_every_v2(callback_function, an_array)
    -- JavaScript-like Array.every() function
    local is_condition_match = true
    for array_item_index, array_item in ipairs(an_array) do
        is_condition_match = callback_function(array_item, array_item_index, an_array)
        if is_condition_match == false then
            return is_condition_match
        end
    end
    return is_condition_match
end

function array_every_v3(callback_function, an_array)
    -- JavaScript-like Array.every() function
    for array_item_index, array_item in ipairs(an_array) do
        local is_condition_match = callback_function(array_item, array_item_index, an_array)
        if is_condition_match == false then
            return false
        end
    end
    return true
end

function array_every_v4(callback_function, an_array)
    -- JavaScript-like Array.every() function
    for array_item_index, array_item in ipairs(an_array) do
        if callback_function(array_item, array_item_index, an_array) == false then
            return false
        end
    end
    return true
end

print("\n-- JavaScript-like Array.every() in JavaScript-like Array Lua table")

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
print("numbers: " .. pretty_array_of_primitives(numbers))

print("-- using JavaScript-like Array.every() function \"array_every_v1\"")

is_all_number_less_than_500 = array_every_v1(function (number) return number < 500 end, numbers)
print("is all number < 500: " .. tostring(is_all_number_less_than_500))
-- is all number < 500: true

is_all_number_more_than_500 = array_every_v1(function (number) return number > 500 end, numbers)
print("is all number > 500: " .. tostring(is_all_number_more_than_500))
-- is all number > 500: false

print("-- using JavaScript-like Array.every() function \"array_every_v2\"")

is_all_number_less_than_500 = array_every_v2(function (number) return number < 500 end, numbers)
print("is all number < 500: " .. tostring(is_all_number_less_than_500))
-- is all number < 500: true

is_all_number_more_than_500 = array_every_v2(function (number) return number > 500 end, numbers)
print("is all number > 500: " .. tostring(is_all_number_more_than_500))
-- is all number > 500: false

print("-- using JavaScript-like Array.every() function \"array_every_v3\"")

is_all_number_less_than_500 = array_every_v3(function (number) return number < 500 end, numbers)
print("is all number < 500: " .. tostring(is_all_number_less_than_500))
-- is all number < 500: true

is_all_number_more_than_500 = array_every_v3(function (number) return number > 500 end, numbers)
print("is all number > 500: " .. tostring(is_all_number_more_than_500))
-- is all number > 500: false

print("-- using JavaScript-like Array.every() function \"array_every_v4\"")

is_all_number_less_than_500 = array_every_v4(function (number) return number < 500 end, numbers)
print("is all number < 500: " .. tostring(is_all_number_less_than_500))
-- is all number < 500: true

is_all_number_more_than_500 = array_every_v4(function (number) return number > 500 end, numbers)
print("is all number > 500: " .. tostring(is_all_number_more_than_500))
-- is all number > 500: false

print("\n-- JavaScript-like Array.every() in JavaScript-like Array of Objects Lua table")

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

print("-- using JavaScript-like Array.every() function \"array_every_v1\"")

is_all_product_price_less_than_500 = array_every_v1(function (product) return product.price < 500 end, products)
print("is all product price < 500: " .. tostring(is_all_product_price_less_than_500))
-- is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v1(function (product) return product.price > 500 end, products)
print("is all product price > 500: " .. tostring(is_all_product_price_more_than_500))
-- is all product price > 500: false

print("-- using JavaScript-like Array.every() function \"array_every_v2\"")

is_all_product_price_less_than_500 = array_every_v2(function (product) return product.price < 500 end, products)
print("is all product price < 500: " .. tostring(is_all_product_price_less_than_500))
-- is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v2(function (product) return product.price > 500 end, products)
print("is all product price > 500: " .. tostring(is_all_product_price_more_than_500))
-- is all product price > 500: false

print("-- using JavaScript-like Array.every() function \"array_every_v3\"")

is_all_product_price_less_than_500 = array_every_v3(function (product) return product.price < 500 end, products)
print("is all product price < 500: " .. tostring(is_all_product_price_less_than_500))
-- is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v3(function (product) return product.price > 500 end, products)
print("is all product price > 500: " .. tostring(is_all_product_price_more_than_500))
-- is all product price > 500: false

print("-- using JavaScript-like Array.every() function \"array_every_v4\"")

is_all_product_price_less_than_500 = array_every_v4(function (product) return product.price < 500 end, products)
print("is all product price < 500: " .. tostring(is_all_product_price_less_than_500))
-- is all product price < 500: true

is_all_product_price_more_than_500 = array_every_v4(function (product) return product.price > 500 end, products)
print("is all product price > 500: " .. tostring(is_all_product_price_more_than_500))
-- is all product price > 500: false
