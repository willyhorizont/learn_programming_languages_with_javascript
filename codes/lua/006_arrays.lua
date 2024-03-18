JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

function sprint(...)
    local parameters = {...}
    local result = ""
    for _, parameter in ipairs(parameters) do
        result = result .. tostring(parameter)
    end
    print(result)
end

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

-- Array in Lua

fruits = {"apple", "mango", "orange"}
sprint("fruits: ", pretty_array_of_primitives(fruits))

sprint("fruits, length: ", #fruits)
-- fruits, length: 3

sprint("fruits, get mango: ", fruits[2])
-- fruits, get mango: mango

sprint("fruits, first element: ", fruits[1])
-- fruits, first element: apple

sprint("fruits, last element: ", fruits[#fruits])
-- fruits, last element: orange

for array_item_index, array_item in ipairs(fruits) do
    sprint("fruits, for for loop, index: ", array_item_index, ", value: ", array_item)
end
-- fruits, for for loop, index: 1, value: apple
-- fruits, for for loop, index: 2, value: mango
-- fruits, for for loop, index: 3, value: orange

-- Array of Objects in Lua

products = {
    {
        id = "P1",
        name = "bubble gum"
    },
    {
        id = "P1",
        name = "bubble gum"
    }
}
sprint("products: ", pretty_json_stringify(products))

for array_item_index, array_item in ipairs(products) do
    iteration_index = 0
    for object_key, object_value in pairs(array_item) do
        sprint("products, for loop, array item index: ", array_item_index, ", iteration/entry index: ", iteration_index, ", key: ", object_key, ", value: ", object_value)
        iteration_index = iteration_index + 1
    end
end
-- products, for loop, array item index: 1, iteration/entry index: 0, key: id, value: P1
-- products, for loop, array item index: 1, iteration/entry index: 1, key: name, value: bubble gum
-- products, for loop, array item index: 2, iteration/entry index: 0, key: id, value: P1
-- products, for loop, array item index: 2, iteration/entry index: 1, key: name, value: bubble gum
