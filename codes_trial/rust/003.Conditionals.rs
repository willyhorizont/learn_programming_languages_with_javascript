#![allow(unused_variables)]
#![allow(unused_parens)]
#![allow(dead_code)]

fn main() {
    /*
        Relational Operators / Comparison Operators:
        equal to (==) *checks for equality after performing type coercion. It converts operands to the same type before making the comparison.
        not equal to (!=) *checks for inequality after performing type coercion. It converts operands to the same type before making the comparison.
        greater than (>)
        less than (<)
        greater than or equal to (>=)
        less than or equal to (<=)

        Logical Operators:
        Logical AND (&&)
        Logical OR (||)
        Logical NOT (!)
    */

    let correct_answer = 100;

    let mut my_age: i64;
    let mut my_answer: i64;
    let mut has_driving_license: bool;
    let mut can_drive: bool;

    println!("\n// basic conditional control flow\n");

    my_age = 10;
    println!("my_age: {my_age}");
    if (my_age > 24) {
        println!("you are old");
    } else if (my_age > 17) {
        println!("you are young");
    } else {
        println!("you are under age");
    }

    println!("\n// equal to (==)\n");

    my_answer = 100;
    println!("my_answer: {my_answer}");
    println!("correct_answer: {correct_answer}");
    println!("(my_answer == correct_answer):");
    if (my_answer == correct_answer) {
        println!("Your answer is correct");
    } else {
        println!("Your answer is wrong");
    }

    println!("\n// not equal to (!=)\n");

    my_answer = 25;
    println!("my_answer: {my_answer}");
    println!("correct_answer: {correct_answer}");
    println!("(my_answer != correct_answer):");
    if (my_answer != correct_answer) {
        println!("Your answer is wrong");
    } else {
        println!("Your answer is correct");
    }

    println!("\n// greater than (>)\n");

    my_age = 70;
    println!("my_age: {my_age}");
    println!("(my_age > 50):");
    if (my_age > 50) {
        println!("You are old");
    }

    println!("\n// less than (<)\n");

    my_age = 16;
    println!("my_age: {my_age}");
    println!("(my_age < 20):");
    if (my_age < 20) {
        println!("You are young");
    }

    println!("\n// greater than or equal to (>=)\n");

    my_age = 73;
    println!("my_age: {my_age}");
    println!("(my_age >= 65):");
    if (my_age >= 65) {
        println!("You are allowed to retire");
    }

    println!("\n// less than or equal to (<=)\n");

    my_age = 14;
    println!("my_age: {my_age}");
    println!("(my_age <= 16):");
    if (my_age <= 16) {
        println!("You are not allowed to drive");
    }

    println!("\n// Logical AND (&&)\n");

    my_age = 17;
    println!("my_age: {my_age}");
    has_driving_license = false;
    println!("has_driving_license: {has_driving_license}");
    println!("((my_age >= 17) && (has_driving_license == true)):");
    if ((my_age >= 17) && (has_driving_license == true)) {
        println!("You are allowed to drive");
    } else {
        println!("You are not allowed to drive");
    }

    my_age = 17;
    println!("my_age: {my_age}");
    has_driving_license = true;
    println!("has_driving_license: {has_driving_license}");
    println!("((my_age >= 17) && (has_driving_license == true)):");
    if ((my_age >= 17) && (has_driving_license == true)) {
        println!("You are allowed to drive");
    } else {
        println!("You are not allowed to drive");
    }

    println!("\n// Logical OR (||)\n");

    my_age = 2;
    println!("my_age: {my_age}");
    println!("((my_age <= 3) || (my_age >= 65)):");
    if ((my_age <= 3) || (my_age >= 65)) {
        println!("You should stay home");
    }

    my_age = 89;
    println!("my_age: {my_age}");
    println!("((my_age <= 3) || (my_age >= 65)):");
    if ((my_age <= 3) || (my_age >= 65)) {
        println!("You should stay home");
    }

    println!("\n// Logical NOT (!)\n");

    can_drive = false;
    println!("can_drive: {:?}", can_drive);
    println!("!can_drive: {:?}", !can_drive);

    can_drive = true;
    println!("can_drive: {:?}", can_drive);
    println!("!can_drive: {:?}", !can_drive);
}
