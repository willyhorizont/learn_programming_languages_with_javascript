/*
    Relational Operators / Comparison Operators:
    equal to (==)
    not equal to (!=)
    greater than (>)
    less than (<)
    greater than or equal to (>=)
    less than or equal to (<=)

    Logical Operators:
    Logical AND (&&)
    Logical OR (||)
    Logical NOT (!)
*/

let CORRECT_ANSWER = 100

var myAge: Int
var myAnswer: Int
var hasDrivingLicense: Bool
var canDrive: Bool

print("\n// basic conditional control flow\n")

myAge = 10
print("myAge: \(myAge)")
if (myAge > 24) {
    print("you are old")
} else if (myAge > 17) {
    print("you are young")
} else {
    print("you are under age")
}

print("\n// equal to (==)\n")

myAnswer = 100
print("myAnswer: \(myAnswer)")
print("CORRECT_ANSWER: \(CORRECT_ANSWER)")
print("(myAnswer == CORRECT_ANSWER):")
if (myAnswer == CORRECT_ANSWER) {
    print("Your answer is correct")
} else {
    print("Your answer is wrong")
}

print("\n// not equal to (!=)\n")

myAnswer = 25
print("myAnswer: \(myAnswer)")
print("CORRECT_ANSWER: \(CORRECT_ANSWER)")
print("(myAnswer != CORRECT_ANSWER):")
if (myAnswer != CORRECT_ANSWER) {
    print("Your answer is correct")
} else {
    print("Your answer is wrong")
}

print("\n// greater than (>)\n")

myAge = 70
print("myAge: \(myAge)")
print("(myAge > 50):")
if (myAge > 50) {
    print("You are old")
}

print("\n// less than (<)\n")

myAge = 16
print("myAge: \(myAge)")
print("(myAge < 20):")
if (myAge < 20) {
    print("You are young")
}

print("\n// greater than or equal to (>=)\n")

myAge = 73
print("myAge: \(myAge)")
print("(myAge >= 65):")
if (myAge >= 65) {
    print("You are allowed to retire")
}

print("\n// less than or equal to (<=)\n")

myAge = 14
print("myAge: \(myAge)")
print("(myAge <= 16):")
if (myAge <= 16) {
    print("You are not allowed to drive")
}

print("\n// Logical AND (&&)\n")

myAge = 17
print("myAge: \(myAge)")
hasDrivingLicense = false
print("hasDrivingLicense: \(hasDrivingLicense)")
print("((myAge >= 17) && (hasDrivingLicense == true)):")
print((((myAge >= 17) && (hasDrivingLicense == true)) ? "You are allowed to drive" : "You are not allowed to drive"))

myAge = 17
print("myAge: \(myAge)")
hasDrivingLicense = true
print("hasDrivingLicense: \(hasDrivingLicense)")
print("((myAge >= 17) && (hasDrivingLicense == true)):")
print((((myAge >= 17) && (hasDrivingLicense == true)) ? "You are allowed to drive" : "You are not allowed to drive"))

print("\n// Logical OR (||)\n")

myAge = 2
print("myAge: \(myAge)")
print("((myAge <= 3) || (myAge >= 65)):")
if ((myAge <= 3) || (myAge >= 65)) {
    print("You should stay home")
}

myAge = 89
print("myAge: \(myAge)")
print("((myAge <= 3) || (myAge >= 65)):")
if ((myAge <= 3) || (myAge >= 65)) {
    print("You should stay home")
}

print("\n// Logical NOT (!)\n")

canDrive = false
print("canDrive: \(canDrive)")
print("!canDrive: \(!canDrive)")

canDrive = true
print("canDrive: \(canDrive)")
print("!canDrive: \(!canDrive)")
