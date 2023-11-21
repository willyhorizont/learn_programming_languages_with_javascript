JSON = (loadfile "utils/JSON.lua")() -- Thanks to Jeffrey Friedl's awesome work, checkout his awesome personal blog at http://regex.info/blog/lua/json

function pretty_json_stringify(anything) return JSON:encode_pretty(anything, 'etc', { pretty=true, indent="    ", array_newline=true }) end

friend = {
    name = "Alisa",
    country = "Finland",
    age = 25
}
print("friend: " .. pretty_json_stringify(friend))

print("friend, get country: " .. friend["country"])
-- friend, get country: Finland

-- iterate over and get each key-value pair
for object_key, object_value in pairs(friend) do
    print("friend, loop, key: " .. object_key .. ", value: " .. object_value)
end
-- friend, loop, key: age, value: 25
-- friend, loop, key: name, value: Alisa
-- friend, loop, key: country, value: Finland

-- iterate over and get each key-value pair and iteration/entry index
iteration_index = 0
for object_key, object_value in pairs(friend) do
    print("friend, loop, index: " .. iteration_index .. ", key: " .. object_key .. ", value: " .. object_value)
    iteration_index = iteration_index + 1
end
-- friend, loop, index: 0, key: name, value: Alisa
-- friend, loop, index: 1, key: age, value: 25
-- friend, loop, index: 2, key: country, value: Finland
