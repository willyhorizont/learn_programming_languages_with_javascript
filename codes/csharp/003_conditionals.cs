using System; // Console, Func<>, Action<>, Action

class Program {
    static void Main(string[] Args) {
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

        dynamic CORRECT_ANSWER = 100;

        dynamic MyAge;
        dynamic MyAnswer;
        dynamic HasDrivingLicense;
        dynamic CanDrive;

        Console.WriteLine("\n// basic conditional control flow\n");

        MyAge = 10;
        Console.WriteLine($"MyAge: {MyAge}");
        if (MyAge > 24) {
            Console.WriteLine("you are old");
        } else if (MyAge > 17) {
            Console.WriteLine("you are young");
        } else {
            Console.WriteLine("you are under age");
        }

        Console.WriteLine("\n// equal to (==)\n");

        MyAnswer = 100;
        Console.WriteLine($"MyAnswer: {MyAnswer}");
        Console.WriteLine($"CORRECT_ANSWER: {CORRECT_ANSWER}");
        Console.WriteLine("(MyAnswer == CORRECT_ANSWER):");
        if (MyAnswer == CORRECT_ANSWER) {
            Console.WriteLine("Your answer is correct");
        } else {
            Console.WriteLine("Your answer is wrong");
        }

        Console.WriteLine("\n// not equal to (!=)\n");

        MyAnswer = 25;
        Console.WriteLine($"MyAnswer: {MyAnswer}");
        Console.WriteLine($"CORRECT_ANSWER: {CORRECT_ANSWER}");
        Console.WriteLine("(MyAnswer != CORRECT_ANSWER):");
        if (MyAnswer != CORRECT_ANSWER) {
            Console.WriteLine("Your answer is correct");
        } else {
            Console.WriteLine("Your answer is wrong");
        }

        Console.WriteLine("\n// greater than (>)\n");

        MyAge = 70;
        Console.WriteLine($"MyAge: {MyAge}");
        Console.WriteLine("(MyAge > 50):");
        if (MyAge > 50) Console.WriteLine("You are old");

        Console.WriteLine("\n// less than (<)\n");

        MyAge = 16;
        Console.WriteLine($"MyAge: {MyAge}");
        Console.WriteLine("(MyAge < 20):");
        if (MyAge < 20) Console.WriteLine("You are young");

        Console.WriteLine("\n// greater than or equal to (>=)\n");

        MyAge = 73;
        Console.WriteLine($"MyAge: {MyAge}");
        Console.WriteLine("(MyAge >= 65):");
        if (MyAge >= 65) Console.WriteLine("You are allowed to retire");

        Console.WriteLine("\n// less than or equal to (<=)\n");

        MyAge = 14;
        Console.WriteLine($"MyAge: {MyAge}");
        Console.WriteLine("(MyAge <= 16):");
        if (MyAge <= 16) Console.WriteLine("You are not allowed to drive");

        Console.WriteLine("\n// Logical AND (&&)\n");

        MyAge = 17;
        Console.WriteLine($"MyAge: {MyAge}");
        HasDrivingLicense = false;
        Console.WriteLine($"HasDrivingLicense: {HasDrivingLicense}");
        Console.WriteLine("((MyAge >= 17) && (HasDrivingLicense == true)):");
        Console.WriteLine((((MyAge >= 17) && (HasDrivingLicense == true)) ? "You are allowed to drive" : "You are not allowed to drive"));

        MyAge = 17;
        Console.WriteLine($"MyAge: {MyAge}");
        HasDrivingLicense = true;
        Console.WriteLine($"HasDrivingLicense: {HasDrivingLicense}");
        Console.WriteLine("((MyAge >= 17) && (HasDrivingLicense == true)):");
        Console.WriteLine((((MyAge >= 17) && (HasDrivingLicense == true)) ? "You are allowed to drive" : "You are not allowed to drive"));

        Console.WriteLine("\n// Logical OR (||)\n");

        MyAge = 2;
        Console.WriteLine($"MyAge: {MyAge}");
        Console.WriteLine("((MyAge <= 3) || (MyAge >= 65)):");
        if ((MyAge <= 3) || (MyAge >= 65)) Console.WriteLine("You should stay home");

        MyAge = 89;
        Console.WriteLine($"MyAge: {MyAge}");
        Console.WriteLine("((MyAge <= 3) || (MyAge >= 65)):");
        if ((MyAge <= 3) || (MyAge >= 65)) Console.WriteLine("You should stay home");

        Console.WriteLine("\n// Logical NOT (!)\n");

        CanDrive = false;
        Console.WriteLine($"CanDrive: {CanDrive}");
        Console.WriteLine($"!CanDrive: {!CanDrive}");

        CanDrive = true;
        Console.WriteLine($"CanDrive: {CanDrive}");
        Console.WriteLine($"!CanDrive: {!CanDrive}");
    }
}
