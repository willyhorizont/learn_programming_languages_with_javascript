JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

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

-- Array in Lua

fruits = {"apple", "mango", "orange"}
print("fruits: " .. pretty_array_of_primitives(fruits))

print("fruits, length: " .. #fruits)
-- fruits, length: 3

print("fruits, get mango: " .. fruits[2])
-- fruits, get mango: mango

print("fruits, first element: " .. fruits[1])
-- fruits, first element: apple

print("fruits, last element: " .. fruits[#fruits])
-- fruits, last element: orange

for array_item_index, array_item in ipairs(fruits) do
    print("fruits, for loop, index: " .. array_item_index .. ", value: " .. array_item)
end
-- fruits, for loop, index: 1, value: apple
-- fruits, for loop, index: 2, value: mango
-- fruits, for loop, index: 3, value: orange

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
print("products: " .. pretty_json_stringify(products))

for array_item_index, array_item in ipairs(products) do
    for object_key, object_value in pairs(array_item) do
        print("products, loop, index: " .. array_item_index .. ", key: " .. object_key .. ", value: " .. object_value)
    end
end
-- products, loop, index: 1, key: id, value: P1
-- products, loop, index: 1, key: name, value: bubble gum
-- products, loop, index: 2, key: id, value: P1
-- products, loop, index: 2, key: name, value: bubble gum
