from numbers import Number

js_like_type = {"Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function"}

array_reduce = lambda callback_function, any_array, initial_value_or_current_result, array_item_index=0: (initial_value_or_current_result if (array_item_index >= len(any_array)) else array_reduce(callback_function, any_array, (callback_function(initial_value_or_current_result, any_array[array_item_index], array_item_index, any_array)), (array_item_index + 1)))  # '''JavaScript-like Array.reduce() function array_reduce_v2'''

is_like_js_null = lambda anything: (anything is None)

is_like_js_boolean = lambda anything: ((isinstance(anything, bool) == True) and ((anything == True) or (anything == False)))

is_like_js_string = lambda anything: (isinstance(anything, str) == True)

is_like_js_numeric = lambda anything: (isinstance(anything, Number) == True)

is_like_js_object = lambda anything: (isinstance(anything, dict) == True)

is_like_js_array = lambda anything: (isinstance(anything, list) == True)

is_like_js_function = lambda anything: (callable(anything) == True)

get_type = lambda anything: (js_like_type["Null"] if (is_like_js_null(anything) == True) else js_like_type["Boolean"] if (is_like_js_boolean(anything) == True) else js_like_type["String"] if (is_like_js_string(anything) == True) else js_like_type["Numeric"] if (is_like_js_numeric(anything) == True) else js_like_type["Object"] if (is_like_js_object(anything) == True) else js_like_type["Array"] if (is_like_js_array(anything) == True) else js_like_type["Function"] if (is_like_js_function(anything) == True) else str(type(anything)))  # '''get_type_v2'''


def optional_chaining(callback_function):
    try:
        return callback_function()
    except Exception as any_exception:
        return None


nullish_coalescing = lambda anything, default_value: (default_value if (is_like_js_null(anything) == True) else anything)  # '''JavaScript-like Nullish Coalescing Operator (??) function nullish_coalescing_v2'''

json_stringify = (json_stringify_v10_inner := lambda anything, pretty=False, indent=(" " * 4), indent_level=0: ("null" if ((anything_type := get_type(anything)) == js_like_type["Null"]) else ('"' + str(anything) + '"') if (anything_type == js_like_type["String"]) else str(anything) if (anything_type == js_like_type["Numeric"]) else "true" if ((anything_type == js_like_type["Boolean"]) and (anything == True)) else "false" if ((anything_type == js_like_type["Boolean"]) and (anything == False)) else (("{" + "}") if (len(anything) == 0) else ("".join([(("{\n" + (indent * (indent_level + 1))) if (pretty == True) else "{ "), *[((('"' + str(object_key) + '": ' + json_stringify_v10_inner(object_value, pretty=pretty, indent_level=(indent_level + 1))) + ((",\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((object_entry_index + 1) != len(anything)) else ('"' + str(object_key) + '": ' + json_stringify_v10_inner(object_value, pretty=pretty, indent_level=(indent_level + 1)))) for (object_entry_index, (object_key, object_value)) in enumerate(anything.items())], (("\n" + (indent * indent_level) + "}") if (pretty == True) else " }")]))) if (anything_type == js_like_type["Object"]) else ("[]" if (len(anything) == 0) else ("".join([(("[\n" + (indent * (indent_level + 1))) if (pretty == True) else "["), *[((json_stringify_v10_inner(array_item, pretty=pretty, indent_level=(indent_level + 1)) + ((",\n" + (indent * (indent_level + 1))) if (pretty == True) else ", ")) if ((array_item_index + 1) != len(anything)) else json_stringify_v10_inner(array_item, pretty=pretty, indent_level=(indent_level + 1))) for (array_item_index, array_item) in enumerate(anything)], (("\n" + (indent * indent_level) + "]") if (pretty == True) else "]")]))) if (anything_type == js_like_type["Array"]) else "[object Function]" if (anything_type == js_like_type["Function"]) else anything_type))  # '''custom JSON.stringify() function json_stringify_v10'''

print("\n# JavaScript-like Spread Syntax (...) in Python")

def array_to_object(any_array):
    new_object = {}
    for (array_item_index, array_item) in enumerate(any_array):
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
