require "json"

print("\n", "# JavaScript-like Object.keys() in Ruby Hash")

friend = {
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
}
print("\n", "friend: ", JSON.pretty_generate(friend, { "indent": " " * 4 }))

print("\n", "friend keys: ", JSON.generate(friend.keys).gsub(",", ", "))
# friend keys: ["name", "country", "age"]
