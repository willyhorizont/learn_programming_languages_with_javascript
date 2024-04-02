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

const countVowelsV1 = (aString) => [...aString].reduce((currentResult, aCharacter) => (["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].includes(aCharacter) ? (currentResult + 1) : currentResult), 0);
console.log(countVowelsV1("Hello World")); // 3

const countVowelsV2 = (aString) => [...aString].reduce((currentResult, aCharacter) => (["A", "I", "U", "E", "O"].includes(aCharacter.toUpperCase()) ? (currentResult + 1) : currentResult), 0);
console.log(countVowelsV2("Hello World")); // 3

const countVowelsV3 = (aString) => [...aString].reduce((currentResult, aCharacter) => ("aiueoAIUEO".includes(aCharacter) ? (currentResult + 1) : currentResult), 0);
console.log(countVowelsV3("Hello World")); // 3

const countVowelsV4 = (aString) => [...aString].reduce((currentResult, aCharacter) => ("AIUEO".includes(aCharacter.toUpperCase()) ? (currentResult + 1) : currentResult), 0);
console.log(countVowelsV4("Hello World")); // 3

const countVowelsV5 = (aString) => [...aString].filter((aCharacter) => ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].includes(aCharacter)).length;
console.log(countVowelsV5("Hello World")); // 3

const countVowelsV6 = (aString) => [...aString].filter((aCharacter) => ["A", "I", "U", "E", "O"].includes(aCharacter.toUpperCase())).length;
console.log(countVowelsV6("Hello World")); // 3

const countVowelsV7 = (aString) => [...aString].filter((aCharacter) => "aiueoAIUEO".includes(aCharacter)).length;
console.log(countVowelsV7("Hello World")); // 3

const countVowelsV8 = (aString) => [...aString].filter((aCharacter) => "AIUEO".includes(aCharacter.toUpperCase())).length;
console.log(countVowelsV8("Hello World")); // 3
