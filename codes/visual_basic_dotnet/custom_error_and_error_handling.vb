Imports System.Collections.Generic ' Dictionary, KeyValuePair

Module Program
    Function GiveMeRespect(ByVal Argument As String) As String
        ' Custom Error
        If (Argument <> "respect") Then Throw New Exception("Exception: You should give me ""respect""!")
        Return "Thank you for giving me ""respect""!"
    End Function

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' Custom Error and Error Handling in Visual Basic (.NET)")

        Dim Response As String

        ' Error Handling
        Try
            Response = GiveMeRespect("boo!")
            Console.WriteLine(Response)
        Catch AnException As Exception
            Console.WriteLine(AnException.Message)
        End Try
        Console.WriteLine("I'm sorry!")

        ' Without Error Handling
        Response = GiveMeRespect("boo!")
        ' this will never executed
        Console.WriteLine(Response)
        Console.WriteLine("I'm sorry!")
    End Sub
End Module
