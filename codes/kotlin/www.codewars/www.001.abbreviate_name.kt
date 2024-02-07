@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST")

/*
Title:
    Abbreviate a Two Word Name
Instructions:
    Write a function to convert a name into initials. This kata strictly takes two words with one space in between them.
    The output should be two capital letters with a dot separating them.
    It should look like this:
    Sam Harris => S.H
    patrick feeney => P.F
*/

fun main() {
    val abbrevName: (String) -> String = { completeName -> completeName.split(" ").toMutableList().map { name: String -> name.first().uppercase() }.joinToString(".") }
    println(abbrevName("Sam Harris"))
    // S.H
    println(abbrevName("patrick feeney"))
    // P.F
}
