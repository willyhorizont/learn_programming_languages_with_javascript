Imports System.Collections.Generic

Module Program
    Sub Main(args As String())
        Dim PrettyJsonStringifyV1 As Func(Of Object, String, String) = Function(ByVal Anything, ByVal Indent)
            Dim IndentLevel As Integer = 0
            Dim PrettyJsonStringifyInner As Func(Of Object, String, String) = Function(ByVal AnythingInner, ByVal IndentInner)
                If (IsNothing(AnythingInner) == true) Then
                    Return "null"
                End If
                If (TypeOf AnythingInner Is String) Then
                    Return """" & AnythingInner & """"
                End If
                If (IsNumeric(AnythingInner) OrElse (TypeOf AnythingInner Is Boolean)) Then
                    Return CStr(AnythingInner)
                End If
                If (TypeOf AnythingInner Is Object()) Then
                    IndentLevel += 1
                    Dim Result As String = "[" & vbCrLf & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel))
                    Dim ArrayItemIndex As Integer = 0
                    For Each ArrayItem As Object In AnythingInner
                        Result &= PrettyJsonStringifyInner(ArrayItem, IndentInner)
                        If ((ArrayItemIndex + 1) <> AnythingInner.Length) Then
                            Result &= "," & vbCrLf & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel))
                        End If
                        ArrayItemIndex += 1
                    Next
                    IndentLevel -= 1
                    Result &= vbCrLf & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel)) & "]"
                    Return Result
                End If
                If (TypeOf AnythingInner Is Dictionary(Of String, Object)) Then
                    IndentLevel += 1
                    Dim Result As String = "{" & vbCrLf & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel))
                    Dim IterationIndex As Integer = 0
                    For Each objectEntry As KeyValuePair(Of String, Object) In AnythingInner
                        Dim ObjectKey = objectEntry.Key
                        Dim ObjectValue = objectEntry.Value
                        Result &= """" & ObjectKey & """: " & PrettyJsonStringifyInner(ObjectValue, IndentInner)
                        If ((IterationIndex + 1) <> AnythingInner.Length) Then
                            Result &= "," & vbCrLf & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel))
                        End If
                        IterationIndex += 1
                    Next
                    IndentLevel -= 1
                    Result &= vbCrLf & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel)) & "}"
                    Return Result
                End If
                Return "null"
            End Function
            Return PrettyJsonStringifyInner(Anything, Indent)
        End Function
        Dim PrettyJsonStringifyV2 As Func(Of Object, String) = Function(ByVal Anything)
            Dim Indent As String = "    "
            Dim IndentLevel As Integer = 0
            Dim PrettyJsonStringifyInner As Func(Of Object, String) = Function(ByVal AnythingInner)
                If (IsNothing(AnythingInner) == true) Then
                    Return "null"
                End If
                If (TypeOf AnythingInner Is String) Then
                    Return """" & AnythingInner & """"
                End If
                If (IsNumeric(AnythingInner) OrElse (TypeOf AnythingInner Is Boolean)) Then
                    Return CStr(AnythingInner)
                End If
                If (TypeOf AnythingInner Is Object()) Then
                    IndentLevel += 1
                    Dim Result As String = "[" & vbCrLf & String.Concat(Enumerable.Repeat(Indent, IndentLevel))
                    Dim ArrayItemIndex As Integer = 0
                    For Each ArrayItem As Object In AnythingInner
                        Result &= PrettyJsonStringifyInner(ArrayItem)
                        If ((ArrayItemIndex + 1) <> AnythingInner.Length) Then
                            Result &= "," & vbCrLf & String.Concat(Enumerable.Repeat(Indent, IndentLevel))
                        End If
                        ArrayItemIndex += 1
                    Next
                    IndentLevel -= 1
                    Result &= vbCrLf & String.Concat(Enumerable.Repeat(Indent, IndentLevel)) & "]"
                    Return Result
                End If
                If (TypeOf AnythingInner Is Dictionary(Of String, Object)) Then
                    IndentLevel += 1
                    Dim Result As String = "{" & vbCrLf & String.Concat(Enumerable.Repeat(Indent, IndentLevel))
                    Dim IterationIndex As Integer = 0
                    For Each objectEntry As KeyValuePair(Of String, Object) In AnythingInner
                        Dim ObjectKey = objectEntry.Key
                        Dim ObjectValue = objectEntry.Value
                        Result &= """" & ObjectKey & """: " & PrettyJsonStringifyInner(ObjectValue)
                        If ((IterationIndex + 1) <> AnythingInner.Length) Then
                            Result &= "," & vbCrLf & String.Concat(Enumerable.Repeat(Indent, IndentLevel))
                        End If
                        IterationIndex += 1
                    Next
                    IndentLevel -= 1
                    Result &= vbCrLf & String.Concat(Enumerable.Repeat(Indent, IndentLevel)) & "}"
                    Return Result
                End If
                Return "null"
            End Function
            Return PrettyJsonStringifyInner(Anything)
        End Function
        Console.WriteLine("""")
        Console.WriteLine("Hello, World!")

        Dim MyNumber As List(Of Object) = New List(Of Object) From {1, 2, 3, 4}
        Dim MyNumberSum As String = MyNumber.Aggregate(0, Function(acc, x) (acc + x))
        Console.WriteLine("MyNumberSum: " & MyNumberSum)

        Dim Something As Object = 123
        Console.WriteLine($"Something: {PrettyJsonStringify(Something)}")

        Dim MyObject As Object = New Dictionary(Of String, Object) From {
            {"my_string", "foo"},
            {"my_number", 17},
            {"my_bool", true},
            {"my_null", Nothing},
            {"my_object", New Dictionary(Of String, Object) From {{"foo", "bar"}}},
            {"my_array", New List(Of Object) From {1, 2, 3}}
        }

        For Each objectEntry As KeyValuePair(Of String, Object) In MyObject
            Dim objectKey = objectEntry.Key
            Dim objectValue = objectEntry.Value
            Console.WriteLine("isNothing(objectValue): " & isNothing(objectValue))
            If (isNothing(objectValue) = True) Then
                Console.WriteLine("Key: " & objectKey & ", Value: " & "null")
            Else
                Console.WriteLine("Key: " & objectKey & ", Value: " & objectValue.ToString())
            End If
        Next

        Dim MyArray2 = New List(Of Object) From {"foo", 17, true}
        Console.WriteLine("MyArray2(2): " & MyArray2(0))

        For Each arrayItem As Object In MyArray2
            Console.WriteLine(arrayItem.ToString())
        Next

        For i As Integer = 0 To MyArray2.Length - 1
            Console.WriteLine("Index: " & i & ", Value: " & MyArray2(i).ToString())
        Next

        Dim sum As Integer
        sum = AddNumbers(5, 3)
        Console.WriteLine("The sum is: " & sum)

        Dim square As Func(Of Integer, Integer) = Function(x) x * x
        Console.WriteLine(square(5)) ' Output: 25

        Dim greet As Action(Of String) = Sub(name) Console.WriteLine("Hello, " & name)
        greet("Alice") ' Output: Hello, Alice

        Dim GetRectangleArea1 = Function(RectangleWidth As Integer, RectangleLength As Integer) As Integer
            Return (RectangleWidth * RectangleLength)
        End Function
        Dim GetRectangleArea2 As Func(Of Integer, Integer, Integer) = Function(RectangleWidth, RectangleLength)
            Return (RectangleWidth * RectangleLength)
        End Function
    End Sub
    Function AddNumbers(ByVal num1 As Integer, ByVal num2 As Integer) As Integer
        Dim result As Integer
        result = num1 + num2
        Return result
    End Function
    Function PrettyJsonStringifyV3(ByVal Anything As Object, Optional ByVal Indent As String = "    ") As String
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
End Module
