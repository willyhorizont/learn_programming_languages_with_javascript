require "json"

print("\n", "# JavaScript-like Object.values() in Ruby Hash")

friend = {
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
}
print("\n", "friend: ", JSON.pretty_generate(friend, { "indent": " " * 4 }))

print("\n", "friend values: ", JSON.generate(friend.values()).gsub(",", ", "))
# friend values: ["Alisa", "Finland", 25]

print("\n", "friend values: ", JSON.generate(friend.values).gsub(",", ", "))
# friend values: ["Alisa", "Finland", 25]
