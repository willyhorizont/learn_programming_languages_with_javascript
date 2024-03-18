Imports System.Collections.Generic ' Dictionary, KeyValuePair

Module Program
    Function PrettyArrayOfPrimitives(ByVal AnArrayOfPrimitives As List(Of Object)) As String
        Dim Result As String = "["
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArrayOfPrimitives
            If (((TypeOf ArrayItem Is String) = false) AndAlso ((IsNumeric(ArrayItem)) = false) AndAlso ((TypeOf ArrayItem Is Boolean) = false) AndAlso ((ArrayItem Is Nothing) = false)) Then Continue For
            If (TypeOf ArrayItem Is String) Then Result += """" & ArrayItem & """"
            If IsNumeric(ArrayItem) Then Result += CStr(ArrayItem).Replace(",", ".")
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

    Function ArrayEveryV1(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Boolean
        ' JavaScript-like Array.every() function
        Dim IsConditionMatch As Boolean = false
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            IsConditionMatch = CallbackFunction(ArrayItem, ArrayItemIndex, AnArray)
            If (IsConditionMatch = false) Then Exit For
            ArrayItemIndex += 1
        Next
        Return IsConditionMatch
    End Function

    Function ArrayEveryV2(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Boolean
        ' JavaScript-like Array.every() function
        Dim IsConditionMatch As Boolean = false
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            IsConditionMatch = CallbackFunction(ArrayItem, ArrayItemIndex, AnArray)
            If (IsConditionMatch = false) Then Return IsConditionMatch
            ArrayItemIndex += 1
        Next
        Return IsConditionMatch
    End Function

    Function ArrayEveryV3(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Boolean
        ' JavaScript-like Array.every() function
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            Dim IsConditionMatch As Boolean = CallbackFunction(ArrayItem, ArrayItemIndex, AnArray)
            If (IsConditionMatch = false) Then Return false
            ArrayItemIndex += 1
        Next
        Return true
    End Function

    Function ArrayEveryV4(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Boolean
        ' JavaScript-like Array.every() function
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            If (CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) = false) Then Return false
            ArrayItemIndex += 1
        Next
        Return true
    End Function

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.every() in Visual Basic (.NET) List(Of Object)")

        Dim Numbers As List(Of Object) = New List(Of Object) From {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
        Console.WriteLine($"Numbers: {PrettyArrayOfPrimitives(Numbers)}")

        Dim IsAllNumberLessThan500 As Boolean
        Dim IsAllNumberMoreThan500 As Boolean

        Console.WriteLine("' using JavaScript-like Array.every() function ""ArrayEveryV1""")

        IsAllNumberLessThan500 = ArrayEveryV1(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number < 500), Numbers)
        Console.WriteLine($"is all number < 500: {IsAllNumberLessThan500}")
        ' is all number < 500: True

        IsAllNumberMoreThan500 = ArrayEveryV1(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number > 500), Numbers)
        Console.WriteLine($"is all number > 500: {IsAllNumberMoreThan500}")
        ' is all number > 500: False

        Console.WriteLine("' using JavaScript-like Array.every() function ""ArrayEveryV2""")

        IsAllNumberLessThan500 = ArrayEveryV2(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number < 500), Numbers)
        Console.WriteLine($"is all number < 500: {IsAllNumberLessThan500}")
        ' is all number < 500: True

        IsAllNumberMoreThan500 = ArrayEveryV2(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number > 500), Numbers)
        Console.WriteLine($"is all number > 500: {IsAllNumberMoreThan500}")
        ' is all number > 500: False

        Console.WriteLine("' using JavaScript-like Array.every() function ""ArrayEveryV3""")

        IsAllNumberLessThan500 = ArrayEveryV3(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number < 500), Numbers)
        Console.WriteLine($"is all number < 500: {IsAllNumberLessThan500}")
        ' is all number < 500: True

        IsAllNumberMoreThan500 = ArrayEveryV3(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number > 500), Numbers)
        Console.WriteLine($"is all number > 500: {IsAllNumberMoreThan500}")
        ' is all number > 500: False

        Console.WriteLine("' using JavaScript-like Array.every() function ""ArrayEveryV4""")

        IsAllNumberLessThan500 = ArrayEveryV4(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number < 500), Numbers)
        Console.WriteLine($"is all number < 500: {IsAllNumberLessThan500}")
        ' is all number < 500: True

        IsAllNumberMoreThan500 = ArrayEveryV4(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number > 500), Numbers)
        Console.WriteLine($"is all number > 500: {IsAllNumberMoreThan500}")
        ' is all number > 500: False

        Console.WriteLine("' using Visual Basic (.NET) Array.every() built-in method ""Array.All()""")

        IsAllNumberLessThan500 = Numbers.All(Function(ByVal Number As Integer) (Number < 500))
        Console.WriteLine($"is all number < 500: {IsAllNumberLessThan500}")
        ' is all number < 500: True

        IsAllNumberMoreThan500 = Numbers.All(Function(ByVal Number As Integer) (Number > 500))
        Console.WriteLine($"is all number > 500: {IsAllNumberMoreThan500}")
        ' is all number > 500: False

        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.every() in Visual Basic (.NET) List(Of Dictionary(Of String, Object))")

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

        Dim IsAllProductPriceLessThan500 As Boolean
        Dim IsAllProductPriceMoreThan500 As Boolean

        Console.WriteLine("' using JavaScript-like Array.every() function ""ArrayEveryV1""")

        IsAllProductPriceLessThan500 = ArrayEveryV1(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") < 500), Products)
        Console.WriteLine($"is all product price < 500: {IsAllProductPriceLessThan500}")
        ' is all product price < 500: True

        IsAllProductPriceMoreThan500 = ArrayEveryV1(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") > 500), Products)
        Console.WriteLine($"is all product price > 500: {IsAllProductPriceMoreThan500}")
        ' is all product price > 500: False

        Console.WriteLine("' using JavaScript-like Array.every() function ""ArrayEveryV2""")

        IsAllProductPriceLessThan500 = ArrayEveryV2(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") < 500), Products)
        Console.WriteLine($"is all product price < 500: {IsAllProductPriceLessThan500}")
        ' is all product price < 500: True

        IsAllProductPriceMoreThan500 = ArrayEveryV2(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") > 500), Products)
        Console.WriteLine($"is all product price > 500: {IsAllProductPriceMoreThan500}")
        ' is all product price > 500: False

        Console.WriteLine("' using JavaScript-like Array.every() function ""ArrayEveryV3""")

        IsAllProductPriceLessThan500 = ArrayEveryV3(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") < 500), Products)
        Console.WriteLine($"is all product price < 500: {IsAllProductPriceLessThan500}")
        ' is all product price < 500: True

        IsAllProductPriceMoreThan500 = ArrayEveryV3(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") > 500), Products)
        Console.WriteLine($"is all product price > 500: {IsAllProductPriceMoreThan500}")
        ' is all product price > 500: False

        Console.WriteLine("' using JavaScript-like Array.every() function ""ArrayEveryV4""")

        IsAllProductPriceLessThan500 = ArrayEveryV4(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") < 500), Products)
        Console.WriteLine($"is all product price < 500: {IsAllProductPriceLessThan500}")
        ' is all product price < 500: True

        IsAllProductPriceMoreThan500 = ArrayEveryV4(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") > 500), Products)
        Console.WriteLine($"is all product price > 500: {IsAllProductPriceMoreThan500}")
        ' is all product price > 500: False

        Console.WriteLine("' using Visual Basic (.NET) Array.every() built-in method ""Array.All()""")

        IsAllProductPriceLessThan500 = Products.All(Function(ByVal Product As Object) (Product("price") < 500))
        Console.WriteLine($"is all product price < 500: {IsAllProductPriceLessThan500}")
        ' is all product price < 500: True

        IsAllProductPriceMoreThan500 = Products.All(Function(ByVal Product As Object) (Product("price") > 500))
        Console.WriteLine($"is all product price > 500: {IsAllProductPriceMoreThan500}")
        ' is all product price > 500: False
    End Sub
End Module
