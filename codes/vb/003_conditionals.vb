Module Program
    Sub Main(Args As String())
        ' Relational Operators / Comparison Operators:
        ' equal to (=) *checks for equality after performing type coercion. It converts operands to the same type before making the comparison.
        ' not equal to (<>) *checks for inequality after performing type coercion. It converts operands to the same type before making the comparison.
        ' greater than (>)
        ' less than (<)
        ' greater than or equal to (>=)
        ' less than or equal to (<=)

        ' Logical Operators:
        ' Logical AND (And, AndAlso)
        ' Logical OR (Or, OrElse)
        ' Logical NOT (Not)

        Dim CORRECT_ANSWER = 100

        Dim MyAge
        Dim MyAnswer
        Dim HasDrivingLicense
        Dim CanDrive

        Console.WriteLine($"{Environment.NewLine}' basic conditional control flow{Environment.NewLine}")

        MyAge = 10
        Console.WriteLine($"MyAge: {MyAge}")
        If (MyAge > 24) Then
            Console.WriteLine("you are old")
        Else If (MyAge > 17) Then
            Console.WriteLine("you are young")
        Else
            Console.WriteLine("you are under age")
        End If

        Console.WriteLine($"{Environment.NewLine}' equal to (=){Environment.NewLine}")

        MyAnswer = 100
        Console.WriteLine($"MyAnswer: {MyAnswer}")
        Console.WriteLine($"CORRECT_ANSWER: {CORRECT_ANSWER}")
        Console.WriteLine("(MyAnswer = CORRECT_ANSWER):")
        If (MyAnswer = CORRECT_ANSWER) Then
            Console.WriteLine("Your answer is correct")
        Else
            Console.WriteLine("Your answer is wrong")
        End If

        Console.WriteLine($"{Environment.NewLine}' not equal to (<>){Environment.NewLine}")

        MyAnswer = 25
        Console.WriteLine($"MyAnswer: {MyAnswer}")
        Console.WriteLine($"CORRECT_ANSWER: {CORRECT_ANSWER}")
        Console.WriteLine("(MyAnswer <> CORRECT_ANSWER):")
        If (MyAnswer <> CORRECT_ANSWER) Then
            Console.WriteLine("Your answer is correct")
        Else
            Console.WriteLine("Your answer is wrong")
        End If

        Console.WriteLine($"{Environment.NewLine}' greater than (>){Environment.NewLine}")

        MyAge = 70
        Console.WriteLine($"MyAge: {MyAge}")
        Console.WriteLine("(MyAge > 50):")
        If (MyAge > 50) Then Console.WriteLine("You are old")

        Console.WriteLine($"{Environment.NewLine}' less than (<){Environment.NewLine}")

        MyAge = 16
        Console.WriteLine($"MyAge: {MyAge}")
        Console.WriteLine("(MyAge < 20):")
        If (MyAge < 20) Then Console.WriteLine("You are young")

        Console.WriteLine($"{Environment.NewLine}' greater than or equal to (>=){Environment.NewLine}")

        MyAge = 73
        Console.WriteLine($"MyAge: {MyAge}")
        Console.WriteLine("(MyAge >= 65):")
        If (MyAge >= 65) Then Console.WriteLine("You are old")

        Console.WriteLine($"{Environment.NewLine}' less than or equal to (<=){Environment.NewLine}")

        MyAge = 14
        Console.WriteLine($"MyAge: {MyAge}")
        Console.WriteLine("(MyAge <= 16):")
        If (MyAge <= 16) Then Console.WriteLine("You are young")

        Console.WriteLine($"{Environment.NewLine}' Logical AND (And, AndAlso){Environment.NewLine}")

        MyAge = 17
        Console.WriteLine($"MyAge: {MyAge}")
        HasDrivingLicense = false
        Console.WriteLine($"HasDrivingLicense: {HasDrivingLicense}")
        Console.WriteLine("((MyAge >= 17) And (HasDrivingLicense = true)):")
        Console.WriteLine(If(((MyAge >= 17) And (HasDrivingLicense = true)), "You are allowed to drive", "You are not allowed to drive"))

        MyAge = 17
        Console.WriteLine($"MyAge: {MyAge}")
        HasDrivingLicense = true
        Console.WriteLine($"HasDrivingLicense: {HasDrivingLicense}")
        Console.WriteLine("((MyAge >= 17) And (HasDrivingLicense = true)):")
        Console.WriteLine(If(((MyAge >= 17) And (HasDrivingLicense = true)), "You are allowed to drive", "You are not allowed to drive"))

        MyAge = 17
        Console.WriteLine($"MyAge: {MyAge}")
        HasDrivingLicense = false
        Console.WriteLine($"HasDrivingLicense: {HasDrivingLicense}")
        Console.WriteLine("((MyAge >= 17) AndAlso (HasDrivingLicense = true)):")
        Console.WriteLine(If(((MyAge >= 17) AndAlso (HasDrivingLicense = true)), "You are allowed to drive", "You are not allowed to drive"))

        MyAge = 17
        Console.WriteLine($"MyAge: {MyAge}")
        HasDrivingLicense = true
        Console.WriteLine($"HasDrivingLicense: {HasDrivingLicense}")
        Console.WriteLine("((MyAge >= 17) AndAlso (HasDrivingLicense = true)):")
        Console.WriteLine(If(((MyAge >= 17) AndAlso (HasDrivingLicense = true)), "You are allowed to drive", "You are not allowed to drive"))

        Console.WriteLine($"{Environment.NewLine}' Logical OR (Or, OrElse){Environment.NewLine}")

        MyAge = 2
        Console.WriteLine($"MyAge: {MyAge}")
        Console.WriteLine("((MyAge <= 3) Or (MyAge >= 65)):")
        if ((MyAge <= 3) Or (MyAge >= 65)) Then Console.WriteLine("You should stay home")

        MyAge = 89
        Console.WriteLine($"MyAge: {MyAge}")
        Console.WriteLine("((MyAge <= 3) Or (MyAge >= 65)):")
        if ((MyAge <= 3) Or (MyAge >= 65)) Then Console.WriteLine("You should stay home")

        MyAge = 2
        Console.WriteLine($"MyAge: {MyAge}")
        Console.WriteLine("((MyAge <= 3) OrElse (MyAge >= 65)):")
        if ((MyAge <= 3) OrElse (MyAge >= 65)) Then Console.WriteLine("You should stay home")

        MyAge = 89
        Console.WriteLine($"MyAge: {MyAge}")
        Console.WriteLine("((MyAge <= 3) OrElse (MyAge >= 65)):")
        if ((MyAge <= 3) OrElse (MyAge >= 65)) Then Console.WriteLine("You should stay home")

        Console.WriteLine($"{Environment.NewLine}' Logical NOT (Not){Environment.NewLine}")

        CanDrive = false
        Console.WriteLine($"CanDrive: {CanDrive}")
        Console.WriteLine($"Not CanDrive: {Not CanDrive}")

        CanDrive = true
        Console.WriteLine($"CanDrive: {CanDrive}")
        Console.WriteLine($"Not CanDrive: {Not CanDrive}")
    End Sub
End Module
