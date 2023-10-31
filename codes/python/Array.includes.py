import json


def array_includes_v1(search_element, an_array):
    '''JavaScript-like Array.includes() function'''
    return search_element in an_array


# JavaScript-like Array.includes() function
array_includes_v2 = lambda search_element, an_array: search_element in an_array

print('\n# JavaScript-like Array.includes() in Python')

my_friends = ['Alisa', 'Trivia']
print(f'my friends: {json.dumps(my_friends)}')

print('# using JavaScript-like Array.includes() function "array_includes_v1"')

name = 'Alisa'
print(f'name: "{name}"')
is_my_friend = array_includes_v1(name, my_friends)
print(f'is my friends includes "{name}": {"true" if is_my_friend == True else "false"}')
# is my friends includes "Alisa": true

name = 'Tony'
print(f'name: "{name}"')
is_my_friend = array_includes_v1(name, my_friends)
print(f'is my friends includes "{name}": {"true" if is_my_friend == True else "false"}')
# is my friends includes "Tony": false

name = 'Ezekiel'
print(f'name: "{name}"')
is_my_friend = array_includes_v1(name, my_friends)
print(f'is my friends includes "{name}": {"true" if is_my_friend == True else "false"}')
# is my friends includes "Ezekiel": false

print('# using JavaScript-like Array.includes() function "array_includes_v2"')

name = 'Alisa'
print(f'name: "{name}"')
is_my_friend = array_includes_v2(name, my_friends)
print(f'is my friends includes "{name}": {"true" if is_my_friend == True else "false"}')
# is my friends includes "Alisa": true

name = 'Tony'
print(f'name: "{name}"')
is_my_friend = array_includes_v2(name, my_friends)
print(f'is my friends includes "{name}": {"true" if is_my_friend == True else "false"}')
# is my friends includes "Tony": false

name = 'Ezekiel'
print(f'name: "{name}"')
is_my_friend = array_includes_v2(name, my_friends)
print(f'is my friends includes "{name}": {"true" if is_my_friend == True else "false"}')
# is my friends includes "Ezekiel": false

print('# using the "pythonic" way of Array.includes()')

name = 'Alisa'
print(f'name: "{name}"')
is_my_friend = name in my_friends
print(f'is my friends includes "{name}": {"true" if is_my_friend == True else "false"}')
# is my friends includes "Alisa": true

name = 'Tony'
print(f'name: "{name}"')
is_my_friend = name in my_friends
print(f'is my friends includes "{name}": {"true" if is_my_friend == True else "false"}')
# is my friends includes "Tony": false

name = 'Ezekiel'
print(f'name: "{name}"')
is_my_friend = name in my_friends
print(f'is my friends includes "{name}": {"true" if is_my_friend == True else "false"}')
# is my friends includes "Ezekiel": false
