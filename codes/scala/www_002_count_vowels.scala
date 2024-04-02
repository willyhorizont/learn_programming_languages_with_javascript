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

val countVowelsV1 = ((aString: String) => (aString.toCharArray.foldLeft(0)((currentResult: Int, aCharacter: Char) => (if (Array("a", "i", "u", "e", "o", "A", "I", "U", "E", "O").contains(aCharacter.toString)) (currentResult + 1) else currentResult): Int): Int))
println(countVowelsV1("Hello World")) // 3

val countVowelsV2 = ((aString: String) => (aString.toCharArray.foldLeft(0)((currentResult: Int, aCharacter: Char) => (if (Array("A", "I", "U", "E", "O").contains(aCharacter.toString.toUpperCase())) (currentResult + 1) else currentResult): Int): Int))
println(countVowelsV2("Hello World")) // 3

val countVowelsV3 = ((aString: String) => (aString.toCharArray.foldLeft(0)((currentResult: Int, aCharacter: Char) => (if ("aiueoAIUEO".contains(aCharacter.toString)) (currentResult + 1) else currentResult): Int): Int))
println(countVowelsV3("Hello World")) // 3

val countVowelsV4 = ((aString: String) => (aString.toCharArray.foldLeft(0)((currentResult: Int, aCharacter: Char) => (if ("AIUEO".contains(aCharacter.toString.toUpperCase())) (currentResult + 1) else currentResult): Int): Int))
println(countVowelsV4("Hello World")) // 3

val countVowelsV5 = ((aString: String) => (aString.toCharArray.filter((aCharacter: Char) => (Array("a", "i", "u", "e", "o", "A", "I", "U", "E", "O").contains(aCharacter.toString)): Boolean): Array[Char]).length: Int)
println(countVowelsV5("Hello World")) // 3

val countVowelsV6 = ((aString: String) => (aString.toCharArray.filter((aCharacter: Char) => (Array("A", "I", "U", "E", "O").contains(aCharacter.toString.toUpperCase())): Boolean): Array[Char]).length: Int)
println(countVowelsV6("Hello World")) // 3

val countVowelsV7 = ((aString: String) => (aString.toCharArray.filter((aCharacter: Char) => ("aiueoAIUEO".contains(aCharacter.toString)): Boolean): Array[Char]).length: Int)
println(countVowelsV7("Hello World")) // 3

val countVowelsV8 = ((aString: String) => (aString.toCharArray.filter((aCharacter: Char) => ("AIUEO".contains(aCharacter.toString.toUpperCase())): Boolean): Array[Char]).length: Int)
println(countVowelsV8("Hello World")) // 3
