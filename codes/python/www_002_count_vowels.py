'''
    Source:
        https://www.codewars.com/kata/54ff3102c1bad923760001f3
    Title:
        Vowel Count
    Description:
        Return the number (count) of vowels in the given string.
        We will consider a, e, i, o, u as vowels for this Kata (but not y).
        The input string will only consist of lower case letters and/or spaces.
'''

from functools import reduce

count_vowels_v1 = lambda a_string: reduce(lambda current_result, a_character: current_result + 1 if a_character in ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"] else current_result, [*a_string], 0)
print(count_vowels_v1("Hello World"))  # 3

count_vowels_v2 = lambda a_string: reduce(lambda current_result, a_character: current_result + 1 if a_character.upper() in ["A", "I", "U", "E", "O"] else current_result, [*a_string], 0)
print(count_vowels_v2("Hello World"))  # 3

count_vowels_v3 = lambda a_string: reduce(lambda current_result, a_character: current_result + 1 if a_character in "aiueoAIUEO" else current_result, [*a_string], 0)
print(count_vowels_v3("Hello World"))  # 3

count_vowels_v4 = lambda a_string: reduce(lambda current_result, a_character: current_result + 1 if a_character.upper() in "AIUEO" else current_result, [*a_string], 0)
print(count_vowels_v4("Hello World"))  # 3

count_vowels_v5 = lambda a_string: len(list(filter(lambda a_character: a_character in ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"], [*a_string])))
print(count_vowels_v5("Hello World"))  # 3

count_vowels_v6 = lambda a_string: len(list(filter(lambda a_character: a_character.upper() in ["A", "I", "U", "E", "O"], [*a_string])))
print(count_vowels_v6("Hello World"))  # 3

count_vowels_v7 = lambda a_string: len(list(filter(lambda a_character: a_character in "aiueoAIUEO", [*a_string])))
print(count_vowels_v7("Hello World"))  # 3

count_vowels_v8 = lambda a_string: len(list(filter(lambda a_character: a_character.upper() in "AIUEO", [*a_string])))
print(count_vowels_v8("Hello World"))  # 3
