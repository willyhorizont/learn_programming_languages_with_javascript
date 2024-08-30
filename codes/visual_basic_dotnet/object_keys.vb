Imports System.Collections.Generic ' Dictionary, KeyValuePair

Module Program
    Function JsonStringify(ByVal Anything As Object, Optional ByVal Pretty As Boolean = False, Optional ByVal Indent As String = "    ") As String
        Dim IndentLevel As Integer = 0
        Dim JsonStringifyInner As Func(Of Object, String, String) = Function(ByVal AnythingInner As Object, ByVal IndentInner As String)
            If (AnythingInner Is Nothing) Then Return "null"
            If (TypeOf AnythingInner Is String) Then Return """" & AnythingInner & """"
            If (IsNumeric(AnythingInner) = True) Then Return CStr(AnythingInner).Replace(",", ".")
            If (TypeOf AnythingInner Is Boolean) Then Return CStr(AnythingInner)
            If (TypeOf AnythingInner Is List(Of Object)) Then
                If (AnythingInner.Count = 0) Then Return "[]"
                IndentLevel += 1
                Dim Result As String = If((Pretty = True), "[" & Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel)), "[")
                Dim ArrayItemIndex As Integer = 0
                For Each ArrayItem As Object In AnythingInner
                    Result &= JsonStringifyInner(ArrayItem, IndentInner)
                    If ((ArrayItemIndex + 1) <> AnythingInner.Count) Then Result &= If((Pretty = True), "," & Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel)), ", ")
                    ArrayItemIndex += 1
                Next
                IndentLevel -= 1
                Result &= If((Pretty = True), Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel)) & "]", "]")
                Return Result
            End If
            If (TypeOf AnythingInner Is Dictionary(Of String, Object)) Then
                If (AnythingInner.Count = 0) Then Return "{}"
                IndentLevel += 1
                Dim Result As String = If((Pretty = True), "{" & Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel)), "{")
                Dim ObjectIterationIndex As Integer = 0
                For Each ObjectEntry As KeyValuePair(Of String, Object) In AnythingInner
                    Dim ObjectKey = ObjectEntry.Key
                    Dim ObjectValue = ObjectEntry.Value
                    Result &= """" & ObjectKey & """: " & JsonStringifyInner(ObjectValue, IndentInner)
                    If ((ObjectIterationIndex + 1) <> AnythingInner.Count) Then Result &= If((Pretty = True), "," & Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel)), ", ")
                    ObjectIterationIndex += 1
                Next
                IndentLevel -= 1
                Result &= If((Pretty = True), Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel)) & "}", "}")
                Return Result
            End If
            Return "null"
        End Function
        Return JsonStringifyInner(Anything, Indent)
    End Function

    Function ObjectKeysV1(ByVal AnObject As Object) As List(Of Object)
        ' JavaScript-like Object.keys() function
        Dim ObjectKeysResult As New List(Of Object)()
        For Each ObjectEntry As KeyValuePair(Of String, Object) In AnObject
            Dim ObjectKey = ObjectEntry.Key
            Dim ObjectValue = ObjectEntry.Value
            ObjectKeysResult.Add(ObjectKey)
        Next
        Return ObjectKeysResult
    End Function

    Function ObjectKeysV2(ByVal AnObject As Object) As List(Of Object)
        ' JavaScript-like Object.keys() function
        Dim ObjectKeysResult As New List(Of Object)()
        For Each ObjectKey As String In AnObject.Keys
            ObjectKeysResult.Add(ObjectKey)
        Next
        Return ObjectKeysResult
    End Function

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Object.keys() in Visual Basic (.NET) Dictionary")

        Dim MyFriend As Object = New Dictionary(Of String, Object) From {
            {"name", "Alisa"},
            {"country", "Finland"},
            {"age", 25}
        }
        Console.WriteLine("MyFriend: " & JsonStringify(MyFriend, Pretty:=True))

        Console.WriteLine($"friend keys: {JsonStringify(ObjectKeysV1(MyFriend))}")
        ' friend keys: ["name", "country", "age"]

        Console.WriteLine($"friend keys: {JsonStringify(ObjectKeysV2(MyFriend))}")
        ' friend keys: ["name", "country", "age"]
    End Sub
End Module
