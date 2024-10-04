import time
import random


def array_reduce(callback_function, an_array, initial_value):
    '''JavaScript-like Array.reduce() function'''
    result = initial_value
    for array_item_index, array_item in enumerate(an_array):
        result = callback_function(result, array_item, array_item_index, an_array)
    return result


characters_string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ `~!@#$%^&*()_+-=[]\\{}|;':\",./<>?"
target_string = "Hello, World!"
result_container = [[any_character, ""] for any_character in target_string]


def print_character(expected_printed_character, target_string_index):
    global result_container
    printed_character = result_container[target_string_index][1]
    while (printed_character != expected_printed_character):
        any_character = characters_string[random.randint(0, (len(characters_string) - 1))]
        printed_character = any_character
        result_container[target_string_index] = [result_container[target_string_index][0], any_character]
        result_string = array_reduce(lambda current_result, current_array, *_: f"{current_result}{current_array[1]}", result_container, "")
        print(result_string)
        time.sleep(0.05)


def main():
    for (target_string_index, any_character) in enumerate(target_string):
        print_character(any_character, target_string_index)
    for _ in range(1, (10 + 1), 1):
        print(target_string)


if __name__ == "__main__":
    main()
