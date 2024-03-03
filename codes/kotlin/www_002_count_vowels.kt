@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")

/*
Source:
    https://www.codewars.com/kata/54ff3102c1bad923760001f3
Title:
    Vowel Count
Description:
    Return the number (count) of vowels in the given string.
    We will consider a, e, i, o, u as vowels for this Kata (but not y).
    The input string will only consist of lower case letters and/or spaces.
*/

fun main() {
    val countVowelsV1: (String) -> Int = { aString -> aString.split("").toMutableList().fold(0) { result: Int, aLetter: String -> if (aLetter in mutableListOf<String>("a", "i", "u", "e", "o", "A", "I", "U", "E", "O")) (result + 1) else result } }
    println(countVowelsV1("Hello World")) // 3

    val countVowelsV2: (String) -> Int = { aString -> aString.split("").toMutableList().fold(0) { result: Int, aLetter: String -> if (aLetter.uppercase() in mutableListOf<String>("A", "I", "U", "E", "O")) (result + 1) else result } }
    println(countVowelsV2("Hello World")) // 3

    val countVowelsV3: (String) -> Int = { aString -> aString.toCharArray().fold(0) { result: Int, aLetter: Char -> if ("aiueoAIUEO".contains(aLetter)) (result + 1) else result } }
    println(countVowelsV3("Hello World")) // 3

    val countVowelsV4: (String) -> Int = { aString -> aString.toCharArray().fold(0) { result: Int, aLetter: Char -> if ("AIUEO".contains(aLetter.uppercase())) (result + 1) else result } }
    println(countVowelsV4("Hello World")) // 3

    val countVowelsV5: (String) -> Int = { aString -> aString.split("").toMutableList().filter { aLetter: String -> (aLetter in mutableListOf<String>("a", "i", "u", "e", "o", "A", "I", "U", "E", "O")) }.size }
    println(countVowelsV5("Hello World")) // 3

    val countVowelsV6: (String) -> Int = { aString -> aString.split("").toMutableList().filter { aLetter: String -> (aLetter.uppercase() in mutableListOf<String>("A", "I", "U", "E", "O")) }.size }
    println(countVowelsV6("Hello World")) // 3

    val countVowelsV7: (String) -> Int = { aString -> aString.toCharArray().filter { aLetter: Char -> ("aiueoAIUEO".contains(aLetter)) }.size }
    println(countVowelsV7("Hello World")) // 3

    val countVowelsV8: (String) -> Int = { aString -> aString.toCharArray().filter { aLetter: Char -> ("AIUEO".contains(aLetter.uppercase())) }.size }
    println(countVowelsV8("Hello World")) // 3
}
