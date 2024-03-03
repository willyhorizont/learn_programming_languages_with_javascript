/*
Source:
    https://www.codewars.com/kata/586538146b56991861000293
Title:
    If you can read this...
Description:
    Task:
        You'll have to translate a string to Pilot's alphabet (NATO phonetic alphabet).
    Input:
        If, you can read?
    Output:
        India Foxtrot , Yankee Oscar Uniform Charlie Alfa November Romeo Echo Alfa Delta ?
    Note:
        There is a preloaded dictionary that you can use, named NATO. It uses uppercase keys, e.g. NATO['A'] is "Alfa". See comments in the initial code to see how to access it in your language.
        The set of used punctuation is ,.!?.
        Punctuation should be kept in your return string, but spaces should not.
        Xray should not have a dash within.
        Every word and punctuation mark should be seperated by a space ' '.
        There should be no trailing whitespace
*/

const NATO = {
    "A": "Alfa",
    "B": "Bravo",
    "C": "Charlie",
    "D": "Delta",
    "E": "Echo",
    "F": "Foxtrot",
    "G": "Golf",
    "H": "Hotel",
    "I": "India",
    "J": "Juliett",
    "K": "Kilo",
    "L": "Lima",
    "M": "Mike",
    "N": "November",
    "O": "Oscar",
    "P": "Papa",
    "Q": "Quebec",
    "R": "Romeo",
    "S": "Sierra",
    "T": "Tango",
    "U": "Uniform",
    "V": "Victor",
    "W": "Whiskey",
    "X": "Xray",
    "Y": "Yankee",
    "Z": "Zulu",
    ",": ",",
    ".": ".",
    "!": "!",
    "?": "?",
};

const encryptToNatoPhoneticAlphabet = (aString) => [...aString].filter((rawCharacter) => Object.keys({ ...NATO, ",": ",", ".": ".", "!": "!", "?": "?" }).includes(rawCharacter.toUpperCase()) === true).map((allowedCharacter) => ({ ...NATO, ",": ",", ".": ".", "!": "!", "?": "?" }[allowedCharacter.toUpperCase()])).join(" ");
console.log(encryptToNatoPhoneticAlphabet("If, you can read?")); // India Foxtrot , Yankee Oscar Uniform Charlie Alfa November Romeo Echo Alfa Delta ?
console.log(encryptToNatoPhoneticAlphabet("go for it!")); // Golf Oscar Foxtrot Oscar Romeo India Tango !
console.log(encryptToNatoPhoneticAlphabet("bcdQxe, zeMe, wrhXfcuZSS, qLyPytX")); // Bravo Charlie Delta Quebec Xray Echo , Zulu Echo Mike Echo , Whiskey Romeo Hotel Xray Foxtrot Charlie Uniform Zulu Sierra Sierra , Quebec Lima Yankee Papa Yankee Tango Xray
