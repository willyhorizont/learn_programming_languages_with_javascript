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

let countVowelsV1 = { (aString: String) -> Int in aString.split(separator: "").reduce(0) { (result: Int, aLetter: Substring) -> Int in ((["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].contains(aLetter)) ? (result + 1) : result) } }
print(countVowelsV1("Hello World")) // 3

let countVowelsV2 = { (aString: String) -> Int in aString.split(separator: "").reduce(0) { (result: Int, aLetter: Substring) -> Int in ((["A", "I", "U", "E", "O"].contains(aLetter.uppercased())) ? (result + 1) : result) } }
print(countVowelsV2("Hello World")) // 3

let countVowelsV3 = { (aString: String) -> Int in aString.split(separator: "").reduce(0) { (result: Int, aLetter: Substring) -> Int in (("aiueoAIUEO".contains(aLetter)) ? (result + 1) : result) } }
print(countVowelsV3("Hello World")) // 3

let countVowelsV4 = { (aString: String) -> Int in aString.split(separator: "").reduce(0) { (result: Int, aLetter: Substring) -> Int in (("AIUEO".contains(aLetter.uppercased())) ? (result + 1) : result) } }
print(countVowelsV4("Hello World")) // 3

let countVowelsV5 = { (aString: String) -> Int in aString.split(separator: "").filter { (["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].contains($0)) }.count }
print(countVowelsV5("Hello World")) // 3

let countVowelsV6 = { (aString: String) -> Int in aString.split(separator: "").filter { (["A", "I", "U", "E", "O"].contains($0.uppercased())) }.count }
print(countVowelsV6("Hello World")) // 3

let countVowelsV7 = { (aString: String) -> Int in aString.split(separator: "").filter { ("aiueoAIUEO".contains($0)) }.count }
print(countVowelsV7("Hello World")) // 3

let countVowelsV8 = { (aString: String) -> Int in aString.split(separator: "").filter { ("AIUEO".contains($0.uppercased())) }.count }
print(countVowelsV8("Hello World")) // 3
