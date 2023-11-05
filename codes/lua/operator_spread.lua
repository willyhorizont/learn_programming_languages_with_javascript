JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

-- There's no JavaScript-like Spread Syntax in Lua.
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

print('\n-- JavaScript-like Spread Syntax in JavaScript-like Array Lua table')

my_fruits_in_fridge = {"apple", "mango", "orange"}
print("my fruits in fridge: " .. pretty_array_of_primitives(my_fruits_in_fridge))

my_fruits_from_grocery_store = {"melon", "banana"}
print("my fruits from grocery store: " .. pretty_array_of_primitives(my_fruits_from_grocery_store))

my_fruits = spread_syntax_array(my_fruits_in_fridge, my_fruits_from_grocery_store)
print("my fruits: " .. pretty_array_of_primitives(my_fruits))
-- my fruits: ["apple", "mango", "orange", "melon", "banana"]

print('\n-- JavaScript-like Spread Syntax in JavaScript-like Array of Objects Lua table')

general_car = {
    wheels = 4,
    tires = 4,
}
print("general car: " .. pretty_json_stringify(general_car))

minivan_car = spread_syntax_object(general_car, { doors = 4 })
print("minivan car: " .. pretty_json_stringify(minivan_car))
-- minivan car: {
--     "wheels": 4,
--     "tires": 4,
--     "doors": 4
-- }

super_car = spread_syntax_object(general_car, { doors = 2 })
print("super car: " .. pretty_json_stringify(super_car))
-- super car: {
--     "wheels": 4,
--     "tires": 4,
--     "doors": 2
-- }
