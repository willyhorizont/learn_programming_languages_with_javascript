require 'json'

print("\n# JavaScript-like Optional Chaining Operator (?.) in Ruby")

JSON_OBJECT = {
    "foo" => {
        "bar" => "baz"
    },
    "fruits" => ["apple", "mango", "banana"]
}
print("\nJSON_OBJECT: ", JSON.pretty_generate(JSON_OBJECT, { "indent": " " * 4 }))

print("\n# using Ruby Optional Chaining Operator (?.) built-in method \"dig\"")

print("\nJSON_OBJECT?.foo?.bar: ", JSON.pretty_generate(JSON_OBJECT.dig("foo", "bar"), { "indent": " " * 4 }))
# JSON_OBJECT?.foo?.bar: "baz"

print("\nJSON_OBJECT?.foo?.baz: ", JSON.pretty_generate(JSON_OBJECT.dig("foo", "baz"), { "indent": " " * 4 }))
# JSON_OBJECT?.foo?.baz: null

print("\nJSON_OBJECT?.fruits?.[2]: ", JSON.pretty_generate(JSON_OBJECT.dig("fruits", 2), { "indent": " " * 4 }))
# JSON_OBJECT?.fruits?.[2]: "banana"

print("\nJSON_OBJECT?.fruits?.[5]: ", JSON.pretty_generate(JSON_OBJECT.dig("fruits", 5), { "indent": " " * 4 }))
# JSON_OBJECT?.fruits?.[5]: null
