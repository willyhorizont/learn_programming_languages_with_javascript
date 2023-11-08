require 'json'

print("\n# JavaScript-like Nullish Coalescing Operator (??) in Ruby")

# There's no JavaScript-like Nullish Coalescing Operator (??) in Ruby.
# But, we can create our own function to mimic it in Ruby.

# JavaScript-like Nullish Coalescing Operator (??) function
nullish_coalescing = ->(anything, default_value) { ((anything == nil) ? default_value : anything) }

JSON_OBJECT = {
    "foo" => {
        "bar" => "baz"
    }
}
print("\nJSON_OBJECT: ", JSON.pretty_generate(JSON_OBJECT, { "indent": " " * 4 }))

print("\n# using JavaScript-like Nullish Coalescing Operator (??) function \"nullish_coalescing\"")

print("\nJSON_OBJECT?.foo?.bar ?? \"not found\": ", nullish_coalescing.(JSON_OBJECT.dig("foo", "bar"), "not found"))
# JSON_OBJECT?.foo?.bar ?? "not found": baz

print("\nJSON_OBJECT?.foo?.baz ?? \"not found\": ", nullish_coalescing.(JSON_OBJECT.dig("foo", "baz"), "not found"))
# JSON_OBJECT?.foo?.baz ?? "not found": not found
