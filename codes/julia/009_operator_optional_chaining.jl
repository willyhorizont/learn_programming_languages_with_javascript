using JSON

println("\n# JavaScript-like Optional Chaining Operator (?.) in Julia")

# There's no JavaScript-like Optional Chaining Operator (?.) in Julia.
# But, we can use Julia try-catch block to mimic it in Julia.

JSON_OBJECT = Dict(
    "foo" => Dict(
        "bar" => "baz"
    ),
    "fruits" => ["apple", "mango", "banana"]
)
println("JSON_OBJECT: ", chomp(JSON.json(JSON_OBJECT, 4)))

println("JSON_OBJECT?.foo?.bar: ", try JSON_OBJECT["foo"]["bar"] catch(err) nothing end)
# JSON_OBJECT?.foo?.bar: baz

println("JSON_OBJECT?.foo?.baz: ", try JSON_OBJECT["foo"]["baz"] catch(err) nothing end)
# JSON_OBJECT?.foo?.baz: nothing

println("JSON_OBJECT?.fruits?.[2]: ", try JSON_OBJECT["fruits"][2] catch(err) nothing end)
# JSON_OBJECT?.fruits?.[2]: mango

println("JSON_OBJECT?.fruits?.[5]: ", try JSON_OBJECT["fruits"][5] catch(err) nothing end)
# JSON_OBJECT?.fruits?.[5]: nothing
