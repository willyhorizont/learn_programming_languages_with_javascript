using Printf
using Statistics
using JSON

# There's no JavaScript-like Spread Syntax in Perl.
# But, we can create our own function to mimic it in Perl.

pretty_array_of_primitives = (an_array_of_primitives) -> string("[", join(an_array_of_primitives, ", "), "]")

println("\n# JavaScript-like Spread Syntax in Julia Array")

my_fruits_in_fridge = ["apple", "mango", "orange"]
println("my fruits in fridge: ", pretty_array_of_primitives(my_fruits_in_fridge))

my_fruits_from_grocery_store = ["melon", "banana"]
println("my fruits from grocery store: ", pretty_array_of_primitives(my_fruits_from_grocery_store))

my_fruits = vcat(my_fruits_in_fridge, my_fruits_from_grocery_store)
println("my fruits: ", pretty_array_of_primitives(my_fruits))
# my fruits: ["apple", "mango", "orange", "melon", "banana"]

println("\n# JavaScript-like Spread Syntax in Julia Array of Dicts")

general_car = Dict(
    "wheels" => 4,
    "tires" => 4,
)
println("general car: ", JSON.json(general_car, 4))

minivan_car = merge(general_car, Dict("doors" => 4))
println("minivan car: ", JSON.json(minivan_car, 4))
# minivan car: {
#     "wheels": 4,
#     "tires": 4,
#     "doors": 4
# }

super_car = merge(general_car, Dict("doors" => 2))
println("super car: ", JSON.json(super_car, 4))
# super car: {
#     "wheels": 4,
#     "tires": 4,
#     "doors": 2
# }
