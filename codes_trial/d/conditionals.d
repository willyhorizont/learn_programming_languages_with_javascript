import std.stdio;

/*
    Relational Operators / Comparison Operators:
    equal to (==)
    not equal to (!=)
    greater than (>)
    less than (<)
    greater then or equal to (>=)
    less then or equal to (<=)

    Logical Operators:
    Logical AND (&&)
    Logical OR (||)
    Logical NOT (!)
*/

void main() {
    auto CORRECT_ANSWER = 100;
    int myAnswer;
    int myAge;
	bool hasDrivingLicense;
	bool canDrive;

    writeln("\n// basic conditional control flow\n");

    myAge = 10;
    writeln("myAge: ", myAge);
    if (myAge > 24) {
        writeln("you are old");
    } else if (myAge > 17) {
        writeln("you are young");
    } else {
        writeln("you are under age");
    }

    writeln("\n// equal to (==)\n");

    myAnswer = 100;
    writeln("myAnswer: ", myAnswer);
    writeln("CORRECT_ANSWER: ", CORRECT_ANSWER);
    writeln("(myAnswer == CORRECT_ANSWER): ");
    if (myAnswer == CORRECT_ANSWER) {
        writeln("Your answer is correct");
    } else {
        writeln("Your answer is wrong");
    }

    writeln("\n// not equal to (!=)\n");

    myAnswer = 25;
    writeln("myAnswer: ", myAnswer);
    writeln("CORRECT_ANSWER: ", CORRECT_ANSWER);
    writeln("(myAnswer != CORRECT_ANSWER): ");
    if (myAnswer != CORRECT_ANSWER) {
        writeln("Your answer is wrong");
    } else {
        writeln("Your answer is correct");
    }

    writeln("\n// greater than (>)\n");

    myAge = 70;
	writeln("myAge: ", myAge);
	writeln("(myAge > 50): ");
	if (myAge > 50) {
		writeln("You are old");
	}

    writeln("\n// less than (<)\n");

    myAge = 16;
	writeln("myAge: ", myAge);
	writeln("(myAge < 20): ");
	if (myAge < 20) {
		writeln("You are young");
	}

    writeln("\n// greater then or equal to (>=)\n");

    myAge = 73;
	writeln("myAge: ", myAge);
	writeln("(myAge >= 65): ");
	if (myAge >= 65) {
		writeln("You are allowed to retire");
	}

    writeln("\n// less then or equal to (<=)\n");

    myAge = 14;
	writeln("myAge: ", myAge);
	writeln("(myAge <= 16): ");
	if (myAge <= 16) {
		writeln("You are not allowed to drive");
	}

    writeln("\n// Logical AND (&&)\n");

    myAge = 17;
	writeln("myAge: ", myAge);
	hasDrivingLicense = false;
	writeln("hasDrivingLicense: ", hasDrivingLicense);
	writeln("((myAge >= 17) && (hasDrivingLicense == true)): ");
	if ((myAge >= 17) && (hasDrivingLicense == true)) {
		writeln("You are allowed to drive");
	} else {
		writeln("You are not allowed to drive");
	}

	myAge = 17;
	writeln("myAge: ", myAge);
	hasDrivingLicense = true;
	writeln("hasDrivingLicense: ", hasDrivingLicense);
	writeln("((myAge >= 17) && (hasDrivingLicense == true)): ");
	if ((myAge >= 17) && (hasDrivingLicense == true)) {
		writeln("You are allowed to drive");
	} else {
		writeln("You are not allowed to drive");
	}

    writeln("\n// Logical OR (||)\n");

    myAge = 2;
	writeln("myAge: ", myAge);
	writeln("((myAge <= 3) || (myAge >= 65)): ");
	if ((myAge <= 3) || (myAge >= 65)) {
		writeln("You should stay home");
	}

	myAge = 89;
	writeln("myAge: ", myAge);
	writeln("((myAge <= 3) || (myAge >= 65)): ");
	if ((myAge <= 3) || (myAge >= 65)) {
		writeln("You should stay home");
	}

    writeln("\n// Logical NOT (!)\n");

    canDrive = false;
	writeln("canDrive: ", canDrive);
	writeln("!canDrive: ", !canDrive);

	canDrive = true;
	writeln("canDrive: ", canDrive);
	writeln("!canDrive: ", !canDrive);
}
