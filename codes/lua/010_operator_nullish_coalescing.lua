JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

function sprint(...)
    local parameters = {...}
    local result = ""
    for _, parameter in ipairs(parameters) do
        result = result .. tostring(parameter)
    end
    print(result)
end

print('\n-- JavaScript-like Nullish Coalescing Operator (??) in Lua')

function pretty_json_stringify(anything) return JSON:encode_pretty(anything, 'etc', { pretty=true, indent="    ", array_newline=true }) end

function nullish_coalescing(anything, default_value)
    -- JavaScript-like Nullish Coalescing Operator (??) function
    if (anything == nil) then return default_value else return anything end
end

JSON_OBJECT = {
    foo = {
        bar = "baz",
    },
    fruits = {"apple", "mango", "banana"}
}
sprint("JSON_OBJECT: ", pretty_json_stringify(JSON_OBJECT))

print("-- using JavaScript-like Nullish Coalescing Operator (??) function \"nullish_coalescing\"")

sprint("(JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): ", pretty_json_stringify(nullish_coalescing(JSON_OBJECT["foo"]["bar"], "not found")))
-- (JSON_OBJECT?.foo?.bar ?? 'not found') or (JSON_OBJECT?.['foo']?.['bar'] ?? 'not found'): "baz"

sprint("(JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): ", pretty_json_stringify(nullish_coalescing(JSON_OBJECT["foo"]["baz"], "not found")))
-- (JSON_OBJECT?.foo?.baz ?? 'not found') or (JSON_OBJECT?.['foo']?.['baz'] ?? 'not found'): "not found"

sprint("(JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): ", pretty_json_stringify(nullish_coalescing(JSON_OBJECT["fruits"][2], "not found")))
-- (JSON_OBJECT?.fruits?.[2] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[2] ?? 'not found'): "mango"

sprint("(JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): ", pretty_json_stringify(nullish_coalescing(JSON_OBJECT["fruits"][5], "not found")))
-- (JSON_OBJECT?.fruits?.[5] ?? 'not found') or (JSON_OBJECT?.['fruits']?.[5] ?? 'not found'): "not found"
