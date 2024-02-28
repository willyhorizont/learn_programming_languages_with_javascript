# Source:
#     https://www.codewars.com/kata/54ff3102c1bad923760001f3
# Title:
#     Vowel Count
# Description:
#     Return the number (count) of vowels in the given string.
#     We will consider a, e, i, o, u as vowels for this Kata (but not y).
#     The input string will only consist of lower case letters and/or spaces.

countVowelsV1 <- function(aString) Reduce(function(result, letter) (if (letter %in% list("a", "i", "u", "e", "o", "A", "I", "U", "E", "O")) result + 1 else result), strsplit(aString, split = "")[[1]], 0)
cat(paste(sep = "", countVowelsV1("Hello World"), "\n")) # 3

countVowelsV2 <- function(aString) Reduce(function(result, letter) (if (toupper(letter) %in% list("A", "I", "U", "E", "O")) result + 1 else result), strsplit(aString, split = "")[[1]], 0)
cat(paste(sep = "", countVowelsV2("Hello World"), "\n")) # 3

countVowelsV3 <- function(aString) Reduce(function(result, letter) (if (grepl(letter, "aiueoAIUEO")) result + 1 else result), strsplit(aString, split = "")[[1]], 0)
cat(paste(sep = "", countVowelsV3("Hello World"), "\n")) # 3

countVowelsV4 <- function(aString) Reduce(function(result, letter) (if (grepl(toupper(letter), "AIUEO")) result + 1 else result), strsplit(aString, split = "")[[1]], 0)
cat(paste(sep = "", countVowelsV4("Hello World"), "\n")) # 3

countVowelsV5 <- function(aString) length(Filter(function(letter) (letter %in% list("a", "i", "u", "e", "o", "A", "I", "U", "E", "O")), strsplit(aString, split = "")[[1]]))
cat(paste(sep = "", countVowelsV5("Hello World"), "\n")) # 3

countVowelsV6 <- function(aString) length(Filter(function(letter) (toupper(letter) %in% list("A", "I", "U", "E", "O")), strsplit(aString, split = "")[[1]]))
cat(paste(sep = "", countVowelsV6("Hello World"), "\n")) # 3

countVowelsV7 <- function(aString) length(Filter(function(letter) (grepl(letter, "aiueoAIUEO")), strsplit(aString, split = "")[[1]]))
cat(paste(sep = "", countVowelsV7("Hello World"), "\n")) # 3

countVowelsV8 <- function(aString) length(Filter(function(letter) (grepl(toupper(letter), "AIUEO")), strsplit(aString, split = "")[[1]]))
cat(paste(sep = "", countVowelsV8("Hello World"), "\n")) # 3
