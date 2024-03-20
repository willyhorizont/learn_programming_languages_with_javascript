Imports System.Collections.Generic ' Dictionary, KeyValuePair

Module Program
    Function PrettyJsonStringify(ByVal Anything As Object, Optional ByVal Indent As String = "    ") As String
        Dim IndentLevel As Integer = 0
        Dim PrettyJsonStringifyInner As Func(Of Object, String, String) = Function(ByVal AnythingInner As Object, ByVal IndentInner As String)
            If (AnythingInner Is Nothing) Then Return "null"
            If (TypeOf AnythingInner Is String) Then Return """" & AnythingInner & """"
            If IsNumeric(AnythingInner) Then Return CStr(AnythingInner).Replace(",", ".")
            If (TypeOf AnythingInner Is Boolean) Then Return CStr(AnythingInner)
            If (TypeOf AnythingInner Is List(Of Object)) Then
                If (AnythingInner.Count = 0) Then Return "[]"
                IndentLevel += 1
                Dim Result As String = "[" & Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel))
                Dim ArrayItemIndex As Integer = 0
                For Each ArrayItem As Object In AnythingInner
                    Result &= PrettyJsonStringifyInner(ArrayItem, IndentInner)
                    If ((ArrayItemIndex + 1) <> AnythingInner.Count) Then Result &= "," & Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel))
                    ArrayItemIndex += 1
                Next
                IndentLevel -= 1
                Result &= Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel)) & "]"
                Return Result
            End If
            If (TypeOf AnythingInner Is Dictionary(Of String, Object)) Then
                If (AnythingInner.Count = 0) Then Return "{}"
                IndentLevel += 1
                Dim Result As String = "{" & Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel))
                Dim IterationIndex As Integer = 0
                For Each ObjectEntry As KeyValuePair(Of String, Object) In AnythingInner
                    Dim ObjectKey = ObjectEntry.Key
                    Dim ObjectValue = ObjectEntry.Value
                    Result &= """" & ObjectKey & """: " & PrettyJsonStringifyInner(ObjectValue, IndentInner)
                    If ((IterationIndex + 1) <> AnythingInner.Count) Then Result &= "," & Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel))
                    IterationIndex += 1
                Next
                IndentLevel -= 1
                Result &= Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel)) & "}"
                Return Result
            End If
            Return "null"
        End Function
        Return PrettyJsonStringifyInner(Anything, Indent)
    End Function
    Sub Main(Args As String())
        ' in Visual Basic (.NET), JavaScript-like Object is called Dictionary

        Dim MyFriend As Object = New Dictionary(Of String, Object) From {
            {"name", "Alisa"},
            {"country", "Finland"},
            {"age", 25}
        }
        Console.WriteLine("MyFriend: " & PrettyJsonStringify(MyFriend))

        Console.WriteLine("MyFriend, get country: Finland: " & PrettyJsonStringify(MyFriend("country")))
        ' MyFriend, get country: Finland

        ' iterate over and get each key-value pair
        For Each ObjectEntry As KeyValuePair(Of String, Object) In MyFriend
            Dim ObjectKey = ObjectEntry.Key
            Dim ObjectValue = ObjectEntry.Value
            Console.WriteLine($"MyFriend, foreach loop, key: {ObjectKey}, value: {ObjectValue}")
        Next
        ' MyFriend, foreach loop, key: name, value: Alisa
        ' MyFriend, foreach loop, key: country, value: Finland
        ' MyFriend, foreach loop, key: age, value: 25

        ' iterate over and get each key-value pair and iteration/entry index
        Dim IterationIndex As Integer = 0
        For Each ObjectEntry As KeyValuePair(Of String, Object) In MyFriend
            Dim ObjectKey = ObjectEntry.Key
            Dim ObjectValue = ObjectEntry.Value
            Console.WriteLine($"MyFriend, foreach loop, iteration/entry index: {IterationIndex}, key: {ObjectKey}, value: {ObjectValue}")
            IterationIndex += 1
        Next
        ' MyFriend, foreach loop, iteration/entry index: 0, key: name, value: Alisa
        ' MyFriend, foreach loop, iteration/entry index: 1, key: country, value: Finland
        ' MyFriend, foreach loop, iteration/entry index: 2, key: age, value: 25
    End Sub
End Module
