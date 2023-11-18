import json

print('\n# JavaScript-like Spread Syntax (...) in Python')

def array_to_object(an_array):
    new_object = {}
    for (array_item_index, array_item) in enumerate(an_array):
        new_object[array_item_index] = array_item
    return new_object

fruits = ["Mango", "Melon", "Banana"]
print(f'fruits: {json.dumps(fruits)}')

vegetables = ["Carrot", "Tomato"]
print(f'vegetables: {json.dumps(vegetables)}')

country_capitals_in_asia = {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo"
}
print(f'country_capitals_in_asia: {json.dumps(country_capitals_in_asia, indent=4)}')

country_capitals_in_europe = {
    "France": "Paris",
    "England": "London"
}
print(f'country_capitals_in_europe: {json.dumps(country_capitals_in_europe, indent=4)}')

print("\n# [...array1, ...array2]:\n")

combination1 = [*fruits, *vegetables]
print(f'combination1: {json.dumps(combination1, indent=4)}')
# combination1: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Carrot",
#     "Tomato"
# ]

combination2 = [*fruits, *["Cucumber", "Onions"]]
print(f'combination2: {json.dumps(combination2, indent=4)}')
# combination2: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Cucumber",
#     "Onions"
# ]

print("\n# { ...object1, ...object2 }:\n")

combination3 = {**country_capitals_in_asia, **country_capitals_in_europe}
print(f'combination3: {json.dumps(combination3, indent=4)}')
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

combination4 = {**country_capitals_in_asia, **{"Germany": "Berlin", "Italy": "Rome"}}
print(f'combination4: {json.dumps(combination4, indent=4)}')
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

print("\n# [...array1, array2]:\n")

combination5 = [*fruits, vegetables]
print(f'combination5: {json.dumps(combination5, indent=4)}')
# combination5: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Carrot",
#         "Tomato"
#     ]
# ]

combination6 = [*fruits, ["Cucumber", "Onions"]]
print(f'combination6: {json.dumps(combination6, indent=4)}')
# combination6: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Cucumber",
#         "Onions"
#     ]
# ]

print("\n# [...array1, object1]:\n")

combination7 = [*fruits, country_capitals_in_asia]
print(f'combination7: {json.dumps(combination7, indent=4)}')
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

combination8 = [*fruits, { "Germany": "Berlin", "Italy": "Rome" }]
print(f'combination8: {json.dumps(combination8, indent=4)}')
# combination8: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# ]

print("\n# { ...object1, object2 }:\n")

combination9 = {**country_capitals_in_asia, "country_capitals_in_europe": country_capitals_in_europe}
print(f'combination9: {json.dumps(combination9, indent=4)}')
# combination9: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "country_capitals_in_europe" : {
#       "France" : "Paris",
#       "England" : "London"
#    }
# }

combination10 = {**country_capitals_in_asia, "country_capitals_in_europe": { "Germany": "Berlin", "Italy": "Rome" }}
print(f'combination10: {json.dumps(combination10, indent=4)}')
# combination10: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "country_capitals_in_europe": {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# }

print("\n# { ...object1, array2 }:\n")

combination11 = {**country_capitals_in_asia, "vegetables": vegetables}
print(f'combination11: {json.dumps(combination11, indent=4)}')
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

combination12 = {**country_capitals_in_asia, "vegetables": ["Cucumber", "Onions"]}
print(f'combination12: {json.dumps(combination12, indent=4)}')
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Onions"
#     ]
# }

print("\n# { ...object1, ...array2 }:\n")

combination13 = {**country_capitals_in_asia, **array_to_object(vegetables)}
print(f'combination13: {json.dumps(combination13, indent=4)}')
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Carrot",
#    "2" : "Tomato"
# }

combination14 = {**country_capitals_in_asia, **array_to_object(["Cucumber", "Onions"])}
print(f'combination14: {json.dumps(combination14, indent=4)}')
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Cucumber",
#    "2" : "Onions"
# }

# print("\n# [...array1, ...object1]: # this combination throw an error in JavaScript\n")

# this combination throw an error in JavaScript
# combination_error_in_javascript1 = [*fruits, *country_capitals_in_asia]
# print(f'combination_error_in_javascript1: {json.dumps(combination_error_in_javascript1, indent=4)}')

# this combination throw an error in JavaScript
# combination_error_in_javascript2 = [*fruits, *{ "Germany": "Berlin", "Italy": "Rome" }]
# print(f'combination_error_in_javascript2: {json.dumps(combination_error_in_javascript2, indent=4)}')
