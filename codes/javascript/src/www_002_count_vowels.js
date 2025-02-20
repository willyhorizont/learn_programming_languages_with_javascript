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

const countVowelsV1 = (anyString) => [...anyString].reduce((currentResult, anyCharacter) => (["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].includes(anyCharacter) ? (currentResult + 1) : currentResult), 0);
console.log(countVowelsV1("Hello World")); // 3

const countVowelsV2 = (anyString) => [...anyString].reduce((currentResult, anyCharacter) => (["A", "I", "U", "E", "O"].includes(anyCharacter.toUpperCase()) ? (currentResult + 1) : currentResult), 0);
console.log(countVowelsV2("Hello World")); // 3

const countVowelsV3 = (anyString) => [...anyString].reduce((currentResult, anyCharacter) => ("aiueoAIUEO".includes(anyCharacter) ? (currentResult + 1) : currentResult), 0);
console.log(countVowelsV3("Hello World")); // 3

const countVowelsV4 = (anyString) => [...anyString].reduce((currentResult, anyCharacter) => ("AIUEO".includes(anyCharacter.toUpperCase()) ? (currentResult + 1) : currentResult), 0);
console.log(countVowelsV4("Hello World")); // 3

const countVowelsV5 = (anyString) => [...anyString].filter((anyCharacter) => ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].includes(anyCharacter)).length;
console.log(countVowelsV5("Hello World")); // 3

const countVowelsV6 = (anyString) => [...anyString].filter((anyCharacter) => ["A", "I", "U", "E", "O"].includes(anyCharacter.toUpperCase())).length;
console.log(countVowelsV6("Hello World")); // 3

const countVowelsV7 = (anyString) => [...anyString].filter((anyCharacter) => "aiueoAIUEO".includes(anyCharacter)).length;
console.log(countVowelsV7("Hello World")); // 3

const countVowelsV8 = (anyString) => [...anyString].filter((anyCharacter) => "AIUEO".includes(anyCharacter.toUpperCase())).length;
console.log(countVowelsV8("Hello World")); // 3
