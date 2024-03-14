using JSON

println("\n# JavaScript-like Nullish Coalescing Operator (??) in Julia")

# There's no JavaScript-like Nullish Coalescing Operator (??) in Julia.
# But, we can create our own function to mimic it in Julia.

# JavaScript-like Nullish Coalescing Operator (??) function
nullish_coalescing = (anything, default_value) -> ((anything === nothing) ? default_value : anything)

JSON_OBJECT = Dict(
    "foo" => Dict(
        "bar" => "baz"
    ),
    "fruits" => ["apple", "mango", "banana"]
)
println("JSON_OBJECT: ", chomp(JSON.json(JSON_OBJECT, 4)))

println("# using JavaScript-like Nullish Coalescing Operator (??) function \"nullish_coalescing\"")

println("(JSON_OBJECT?.foo?.bar ?? \"not found\"): ", nullish_coalescing(try JSON_OBJECT["foo"]["bar"] catch(err) nothing end, "not found"))
# (JSON_OBJECT?.foo?.bar ?? "not found"): baz

println("(JSON_OBJECT?.foo?.baz ?? \"not found\"): ", nullish_coalescing(try JSON_OBJECT["foo"]["baz"] catch(err) nothing end, "not found"))
# (JSON_OBJECT?.foo?.baz ?? "not found"): not found

println("(JSON_OBJECT?.fruits?.[2] ?? \"not found\"): ", nullish_coalescing(try JSON_OBJECT["fruits"][2] catch(err) nothing end, "not found"))
# (JSON_OBJECT?.fruits?.[2] ?? "not found"): mango

println("(JSON_OBJECT?.fruits?.[5] ?? \"not found\"): ", nullish_coalescing(try JSON_OBJECT["fruits"][5] catch(err) nothing end, "not found"))
# (JSON_OBJECT?.fruits?.[5] ?? "not found"): not found
