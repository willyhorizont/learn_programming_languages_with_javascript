JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

-- There's no JavaScript-like Array.reduce() in Lua.
-- But, we can create our own function to mimic it in Lua.

function pretty_json_stringify(aJson) return JSON:encode_pretty(aJson, 'etc', { pretty=true, indent="    ", array_newline=true }) end

function pretty_array_of_primitives(an_array_of_primitives)
    local result = "["
    for array_item_index, array_item in ipairs(an_array_of_primitives) do
        if type(array_item) ~= "string" and type(array_item) ~= "number" then
            goto last
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
        ::last::
    end
    result = result .. "]"
    return result
end

function get_type(something)
    if type(something) ~= "table" then
       return type(something) 
    end
    for k, v in pairs(something) do
        if type(k) == "number" and (k >= 1 and k <= #something) then
            return "array"
        end
    end
    return "object"
end

spread_syntax_object = function(...)
    local parameters = {...}
    local new_object = {}
    for parameter_index, parameter in ipairs(parameters) do
        if get_type(parameter) == "object" then
            for object_key, object_value in pairs(parameter) do
                new_object[object_key] = object_value
            end
        end
        if get_type(parameter) == "array" then
            for array_item_index, array_item in ipairs(parameter) do
                new_object[tostring(array_item_index)] = array_item
            end
        end
    end
    return new_object
end

spread_syntax_array = function(...)
    local parameters = {...}
    local new_array = {}
    for parameter_index, an_array in ipairs(parameters) do
        for array_item_index, array_item in ipairs(an_array) do
            table.insert(new_array, array_item)
        end
    end
    return new_array
end

function array_reduce(callback_function, an_array, initial_value)
    -- JavaScript-like Array.reduce() function
    local result = nil
    for array_item_index, array_item in ipairs(an_array) do
        result = callback_function((((array_item_index == 1) and initial_value) or result), array_item, array_item_index, an_array)
    end
    return result
end

print('\n-- JavaScript-like Array.reduce() in JavaScript-like Array Lua table')

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
print("numbers: " .. pretty_array_of_primitives(numbers))

print("-- using JavaScript-like Array.reduce() function \"array_reduce\"")

numbers_total = array_reduce(function(current_result, current_number) return (current_result + current_number) end, numbers, 0)
print("total number: " .. pretty_json_stringify(numbers_total))
-- total number: 635

print('\n-- JavaScript-like Array.reduce() in JavaScript-like Array of Objects Lua table')

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

print("-- using JavaScript-like Array.reduce() function \"array_reduce\"")

products_grouped = array_reduce(function(current_result, current_product) return (((current_product.price > 100) and spread_syntax_object(current_result, { expensive = spread_syntax_array(current_result.expensive, current_product) })) or spread_syntax_object(current_result, { cheap = spread_syntax_array(current_result.cheap, current_product) })) end, products, { expensive = {}, cheap = {} })
print("grouped products: " .. pretty_json_stringify(products_grouped))
-- grouped products: {
--     "expensive": [
--         {
--             "code": "bubble_gum",
--             "price": 233
--         },
--         {
--             "code": "towel",
--             "price": 499
--         }
--     ],
--     "cheap": [
--         {
--             "code": "pasta",
--             "price": 30
--         },
--         {
--             "code": "potato_chips",
--             "price": 5
--         }
--     ]
-- }
