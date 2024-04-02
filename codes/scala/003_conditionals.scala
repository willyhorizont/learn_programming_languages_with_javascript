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

val CORRECT_ANSWER: Int = 100
var myAge: Any = null
var myAnswer: Any = null
var hasDrivingLicense: Any = null
var canDrive: Any = null

println("\n" + "// basic conditional control flow\n")

myAge = 10
println(s"myAge: ${myAge.asInstanceOf[Int]}")
if (myAge.asInstanceOf[Int] > 24) {
    println("you are old")
} else if (myAge.asInstanceOf[Int] > 17) {
    println("you are young")
} else {
    println("you are under age")
}

println("\n" + "equal to (==)\n")

myAnswer = 100
println(s"myAnswer: ${myAnswer.asInstanceOf[Int]}")
println(s"CORRECT_ANSWER: ${CORRECT_ANSWER}")
println("(myAnswer == CORRECT_ANSWER):")
if (myAnswer.asInstanceOf[Int] == CORRECT_ANSWER) {
    println("Your answer is correct")
} else {
    println("Your answer is wrong")
}

println("\n" + "not equal to (!=)\n")

myAnswer = 25
println(s"myAnswer: ${myAnswer.asInstanceOf[Int]}")
println(s"CORRECT_ANSWER: ${CORRECT_ANSWER}")
println("(myAnswer != CORRECT_ANSWER):")
if (myAnswer.asInstanceOf[Int] != CORRECT_ANSWER) {
    println("Your answer is correct")
} else {
    println("Your answer is wrong")
}

println("\n" + "greater than (>)\n")

myAge = 70
println(s"myAge: ${myAge.asInstanceOf[Int]}")
println("(myAge > 50):")
if (myAge.asInstanceOf[Int] > 50) println("You are old")

println("\n" + "less than (<)\n")

myAge = 16
println(s"myAge: ${myAge.asInstanceOf[Int]}")
println("(myAge < 20):")
if (myAge.asInstanceOf[Int] < 20) println("You are young")

println("\n" + "greater than or equal to (>=)\n")

myAge = 73
println(s"myAge: ${myAge.asInstanceOf[Int]}")
println("(myAge >= 65):")
if (myAge.asInstanceOf[Int] >= 65) println("You are allowed to retire")

println("\n" + "less than or equal to (<=)\n")

myAge = 14
println(s"myAge: ${myAge.asInstanceOf[Int]}")
println("(myAge <= 16):")
if (myAge.asInstanceOf[Int] <= 16) println("You are not allowed to drive")

println("\n" + "Logical AND (&&)\n")

myAge = 17
println(s"myAge: ${myAge.asInstanceOf[Int]}")
hasDrivingLicense = false
println(s"hasDrivingLicense: ${hasDrivingLicense.asInstanceOf[Boolean]}")
println("((myAge >= 17) && (hasDrivingLicense == true)):")
println(if ((myAge.asInstanceOf[Int] >= 17) && (hasDrivingLicense.asInstanceOf[Boolean] == true)) "You are allowed to drive" else "You are not allowed to drive")

myAge = 17
println(s"myAge: ${myAge.asInstanceOf[Int]}")
hasDrivingLicense = true
println(s"hasDrivingLicense: ${hasDrivingLicense.asInstanceOf[Boolean]}")
println("((myAge >= 17) && (hasDrivingLicense == true)):")
println(if ((myAge.asInstanceOf[Int] >= 17) && (hasDrivingLicense.asInstanceOf[Boolean] == true)) "You are allowed to drive" else "You are not allowed to drive")

println("\n" + "Logical OR (||)\n")

myAge = 2
println(s"myAge: ${myAge.asInstanceOf[Int]}")
println("((myAge <= 3) || (myAge >= 65)):")
if ((myAge.asInstanceOf[Int] <= 3) || (myAge.asInstanceOf[Int] >= 65)) println("You should stay home")

myAge = 89
println(s"myAge: ${myAge.asInstanceOf[Int]}")
println("((myAge <= 3) || (myAge >= 65)):")
if ((myAge.asInstanceOf[Int] <= 3) || (myAge.asInstanceOf[Int] >= 65)) println("You should stay home")

println("\n" + "Logical NOT (!)\n")

canDrive = false
println(s"canDrive: ${canDrive.asInstanceOf[Boolean]}")
println(s"!canDrive: ${!canDrive.asInstanceOf[Boolean]}")

canDrive = true
println(s"canDrive: ${canDrive.asInstanceOf[Boolean]}")
println(s"!canDrive: ${!canDrive.asInstanceOf[Boolean]}")
