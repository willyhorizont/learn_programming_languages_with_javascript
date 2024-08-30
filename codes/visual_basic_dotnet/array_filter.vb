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

    Function ArrayFilterV1(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As List(Of Object)
        ' JavaScript-like Array.filter() function
        Dim DataFiltered As New List(Of Object)()
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            Dim IsConditionMatch As Boolean = CallbackFunction(ArrayItem, ArrayItemIndex, AnArray)
            If (IsConditionMatch = true) Then DataFiltered.Add(ArrayItem)
            ArrayItemIndex += 1
        Next
        Return DataFiltered
    End Function

    Function ArrayFilterV2(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Boolean), ByVal AnArray As List(Of Object)) As List(Of Object)
        ' JavaScript-like Array.filter() function
        Dim DataFiltered As New List(Of Object)()
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            If (CallbackFunction(ArrayItem, ArrayItemIndex, AnArray) = true) Then DataFiltered.Add(ArrayItem)
            ArrayItemIndex += 1
        Next
        Return DataFiltered
    End Function

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.filter() in Visual Basic (.NET) List")

        Dim Numbers As List(Of Object) = New List(Of Object) From {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
        Console.WriteLine($"Numbers: {JsonStringify(Numbers)}")

        Dim NumbersEven As New List(Of Object)()
        Dim NumbersOdd As New List(Of Object)()

        Console.WriteLine("' using JavaScript-like Array.filter() function ""ArrayFilterV1""")

        NumbersEven = ArrayFilterV1(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) ((Number Mod 2) = 0), Numbers)
        Console.WriteLine($"even numbers only: {JsonStringify(NumbersEven)}")
        ' even numbers only: [12, 34, 36, 4, 254]

        NumbersOdd = ArrayFilterV1(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) ((Number Mod 2) <> 0), Numbers)
        Console.WriteLine($"odd numbers only: {JsonStringify(NumbersOdd)}")
        ' odd numbers only: [27, 23, 65, 93, 87]

        Console.WriteLine("' using JavaScript-like Array.filter() function ""ArrayFilterV2""")

        NumbersEven = ArrayFilterV2(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) ((Number Mod 2) = 0), Numbers)
        Console.WriteLine($"even numbers only: {JsonStringify(NumbersEven)}")
        ' even numbers only: [12, 34, 36, 4, 254]

        NumbersOdd = ArrayFilterV2(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) ((Number Mod 2) <> 0), Numbers)
        Console.WriteLine($"odd numbers only: {JsonStringify(NumbersOdd)}")
        ' odd numbers only: [27, 23, 65, 93, 87]

        Console.WriteLine("' using Visual Basic (.NET) Array.filter() built-in method ""Array.Where().ToList()""")

        NumbersEven = Numbers.Where(Function(ByVal Number As Integer) ((Number Mod 2) = 0)).ToList()
        Console.WriteLine($"even numbers only: {JsonStringify(NumbersEven)}")
        ' even numbers only: [12, 34, 36, 4, 254]

        NumbersOdd = Numbers.Where(Function(ByVal Number As Integer) ((Number Mod 2) <> 0)).ToList()
        Console.WriteLine($"odd numbers only: {JsonStringify(NumbersOdd)}")
        ' odd numbers only: [27, 23, 65, 93, 87]

        Console.WriteLine("' using Visual Basic (.NET) Array.filter() built-in method ""Array.Where().Cast(Of Object)().ToList()""")

        NumbersEven = Numbers.Where(Function(ByVal Number As Integer) ((Number Mod 2) = 0)).Cast(Of Object)().ToList()
        Console.WriteLine($"even numbers only: {JsonStringify(NumbersEven)}")
        ' even numbers only: [12, 34, 36, 4, 254]

        NumbersOdd = Numbers.Where(Function(ByVal Number As Integer) ((Number Mod 2) <> 0)).Cast(Of Object)().ToList()
        Console.WriteLine($"odd numbers only: {JsonStringify(NumbersOdd)}")
        ' odd numbers only: [27, 23, 65, 93, 87]

        Console.WriteLine("' using Visual Basic (.NET) Array.filter() built-in method ""DirectCast(Array.Where().ToList(), List(Of Object))""")

        NumbersEven = DirectCast(Numbers.Where(Function(ByVal Number As Integer) ((Number Mod 2) = 0)).ToList(), List(Of Object))
        Console.WriteLine($"even numbers only: {JsonStringify(NumbersEven)}")
        ' even numbers only: [12, 34, 36, 4, 254]

        NumbersOdd = DirectCast(Numbers.Where(Function(ByVal Number As Integer) ((Number Mod 2) <> 0)).ToList(), List(Of Object))
        Console.WriteLine($"odd numbers only: {JsonStringify(NumbersOdd)}")
        ' odd numbers only: [27, 23, 65, 93, 87]

        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.filter() in Visual Basic (.NET) List of Dictionaries")

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

        Dim ProductsBelow100 As New List(Of Object)()
        Dim ProductsAbove100 As New List(Of Object)()

        Console.WriteLine("' using JavaScript-like Array.filter() function ""ArrayFilterV1""")

        ProductsBelow100 = ArrayFilterV1(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") <= 100), Products)
        Console.WriteLine($"products with price <= 100 only: {JsonStringify(ProductsBelow100, Pretty:=True)}")
        ' products with price <= 100 only: [
        '     {
        '         "code": "potato_chips",
        '         "price": 5
        '     }
        ' ]

        ProductsAbove100 = ArrayFilterV1(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") > 100), Products)
        Console.WriteLine($"products with price > 100 only: {JsonStringify(ProductsAbove100, Pretty:=True)}")
        ' products with price > 100 only: [
        '     {
        '         "code": "pasta",
        '         "price": 321
        '     },
        '     {
        '         "code": "bubble_gum",
        '         "price": 233
        '     },
        '     {
        '         "code": "towel",
        '         "price": 499
        '     }
        ' ]

        Console.WriteLine("' using JavaScript-like Array.filter() function ""ArrayFilterV2""")

        ProductsBelow100 = ArrayFilterV2(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") <= 100), Products)
        Console.WriteLine($"products with price <= 100 only: {JsonStringify(ProductsBelow100, Pretty:=True)}")
        ' products with price <= 100 only: [
        '     {
        '         "code": "potato_chips",
        '         "price": 5
        '     }
        ' ]

        ProductsAbove100 = ArrayFilterV2(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (Product("price") > 100), Products)
        Console.WriteLine($"products with price > 100 only: {JsonStringify(ProductsAbove100, Pretty:=True)}")
        ' products with price > 100 only: [
        '     {
        '         "code": "pasta",
        '         "price": 321
        '     },
        '     {
        '         "code": "bubble_gum",
        '         "price": 233
        '     },
        '     {
        '         "code": "towel",
        '         "price": 499
        '     }
        ' ]

        Console.WriteLine("' using Visual Basic (.NET) Array.filter() built-in method ""Array.Where().ToList()""")

        ProductsBelow100 = Products.Where(Function(ByVal Product As Object) (Product("price") <= 100)).ToList()
        Console.WriteLine($"products with price <= 100 only: {JsonStringify(ProductsBelow100, Pretty:=True)}")
        ' products with price <= 100 only: [
        '     {
        '         "code": "potato_chips",
        '         "price": 5
        '     }
        ' ]

        ProductsAbove100 = Products.Where(Function(ByVal Product As Object) (Product("price") > 100)).ToList()
        Console.WriteLine($"products with price > 100 only: {JsonStringify(ProductsAbove100, Pretty:=True)}")
        ' products with price > 100 only: [
        '     {
        '         "code": "pasta",
        '         "price": 321
        '     },
        '     {
        '         "code": "bubble_gum",
        '         "price": 233
        '     },
        '     {
        '         "code": "towel",
        '         "price": 499
        '     }
        ' ]

        Console.WriteLine("' using Visual Basic (.NET) Array.filter() built-in method ""Array.Where().Cast(Of Object)().ToList()""")

        ProductsBelow100 = Products.Where(Function(ByVal Product As Object) (Product("price") <= 100)).Cast(Of Object)().ToList()
        Console.WriteLine($"products with price <= 100 only: {JsonStringify(ProductsBelow100, Pretty:=True)}")
        ' products with price <= 100 only: [
        '     {
        '         "code": "potato_chips",
        '         "price": 5
        '     }
        ' ]

        ProductsAbove100 = Products.Where(Function(ByVal Product As Object) (Product("price") > 100)).Cast(Of Object)().ToList()
        Console.WriteLine($"products with price > 100 only: {JsonStringify(ProductsAbove100, Pretty:=True)}")
        ' products with price > 100 only: [
        '     {
        '         "code": "pasta",
        '         "price": 321
        '     },
        '     {
        '         "code": "bubble_gum",
        '         "price": 233
        '     },
        '     {
        '         "code": "towel",
        '         "price": 499
        '     }
        ' ]

        Console.WriteLine("' using Visual Basic (.NET) Array.filter() built-in method ""DirectCast(Array.Where().ToList(), List(Of Object))""")

        ProductsBelow100 = DirectCast(Products.Where(Function(ByVal Product As Object) (Product("price") <= 100)).ToList(), List(Of Object))
        Console.WriteLine($"products with price <= 100 only: {JsonStringify(ProductsBelow100, Pretty:=True)}")
        ' products with price <= 100 only: [
        '     {
        '         "code": "potato_chips",
        '         "price": 5
        '     }
        ' ]

        ProductsAbove100 = DirectCast(Products.Where(Function(ByVal Product As Object) (Product("price") > 100)).ToList(), List(Of Object))
        Console.WriteLine($"products with price > 100 only: {JsonStringify(ProductsAbove100, Pretty:=True)}")
        ' products with price > 100 only: [
        '     {
        '         "code": "pasta",
        '         "price": 321
        '     },
        '     {
        '         "code": "bubble_gum",
        '         "price": 233
        '     },
        '     {
        '         "code": "towel",
        '         "price": 499
        '     }
        ' ]
    End Sub
End Module
