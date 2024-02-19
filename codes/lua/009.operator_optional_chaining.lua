JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

function s_print(...)
    local parameters = {...}
    local result = ""
    for _, parameter in ipairs(parameters) do
        result = result .. tostring(parameter)
    end
    print(result)
end

print('\n-- JavaScript-like Optional Chaining Operator (?.) in Lua')

-- There's no JavaScript-like Optional Chaining Operator (?.) in Lua.
-- But, we don't need that in Lua.

function pretty_json_stringify(anything) return JSON:encode_pretty(anything, 'etc', { pretty=true, indent="    ", array_newline=true }) end

JSON_OBJECT = {
    foo = {
        bar = "baz",
    },
    fruits = {"apple", "mango", "banana"}
}
s_print("JSON_OBJECT: ", pretty_json_stringify(JSON_OBJECT))

s_print("JSON_OBJECT?.foo?.bar: ", pretty_json_stringify(JSON_OBJECT["foo"]["bar"]))
-- JSON_OBJECT?.foo?.bar: "baz"

s_print("JSON_OBJECT?.foo?.baz: ", pretty_json_stringify(JSON_OBJECT["foo"]["baz"]))
-- JSON_OBJECT?.foo?.baz: null

s_print("JSON_OBJECT?.fruits?.[2]: ", pretty_json_stringify(JSON_OBJECT["fruits"][2]))
-- JSON_OBJECT?.fruits?.[2]: "mango"

s_print("JSON_OBJECT?.fruits?.[5]: ", pretty_json_stringify(JSON_OBJECT["fruits"][5]))
-- JSON_OBJECT?.fruits?.[5]: null
