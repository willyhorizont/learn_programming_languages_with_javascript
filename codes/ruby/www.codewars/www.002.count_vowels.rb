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
    return a_string.split("").reduce(0) { |result, letter| (["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].include?(letter) ? (result + 1) : result) }
end
print(count_vowels_v1("Hello World"), "\n") # 3

def count_vowels_v2(a_string)
    return a_string.split("").reduce(0) { |result, letter| (["A", "I", "U", "E", "O"].include?(letter.upcase()) ? (result + 1) : result) }
end
print(count_vowels_v2("Hello World"), "\n") # 3

def count_vowels_v3(a_string)
    return a_string.split("").reduce(0) { |result, letter| ("aiueoAIUEO".include?(letter) ? (result + 1) : result) }
end
print(count_vowels_v3("Hello World"), "\n") # 3

def count_vowels_v4(a_string)
    return a_string.split("").reduce(0) { |result, letter| ("AIUEO".include?(letter.upcase()) ? (result + 1) : result) }
end
print(count_vowels_v4("Hello World"), "\n") # 3

def count_vowels_v5(a_string)
    return a_string.split("").select { |letter| ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].include?(letter) }.size()
end
print(count_vowels_v5("Hello World"), "\n") # 3

def count_vowels_v6(a_string)
    return a_string.split("").select { |letter| ["A", "I", "U", "E", "O"].include?(letter.upcase()) }.size()
end
print(count_vowels_v6("Hello World"), "\n") # 3

def count_vowels_v7(a_string)
    return a_string.split("").select { |letter| "aiueoAIUEO".include?(letter) }.size()
end
print(count_vowels_v7("Hello World"), "\n") # 3

def count_vowels_v8(a_string)
    return a_string.split("").select { |letter| "AIUEO".include?(letter.upcase()) }.size()
end
print(count_vowels_v8("Hello World"), "\n") # 3
