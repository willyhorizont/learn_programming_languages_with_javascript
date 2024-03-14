Module Program
    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' Ternary Operator in Visual Basic (.NET)")

        Dim MyAnswer As String

        Dim CORRECT_ANSWER As String = "foo"
        Console.WriteLine($"correct answer: {CORRECT_ANSWER}")

        MyAnswer = "bar"
        Console.WriteLine($"my answer: {MyAnswer}")
        Console.WriteLine($"is my answer correct: {If((MyAnswer = CORRECT_ANSWER), "correct!", "wrong!")}")
        ' is my answer correct: wrong!
        MyAnswer = "foo"
        Console.WriteLine($"my answer: {MyAnswer}")
        Console.WriteLine($"is my answer correct: {If((MyAnswer = CORRECT_ANSWER), "correct!", "wrong!")}")
        ' is my answer correct: correct!
    End Sub
End Module
