# Source:
#     https://www.codewars.com/kata/54ff3102c1bad923760001f3
# Title:
#     Vowel Count
# Description:
#     Return the number (count) of vowels in the given string.
#     We will consider a, e, i, o, u as vowels for this Kata (but not y).
#     The input string will only consist of lower case letters and/or spaces.

count_vowels_v1 <- function(a_string) Reduce(function(current_result, a_character) (if (a_character %in% list("a", "i", "u", "e", "o", "A", "I", "U", "E", "O")) current_result + 1 else current_result), strsplit(a_string, split = "")[[1]], 0)
cat(paste(sep = "", count_vowels_v1("Hello World"), "\n")) # 3

count_vowels_v2 <- function(a_string) Reduce(function(current_result, a_character) (if (toupper(a_character) %in% list("A", "I", "U", "E", "O")) current_result + 1 else current_result), strsplit(a_string, split = "")[[1]], 0)
cat(paste(sep = "", count_vowels_v2("Hello World"), "\n")) # 3

count_vowels_v3 <- function(a_string) Reduce(function(current_result, a_character) (if (grepl(a_character, "aiueoAIUEO")) current_result + 1 else current_result), strsplit(a_string, split = "")[[1]], 0)
cat(paste(sep = "", count_vowels_v3("Hello World"), "\n")) # 3

count_vowels_v4 <- function(a_string) Reduce(function(current_result, a_character) (if (grepl(toupper(a_character), "AIUEO")) current_result + 1 else current_result), strsplit(a_string, split = "")[[1]], 0)
cat(paste(sep = "", count_vowels_v4("Hello World"), "\n")) # 3

count_vowels_v5 <- function(a_string) length(Filter(function(a_character) (a_character %in% list("a", "i", "u", "e", "o", "A", "I", "U", "E", "O")), strsplit(a_string, split = "")[[1]]))
cat(paste(sep = "", count_vowels_v5("Hello World"), "\n")) # 3

count_vowels_v6 <- function(a_string) length(Filter(function(a_character) (toupper(a_character) %in% list("A", "I", "U", "E", "O")), strsplit(a_string, split = "")[[1]]))
cat(paste(sep = "", count_vowels_v6("Hello World"), "\n")) # 3

count_vowels_v7 <- function(a_string) length(Filter(function(a_character) (grepl(a_character, "aiueoAIUEO")), strsplit(a_string, split = "")[[1]]))
cat(paste(sep = "", count_vowels_v7("Hello World"), "\n")) # 3

count_vowels_v8 <- function(a_string) length(Filter(function(a_character) (grepl(toupper(a_character), "AIUEO")), strsplit(a_string, split = "")[[1]]))
cat(paste(sep = "", count_vowels_v8("Hello World"), "\n")) # 3
