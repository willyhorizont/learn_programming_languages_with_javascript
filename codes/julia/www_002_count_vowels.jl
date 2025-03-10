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

count_vowels_v1::Any = (any_string::Any) -> (reduce(((current_result::Any, any_character::Any) -> ((any_character in Vector{Any}(["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"])) ? (current_result + 1) : current_result)::Any), split(any_string, ""); init=0))::Any
println(count_vowels_v1("Hello World")) # 3

count_vowels_v2::Any = (any_string::Any) -> (reduce(((current_result::Any, any_character::Any) -> ((uppercase(any_character) in Vector{Any}(["A", "I", "U", "E", "O"])) ? (current_result + 1) : current_result)::Any), split(any_string, ""); init=0))::Any
println(count_vowels_v2("Hello World")) # 3

count_vowels_v3::Any = (any_string::Any) -> (reduce(((current_result::Any, any_character::Any) -> (occursin(any_character, "aiueoAIUEO") ? (current_result + 1) : current_result)::Any), split(any_string, ""); init=0))::Any
println(count_vowels_v3("Hello World")) # 3

count_vowels_v4::Any = (any_string::Any) -> (reduce(((current_result::Any, any_character::Any) -> (occursin(uppercase(any_character), "AIUEO") ? (current_result + 1) : current_result)::Any), split(any_string, ""); init=0))::Any
println(count_vowels_v4("Hello World")) # 3

count_vowels_v5::Any = (any_string::Any) -> (length(filter(((any_character::Any) -> (any_character in Vector{Any}(["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"]))::Any), split(any_string, ""))))::Any
println(count_vowels_v5("Hello World")) # 3

count_vowels_v6::Any = (any_string::Any) -> (length(filter(((any_character::Any) -> (uppercase(any_character) in Vector{Any}(["A", "I", "U", "E", "O"]))::Any), split(any_string, ""))))::Any
println(count_vowels_v6("Hello World")) # 3

count_vowels_v7::Any = (any_string::Any) -> (length(filter(((any_character::Any) -> (occursin(any_character, "aiueoAIUEO"))::Any), split(any_string, ""))))::Any
println(count_vowels_v7("Hello World")) # 3

count_vowels_v8::Any = (any_string::Any) -> (length(filter(((any_character::Any) -> (occursin(uppercase(any_character), "AIUEO"))::Any), split(any_string, ""))))::Any
println(count_vowels_v8("Hello World")) # 3
