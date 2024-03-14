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

    Function ArrayFindV1(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Object
        ' JavaScript-like Array.find() function
        Dim DataFound As Object = Nothing
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            Dim IsConditionMatch As Boolean = CallbackFunction(ArrayItem, ArrayItemIndex, AnArray)
            If (IsConditionMatch = true) Then
                DataFound = ArrayItem
                Exit For
            End If
            ArrayItemIndex += 1
        Next
        Return DataFound
    End Function

    Function ArrayFindV2(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Object
        ' JavaScript-like Array.find() function
        Dim DataFound As Object = Nothing
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            If (CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) = true) Then
                DataFound = ArrayItem
                Exit For
            End If
            ArrayItemIndex += 1
        Next
        Return DataFound
    End Function

    Function ArrayFindV3(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Object
        ' JavaScript-like Array.find() function
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            Dim IsConditionMatch As Boolean = CallbackFunction(ArrayItem, ArrayItemIndex, AnArray)
            If (IsConditionMatch = true) Then Return ArrayItem
            ArrayItemIndex += 1
        Next
        Return Nothing
    End Function

    Function ArrayFindV4(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Object
        ' JavaScript-like Array.find() function
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            If (CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) = true) Then Return ArrayItem
            ArrayItemIndex += 1
        Next
        Return Nothing
    End Function

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.find() in Visual Basic (.NET) List(Of Object)")

        Dim Numbers As List(Of Object) = New List(Of Object) From {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
        Console.WriteLine($"Numbers: {PrettyArrayOfPrimitives(Numbers)}")

        Dim EvenNumberFound As Object
        Dim OddNumberFound As Object

        Console.WriteLine("' using JavaScript-like Array.find() function ""ArrayFindV1""")

        EvenNumberFound = ArrayFindV1(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) ((Number Mod 2) = 0), Numbers)
        Console.WriteLine($"even number found: {EvenNumberFound}")
        ' even number found: 12

        OddNumberFound = ArrayFindV1(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) ((Number Mod 2) <> 0), Numbers)
        Console.WriteLine($"even number found: {OddNumberFound}")
        ' odd number found: 27

        Console.WriteLine("' using JavaScript-like Array.find() function ""ArrayFindV2""")

        EvenNumberFound = ArrayFindV2(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) ((Number Mod 2) = 0), Numbers)
        Console.WriteLine($"even number found: {EvenNumberFound}")
        ' even number found: 12

        OddNumberFound = ArrayFindV2(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) ((Number Mod 2) <> 0), Numbers)
        Console.WriteLine($"even number found: {OddNumberFound}")
        ' odd number found: 27

        Console.WriteLine("' using JavaScript-like Array.find() function ""ArrayFindV3""")

        EvenNumberFound = ArrayFindV3(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) ((Number Mod 2) = 0), Numbers)
        Console.WriteLine($"even number found: {EvenNumberFound}")
        ' even number found: 12

        OddNumberFound = ArrayFindV3(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) ((Number Mod 2) <> 0), Numbers)
        Console.WriteLine($"even number found: {OddNumberFound}")
        ' odd number found: 27

        Console.WriteLine("' using JavaScript-like Array.find() function ""ArrayFindV4""")

        EvenNumberFound = ArrayFindV4(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) ((Number Mod 2) = 0), Numbers)
        Console.WriteLine($"even number found: {EvenNumberFound}")
        ' even number found: 12

        OddNumberFound = ArrayFindV4(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) ((Number Mod 2) <> 0), Numbers)
        Console.WriteLine($"even number found: {OddNumberFound}")
        ' odd number found: 27

        Console.WriteLine("' using Visual Basic (.NET) Array.some() built-in method ""Array.Find()""")

        EvenNumberFound = Numbers.Find(Function(ByVal Number As Integer) ((Number Mod 2) = 0))
        Console.WriteLine($"even number found: {EvenNumberFound}")
        ' even number found: 12

        OddNumberFound = Numbers.Find(Function(ByVal Number As Integer) ((Number Mod 2) <> 0))
        Console.WriteLine($"even number found: {OddNumberFound}")
        ' odd number found: 27

        Console.WriteLine("' using Visual Basic (.NET) Array.some() built-in method ""Array.FirstOrDefault()""")

        EvenNumberFound = Numbers.FirstOrDefault(Function(ByVal Number As Integer) ((Number Mod 2) = 0))
        Console.WriteLine($"even number found: {EvenNumberFound}")
        ' even number found: 12

        OddNumberFound = Numbers.FirstOrDefault(Function(ByVal Number As Integer) ((Number Mod 2) <> 0))
        Console.WriteLine($"even number found: {OddNumberFound}")
        ' odd number found: 27

        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.find() in Visual Basic (.NET) List(Of Dictionary(Of String, Object))")

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

        Dim ProductToFind As String = "bubble_gum"
        Console.WriteLine($"product to find: {PrettyJsonStringify(ProductToFind)}")

        Dim ProductFound As Object

        Console.WriteLine("' using JavaScript-like Array.find() function ""ArrayFindV1""")

        ProductFound = ArrayFindV1(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("code") = ProductToFind), Products)
        Console.WriteLine($"product found: {PrettyJsonStringify(ProductFound)}")
        ' product found: {
	    '     "code":"bubble_gum",
	    '     "price": 233
	    ' }

        Console.WriteLine("' using JavaScript-like Array.find() function ""ArrayFindV2""")

        ProductFound = ArrayFindV2(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("code") = ProductToFind), Products)
        Console.WriteLine($"product found: {PrettyJsonStringify(ProductFound)}")
        ' product found: {
	    '     "code":"bubble_gum",
	    '     "price": 233
	    ' }

        Console.WriteLine("' using JavaScript-like Array.find() function ""ArrayFindV3""")

        ProductFound = ArrayFindV3(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("code") = ProductToFind), Products)
        Console.WriteLine($"product found: {PrettyJsonStringify(ProductFound)}")
        ' product found: {
	    '     "code":"bubble_gum",
	    '     "price": 233
	    ' }

        Console.WriteLine("' using JavaScript-like Array.find() function ""ArrayFindV4""")

        ProductFound = ArrayFindV4(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("code") = ProductToFind), Products)
        Console.WriteLine($"product found: {PrettyJsonStringify(ProductFound)}")
        ' product found: {
	    '     "code":"bubble_gum",
	    '     "price": 233
	    ' }

        Console.WriteLine("' using Visual Basic (.NET) Array.some() built-in method ""Array.Find()""")

        ProductFound = Products.Find(Function(ByVal Product As Object) (Product("code") = ProductToFind))
        Console.WriteLine($"product found: {PrettyJsonStringify(ProductFound)}")
        ' product found: {
	    '     "code":"bubble_gum",
	    '     "price": 233
	    ' }

        Console.WriteLine("' using Visual Basic (.NET) Array.some() built-in method ""Array.FirstOrDefault()""")

        ProductFound = Products.FirstOrDefault(Function(ByVal Product As Object) (Product("code") = ProductToFind))
        Console.WriteLine($"product found: {PrettyJsonStringify(ProductFound)}")
        ' product found: {
	    '     "code":"bubble_gum",
	    '     "price": 233
	    ' }
    End Sub
End Module
