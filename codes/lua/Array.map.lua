JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

-- There's no JavaScript-like Array.map() in Lua.
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

function get_type(something)
    if type(something) ~= "table" then
       return type(something) 
    end
    if next(something) == nil then
        return "empty_table"
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
        local parameter_type = get_type(parameter)
        if parameter_type == "object" then
            for object_key, object_value in pairs(parameter) do
                new_object[object_key] = object_value
            end
        end
        if parameter_type == "array" then
            for array_item_index, array_item in ipairs(parameter) do
                new_object[tostring(array_item_index)] = array_item
            end
        end
    end
    return new_object
end

function array_map_v1(callback_function, an_array)
    -- JavaScript-like Array.map() function
    local new_array = {}
    for array_item_index, array_item in ipairs(an_array) do
        local new_array_item = callback_function(array_item, array_item_index, an_array)
        table.insert(new_array, new_array_item)
    end
    return new_array
end

function array_map_v2(callback_function, an_array)
    -- JavaScript-like Array.map() function
    local new_array = {}
    for array_item_index, array_item in ipairs(an_array) do
        table.insert(new_array, callback_function(array_item, array_item_index, an_array))
    end
    return new_array
end

print('\n-- JavaScript-like Array.map() in JavaScript-like Array Lua table')

numbers = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
print("numbers: " .. pretty_array_of_primitives(numbers))

print("-- using JavaScript-like Array.map() function \"array_map_v1\"")

numbers_labeled = array_map_v1(function(number) return {[tostring(number)] = ((((number % 2) == 0) and "even") or "odd")} end, numbers)
print("labeled numbers: " .. pretty_json_stringify(numbers_labeled))
-- labeled numbers: [
--     {
--         "12": "even"
--     },
--     {
--         "34": "even"
--     },
--     {
--         "27": "odd"
--     },
--     {
--         "23": "odd"
--     },
--     {
--         "65": "odd"
--     },
--     {
--         "93": "odd"
--     },
--     {
--         "36": "even"
--     },
--     {
--         "87": "odd"
--     },
--     {
--         "4": "even"
--     },
--     {
--         "254": "even"
--     }
-- ]

print("-- using JavaScript-like Array.map() function \"array_map_v2\"")

numbers_labeled = array_map_v2(function(number) return {[tostring(number)] = ((((number % 2) == 0) and "even") or "odd")} end, numbers)
print("labeled numbers: " .. pretty_json_stringify(numbers_labeled))
-- labeled numbers: [
--     {
--         "12": "even"
--     },
--     {
--         "34": "even"
--     },
--     {
--         "27": "odd"
--     },
--     {
--         "23": "odd"
--     },
--     {
--         "65": "odd"
--     },
--     {
--         "93": "odd"
--     },
--     {
--         "36": "even"
--     },
--     {
--         "87": "odd"
--     },
--     {
--         "4": "even"
--     },
--     {
--         "254": "even"
--     }
-- ]

print('\n-- JavaScript-like Array.map() in JavaScript-like Array of Objects Lua table')

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

print("-- using JavaScript-like Array.map() function \"array_map_v1\"")

products_labeled = array_map_v1(function(product) return spread_syntax_object(product, { label = (((product.price > 100) and "expensive") or "cheap") }) end, products)
print("labeled products: " .. pretty_json_stringify(products_labeled))
-- labeled products: [
--     {
--         "code": "pasta",
--         "price": 321,
--         "label": "expensive"
--     },
--     {
--         "code": "bubble_gum",
--         "price": 233,
--         "label": "expensive"
--     },
--     {
--         "code": "potato_chips",
--         "price": 5,
--         "label": "cheap"
--     },
--     {
--         "code": "towel",
--         "price": 499,
--         "label": "expensive"
--     }
-- ]

print("-- using JavaScript-like Array.map() function \"array_map_v2\"")

products_labeled = array_map_v2(function(product) return spread_syntax_object(product, { label = (((product.price > 100) and "expensive") or "cheap") }) end, products)
print("labeled products: " .. pretty_json_stringify(products_labeled))
-- labeled products: [
--     {
--         "code": "pasta",
--         "price": 321,
--         "label": "expensive"
--     },
--     {
--         "code": "bubble_gum",
--         "price": 233,
--         "label": "expensive"
--     },
--     {
--         "code": "potato_chips",
--         "price": 5,
--         "label": "cheap"
--     },
--     {
--         "code": "towel",
--         "price": 499,
--         "label": "expensive"
--     }
-- ]
