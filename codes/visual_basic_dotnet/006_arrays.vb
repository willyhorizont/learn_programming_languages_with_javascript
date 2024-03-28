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
    Function PrettyJsonStringify(ByVal Anything As Object, Optional ByVal Indent As String = "    ") As String
        Dim IndentLevel As Integer = 0
        Dim PrettyJsonStringifyInner As Func(Of Object, String, String) = Function(ByVal AnythingInner As Object, ByVal IndentInner As String)
            If (AnythingInner Is Nothing) Then Return "null"
            If (TypeOf AnythingInner Is String) Then Return """" & AnythingInner & """"
            If (IsNumeric(AnythingInner) = true) Then Return CStr(AnythingInner).Replace(",", ".")
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
        Dim ArrayItemIndex As Integer = 0

        ' in Visual Basic (.NET), JavaScript-like Array is called List

        Dim Fruits As List(Of Object) = New List(Of Object) From {"apple", "mango", "orange"}
        Console.WriteLine("Fruits: " & PrettyArrayOfPrimitives(Fruits))

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
            Console.WriteLine($"Fruits, foreach loop, index: {ArrayItemIndex}, value: {ArrayItem}")
            ArrayItemIndex += 1
        Next
        ' Fruits, foreach loop, index: 0, value: apple
        ' Fruits, foreach loop, index: 1, value: mango
        ' Fruits, foreach loop, index: 2, value: orange

        ' in Visual Basic (.NET), JavaScript-like Array of Objects is called List of Dictionaries

        Dim Products As List(Of Object) = New List(Of Object) From {
            New Dictionary(Of String, Object) From {
                {"id", "P1"},
                {"name", "bubble gum"}
            },
            New Dictionary(Of String, Object) From {
                {"id", "P2"},
                {"name", "potato chips"}
            }
        }
        Console.WriteLine("Products: " & PrettyJsonStringify(Products))

        ArrayItemIndex = 0
        For Each ArrayItem As Object In Products
            Dim IterationIndex As Integer = 0
            For Each ObjectEntry As KeyValuePair(Of String, Object) In ArrayItem
                Dim ObjectKey = ObjectEntry.Key
                Dim ObjectValue = ObjectEntry.Value
                Console.WriteLine($"Products, foreach loop, array item index: {ArrayItemIndex}, iteration/entry index: {IterationIndex}, key: {ObjectKey}, value: {ObjectValue}")
                IterationIndex += 1
            Next
            ArrayItemIndex += 1
        Next
        ' Products, foreach loop, array item index: 0, iteration/entry index: 0, key: id, value: P1
        ' Products, foreach loop, array item index: 0, iteration/entry index: 1, key: name, value: bubble gum
        ' Products, foreach loop, array item index: 1, iteration/entry index: 0, key: id, value: P2
        ' Products, foreach loop, array item index: 1, iteration/entry index: 1, key: name, value: potato chips
    End Sub
End Module
