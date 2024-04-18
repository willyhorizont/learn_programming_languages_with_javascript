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

    Function ArrayFindIndexV1(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Integer
        ' JavaScript-like Array.findIndex() function
        Dim DataFoundIndex As Integer = -1
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            Dim IsConditionMatch As Boolean = CallbackFunction(ArrayItem, ArrayItemIndex, AnArray)
            If (IsConditionMatch = true) Then
                DataFoundIndex = ArrayItemIndex
                Exit For
            End If
            ArrayItemIndex += 1
        Next
        Return DataFoundIndex
    End Function

    Function ArrayFindIndexV2(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Integer
        ' JavaScript-like Array.findIndex() function
        Dim DataFoundIndex As Integer = -1
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            If (CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) = true) Then
                DataFoundIndex = ArrayItemIndex
                Exit For
            End If
            ArrayItemIndex += 1
        Next
        Return DataFoundIndex
    End Function

    Function ArrayFindIndexV3(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Integer
        ' JavaScript-like Array.findIndex() function
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            Dim IsConditionMatch As Boolean = CallbackFunction(ArrayItem, ArrayItemIndex, AnArray)
            If (IsConditionMatch = true) Then Return ArrayItemIndex
            ArrayItemIndex += 1
        Next
        Return -1
    End Function

    Function ArrayFindIndexV4(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As Integer
        ' JavaScript-like Array.findIndex() function
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            If (CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) = true) Then Return ArrayItemIndex
            ArrayItemIndex += 1
        Next
        Return -1
    End Function

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.findIndex() in Visual Basic (.NET) List")

        Dim Numbers As List(Of Object) = New List(Of Object) From {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
        Console.WriteLine($"Numbers: {JsonStringify(Numbers)}")

        Dim NumberToFind As Integer = 27
        Console.WriteLine($"number to find: {NumberToFind}")

        Dim NumberFoundIndex As Integer

        Console.WriteLine("' using JavaScript-like Array.findIndex() function ""ArrayFindIndexV1""")

        NumberFoundIndex = ArrayFindIndexV1(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number = NumberToFind), Numbers)
        Console.WriteLine($"number found index: {NumberFoundIndex}")
        ' number found index: 2

        Console.WriteLine("' using JavaScript-like Array.findIndex() function ""ArrayFindIndexV2""")

        NumberFoundIndex = ArrayFindIndexV2(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number = NumberToFind), Numbers)
        Console.WriteLine($"number found index: {NumberFoundIndex}")
        ' number found index: 2

        Console.WriteLine("' using JavaScript-like Array.findIndex() function ""ArrayFindIndexV3""")

        NumberFoundIndex = ArrayFindIndexV3(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number = NumberToFind), Numbers)
        Console.WriteLine($"number found index: {NumberFoundIndex}")
        ' number found index: 2

        Console.WriteLine("' using JavaScript-like Array.findIndex() function ""ArrayFindIndexV4""")

        NumberFoundIndex = ArrayFindIndexV4(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Number = NumberToFind), Numbers)
        Console.WriteLine($"number found index: {NumberFoundIndex}")
        ' number found index: 2

        Console.WriteLine("' using Visual Basic (.NET) Array.some() built-in method ""Array.FindIndex()""")

        NumberFoundIndex = Numbers.FindIndex(Function(ByVal Number As Integer) (Number = NumberToFind))
        Console.WriteLine($"number found index: {NumberFoundIndex}")
        ' number found index: 2

        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.findIndex() in Visual Basic (.NET) List of Dictionaries")

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
        Console.WriteLine($"Products: {JsonStringify(Products, Pretty:=True)}")

        Dim ProductToFind As String = "pasta"
        Console.WriteLine($"product to find: {JsonStringify(ProductToFind)}")

        Dim ProductFoundIndex As Integer

        Console.WriteLine("' using JavaScript-like Array.findIndex() function ""ArrayFindIndexV1""")

        ProductFoundIndex = ArrayFindIndexV1(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("code") = ProductToFind), Products)
        Console.WriteLine($"product found index: {ProductFoundIndex}")
        ' product found index: 0

        Console.WriteLine("' using JavaScript-like Array.findIndex() function ""ArrayFindIndexV2""")

        ProductFoundIndex = ArrayFindIndexV2(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("code") = ProductToFind), Products)
        Console.WriteLine($"product found index: {ProductFoundIndex}")
        ' product found index: 0

        Console.WriteLine("' using JavaScript-like Array.findIndex() function ""ArrayFindIndexV3""")

        ProductFoundIndex = ArrayFindIndexV3(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("code") = ProductToFind), Products)
        Console.WriteLine($"product found index: {ProductFoundIndex}")
        ' product found index: 0

        Console.WriteLine("' using JavaScript-like Array.findIndex() function ""ArrayFindIndexV4""")

        ProductFoundIndex = ArrayFindIndexV4(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("code") = ProductToFind), Products)
        Console.WriteLine($"product found index: {ProductFoundIndex}")
        ' product found index: 0

        Console.WriteLine("' using Visual Basic (.NET) Array.some() built-in method ""Array.FindIndex()""")

        ProductFoundIndex = Products.FindIndex(Function(ByVal Product As Object) (Product("code") = ProductToFind))
        Console.WriteLine($"product found index: {ProductFoundIndex}")
        ' product found index: 0
    End Sub
End Module
