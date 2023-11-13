friend = {
    name = "Alisa",
    country = "Finland",
    age = 25
}

-- iterate over and get each key-value pair
for object_key, object_value in pairs(friend) do
    print("friend, loop, key: " .. object_key .. ", value: " .. object_value)
end
-- friend, loop, key: age, value: 25
-- friend, loop, key: name, value: Alisa
-- friend, loop, key: country, value: Finland
