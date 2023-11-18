@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")
// to compile and run the code:
// kotlinc 1.Conditionals.kt -include-runtime -d 1.Conditionals.jar && kotlin 1.Conditionals.jar

fun main() {
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

    val CORRECT_ANSWER = 100
    var myAge: Any
    var myAnswer: Any
    var hasDrivingLicense: Any
    var canDrive: Any

    println("\n// basic conditional control flow\n")

    myAge = 10
    println("myAge: ${myAge}")
    if (myAge > 24) {
        println("you are old")
    } else if (myAge > 17) {
        println("you are young")
    } else {
        println("you are under age")
    }

    println("\nequal to (==)\n")

    myAnswer = 100
    println("myAnswer: ${myAnswer}")
    println("CORRECT_ANSWER: ${CORRECT_ANSWER}")
    println("(myAnswer == CORRECT_ANSWER):")
    if (myAnswer == CORRECT_ANSWER) {
        println("Your answer is correct")
    } else {
        println("Your answer is wrong")
    }

    println("\nnot equal to (!=)\n")

    myAnswer = 25
    println("myAnswer: ${myAnswer}")
    println("CORRECT_ANSWER: ${CORRECT_ANSWER}")
    println("(myAnswer != CORRECT_ANSWER):")
    if (myAnswer != CORRECT_ANSWER) {
        println("Your answer is wrong")
    } else {
        println("Your answer is correct")
    }

    println("\ngreater than (>)\n")

    myAge = 70
    println("myAge: ${myAge}")
    println("(myAge > 50):")
    if (myAge > 50) println("You are old")

    println("\nless than (<)\n")

    myAge = 16
    println("myAge: ${myAge}")
    println("(myAge < 20):")
    if (myAge < 20) println("You are young")

    println("\ngreater than or equal to (>=)\n")
    
    myAge = 73
    println("myAge: ${myAge}")
    println("(myAge >= 65):")
    if (myAge >= 65) println("You are allowed to retire")

    println("\nless than or equal to (<=)\n")

    myAge = 14
    println("myAge: ${myAge}")
    println("(myAge <= 16):")
    if (myAge <= 16) println("You are not allowed to drive")

    println("\nLogical AND (&&)\n")

    myAge = 17
    println("myAge: ${myAge}")
    hasDrivingLicense = false
    println("hasDrivingLicense: ${hasDrivingLicense}")
    println("((myAge >= 17) && (hasDrivingLicense == true)):")
    println(if ((myAge >= 17) && (hasDrivingLicense == true)) "You are allowed to drive" else "You are not allowed to drive")

    myAge = 17
    println("myAge: ${myAge}")
    hasDrivingLicense = true
    println("hasDrivingLicense: ${hasDrivingLicense}")
    println("((myAge >= 17) && (hasDrivingLicense == true)):")
    println(if ((myAge >= 17) && (hasDrivingLicense == true)) "You are allowed to drive" else "You are not allowed to drive")

    println("\nLogical OR (||)\n")

    myAge = 2
    println("myAge: ${myAge}")
    println("((myAge <= 3) || (myAge >= 65)):")
    if ((myAge <= 3) || (myAge >= 65)) println("You should stay home")

    myAge = 89
    println("myAge: ${myAge}")
    println("((myAge <= 3) || (myAge >= 65)):")
    if ((myAge <= 3) || (myAge >= 65)) println("You should stay home")

    println("\nLogical NOT (!)\n")

    canDrive = false
    println("canDrive: ${canDrive}")
    println("!canDrive: ${!canDrive}")

    canDrive = true
    println("canDrive: ${canDrive}")
    println("!canDrive: ${!canDrive}")
}
