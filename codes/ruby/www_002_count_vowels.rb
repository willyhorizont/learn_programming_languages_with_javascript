=begin
    Source:
        https://www.codewars.com/kata/54ff3102c1bad923760001f3
    Title:
        Vowel Count
    Description:
        Return the number (count) of vowels in the given string.
        We will consider a, e, i, o, u as vowels for this Kata (but not y).
        The input string will only consist of lower case letters and/or spaces.
=end

def count_vowels_v1(a_string)
    return a_string.split("").reduce(0) { |current_result, a_character| (["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].include?(a_character) ? (current_result + 1) : current_result) }
end
print(count_vowels_v1("Hello World"), "\n") # 3

def count_vowels_v2(a_string)
    return a_string.split("").reduce(0) { |current_result, a_character| (["A", "I", "U", "E", "O"].include?(a_character.upcase()) ? (current_result + 1) : current_result) }
end
print(count_vowels_v2("Hello World"), "\n") # 3

def count_vowels_v3(a_string)
    return a_string.split("").reduce(0) { |current_result, a_character| ("aiueoAIUEO".include?(a_character) ? (current_result + 1) : current_result) }
end
print(count_vowels_v3("Hello World"), "\n") # 3

def count_vowels_v4(a_string)
    return a_string.split("").reduce(0) { |current_result, a_character| ("AIUEO".include?(a_character.upcase()) ? (current_result + 1) : current_result) }
end
print(count_vowels_v4("Hello World"), "\n") # 3

def count_vowels_v5(a_string)
    return a_string.split("").select { |a_character| ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].include?(a_character) }.size()
end
print(count_vowels_v5("Hello World"), "\n") # 3

def count_vowels_v6(a_string)
    return a_string.split("").select { |a_character| ["A", "I", "U", "E", "O"].include?(a_character.upcase()) }.size()
end
print(count_vowels_v6("Hello World"), "\n") # 3

def count_vowels_v7(a_string)
    return a_string.split("").select { |a_character| "aiueoAIUEO".include?(a_character) }.size()
end
print(count_vowels_v7("Hello World"), "\n") # 3

def count_vowels_v8(a_string)
    return a_string.split("").select { |a_character| "AIUEO".include?(a_character.upcase()) }.size()
end
print(count_vowels_v8("Hello World"), "\n") # 3
