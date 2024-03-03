using Printf
using Statistics
using JSON

function pretty_array_of_primitives(an_array_of_primitives)
    result = "["
    for (array_item_index, array_item) in enumerate(an_array_of_primitives)
        if ((isa(array_item, AbstractString) === false) && (isa(array_item, Number) === false) && (isa(array_item, Bool) === false) && array_item !== nothing)
            continue
        end
        if (isa(array_item, AbstractString) === true)
            result = string(result, "\"", array_item, "\"")
        end
        if (array_item === nothing)
            result = string(result, "null")
        end
        if ((isa(array_item, Number) === true) || (isa(array_item, Bool) === true))
            result = string(result, array_item)
        end
        if (array_item_index !== length(an_array_of_primitives))
            result = string(result, ", ")
        end
    end
    result = string(result, "]")
    return result
end

function array_to_object(an_array)
    new_object = Dict()
    for (array_item_index, array_item) in enumerate(an_array)
        new_object[array_item_index] = array_item
    end
    return new_object
end

println("\n# JavaScript-like Spread Syntax (...) in Julia")

fruits = ["Mango", "Melon", "Banana"]
println("fruits: ", pretty_array_of_primitives(fruits))

vegetables = ["Carrot", "Tomato"]
println("vegetables: ", pretty_array_of_primitives(vegetables))

country_capitals_in_asia = Dict(
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
)
println("country_capitals_in_asia: ", JSON.json(country_capitals_in_asia, 4))

country_capitals_in_europe = Dict(
    "France" => "Paris",
    "England" => "London"
)
println("country_capitals_in_europe: ", JSON.json(country_capitals_in_europe, 4))

println("# [...array1, ...array2]:\n")

combination1 = [fruits..., vegetables...]
println("combination1: ", JSON.json(combination1, 4))
# combination1: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Carrot",
#     "Tomato"
# ]

combination2 = [fruits..., ["Cucumber", "Onions"]...]
println("combination2: ", JSON.json(combination2, 4))
# combination2: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Cucumber",
#     "Onions"
# ]

println("# { ...object1, ...object2 }:\n")

combination3 = Dict(country_capitals_in_asia..., country_capitals_in_europe...)
println("combination3: ", JSON.json(combination3, 4))
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

combination4 = Dict(country_capitals_in_asia..., Dict("Germany" => "Berlin", "Italy" => "Rome")...)
println("combination4: ", JSON.json(combination4, 4))
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

println("# [...array1, array2]:\n")

combination5 = [fruits..., vegetables]
println("combination5: ", JSON.json(combination5, 4))
# combination5: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Carrot",
#         "Tomato"
#     ]
# ]

combination6 = [fruits..., ["Cucumber", "Onions"]]
println("combination6: ", JSON.json(combination6, 4))
# combination6: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Cucumber",
#         "Onions"
#     ]
# ]

println("# [...array1, object1]:\n")

combination7 = [fruits..., country_capitals_in_asia]
println("combination7: ", JSON.json(combination7, 4))
# combination7: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Thailand": "Bangkok",
#         "China": "Beijing",
#         "Japan": "Tokyo"
#     }
# ]

combination8 = [fruits..., Dict("Germany" => "Berlin", "Italy" => "Rome")]
println("combination8: ", JSON.json(combination8, 4))
# combination8: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# ]

println("# { ...object1, object2 }:\n")

combination9 = Dict(country_capitals_in_asia..., "country_capitals_in_europe" => country_capitals_in_europe)
println("combination9: ", JSON.json(combination9, 4))
# combination9: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "country_capitals_in_europe" : {
#       "France" : "Paris",
#       "England" : "London"
#    }
# }

combination10 = Dict(country_capitals_in_asia..., "country_capitals_in_europe" => Dict("Germany" => "Berlin", "Italy" => "Rome"))
println("combination10: ", JSON.json(combination10, 4))
# combination10: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "country_capitals_in_europe": {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# }

println("# { ...object1, array2 }:\n")

combination11 = Dict(country_capitals_in_asia..., "vegetables" => vegetables)
println("combination11: ", JSON.json(combination11, 4))
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

combination12 = Dict(country_capitals_in_asia..., "vegetables" => ["Cucumber", "Onions"])
println("combination12: ", JSON.json(combination12, 4))
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Onions"
#     ]
# }

println("# { ...object1, ...array2 }:\n")

combination13 = Dict(country_capitals_in_asia..., array_to_object(vegetables)...)
println("combination13: ", JSON.json(combination13, 4))
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Carrot",
#    "2" : "Tomato"
# }

combination14 = Dict(country_capitals_in_asia..., array_to_object(["Cucumber", "Onions"])...)
println("combination14: ", JSON.json(combination14, 4))
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Cucumber",
#    "2" : "Onions"
# }

# println("# [...array1, ...object1]: // this combination throw an error in JavaScript\n")

# this combination throw an error in JavaScript
# combination_error_in_javascript1 = [fruits..., country_capitals_in_asia...]
# println("combination_error_in_javascript1: ", JSON.json(combination_error_in_javascript1, 4))

# this combination throw an error in JavaScript
# combination_error_in_javascript2 = [fruits..., Dict("Germany" => "Berlin", "Italy" => "Rome")...]
# println("combination_error_in_javascript2: ", JSON.json(combination_error_in_javascript2, 4))
