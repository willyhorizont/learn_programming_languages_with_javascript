import json
from numbers import Number


def array_reduce(callback_function, an_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = initial_value
    for array_item_index, array_item in enumerate(an_array):
        result = callback_function(result, array_item, array_item_index, an_array)
    return result


optional_chaining = lambda anything, *object_properties_array: anything if (((isinstance(anything, dict) == False) and (isinstance(anything, list) == False)) or (len(object_properties_array) == 0)) else array_reduce(lambda current_result, current_item, *_: anything.get(str(current_item)) if ((current_result is None) and (isinstance(anything, dict) == True) and (isinstance(current_item, str) == True)) else anything[int(current_item)] if ((current_result is None) and (isinstance(anything, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(anything) > int(current_item))) else current_result.get(str(current_item)) if ((isinstance(current_result, dict) == True) and (isinstance(current_item, str) == True)) else current_result[int(current_item)] if ((isinstance(current_result, list) == True) and (isinstance(current_item, Number) == True) and (int(current_item) >= 0) and (len(current_result) > int(current_item))) else None, object_properties_array, None)  # '''JavaScript-like Optional Chaining Operator (?.) function optional_chaining_v3'''

nullish_coalescing = lambda anything, default_value: default_value if (anything is None) else anything  # '''JavaScript-like Nullish Coalescing Operator (??) function nullish_coalescing_v2'''

json_stringify = lambda anything, **optional_argument: (json.dumps(anything, indent=4)) if (nullish_coalescing(optional_chaining(optional_argument, "pretty"), False) == True) else (json.dumps(anything).replace("{", "{ ").replace("}", " }"))

print("\n# JavaScript-like Spread Syntax (...) in Python")

def array_to_object(an_array):
    new_object = {}
    for (array_item_index, array_item) in enumerate(an_array):
        new_object[str(array_item_index)] = array_item
    return new_object

fruits = ["Mango", "Melon", "Banana"]
print(f'fruits: {json_stringify(fruits)}')

vegetables = ["Carrot", "Tomato"]
print(f'vegetables: {json_stringify(vegetables)}')

country_capitals_in_asia = {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo"
}
print(f"country_capitals_in_asia: {json_stringify(country_capitals_in_asia, pretty=True)}")

country_capitals_in_europe = {
    "France": "Paris",
    "England": "London"
}
print(f"country_capitals_in_europe: {json_stringify(country_capitals_in_europe, pretty=True)}")

print("\n# [...array1, ...array2]:\n")

combination1 = [*fruits, *vegetables]
print(f"combination1: {json_stringify(combination1, pretty=True)}")
# combination1: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Carrot",
#     "Tomato"
# ]

combination2 = [*fruits, *["Cucumber", "Cabbage"]]
print(f"combination2: {json_stringify(combination2, pretty=True)}")
# combination2: [
#     "Mango",
#     "Melon",
#     "Banana",
#     "Cucumber",
#     "Cabbage"
# ]

print("\n# { ...object1, ...object2 }:\n")

combination3 = {**country_capitals_in_asia, **country_capitals_in_europe}
print(f"combination3: {json_stringify(combination3, pretty=True)}")
# combination3: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "France": "Paris",
#     "England": "London"
# }

combination4 = {**country_capitals_in_asia, **{"Germany": "Berlin", "Italy": "Rome"}}
print(f"combination4: {json_stringify(combination4, pretty=True)}")
# combination4: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "Germany": "Berlin",
#     "Italy": "Rome"
# }

print("\n# [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n")

combination5 = [*fruits, vegetables]
print(f"combination5: {json_stringify(combination5, pretty=True)}")
# combination5: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Carrot",
#         "Tomato"
#     ]
# ]

combination6 = [*fruits, ["Cucumber", "Cabbage"]]
print(f"combination6: {json_stringify(combination6, pretty=True)}")
# combination6: [
#     "Mango",
#     "Melon",
#     "Banana",
#     [
#         "Cucumber",
#         "Cabbage"
#     ]
# ]

print("\n# [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n")

combination7 = [*fruits, country_capitals_in_asia]
print(f"combination7: {json_stringify(combination7, pretty=True)}")
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

combination8 = [*fruits, {"Germany": "Berlin", "Italy": "Rome"}]
print(f"combination8: {json_stringify(combination8, pretty=True)}")
# combination8: [
#     "Mango",
#     "Melon",
#     "Banana",
#     {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# ]

print("\n# { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n")

combination9 = {**country_capitals_in_asia, "country_capitals_in_europe": country_capitals_in_europe}
print(f"combination9: {json_stringify(combination9, pretty=True)}")
# combination9: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "country_capitals_in_europe" : {
#       "France" : "Paris",
#       "England" : "London"
#    }
# }

combination10 = {**country_capitals_in_asia, "country_capitals_in_europe": {"Germany": "Berlin", "Italy": "Rome"}}
print(f"combination10: {json_stringify(combination10, pretty=True)}")
# combination10: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "country_capitals_in_europe": {
#         "Germany": "Berlin",
#         "Italy": "Rome"
#     }
# }

print("\n# { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n")

combination11 = {**country_capitals_in_asia, "vegetables": vegetables}
print(f"combination11: {json_stringify(combination11, pretty=True)}")
# combination11: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Carrot",
#         "Tomato"
#     ]
# }

combination12 = {**country_capitals_in_asia, "vegetables": ["Cucumber", "Cabbage"]}
print(f"combination12: {json_stringify(combination12, pretty=True)}")
# combination12: {
#     "Thailand": "Bangkok",
#     "China": "Beijing",
#     "Japan": "Tokyo",
#     "vegetables": [
#         "Cucumber",
#         "Cabbage"
#     ]
# }

print("\n# { ...object1, ...array2 }:\n")

combination13 = {**country_capitals_in_asia, **array_to_object(vegetables)}
print(f"combination13: {json_stringify(combination13, pretty=True)}")
# combination13: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Carrot",
#    "2" : "Tomato"
# }

combination14 = {**country_capitals_in_asia, **array_to_object(["Cucumber", "Cabbage"])}
print(f"combination14: {json_stringify(combination14, pretty=True)}")
# combination14: {
#    "Thailand" : "Bangkok",
#    "China" : "Beijing",
#    "Japan" : "Tokyo",
#    "1" : "Cucumber",
#    "2" : "Cabbage"
# }

# print("\n# [...array1, ...object1]:  # this combination throw an error in JavaScript\n")

# this combination throw an error in JavaScript
# combination_error_in_javascript1 = [*fruits, *country_capitals_in_asia]
# print(f"combination_error_in_javascript1: {json_stringify(combination_error_in_javascript1, pretty=True)}")

# this combination throw an error in JavaScript
# combination_error_in_javascript2 = [*fruits, *{"Germany": "Berlin", "Italy": "Rome"}]
# print(f"combination_error_in_javascript2: {json_stringify(combination_error_in_javascript2, pretty=True)}")
