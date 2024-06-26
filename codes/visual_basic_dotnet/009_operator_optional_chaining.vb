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

    Function OptionalChaining(ByVal Anything As Object, ByVal ParamArray ObjectPropertiesArray() As Object) As Object
        ' JavaScript-like Optional Chaining Operator (?.) function
        If ((((TypeOf Anything Is Dictionary(Of String, Object)) = false) AndAlso ((TypeOf Anything Is List(Of Object)) = false)) OrElse (ObjectPropertiesArray.Length = 0)) Then Return Anything
        Dim ArrayReduceCallback As Func(Of Object, Object, Object) = Function(ByVal CurrentResult As Object, ByVal CurrentItem As Object) As Object
            If ((CurrentResult Is Nothing) AndAlso (TypeOf Anything Is Dictionary(Of String, Object)) AndAlso (TypeOf CurrentItem Is String) AndAlso DirectCast(Anything, Dictionary(Of String, Object)).ContainsKey(CStr(CurrentItem))) Then
                Try
                    Return DirectCast(Anything, Dictionary(Of String, Object))(CStr(CurrentItem))
                Catch Ex As Exception
                    Return Nothing
                End Try
            End If
            If ((CurrentResult Is Nothing) AndAlso (TypeOf Anything Is List(Of Object)) AndAlso (IsNumeric(CurrentItem) = true) AndAlso (CInt(CurrentItem) >= 0) AndAlso (DirectCast(Anything, List(Of Object)).Count > CInt(CurrentItem))) Then
                Try
                    Return DirectCast(Anything, List(Of Object))(CInt(CurrentItem))
                Catch Ex As Exception
                    Return Nothing
                End Try
            End If
            If ((TypeOf CurrentResult Is Dictionary(Of String, Object)) AndAlso (TypeOf CurrentItem Is String) AndAlso DirectCast(CurrentResult, Dictionary(Of String, Object)).ContainsKey(CStr(CurrentItem))) Then
                Try
                    Return DirectCast(CurrentResult, Dictionary(Of String, Object))(CStr(CurrentItem))
                Catch Ex As Exception
                    Return Nothing
                End Try
            End If
            If ((TypeOf CurrentResult Is List(Of Object)) AndAlso (IsNumeric(CurrentItem) = true) AndAlso (CInt(CurrentItem) >= 0) AndAlso (DirectCast(CurrentResult, List(Of Object)).Count > CInt(CurrentItem))) Then
                Try
                    Return DirectCast(CurrentResult, List(Of Object))(CInt(CurrentItem))
                Catch Ex As Exception
                    Return Nothing
                End Try
            End If
            Return Nothing
        End Function
        Return ObjectPropertiesArray.Aggregate(Nothing, ArrayReduceCallback)
    End Function

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Optional Chaining Operator (?.) in Visual Basic (.NET)")

        ' There's no JavaScript-like Optional Chaining Operator (?.) in Visual Basic (.NET).
        ' But, we can create our own function to mimic it in Visual Basic (.NET).

        Dim JSON_OBJECT As Object = New Dictionary(Of String, Object) From {
            {"foo", New Dictionary(Of String, Object) From {
                {"bar", "baz"}
            }},
            {"fruits", New List(Of Object) From {"apple", "mango", "banana"}}
        }
        Console.WriteLine("JSON_OBJECT: " & JsonStringify(JSON_OBJECT, Pretty:=True))

        Console.WriteLine("' using JavaScript-like Optional Chaining Operator (?.) function ""OptionalChaining""")

        Console.WriteLine($"JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: {JsonStringify(OptionalChaining(JSON_OBJECT, "foo", "bar"))}")
        ' JSON_OBJECT?.foo?.bar or JSON_OBJECT?.['foo']?.['bar']: baz

        Console.WriteLine($"JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: {JsonStringify(OptionalChaining(JSON_OBJECT, "foo", "baz"))}")
        ' JSON_OBJECT?.foo?.baz or JSON_OBJECT?.['foo']?.['baz']: null

        Console.WriteLine($"JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: {JsonStringify(OptionalChaining(JSON_OBJECT, "fruits", 2))}")
        ' JSON_OBJECT?.fruits?.[2] or JSON_OBJECT?.['fruits']?.[2]: "banana"

        Console.WriteLine($"JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: {JsonStringify(OptionalChaining(JSON_OBJECT, "fruits", 5))}")
        ' JSON_OBJECT?.fruits?.[5] or JSON_OBJECT?.['fruits']?.[5]: null
    End Sub
End Module
