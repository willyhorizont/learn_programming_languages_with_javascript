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


def array_includes_v1(search_element, an_array):
    '''JavaScript-like Array.includes() function array_includes_v1'''
    return search_element in an_array


array_includes_v2 = lambda search_element, an_array: search_element in an_array  # '''JavaScript-like Array.includes() function array_includes_v2'''

print("\n# JavaScript-like Array.includes() in Python")

my_friends = ['Alisa', 'Trivia']
print(f'my friends: {json_stringify(my_friends)}')

print('# using JavaScript-like Array.includes() function "array_includes_v1"')

a_name = 'Alisa'
is_my_friend = array_includes_v1(a_name, my_friends)
print(f'is my friends includes "{a_name}": {is_my_friend}')
# is my friends includes "Alisa": True

a_name = 'Trivia'
is_my_friend = array_includes_v1(a_name, my_friends)
print(f'is my friends includes "{a_name}": {is_my_friend}')
# is my friends includes "Trivia": True

a_name = 'Tony'
is_my_friend = array_includes_v1(a_name, my_friends)
print(f'is my friends includes "{a_name}": {is_my_friend}')
# is my friends includes "Tony": False

a_name = 'Ezekiel'
is_my_friend = array_includes_v1(a_name, my_friends)
print(f'is my friends includes "{a_name}": {is_my_friend}')
# is my friends includes "Ezekiel": False

print('# using JavaScript-like Array.includes() function "array_includes_v2"')

a_name = 'Alisa'
is_my_friend = array_includes_v2(a_name, my_friends)
print(f'is my friends includes "{a_name}": {is_my_friend}')
# is my friends includes "Alisa": True

a_name = 'Trivia'
is_my_friend = array_includes_v2(a_name, my_friends)
print(f'is my friends includes "{a_name}": {is_my_friend}')
# is my friends includes "Trivia": True

a_name = 'Tony'
is_my_friend = array_includes_v2(a_name, my_friends)
print(f'is my friends includes "{a_name}": {is_my_friend}')
# is my friends includes "Tony": False

a_name = 'Ezekiel'
is_my_friend = array_includes_v2(a_name, my_friends)
print(f'is my friends includes "{a_name}": {is_my_friend}')
# is my friends includes "Ezekiel": False

print('# using the "pythonic" way of Array.includes()')

a_name = 'Alisa'
is_my_friend = a_name in my_friends
print(f'is my friends includes "{a_name}": {is_my_friend}')
# is my friends includes "Alisa": True

a_name = 'Trivia'
is_my_friend = a_name in my_friends
print(f'is my friends includes "{a_name}": {is_my_friend}')
# is my friends includes "Trivia": True

a_name = 'Tony'
is_my_friend = a_name in my_friends
print(f'is my friends includes "{a_name}": {is_my_friend}')
# is my friends includes "Tony": False

a_name = 'Ezekiel'
is_my_friend = a_name in my_friends
print(f'is my friends includes "{a_name}": {is_my_friend}')
# is my friends includes "Ezekiel": False
