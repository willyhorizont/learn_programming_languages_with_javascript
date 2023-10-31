import json

print('\n# JavaScript-like Spread Syntax in Python List')

my_fruits_in_fridge = ["apple", "mango", "orange"]
print(f'my fruits in fridge: {json.dumps(my_fruits_in_fridge)}')

my_fruits_from_grocery_store = ["melon", "banana"]
print(f'my fruits from grocery store: {json.dumps(my_fruits_from_grocery_store)}')

my_fruits = [*my_fruits_in_fridge, *my_fruits_from_grocery_store]
print(f'my fruits: {json.dumps(my_fruits)}')
# my fruits: ["apple", "mango", "orange", "melon", "banana"]

print('\n# Spread Syntax in Python List of Dictionaries')

general_car = {
    "wheels": 4,
    "tires": 4
}
print(f'general car: {json.dumps(general_car, indent=4)}')

minivan_car = { **general_car, "doors": 4 }
print(f'minivan car: {json.dumps(minivan_car, indent=4)}')
# minivan car: {
#     "wheels": 4,
#     "tires": 4,
#     "doors": 4
# }

super_car = { **general_car, "doors": 2 }
print(f'super car: {json.dumps(super_car, indent=4)}')
# super car: {
#     "wheels": 4,
#     "tires": 4,
#     "doors": 2
# }
