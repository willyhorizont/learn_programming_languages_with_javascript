Imports System.Collections.Generic ' Dictionary, KeyValuePair

Module Program
    Function FactorialV1(ByVal Number As Integer) As Integer
        If (Number < 0) Then Throw New Exception("Argument should be >= 0")
        If (Number = 0) Then Return 1
        Dim Result As Integer = 1
        Dim I = Number
        While (true)
            Result *= I
            I -= 1
            If (I <= 0) Then Exit While
        End While
        Return Result
    End Function

    Function FactorialV2(ByVal Number As Integer) As Integer
        If (Number < 0) Then Throw New Exception("Argument should be >= 0")
        If (Number = 0) Then Return 1
        Dim Result As Integer = 1
        Dim I = Number
        While (I >= 1)
            Result *= I
            I -= 1
        End While
        Return Result
    End Function

    Function FactorialV3(ByVal Number As Integer) As Integer
        If (Number < 0) Then Throw New Exception("Argument should be >= 0")
        If (Number = 0) Then Return 1
        Dim Result As Integer = 1
        For I As Integer = 5 To 1 Step -1
            Result *= I
        Next
        Return Result
    End Function

    Function FactorialV4(ByVal Number As Integer) As Integer
        If (Number < 0) Then Throw New Exception("Argument should be >= 0")
        If (Number = 0) Then Return 1
        Return (Number * FactorialV4(Number - 1))
    End Function

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' Factorial(n) in Visual Basic (.NET)")

        Console.WriteLine("' using factorial function ""FactorialV1""")
        Console.WriteLine($"Factorial(5): {FactorialV1(5)}")
        ' Factorial(5): 120

        Console.WriteLine("' using factorial function ""FactorialV2""")
        Console.WriteLine($"Factorial(5): {FactorialV2(5)}")
        ' Factorial(5): 120

        Console.WriteLine("' using factorial function ""FactorialV3""")
        Console.WriteLine($"Factorial(5): {FactorialV3(5)}")
        ' Factorial(5): 120

        Console.WriteLine("' using factorial function ""FactorialV4""")
        Console.WriteLine($"Factorial(5): {FactorialV4(5)}")
        ' Factorial(5): 120
    End Sub
End Module
