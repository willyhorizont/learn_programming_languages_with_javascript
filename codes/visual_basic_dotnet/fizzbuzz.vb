Imports System.Collections.Generic ' Dictionary, KeyValuePair

Module Program
    Function FizzbuzzV1(ByVal StopNumber As Integer) As String
        If (StopNumber < 1) Then Throw New Exception("Argument should be > 0")
        Dim Result As String = ""
        Dim Number As Integer = 1
        While (true)
            If (Result = "") Then
                Result = $"{Number}"
                If (Number >= StopNumber) Then Exit While
                Number += 1
                Continue While
            End If
            If (((Number Mod 3) = 0) AndAlso ((Number Mod 5) = 0)) Then
                Result = $"{Result}, FizzBuzz"
                If (Number >= StopNumber) Then Exit While
                Number += 1
                Continue While
            End If
            If ((Number Mod 3) = 0) Then
                Result = $"{Result}, Fizz"
                If (Number >= StopNumber) Then Exit While
                Number += 1
                Continue While
            End If
            If ((Number Mod 5) = 0) Then
                Result = $"{Result}, Buzz"
                If (Number >= StopNumber) Then Exit While
                Number += 1
                Continue While
            End If
            Result = $"{Result}, {Number}"
            If (Number >= StopNumber) Then Exit While
            Number += 1
        End While
        Return Result
    End Function

    Function FizzbuzzV2(ByVal StopNumber As Integer) As String
        If (StopNumber < 1) Then Throw New Exception("Argument should be > 0")
        Dim Result As String = ""
        Dim Number As Integer = 1
        While (Number <= StopNumber)
            If (Result = "") Then
                Result = $"{Number}"
                Number += 1
                Continue While
            End If
            If (((Number Mod 3) = 0) AndAlso ((Number Mod 5) = 0)) Then
                Result = $"{Result}, FizzBuzz"
                Number += 1
                Continue While
            End If
            If ((Number Mod 3) = 0) Then
                Result = $"{Result}, Fizz"
                Number += 1
                Continue While
            End If
            If ((Number Mod 5) = 0) Then
                Result = $"{Result}, Buzz"
                Number += 1
                Continue While
            End If
            Result = $"{Result}, {Number}"
            Number += 1
        End While
        Return Result
    End Function

    Function FizzbuzzV3(ByVal StopNumber As Integer) As String
        If (StopNumber < 1) Then Throw New Exception("Argument should be > 0")
        Dim Result As String = ""
        Dim Number As Integer = 1
        While (true)
            If (Result = "") Then
                Result = $"{Number}"
            Else If (((Number Mod 3) = 0) AndAlso ((Number Mod 5) = 0)) Then
                Result = $"{Result}, FizzBuzz"
            Else If ((Number Mod 3) = 0) Then
                Result = $"{Result}, Fizz"
            Else If ((Number Mod 5) = 0) Then
                Result = $"{Result}, Buzz"
            Else
                Result = $"{Result}, {Number}"
            End If
            If (Number >= StopNumber) Then Exit While
            Number += 1
        End While
        Return Result
    End Function

    Function FizzbuzzV4(ByVal StopNumber As Integer) As String
        If (StopNumber < 1) Then Throw New Exception("Argument should be > 0")
        Dim Result As String = ""
        Dim Number As Integer = 1
        While (Number <= StopNumber)
            If (Result = "") Then
                Result = $"{Number}"
            Else If (((Number Mod 3) = 0) AndAlso ((Number Mod 5) = 0)) Then
                Result = $"{Result}, FizzBuzz"
            Else If ((Number Mod 3) = 0) Then
                Result = $"{Result}, Fizz"
            Else If ((Number Mod 5) = 0) Then
                Result = $"{Result}, Buzz"
            Else
                Result = $"{Result}, {Number}"
            End If
            Number += 1
        End While
        Return Result
    End Function

    Function FizzbuzzV5(ByVal StopNumber As Integer) As String
        If (StopNumber < 1) Then Throw New Exception("Argument should be > 0")
        Dim Result As String = ""
        Dim Number As Integer = 1
        While (true)
            Result = If((Result = ""), $"{Number}", If((((Number Mod 3) = 0) AndAlso ((Number Mod 5) = 0)), $"{Result}, FizzBuzz", If(((Number Mod 3) = 0), $"{Result}, Fizz", If(((Number Mod 5) = 0), $"{Result}, Buzz", $"{Result}, {Number}"))))
            If (Number >= StopNumber) Then Exit While
            Number += 1
        End While
        Return Result
    End Function

    Function FizzbuzzV6(ByVal StopNumber As Integer) As String
        If (StopNumber < 1) Then Throw New Exception("Argument should be > 0")
        Dim Result As String = ""
        Dim Number As Integer = 1
        While (Number <= StopNumber)
            Result = If((Result = ""), $"{Number}", If((((Number Mod 3) = 0) AndAlso ((Number Mod 5) = 0)), $"{Result}, FizzBuzz", If(((Number Mod 3) = 0), $"{Result}, Fizz", If(((Number Mod 5) = 0), $"{Result}, Buzz", $"{Result}, {Number}"))))
            Number += 1
        End While
        Return Result
    End Function

    Function FizzbuzzV7(ByVal StopNumber As Integer) As String
        If (StopNumber < 1) Then Throw New Exception("Argument should be > 0")
        Dim Result As String = ""
        For Number As Integer = 1 To StopNumber Step 1
            If (Result = "") Then
                Result = $"{Number}"
                Continue For
            End If
            If (((Number Mod 3) = 0) AndAlso ((Number Mod 5) = 0)) Then
                Result = $"{Result}, FizzBuzz"
                Continue For
            End If
            If ((Number Mod 3) = 0) Then
                Result = $"{Result}, Fizz"
                Continue For
            End If
            If ((Number Mod 5) = 0) Then
                Result = $"{Result}, Buzz"
                Continue For
            End If
            Result = $"{Result}, {Number}"
        Next
        Return Result
    End Function

    Function FizzbuzzV8(ByVal StopNumber As Integer) As String
        If (StopNumber < 1) Then Throw New Exception("Argument should be > 0")
        Dim Result As String = ""
        For Number As Integer = 1 To StopNumber Step 1
            If (Result = "") Then
                Result = $"{Number}"
            Else If (((Number Mod 3) = 0) AndAlso ((Number Mod 5) = 0)) Then
                Result = $"{Result}, FizzBuzz"
            Else If ((Number Mod 3) = 0) Then
                Result = $"{Result}, Fizz"
            Else If ((Number Mod 5) = 0) Then
                Result = $"{Result}, Buzz"
            Else
                Result = $"{Result}, {Number}"
            End If
        Next
        Return Result
    End Function

    Function FizzbuzzV9(ByVal StopNumber As Integer) As String
        If (StopNumber < 1) Then Throw New Exception("Argument should be > 0")
        Dim Result As String = ""
        For Number As Integer = 1 To StopNumber Step 1
            Result = If((Result = ""), $"{Number}", If((((Number Mod 3) = 0) AndAlso ((Number Mod 5) = 0)), $"{Result}, FizzBuzz", If(((Number Mod 3) = 0), $"{Result}, Fizz", If(((Number Mod 5) = 0), $"{Result}, Buzz", $"{Result}, {Number}"))))
        Next
        Return Result
    End Function

    Function FizzbuzzV10(ByVal StopNumber As Integer) As String
        If (StopNumber < 1) Then Throw New Exception("Argument should be > 0")
        Return Enumerable.Range(1, StopNumber).Aggregate("", Function(ByVal CurrentResult As Object, ByVal CurrentNumber As Double) If((CurrentResult = ""), $"{CurrentNumber}", If((((CurrentNumber Mod 3) = 0) AndAlso ((CurrentNumber Mod 5) = 0)), $"{CurrentResult}, FizzBuzz", If(((CurrentNumber Mod 3) = 0), $"{CurrentResult}, Fizz", If(((CurrentNumber Mod 5) = 0), $"{CurrentResult}, Buzz", $"{CurrentResult}, {CurrentNumber}")))))
    End Function

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' FizzBuzz(n) in Visual Basic (.NET)")

        Console.WriteLine("' using fizzbuzz function ""FizzbuzzV1""")
        Console.WriteLine($"Fizzbuzz(36): {FizzbuzzV1(36)}")
        ' FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("' using fizzbuzz function ""FizzbuzzV2""")
        Console.WriteLine($"Fizzbuzz(36): {FizzbuzzV2(36)}")
        ' FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("' using fizzbuzz function ""FizzbuzzV3""")
        Console.WriteLine($"Fizzbuzz(36): {FizzbuzzV3(36)}")
        ' FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("' using fizzbuzz function ""FizzbuzzV4""")
        Console.WriteLine($"Fizzbuzz(36): {FizzbuzzV4(36)}")
        ' FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("' using fizzbuzz function ""FizzbuzzV5""")
        Console.WriteLine($"Fizzbuzz(36): {FizzbuzzV5(36)}")
        ' FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("' using fizzbuzz function ""FizzbuzzV6""")
        Console.WriteLine($"Fizzbuzz(36): {FizzbuzzV6(36)}")
        ' FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("' using fizzbuzz function ""FizzbuzzV7""")
        Console.WriteLine($"Fizzbuzz(36): {FizzbuzzV7(36)}")
        ' FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("' using fizzbuzz function ""FizzbuzzV8""")
        Console.WriteLine($"Fizzbuzz(36): {FizzbuzzV8(36)}")
        ' FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("' using fizzbuzz function ""FizzbuzzV9""")
        Console.WriteLine($"Fizzbuzz(36): {FizzbuzzV9(36)}")
        ' FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

        Console.WriteLine("' using fizzbuzz function ""FizzbuzzV10""")
        Console.WriteLine($"Fizzbuzz(36): {FizzbuzzV10(36)}")
        ' FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
    End Sub
End Module
