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
