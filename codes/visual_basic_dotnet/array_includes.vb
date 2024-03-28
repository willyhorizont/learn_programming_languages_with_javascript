Imports System.Collections.Generic ' Dictionary, KeyValuePair

Module Program
    Function PrettyArrayOfPrimitives(ByVal AnArrayOfPrimitives As List(Of Object)) As String
        Dim Result As String = "["
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArrayOfPrimitives
            If (((TypeOf ArrayItem Is String) = false) AndAlso (IsNumeric(ArrayItem) = false) AndAlso ((TypeOf ArrayItem Is Boolean) = false) AndAlso ((ArrayItem Is Nothing) = false)) Then Continue For
            If (TypeOf ArrayItem Is String) Then Result += """" & ArrayItem & """"
            If (IsNumeric(ArrayItem) = true) Then Result += CStr(ArrayItem).Replace(",", ".")
            If (TypeOf ArrayItem Is Boolean) Then Result += CStr(ArrayItem)
            If (ArrayItem Is Nothing) Then Result += "null"
            If ((ArrayItemIndex + 1) <> AnArrayOfPrimitives.Count) Then Result += ", "
            ArrayItemIndex += 1
        Next
        Result += "]"
        Return Result
    End Function

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.includes() in Visual Basic (.NET)")

        Dim MyFriends As List(Of Object) = New List(Of Object) From {"Alisa", "Trivia"}
        Console.WriteLine($"MyFriends: {PrettyArrayOfPrimitives(MyFriends)}")

        Dim AName As String
        Dim IsMyFriend As Boolean

        Console.WriteLine("' using Visual Basic (.NET) Array.includes() built-in method ""Array.Contains()""")

        AName = "Alisa"
        IsMyFriend = MyFriends.Contains(AName)
        Console.WriteLine($"is my friends includes ""{AName}"": {IsMyFriend}")
        ' is my friends includes "Alisa": True

        AName = "Trivia"
        IsMyFriend = MyFriends.Contains(AName)
        Console.WriteLine($"is my friends includes ""{AName}"": {IsMyFriend}")
        ' is my friends includes "Trivia": True

        AName = "Tony"
        IsMyFriend = MyFriends.Contains(AName)
        Console.WriteLine($"is my friends includes ""{AName}"": {IsMyFriend}")
        ' is my friends includes "Tony": False

        AName = "Ezekiel"
        IsMyFriend = MyFriends.Contains(AName)
        Console.WriteLine($"is my friends includes ""{AName}"": {IsMyFriend}")
        ' is my friends includes "Ezekiel": False
    End Sub
End Module
