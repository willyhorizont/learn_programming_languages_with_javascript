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

    Sub Main(Args As String())
        ' in Visual Basic (.NET), JavaScript-like Object is called Dictionary

        Dim MyFriend As Object = New Dictionary(Of String, Object) From {
            {"name", "Alisa"},
            {"country", "Finland"},
            {"age", 25}
        }
        Console.WriteLine("MyFriend: " & JsonStringify(MyFriend, Pretty:=True))

        Console.WriteLine("MyFriend, get total object keys: " & MyFriend.Count)
        ' MyFriend, get total object keys: 3

        Console.WriteLine("MyFriend, get country: " & MyFriend("country"))
        ' MyFriend, get country: Finland

        ' iterate over and get each key-value pair
        For Each ObjectEntry As KeyValuePair(Of String, Object) In MyFriend
            Dim ObjectKey = ObjectEntry.Key
            Dim ObjectValue = ObjectEntry.Value
            Console.WriteLine($"MyFriend, forEach loop, key: {ObjectKey}, value: {ObjectValue}")
        Next
        ' MyFriend, forEach loop, key: name, value: Alisa
        ' MyFriend, forEach loop, key: country, value: Finland
        ' MyFriend, forEach loop, key: age, value: 25

        ' iterate over and get each key-value pair and object iteration/entry index
        Dim ObjectIterationIndex As Integer = 0
        For Each ObjectEntry As KeyValuePair(Of String, Object) In MyFriend
            Dim ObjectKey = ObjectEntry.Key
            Dim ObjectValue = ObjectEntry.Value
            Console.WriteLine($"MyFriend, forEach loop, object iteration/entry index: {ObjectIterationIndex}, key: {ObjectKey}, value: {ObjectValue}")
            ObjectIterationIndex += 1
        Next
        ' MyFriend, forEach loop, object iteration/entry index: 0, key: name, value: Alisa
        ' MyFriend, forEach loop, object iteration/entry index: 1, key: country, value: Finland
        ' MyFriend, forEach loop, object iteration/entry index: 2, key: age, value: 25

        MyFriend("age") = 27
        Console.WriteLine("MyFriend: " & JsonStringify(MyFriend, Pretty:=True))

        MyFriend("gender") = "Female"
        Console.WriteLine("MyFriend: " & JsonStringify(MyFriend, Pretty:=True))

        MyFriend.Item("job") = "Streamer"
        Console.WriteLine("MyFriend: " & JsonStringify(MyFriend, Pretty:=True))

        MyFriend.Remove("country")
        Console.WriteLine("MyFriend: " & JsonStringify(MyFriend, Pretty:=True))

        ' Computed property names: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer#computed_property_names
        Dim DeliveryResponseKeyMessage As Object = "message"
        Dim DeliveryResponse As Object = New Dictionary(Of String, Object) From {
            {DeliveryResponseKeyMessage, "ok"}
        }
        Console.WriteLine("DeliveryResponse: " & JsonStringify(DeliveryResponse, Pretty:=True))
        Dim DeliveryResponseKeyStatus As Object = "status"
        DeliveryResponse(DeliveryResponseKeyStatus) = 200
        Console.WriteLine("DeliveryResponse: " & JsonStringify(DeliveryResponse, Pretty:=True))
    End Sub
End Module
