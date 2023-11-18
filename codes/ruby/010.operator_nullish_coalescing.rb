require 'json'

print("\n# JavaScript-like Nullish Coalescing Operator (??) in Ruby")

# There's no JavaScript-like Nullish Coalescing Operator (??) in Ruby.
# But, we can create our own function to mimic it in Ruby.

# JavaScript-like Nullish Coalescing Operator (??) function
nullish_coalescing = ->(anything, default_value) { ((anything == nil) ? default_value : anything) }

JSON_OBJECT = {
    "foo" => {
        "bar" => "baz"
    },
    "fruits" => ["apple", "mango", "banana"]
}
print("\nJSON_OBJECT: ", JSON.pretty_generate(JSON_OBJECT, { "indent": " " * 4 }))

print("\n# using JavaScript-like Nullish Coalescing Operator (??) function \"nullish_coalescing\"")

print("\n(JSON_OBJECT?.foo?.bar ?? \"not found\"): ", JSON.pretty_generate(nullish_coalescing.(JSON_OBJECT.dig("foo", "bar"), "not found"), { "indent": " " * 4 }))
# (JSON_OBJECT?.foo?.bar ?? "not found"): "baz"

print("\n(JSON_OBJECT?.foo?.baz ?? \"not found\"): ", JSON.pretty_generate(nullish_coalescing.(JSON_OBJECT.dig("foo", "baz"), "not found"), { "indent": " " * 4 }))
# (JSON_OBJECT?.foo?.baz ?? "not found"): "not found"

print("\n(JSON_OBJECT?.fruits?.[2] ?? \"not found\"): ", JSON.pretty_generate(nullish_coalescing.(JSON_OBJECT.dig("fruits", 2), "not found"), { "indent": " " * 4 }))
# (JSON_OBJECT?.fruits?.[2] ?? "not found"): "banana"

print("\n(JSON_OBJECT?.fruits?.[5] ?? \"not found\"): ", JSON.pretty_generate(nullish_coalescing.(JSON_OBJECT.dig("fruits", 5), "not found"), { "indent": " " * 4 }))
# (JSON_OBJECT?.fruits?.[5] ?? "not found"): "not found"
