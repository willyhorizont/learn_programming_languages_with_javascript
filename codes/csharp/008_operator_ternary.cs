using System; // Console, Func<>, Action<>, Action

class Program {
    static void Main(string[] Args) {
        Console.WriteLine("\n// Ternary Operator in C#");

        dynamic CORRECT_ANSWER = "foo";
        Console.WriteLine($"correct answer: \"{CORRECT_ANSWER}\"");

        dynamic MyAnswer;

        MyAnswer = "bar";
        Console.WriteLine($"my answer: \"{MyAnswer}\"");
        Console.WriteLine($"is my answer correct: {((MyAnswer == CORRECT_ANSWER) ? "correct!" : "wrong!")}");
        // is my answer correct: wrong!

        MyAnswer = "foo";
        Console.WriteLine($"my answer: \"{MyAnswer}\"");
        Console.WriteLine($"is my answer correct: {((MyAnswer == CORRECT_ANSWER) ? "correct!" : "wrong!")}");
        // is my answer correct: correct!
    }
}
