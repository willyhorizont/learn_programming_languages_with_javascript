require "json"

print("\n", "# JavaScript-like Object.entries() in Ruby Hash")

friend = {
    "name" => "Alisa",
    "country" => "Finland",
    "age" => 25
}
print("\n", "friend: ", JSON.pretty_generate(friend, { "indent": " " * 4 }))

print("\n", "friend entries: ", JSON.generate(friend.entries()).gsub(",", ", "))
# friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]

print("\n", "friend entries: ", JSON.generate(friend.entries).gsub(",", ", "))
# friend entries: [["name", "Alisa"], ["country", "Finland"], ["age", 25]]
