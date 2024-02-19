const countVowelsV1 = (str) => [...str].reduce((result, letter) => (["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].includes(letter) ? (result + 1) : result), 0);
console.log(countVowelsV1("Hello World")); // 3
const countVowelsV2 = (str) => [...str].reduce((result, letter) => (["A", "I", "U", "E", "O"].includes(letter.toUpperCase()) ? (result + 1) : result), 0);
console.log(countVowelsV2("Hello World")); // 3
const countVowelsV3 = (str) => [...str].reduce((result, letter) => ("aiueoAIUEO".includes(letter) ? (result + 1) : result), 0);
console.log(countVowelsV3("Hello World")); // 3
const countVowelsV4 = (str) => [...str].reduce((result, letter) => ("AIUEO".includes(letter.toUpperCase()) ? (result + 1) : result), 0);
console.log(countVowelsV4("Hello World")); // 3
const countVowelsV5 = (str) => [...str].filter((letter) => ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"].includes(letter)).length;
console.log(countVowelsV5("Hello World")); // 3
const countVowelsV6 = (str) => [...str].filter((letter) => ["A", "I", "U", "E", "O"].includes(letter.toUpperCase())).length;
console.log(countVowelsV6("Hello World")); // 3
const countVowelsV7 = (str) => [...str].filter((letter) => "aiueoAIUEO".includes(letter)).length;
console.log(countVowelsV7("Hello World")); // 3
const countVowelsV8 = (str) => [...str].filter((letter) => "AIUEO".includes(letter.toUpperCase())).length;
console.log(countVowelsV8("Hello World")); // 3
