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
                Dim ObjectIterationIndex As Integer = 0
                For Each ObjectEntry As KeyValuePair(Of String, Object) In AnythingInner
                    Dim ObjectKey = ObjectEntry.Key
                    Dim ObjectValue = ObjectEntry.Value
                    Result &= """" & ObjectKey & """: " & PrettyJsonStringifyInner(ObjectValue, IndentInner)
                    If ((ObjectIterationIndex + 1) <> AnythingInner.Count) Then Result &= "," & Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel))
                    ObjectIterationIndex += 1
                Next
                IndentLevel -= 1
                Result &= Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel)) & "}"
                Return Result
            End If
            Return "null"
        End Function
        Return PrettyJsonStringifyInner(Anything, Indent)
    End Function

    Function ArraySomeV1(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Boolean
        ' JavaScript-like Array.some() function
        Dim IsConditionMatch As Boolean = false
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            IsConditionMatch = CallbackFunction(ArrayItem, ArrayItemIndex, AnArray)
            If (IsConditionMatch = true) Then Exit For
            ArrayItemIndex += 1
        Next
        Return IsConditionMatch
    End Function

    Function ArraySomeV2(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Boolean
        ' JavaScript-like Array.some() function
        Dim IsConditionMatch As Boolean = false
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            IsConditionMatch = CallbackFunction(ArrayItem, ArrayItemIndex, AnArray)
            If (IsConditionMatch = true) Then Return IsConditionMatch
            ArrayItemIndex += 1
        Next
        Return IsConditionMatch
    End Function

    Function ArraySomeV3(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Boolean
        ' JavaScript-like Array.some() function
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            Dim IsConditionMatch As Boolean = CallbackFunction(ArrayItem, ArrayItemIndex, AnArray)
            If (IsConditionMatch = true) Then Return true
            ArrayItemIndex += 1
        Next
        Return false
    End Function

    Function ArraySomeV4(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Boolean
        ' JavaScript-like Array.some() function
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            If (CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) = true) Then Return true
            ArrayItemIndex += 1
        Next
        Return false
    End Function

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.some() in Visual Basic (.NET) List")

        Dim Numbers As List(Of Object) = New List(Of Object) From {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
        Console.WriteLine($"Numbers: {PrettyArrayOfPrimitives(Numbers)}")

        Dim IsAnyNumberLessThan500 As Boolean
        Dim IsAnyNumberMoreThan500 As Boolean

        Console.WriteLine("' using JavaScript-like Array.some() function ""ArraySomeV1""")

        IsAnyNumberLessThan500 = ArraySomeV1(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number < 500), Numbers)
        Console.WriteLine($"is any number < 500: {IsAnyNumberLessThan500}")
        ' is any number < 500: True

        IsAnyNumberMoreThan500 = ArraySomeV1(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number > 500), Numbers)
        Console.WriteLine($"is any number > 500: {IsAnyNumberMoreThan500}")
        ' is any number > 500: False

        Console.WriteLine("' using JavaScript-like Array.some() function ""ArraySomeV2""")

        IsAnyNumberLessThan500 = ArraySomeV2(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number < 500), Numbers)
        Console.WriteLine($"is any number < 500: {IsAnyNumberLessThan500}")
        ' is any number < 500: True

        IsAnyNumberMoreThan500 = ArraySomeV2(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number > 500), Numbers)
        Console.WriteLine($"is any number > 500: {IsAnyNumberMoreThan500}")
        ' is any number > 500: False

        Console.WriteLine("' using JavaScript-like Array.some() function ""ArraySomeV3""")

        IsAnyNumberLessThan500 = ArraySomeV3(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number < 500), Numbers)
        Console.WriteLine($"is any number < 500: {IsAnyNumberLessThan500}")
        ' is any number < 500: True

        IsAnyNumberMoreThan500 = ArraySomeV3(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number > 500), Numbers)
        Console.WriteLine($"is any number > 500: {IsAnyNumberMoreThan500}")
        ' is any number > 500: False

        Console.WriteLine("' using JavaScript-like Array.some() function ""ArraySomeV4""")

        IsAnyNumberLessThan500 = ArraySomeV4(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number < 500), Numbers)
        Console.WriteLine($"is any number < 500: {IsAnyNumberLessThan500}")
        ' is any number < 500: True

        IsAnyNumberMoreThan500 = ArraySomeV4(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number > 500), Numbers)
        Console.WriteLine($"is any number > 500: {IsAnyNumberMoreThan500}")
        ' is any number > 500: False

        Console.WriteLine("' using Visual Basic (.NET) Array.some() built-in method ""Array.Any()""")

        IsAnyNumberLessThan500 = Numbers.Any(Function(ByVal Number As Integer) (Number < 500))
        Console.WriteLine($"is any number < 500: {IsAnyNumberLessThan500}")
        ' is any number < 500: True

        IsAnyNumberMoreThan500 = Numbers.Any(Function(ByVal Number As Integer) (Number > 500))
        Console.WriteLine($"is any number > 500: {IsAnyNumberMoreThan500}")
        ' is any number > 500: False

        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.some() in Visual Basic (.NET) List of Dictionaries")

        Dim Products As List(Of Object) = New List(Of Object) From {
            New Dictionary(Of String, Object) From {
                {"code", "pasta"},
                {"price", 321}
            },
            New Dictionary(Of String, Object) From {
                {"code", "bubble_gum"},
                {"price", 233}
            },
            New Dictionary(Of String, Object) From {
                {"code", "potato_chips"},
                {"price", 5}
            },
            New Dictionary(Of String, Object) From {
                {"code", "towel"},
                {"price", 499}
            }
        }
        Console.WriteLine($"Products: {PrettyJsonStringify(Products)}")

        Dim IsAnyProductPriceLessThan500 As Boolean
        Dim IsAnyProductPriceMoreThan500 As Boolean

        Console.WriteLine("' using JavaScript-like Array.some() function ""ArraySomeV1""")

        IsAnyProductPriceLessThan500 = ArraySomeV1(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") < 500), Products)
        Console.WriteLine($"is any product price < 500: {IsAnyProductPriceLessThan500}")
        ' is any product price < 500: True

        IsAnyProductPriceMoreThan500 = ArraySomeV1(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") > 500), Products)
        Console.WriteLine($"is any product price > 500: {IsAnyProductPriceMoreThan500}")
        ' is any product price > 500: False

        Console.WriteLine("' using JavaScript-like Array.some() function ""ArraySomeV2""")

        IsAnyProductPriceLessThan500 = ArraySomeV2(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") < 500), Products)
        Console.WriteLine($"is any product price < 500: {IsAnyProductPriceLessThan500}")
        ' is any product price < 500: True

        IsAnyProductPriceMoreThan500 = ArraySomeV2(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") > 500), Products)
        Console.WriteLine($"is any product price > 500: {IsAnyProductPriceMoreThan500}")
        ' is any product price > 500: False

        Console.WriteLine("' using JavaScript-like Array.some() function ""ArraySomeV3""")

        IsAnyProductPriceLessThan500 = ArraySomeV3(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") < 500), Products)
        Console.WriteLine($"is any product price < 500: {IsAnyProductPriceLessThan500}")
        ' is any product price < 500: True

        IsAnyProductPriceMoreThan500 = ArraySomeV3(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") > 500), Products)
        Console.WriteLine($"is any product price > 500: {IsAnyProductPriceMoreThan500}")
        ' is any product price > 500: False

        Console.WriteLine("' using JavaScript-like Array.some() function ""ArraySomeV4""")

        IsAnyProductPriceLessThan500 = ArraySomeV4(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") < 500), Products)
        Console.WriteLine($"is any product price < 500: {IsAnyProductPriceLessThan500}")
        ' is any product price < 500: True

        IsAnyProductPriceMoreThan500 = ArraySomeV4(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") > 500), Products)
        Console.WriteLine($"is any product price > 500: {IsAnyProductPriceMoreThan500}")
        ' is any product price > 500: False

        Console.WriteLine("' using Visual Basic (.NET) Array.some() built-in method ""Array.Any()""")

        IsAnyProductPriceLessThan500 = Products.Any(Function(ByVal Product As Object) (Product("price") < 500))
        Console.WriteLine($"is any product price < 500: {IsAnyProductPriceLessThan500}")
        ' is any product price < 500: True

        IsAnyProductPriceMoreThan500 = Products.Any(Function(ByVal Product As Object) (Product("price") > 500))
        Console.WriteLine($"is any product price > 500: {IsAnyProductPriceMoreThan500}")
        ' is any product price > 500: False
    End Sub
End Module
