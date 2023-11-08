require 'json'

print("\n# JavaScript-like Optional Chaining Operator (?.) in Ruby")

JSON_OBJECT = {
    "foo" => {
        "bar" => "baz"
    }
}
print("\nJSON_OBJECT: ", JSON.pretty_generate(JSON_OBJECT, { "indent": " " * 4 }))

print("\n# using Ruby Optional Chaining Operator (?.) built-in function \"dig\"")

print("\nJSON_OBJECT?.foo?.bar: ", JSON_OBJECT.dig("foo", "bar"))
# JSON_OBJECT?.foo?.bar: baz

print("\nJSON_OBJECT?.foo?.baz: ", JSON_OBJECT.dig("foo", "baz"))
# JSON_OBJECT?.foo?.baz: nil
