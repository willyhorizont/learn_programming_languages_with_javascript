/*
Source:
    https://www.codewars.com/kata/514b92a657cdc65150000006
Title:
    Multiples of 3 or 5
Description:
    If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
    Finish the solution so that it returns the sum of all the multiples of 3 or 5 below the number passed in.
    Additionally, if the number is negative, return 0.
    Note: If the number is a multiple of both 3 and 5, only count it once.
    Courtesy of https://projecteuler.net/problem=1
*/

import Foundation

typealias MyObject = [String: Any?]
typealias MyArray = [Any?]

func spreadSyntaxObject(_ parameters: Any?...) -> MyObject {
    var newObject = MyObject()
    for (_, parameter) in parameters.enumerated() {
        if parameter is MyObject {
            guard let parameter = parameter as? MyObject else {
                continue
            }
            for (objectKey, objectValue) in parameter {
                newObject[objectKey] = objectValue
            }
            continue
        }
        if parameter is MyArray {
            guard let parameter = parameter as? MyArray else {
                continue
            }
            for (arrayItemIndex, arrayItem) in parameter.enumerated() {
                newObject[String(arrayItemIndex)] = arrayItem
            }
            continue
        }
    }
    return newObject
}

let NATO: MyObject = [
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
    "?": "?"
]

let encryptToNatoPhoneticAlphabet = { (aString: String) -> String in aString.split(separator: "").filter { (spreadSyntaxObject(NATO.reduce(MyObject()) { result, pair in spreadSyntaxObject(result, [String(pair.key): pair.value] as MyObject) }, [",": ",", ".": ".", "!": "!", "?": "?"] as MyObject).keys.contains($0.uppercased())) }.map { (allowedCharacter: Substring) -> String in spreadSyntaxObject(NATO.reduce(MyObject()) { result, pair in spreadSyntaxObject(result, [String(pair.key): pair.value] as MyObject) }, [",": ",", ".": ".", "!": "!", "?": "?"] as MyObject)[allowedCharacter.uppercased()] as! String }.joined(separator: " ") }
print(encryptToNatoPhoneticAlphabet("If, you can read?")) // India Foxtrot , Yankee Oscar Uniform Charlie Alfa November Romeo Echo Alfa Delta ?
print(encryptToNatoPhoneticAlphabet("go for it!")) // Golf Oscar Foxtrot Oscar Romeo India Tango !
print(encryptToNatoPhoneticAlphabet("bcdQxe, zeMe, wrhXfcuZSS, qLyPytX")) // Bravo Charlie Delta Quebec Xray Echo , Zulu Echo Mike Echo , Whiskey Romeo Hotel Xray Foxtrot Charlie Uniform Zulu Sierra Sierra , Quebec Lima Yankee Papa Yankee Tango Xray
