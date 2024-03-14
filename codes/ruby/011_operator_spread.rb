require "json"

array_to_object = ->(an_array) do
    new_object = {}
    an_array.each_with_index do |array_item, array_item_index|
        new_object[array_item_index] = array_item
    end
    return new_object
end

print("\n", "# JavaScript-like Spread Syntax (...) in Ruby")

fruits = ["Mango", "Melon", "Banana"]
print("\n", "fruits: ", fruits)

vegetables = ["Carrot", "Tomato"]
print("\n", "vegetables: ", vegetables)

country_capitals_in_asia = {
    "Thailand" => "Bangkok",
    "China" => "Beijing",
    "Japan" => "Tokyo"
}
print("\n", "country_capitals_in_asia: ", JSON.pretty_generate(country_capitals_in_asia, { "indent": " " * 4 }))

country_capitals_in_europe = {
    "France" => "Paris",
    "England" => "London"
}
print("\n", "country_capitals_in_europe: ", JSON.pretty_generate(country_capitals_in_europe, { "indent": " " * 4 }))

print("\n", "# [...array1, ...array2]:\n")

combination1 = [*fruits, *vegetables]
print("\n", "combination1: ", JSON.pretty_generate(combination1, { "indent": " " * 4 }))
# combination1: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Carrot",
#     "Tomato"
# ]

combination2 = [*fruits, *["Cucumber", "Onion"]]
print("\n", "combination2: ", JSON.pretty_generate(combination2, { "indent": " " * 4 }))
# combination2: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Cucumber",
#     "Onion"
# ]

print("\n", "# { ...object1, ...object2 }:\n")

combination3 = {**country_capitals_in_asia, **country_capitals_in_europe}
print("\n", "combination3: ", JSON.pretty_generate(combination3, { "indent": " " * 4 }))
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

combination4 = {**country_capitals_in_asia, **{"Germany" => "Berlin", "Italy" => "Rome"}}
print("\n", "combination4: ", JSON.pretty_generate(combination4, { "indent": " " * 4 }))
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

print("\n", "# [...array1, array2]:\n")

combination5 = [*fruits, vegetables]
print("\n", "combination5: ", JSON.pretty_generate(combination5, { "indent": " " * 4 }))
# combination5: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Carrot",
#         "Tomato"
#     ]
# ]

combination6 = [*fruits, ["Cucumber", "Onion"]]
print("\n", "combination6: ", JSON.pretty_generate(combination6, { "indent": " " * 4 }))
# combination6: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Cucumber",
#         "Onion"
#     ]
# ]

print("\n", "# [...array1, object1]:\n")

combination7 = [*fruits, country_capitals_in_asia]
print("\n", "combination7: ", JSON.pretty_generate(combination7, { "indent": " " * 4 }))
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

combination8 = [*fruits, {"Germany" => "Berlin", "Italy" => "Rome"}]
print("\n", "combination8: ", JSON.pretty_generate(combination8, { "indent": " " * 4 }))
# combination8: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# ]

print("\n", "# { ...object1, object2 }:\n")

combination9 = {**country_capitals_in_asia, "country_capitals_in_europe" => country_capitals_in_europe}
print("\n", "combination9: ", JSON.pretty_generate(combination9, { "indent": " " * 4 }))
# combination9: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "country_capitals_in_europe" : {
#       "France" : "Paris",
#       "England" : "London"
#    }
# }

combination10 = {**country_capitals_in_asia, "country_capitals_in_europe" => {"Germany" => "Berlin", "Italy" => "Rome"}}
print("\n", "combination10: ", JSON.pretty_generate(combination10, { "indent": " " * 4 }))
# combination10: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "country_capitals_in_europe": {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# }

print("\n", "# { ...object1, array2 }:\n")

combination11 = {**country_capitals_in_asia, "vegetables" => vegetables}
print("\n", "combination11: ", JSON.pretty_generate(combination11, { "indent": " " * 4 }))
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

combination12 = {**country_capitals_in_asia, "vegetables" => ["Cucumber", "Onion"]}
print("\n", "combination12: ", JSON.pretty_generate(combination12, { "indent": " " * 4 }))
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Onion"
#     ]
# }

print("\n", "# { ...object1, ...array2 }:\n")

combination13 = {**country_capitals_in_asia, **array_to_object.call(vegetables)}
print("\n", "combination13: ", JSON.pretty_generate(combination13, { "indent": " " * 4 }))
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "0" : "Carrot",
#    "1" : "Tomato"
# }

combination14 = {**country_capitals_in_asia, **array_to_object.call(["Cucumber", "Onion"])}
print("\n", "combination14: ", JSON.pretty_generate(combination14, { "indent": " " * 4 }))
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "0" : "Cucumber",
#    "1" : "Onion"
# }

# print("\n", "# [...array1, ...object1]: // this combination throw an error in JavaScript\n")

# this combination throw an error in JavaScript
# combination_error_in_javascript1 = [*fruits, *country_capitals_in_asia]
# print("\n", "combination_error_in_javascript1: ", JSON.pretty_generate(combination_error_in_javascript1, { "indent": " " * 4 }))

# this combination throw an error in JavaScript
# combination_error_in_javascript2 = [*fruits, *{"Germany" => "Berlin", "Italy" => "Rome"}]
# print("\n", "combination_error_in_javascript2: ", JSON.pretty_generate(combination_error_in_javascript2, { "indent": " " * 4 }))
