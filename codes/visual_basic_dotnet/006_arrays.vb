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
        Dim ArrayItemIndex As Integer = 0

        ' in Visual Basic (.NET), JavaScript-like Array is called List

        Dim Fruits As Object = New List(Of Object) From {"apple", "mango", "orange"}
        Console.WriteLine("Fruits: " & JsonStringify(Fruits))

        Console.WriteLine("Fruits, length: " & Fruits.Count)
        ' Fruits, length: 3

        Console.WriteLine("Fruits, first element: " & Fruits(0))
        ' Fruits, first element: apple

        Console.WriteLine("Fruits, get mango: " & Fruits(1))
        ' Fruits, get mango: mango

        Console.WriteLine("Fruits, last element: " & Fruits(Fruits.Count - 1))
        ' Fruits, last element: orange

        ArrayItemIndex = 0
        For Each ArrayItem As Object In Fruits
            Console.WriteLine($"Fruits, forEach loop, index: {ArrayItemIndex}, value: {ArrayItem}")
            ArrayItemIndex += 1
        Next
        ' Fruits, forEach loop, index: 0, value: apple
        ' Fruits, forEach loop, index: 1, value: mango
        ' Fruits, forEach loop, index: 2, value: orange

        ' in Visual Basic (.NET), JavaScript-like Array of Objects is called List of Dictionaries

        ' Dim Products As List(Of Object) = New List(Of Object) From {
        '     New Dictionary(Of String, Object) From {
        '         {"id", "P1"},
        '         {"name", "bubble gum"}
        '     },
        '     New Dictionary(Of String, Object) From {
        '         {"id", "P2"},
        '         {"name", "potato chips"}
        '     }
        ' }
        ' Console.WriteLine("Products: " & JsonStringify(Products, Pretty:=True))

        ' ArrayItemIndex = 0
        ' For Each ArrayItem As Object In Products
        '     Dim ObjectIterationIndex As Integer = 0
        '     For Each ObjectEntry As KeyValuePair(Of String, Object) In ArrayItem
        '         Dim ObjectKey = ObjectEntry.Key
        '         Dim ObjectValue = ObjectEntry.Value
        '         Console.WriteLine($"Products, forEach loop, array item index: {ArrayItemIndex}, object iteration/entry index: {ObjectIterationIndex}, key: {ObjectKey}, value: {ObjectValue}")
        '         ObjectIterationIndex += 1
        '     Next
        '     ArrayItemIndex += 1
        ' Next
        ' ' Products, forEach loop, array item index: 0, object iteration/entry index: 0, key: id, value: P1
        ' ' Products, forEach loop, array item index: 0, object iteration/entry index: 1, key: name, value: bubble gum
        ' ' Products, forEach loop, array item index: 1, object iteration/entry index: 0, key: id, value: P2
        ' ' Products, forEach loop, array item index: 1, object iteration/entry index: 1, key: name, value: potato chips
    End Sub
End Module
