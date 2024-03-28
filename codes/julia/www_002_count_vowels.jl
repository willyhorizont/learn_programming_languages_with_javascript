#=
Source:
    https://www.codewars.com/kata/54ff3102c1bad923760001f3
Title:
    Vowel Count
Description:
    Return the number (count) of vowels in the given string.
    We will consider a, e, i, o, u as vowels for this Kata (but not y).
    The input string will only consist of lower case letters and/or spaces.
=#

count_vowels_v1 = (a_string) -> reduce((current_result, a_character) -> (a_character in ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"] ? (current_result + 1) : current_result), split(a_string, ""); init=0)
println(count_vowels_v1("Hello World")) # 3

count_vowels_v2 = (a_string) -> reduce((current_result, a_character) -> (uppercase(a_character) in ["A", "I", "U", "E", "O"] ? (current_result + 1) : current_result), split(a_string, ""); init=0)
println(count_vowels_v2("Hello World")) # 3

count_vowels_v3 = (a_string) -> reduce((current_result, a_character) -> (occursin(a_character, "aiueoAIUEO") ? (current_result + 1) : current_result), split(a_string, ""); init=0)
println(count_vowels_v3("Hello World")) # 3

count_vowels_v4 = (a_string) -> reduce((current_result, a_character) -> (occursin(uppercase(a_character), "AIUEO") ? (current_result + 1) : current_result), split(a_string, ""); init=0)
println(count_vowels_v4("Hello World")) # 3

count_vowels_v5 = (a_string) -> length(filter((a_character) -> a_character in ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"], split(a_string, "")))
println(count_vowels_v5("Hello World")) # 3

count_vowels_v6 = (a_string) -> length(filter((a_character) -> uppercase(a_character) in ["A", "I", "U", "E", "O"], split(a_string, "")))
println(count_vowels_v6("Hello World")) # 3

count_vowels_v7 = (a_string) -> length(filter((a_character) -> occursin(a_character, "aiueoAIUEO"), split(a_string, "")))
println(count_vowels_v7("Hello World")) # 3

count_vowels_v8 = (a_string) -> length(filter((a_character) -> occursin(uppercase(a_character), "AIUEO"), split(a_string, "")))
println(count_vowels_v8("Hello World")) # 3
