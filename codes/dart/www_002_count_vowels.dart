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

void main() {
	final countVowelsV1 = (dynamic aString) => aString.split("").fold(0, (dynamic result, dynamic aLetter) => (<dynamic>["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].contains(aLetter) ? (result + 1) : result));
	print(countVowelsV1("Hello World")); // 3

	final countVowelsV2 = (dynamic aString) => aString.split("").fold(0, (dynamic result, dynamic aLetter) => (<dynamic>["A", "I", "U", "E", "O"].contains(aLetter.toUpperCase()) ? (result + 1) : result));
	print(countVowelsV2("Hello World")); // 3

	final countVowelsV3 = (dynamic aString) => aString.split("").fold(0, (dynamic result, dynamic aLetter) => ("aiueoAIUEO".contains(aLetter) ? (result + 1) : result));
	print(countVowelsV3("Hello World")); // 3

	final countVowelsV4 = (dynamic aString) => aString.split("").fold(0, (dynamic result, dynamic aLetter) => ("AIUEO".contains(aLetter.toUpperCase()) ? (result + 1) : result));
	print(countVowelsV4("Hello World")); // 3

	final countVowelsV5 = (dynamic aString) => aString.split("").where((dynamic aLetter) => (<dynamic>["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].contains(aLetter))).toList().length;
	print(countVowelsV5("Hello World")); // 3

	final countVowelsV6 = (dynamic aString) => aString.split("").where((dynamic aLetter) => (<dynamic>["A", "I", "U", "E", "O"].contains(aLetter.toUpperCase()))).toList().length;
	print(countVowelsV6("Hello World")); // 3

	final countVowelsV7 = (dynamic aString) => aString.split("").where((dynamic aLetter) => ("aiueoAIUEO".contains(aLetter))).toList().length;
	print(countVowelsV7("Hello World")); // 3

	final countVowelsV8 = (dynamic aString) => aString.split("").where((dynamic aLetter) => ("AIUEO".contains(aLetter.toUpperCase()))).toList().length;
	print(countVowelsV8("Hello World")); // 3
}
