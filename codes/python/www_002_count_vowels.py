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

count_vowels_v1 = lambda any_string: reduce(lambda current_result, any_character: current_result + 1 if any_character in ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"] else current_result, [*any_string], 0)
print(count_vowels_v1("Hello World"))  # 3

count_vowels_v2 = lambda any_string: reduce(lambda current_result, any_character: current_result + 1 if any_character.upper() in ["A", "I", "U", "E", "O"] else current_result, [*any_string], 0)
print(count_vowels_v2("Hello World"))  # 3

count_vowels_v3 = lambda any_string: reduce(lambda current_result, any_character: current_result + 1 if any_character in "aiueoAIUEO" else current_result, [*any_string], 0)
print(count_vowels_v3("Hello World"))  # 3

count_vowels_v4 = lambda any_string: reduce(lambda current_result, any_character: current_result + 1 if any_character.upper() in "AIUEO" else current_result, [*any_string], 0)
print(count_vowels_v4("Hello World"))  # 3

count_vowels_v5 = lambda any_string: len(list(filter(lambda any_character: any_character in ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"], [*any_string])))
print(count_vowels_v5("Hello World"))  # 3

count_vowels_v6 = lambda any_string: len(list(filter(lambda any_character: any_character.upper() in ["A", "I", "U", "E", "O"], [*any_string])))
print(count_vowels_v6("Hello World"))  # 3

count_vowels_v7 = lambda any_string: len(list(filter(lambda any_character: any_character in "aiueoAIUEO", [*any_string])))
print(count_vowels_v7("Hello World"))  # 3

count_vowels_v8 = lambda any_string: len(list(filter(lambda any_character: any_character.upper() in "AIUEO", [*any_string])))
print(count_vowels_v8("Hello World"))  # 3
