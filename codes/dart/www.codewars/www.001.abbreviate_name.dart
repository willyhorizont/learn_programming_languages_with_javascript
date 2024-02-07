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

void main() {
	final abbrevName = (dynamic completeName) => completeName.split(" ").map((dynamic name) => (name[0].toUpperCase())).toList().join(".");
	print(abbrevName("Sam Harris"));
	// S.H
	print(abbrevName("patrick feeney"));
	// P.F
}
