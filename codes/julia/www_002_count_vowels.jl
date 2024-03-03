using Printf
using Statistics

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

count_vowels_v1 = (a_string) -> reduce((result, a_letter) -> (a_letter in ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"] ? (result + 1) : result), split(a_string, ""); init=0)
println(count_vowels_v1("Hello World")) # 3

count_vowels_v2 = (a_string) -> reduce((result, a_letter) -> (uppercase(a_letter) in ["A", "I", "U", "E", "O"] ? (result + 1) : result), split(a_string, ""); init=0)
println(count_vowels_v2("Hello World")) # 3

count_vowels_v3 = (a_string) -> reduce((result, a_letter) -> (occursin(a_letter, "aiueoAIUEO") ? (result + 1) : result), split(a_string, ""); init=0)
println(count_vowels_v3("Hello World")) # 3

count_vowels_v4 = (a_string) -> reduce((result, a_letter) -> (occursin(uppercase(a_letter), "AIUEO") ? (result + 1) : result), split(a_string, ""); init=0)
println(count_vowels_v4("Hello World")) # 3

count_vowels_v5 = (a_string) -> length(filter((a_letter) -> a_letter in ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"], split(a_string, "")))
println(count_vowels_v5("Hello World")) # 3

count_vowels_v6 = (a_string) -> length(filter((a_letter) -> uppercase(a_letter) in ["A", "I", "U", "E", "O"], split(a_string, "")))
println(count_vowels_v6("Hello World")) # 3

count_vowels_v7 = (a_string) -> length(filter((a_letter) -> occursin(a_letter, "aiueoAIUEO"), split(a_string, "")))
println(count_vowels_v7("Hello World")) # 3

count_vowels_v8 = (a_string) -> length(filter((a_letter) -> occursin(uppercase(a_letter), "AIUEO"), split(a_string, "")))
println(count_vowels_v8("Hello World")) # 3
