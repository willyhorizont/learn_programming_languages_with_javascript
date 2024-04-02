@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

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
    val countVowelsV1 = { aString: String -> (aString.toCharArray().fold(0) { currentResult: Int, aCharacter: Char -> (if (aCharacter.toString() in mutableListOf<String>("a", "i", "u", "e", "o", "A", "I", "U", "E", "O")) (currentResult + 1) else currentResult) }) }
    println(countVowelsV1("Hello World")) // 3

    val countVowelsV2 = { aString: String -> (aString.toCharArray().fold(0) { currentResult: Int, aCharacter: Char -> (if (aCharacter.toString().uppercase() in mutableListOf<String>("A", "I", "U", "E", "O")) (currentResult + 1) else currentResult) }) }
    println(countVowelsV2("Hello World")) // 3

    val countVowelsV3 = { aString: String -> (aString.toCharArray().fold(0) { currentResult: Int, aCharacter: Char -> (if ("aiueoAIUEO".contains(aCharacter)) (currentResult + 1) else currentResult) }) }
    println(countVowelsV3("Hello World")) // 3

    val countVowelsV4 = { aString: String -> (aString.toCharArray().fold(0) { currentResult: Int, aCharacter: Char -> (if ("AIUEO".contains(aCharacter.uppercase())) (currentResult + 1) else currentResult) }) }
    println(countVowelsV4("Hello World")) // 3

    val countVowelsV5 = { aString: String -> (aString.toCharArray().filter { aCharacter: Char -> (aCharacter.toString() in mutableListOf<String>("a", "i", "u", "e", "o", "A", "I", "U", "E", "O")) }.size) }
    println(countVowelsV5("Hello World")) // 3

    val countVowelsV6 = { aString: String -> (aString.toCharArray().filter { aCharacter: Char -> (aCharacter.toString().uppercase() in mutableListOf<String>("A", "I", "U", "E", "O")) }.size) }
    println(countVowelsV6("Hello World")) // 3

    val countVowelsV7 = { aString: String -> (aString.toCharArray().filter { aCharacter: Char -> ("aiueoAIUEO".contains(aCharacter.toString())) }.size) }
    println(countVowelsV7("Hello World")) // 3

    val countVowelsV8 = { aString: String -> (aString.toCharArray().filter { aCharacter: Char -> ("AIUEO".contains(aCharacter.toString().uppercase())) }.size) }
    println(countVowelsV8("Hello World")) // 3
}
