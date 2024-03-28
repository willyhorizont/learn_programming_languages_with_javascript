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

let countVowelsV1 = { (aString: String) -> Int in aString.split(separator: "").reduce(0) { (currentResult: Int, aCharacter: Substring) -> Int in ((["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].contains(aCharacter)) ? (currentResult + 1) : currentResult) } }
print(countVowelsV1("Hello World")) // 3

let countVowelsV2 = { (aString: String) -> Int in aString.split(separator: "").reduce(0) { (currentResult: Int, aCharacter: Substring) -> Int in ((["A", "I", "U", "E", "O"].contains(aCharacter.uppercased())) ? (currentResult + 1) : currentResult) } }
print(countVowelsV2("Hello World")) // 3

let countVowelsV3 = { (aString: String) -> Int in aString.split(separator: "").reduce(0) { (currentResult: Int, aCharacter: Substring) -> Int in (("aiueoAIUEO".contains(aCharacter)) ? (currentResult + 1) : currentResult) } }
print(countVowelsV3("Hello World")) // 3

let countVowelsV4 = { (aString: String) -> Int in aString.split(separator: "").reduce(0) { (currentResult: Int, aCharacter: Substring) -> Int in (("AIUEO".contains(aCharacter.uppercased())) ? (currentResult + 1) : currentResult) } }
print(countVowelsV4("Hello World")) // 3

let countVowelsV5 = { (aString: String) -> Int in aString.split(separator: "").filter { (aCharacter: Substring) -> Bool in (["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].contains(aCharacter)) }.count }
print(countVowelsV5("Hello World")) // 3

let countVowelsV6 = { (aString: String) -> Int in aString.split(separator: "").filter { (aCharacter: Substring) -> Bool in (["A", "I", "U", "E", "O"].contains(aCharacter.uppercased())) }.count }
print(countVowelsV6("Hello World")) // 3

let countVowelsV7 = { (aString: String) -> Int in aString.split(separator: "").filter { (aCharacter: Substring) -> Bool in ("aiueoAIUEO".contains(aCharacter)) }.count }
print(countVowelsV7("Hello World")) // 3

let countVowelsV8 = { (aString: String) -> Int in aString.split(separator: "").filter { (aCharacter: Substring) -> Bool in ("AIUEO".contains(aCharacter.uppercased())) }.count }
print(countVowelsV8("Hello World")) // 3
