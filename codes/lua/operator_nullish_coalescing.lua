JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

print('\n-- JavaScript-like Nullish Coalescing Operator (??) in Lua')

-- There's no JavaScript-like Nullish Coalescing Operator (??) in Lua.
-- But, we can create our own function to mimic it in Lua.

function pretty_json_stringify(anything) return JSON:encode_pretty(anything, 'etc', { pretty=true, indent="    ", array_newline=true }) end

function array_reduce(callback_function, an_array, initial_value)
    -- JavaScript-like Array.reduce() function
    local result = nil
    for array_item_index, array_item in ipairs(an_array) do
        result = callback_function((((array_item_index == 1) and initial_value) or result), array_item, array_item_index, an_array)
    end
    return result
end

function optional_chaining_v2(an_object, object_properties_string)
    -- JavaScript-like Optional Chaining Operator (?.) function
    local object_properties_array = {}
    for match in object_properties_string:gmatch("([^%.]+)") do
        table.insert(object_properties_array, match)
    end
    return array_reduce(function (current_result, current_item) return (((current_result == nil) and (an_object[current_item] or nil)) or (current_result[current_item] or nil)) end, object_properties_array, nil)
end

function nullish_coalescing(anything, default_value)
    -- JavaScript-like Nullish Coalescing Operator (??) function
    if (anything == nil) then
        return default_value
    else
        return anything
    end
end

JSON_OBJECT = {
    foo = {
        bar = "baz",
    }
}
print("JSON_OBJECT: " .. pretty_json_stringify(JSON_OBJECT))

print("-- using JavaScript-like Nullish Coalescing Operator (??) function \"nullish_coalescing\"")

print("JSON_OBJECT?.foo?.bar ?? \"not found\": " .. nullish_coalescing(optional_chaining_v2(JSON_OBJECT, "foo.bar"), "not found"))
-- JSON_OBJECT?.foo?.bar ?? "not found": baz

print("JSON_OBJECT?.foo?.baz ?? \"not found\": " .. nullish_coalescing(optional_chaining_v2(JSON_OBJECT, "foo.baz"), "not found"))
-- JSON_OBJECT?.foo?.baz ?? "not found": not found
