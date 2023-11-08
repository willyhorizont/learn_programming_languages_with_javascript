JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

print('\n-- JavaScript-like Optional Chaining Operator (?.) in Lua')

-- There's no JavaScript-like Optional Chaining Operator (?.) in Lua.
-- But, we can create our own function to mimic it in Lua.

function pretty_json_stringify(aJson) return JSON:encode_pretty(aJson, 'etc', { pretty=true, indent="    ", array_newline=true }) end

function array_reduce(callback_function, an_array, initial_value)
    -- JavaScript-like Array.reduce() function
    local result = nil
    for array_item_index, array_item in ipairs(an_array) do
        result = callback_function((((array_item_index == 1) and initial_value) or result), array_item, array_item_index, an_array)
    end
    return result
end

function optional_chaining_v1(an_object, ...)
    -- JavaScript-like Optional Chaining Operator (?.) function
    local object_properties_array = {...}
    return array_reduce(function (current_result, current_item) return (((current_result == nil) and (an_object[current_item] or nil)) or (current_result[current_item] or nil)) end, object_properties_array, nil)
end

function optional_chaining_v2(an_object, object_properties_string)
    -- JavaScript-like Optional Chaining Operator (?.) function
    local object_properties_array = {}
    for match in object_properties_string:gmatch("([^%.]+)") do
        table.insert(object_properties_array, match)
    end
    return array_reduce(function (current_result, current_item) return (((current_result == nil) and (an_object[current_item] or nil)) or (current_result[current_item] or nil)) end, object_properties_array, nil)
end

JSON_OBJECT = {
    foo = {
        bar = "baz",
    }
}
print("JSON_OBJECT: " .. pretty_json_stringify(JSON_OBJECT))

print("-- using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v1\"")

print("JSON_OBJECT?.foo?.bar: " .. optional_chaining_v1(JSON_OBJECT, "foo", "bar"))
-- JSON_OBJECT?.foo?.bar: baz

print("JSON_OBJECT?.foo?.baz: " .. optional_chaining_v1(JSON_OBJECT, "foo", "baz"))
-- JSON_OBJECT?.foo?.baz: undefined

print("-- using JavaScript-like Optional Chaining Operator (?.) function \"optional_chaining_v2\"")

print("JSON_OBJECT?.foo?.bar: " .. optional_chaining_v2(JSON_OBJECT, "foo.bar"))
-- JSON_OBJECT?.foo?.bar: baz

print("JSON_OBJECT?.foo?.baz: " .. optional_chaining_v2(JSON_OBJECT, "foo.baz"))
-- JSON_OBJECT?.foo?.baz: undefined
