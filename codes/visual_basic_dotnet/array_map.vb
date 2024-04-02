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

    Function SpreadSyntaxObject(ByVal ParamArray Parameters() As Object) As Dictionary(Of String, Object)
        Dim NewObject As New Dictionary(Of String, Object)
        Dim ParameterIndex As Integer = 0
        For Each Parameter As Object In Parameters
            If (TypeOf Parameter Is Dictionary(Of String, Object)) Then
                For Each ObjectEntry As KeyValuePair(Of String, Object) In Parameter
                    Dim ObjectKey = ObjectEntry.Key
                    Dim ObjectValue = ObjectEntry.Value
                    NewObject(CStr(ObjectKey)) = ObjectValue
                Next
                Continue For
            End If
            If (TypeOf Parameter Is List(Of Object)) Then
                Dim ArrayItemIndex As Integer = 0
                For Each ArrayItem As Object In Parameter
                    NewObject(CStr(ArrayItemIndex)) = ArrayItem
                    ArrayItemIndex += 1
                Next
                Continue For
            End If
            ParameterIndex += 1
        Next
        Return NewObject
    End Function

    Function ArrayMapV1(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Object), ByVal AnArray As List(Of Object)) As List(Of Object)
        ' JavaScript-like Array.map() function
        Dim NewArray As New List(Of Object)
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            Dim NewArrayItem As Object = CallbackFunction(ArrayItem, ArrayItemIndex, AnArray)
            NewArray.Add(NewArrayItem)
            ArrayItemIndex += 1
        Next
        Return NewArray
    End Function

    Function ArrayMapV2(ByVal CallbackFunction As Func(Of Object, Integer, List(Of Object), Object), ByVal AnArray As List(Of Object)) As List(Of Object)
        ' JavaScript-like Array.map() function
        Dim NewArray As New List(Of Object)
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            NewArray.Add(CallbackFunction(ArrayItem, ArrayItemIndex, AnArray))
            ArrayItemIndex += 1
        Next
        Return NewArray
    End Function

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.map() in Visual Basic (.NET) List")

        Dim Numbers As List(Of Object) = New List(Of Object) From {12, 34, 27, 23, 65, 93, 36, 87, 4, 254}
        Console.WriteLine($"Numbers: {PrettyArrayOfPrimitives(Numbers)}")

        Dim NumbersLabeled As New List(Of Object)

        Console.WriteLine("' using JavaScript-like Array.map() function ""ArrayMapV1""")

        NumbersLabeled = ArrayMapV1(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) New Dictionary(Of String, Object) From {{CStr(Number), If(((Number Mod 2) = 0), "even", "odd")}}, Numbers)
        Console.WriteLine($"labeled numbers: {PrettyJsonStringify(NumbersLabeled)}")
        ' labeled numbers: [
        '     {
        '         "12": "even"
        '     },
        '     {
        '         "34": "even"
        '     },
        '     {
        '         "27": "odd"
        '     },
        '     {
        '         "23": "odd"
        '     },
        '     {
        '         "65": "odd"
        '     },
        '     {
        '         "93": "odd"
        '     },
        '     {
        '         "36": "even"
        '     },
        '     {
        '         "87": "odd"
        '     },
        '     {
        '         "4": "even"
        '     },
        '     {
        '         "254": "even"
        '     }
        ' ]

        Console.WriteLine("' using JavaScript-like Array.map() function ""ArrayMapV2""")

        NumbersLabeled = ArrayMapV2(Function(ByVal Number As Integer, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) New Dictionary(Of String, Object) From {{CStr(Number), If(((Number Mod 2) = 0), "even", "odd")}}, Numbers)
        Console.WriteLine($"labeled numbers: {PrettyJsonStringify(NumbersLabeled)}")
        ' labeled numbers: [
        '     {
        '         "12": "even"
        '     },
        '     {
        '         "34": "even"
        '     },
        '     {
        '         "27": "odd"
        '     },
        '     {
        '         "23": "odd"
        '     },
        '     {
        '         "65": "odd"
        '     },
        '     {
        '         "93": "odd"
        '     },
        '     {
        '         "36": "even"
        '     },
        '     {
        '         "87": "odd"
        '     },
        '     {
        '         "4": "even"
        '     },
        '     {
        '         "254": "even"
        '     }
        ' ]

        Console.WriteLine("' using Visual Basic (.NET) Array.map() built-in method ""Array.Select().Cast(Of Object)().ToList()""")

        NumbersLabeled = Numbers.Select(Function(ByVal Number As Integer) New Dictionary(Of String, Object) From {{CStr(Number), If(((Number Mod 2) = 0), "even", "odd")}}).Cast(Of Object)().ToList()
        Console.WriteLine($"labeled numbers: {PrettyJsonStringify(NumbersLabeled)}")
        ' labeled numbers: [
        '     {
        '         "12": "even"
        '     },
        '     {
        '         "34": "even"
        '     },
        '     {
        '         "27": "odd"
        '     },
        '     {
        '         "23": "odd"
        '     },
        '     {
        '         "65": "odd"
        '     },
        '     {
        '         "93": "odd"
        '     },
        '     {
        '         "36": "even"
        '     },
        '     {
        '         "87": "odd"
        '     },
        '     {
        '         "4": "even"
        '     },
        '     {
        '         "254": "even"
        '     }
        ' ]

        Console.WriteLine("' using Visual Basic (.NET) Array.map() built-in method ""Array.Select(DirectCast()).ToList()""")

        NumbersLabeled = Numbers.Select(Function(ByVal Number As Integer) DirectCast(New Dictionary(Of String, Object) From {{CStr(Number), If(((Number Mod 2) = 0), "even", "odd")}}, Object)).ToList()
        Console.WriteLine($"labeled numbers: {PrettyJsonStringify(NumbersLabeled)}")
        ' labeled numbers: [
        '     {
        '         "12": "even"
        '     },
        '     {
        '         "34": "even"
        '     },
        '     {
        '         "27": "odd"
        '     },
        '     {
        '         "23": "odd"
        '     },
        '     {
        '         "65": "odd"
        '     },
        '     {
        '         "93": "odd"
        '     },
        '     {
        '         "36": "even"
        '     },
        '     {
        '         "87": "odd"
        '     },
        '     {
        '         "4": "even"
        '     },
        '     {
        '         "254": "even"
        '     }
        ' ]

        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.map() in Visual Basic (.NET) List of Dictionaries")

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

        Dim ProductsLabeled As New List(Of Object)

        Console.WriteLine("' using JavaScript-like Array.map() function ""ArrayMapV1""")

        ProductsLabeled = ArrayMapV1(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) SpreadSyntaxObject(Product, New Dictionary(Of String, Object) From {{"label", If((Product("price") > 100), "expensive", "cheap")}}), Products)
        Console.WriteLine($"labeled products: {PrettyJsonStringify(ProductsLabeled)}")
        ' labeled products: [
        '     {
        '         "code": "pasta",
        '         "price": 321,
        '         "label": "expensive"
        '     },
        '     {
        '         "code": "bubble_gum",
        '         "price": 233,
        '         "label": "expensive"
        '     },
        '     {
        '         "code": "potato_chips",
        '         "price": 5,
        '         "label": "cheap"
        '     },
        '     {
        '         "code": "towel",
        '         "price": 499,
        '         "label": "expensive"
        '     }
        ' ]

        Console.WriteLine("' using JavaScript-like Array.map() function ""ArrayMapV2""")

        ProductsLabeled = ArrayMapV2(Function(ByVal Product As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) SpreadSyntaxObject(Product, New Dictionary(Of String, Object) From {{"label", If((Product("price") > 100), "expensive", "cheap")}}), Products)
        Console.WriteLine($"labeled products: {PrettyJsonStringify(ProductsLabeled)}")
        ' labeled products: [
        '     {
        '         "code": "pasta",
        '         "price": 321,
        '         "label": "expensive"
        '     },
        '     {
        '         "code": "bubble_gum",
        '         "price": 233,
        '         "label": "expensive"
        '     },
        '     {
        '         "code": "potato_chips",
        '         "price": 5,
        '         "label": "cheap"
        '     },
        '     {
        '         "code": "towel",
        '         "price": 499,
        '         "label": "expensive"
        '     }
        ' ]

        Console.WriteLine("' using Visual Basic (.NET) Array.map() built-in method ""Array.Select().Cast(Of Object)().ToList()""")

        ProductsLabeled = Products.Select(Function(ByVal Product As Object) SpreadSyntaxObject(Product, New Dictionary(Of String, Object) From {{"label", If((Product("price") > 100), "expensive", "cheap")}})).Cast(Of Object)().ToList()
        Console.WriteLine($"labeled products: {PrettyJsonStringify(ProductsLabeled)}")
        ' labeled products: [
        '     {
        '         "code": "pasta",
        '         "price": 321,
        '         "label": "expensive"
        '     },
        '     {
        '         "code": "bubble_gum",
        '         "price": 233,
        '         "label": "expensive"
        '     },
        '     {
        '         "code": "potato_chips",
        '         "price": 5,
        '         "label": "cheap"
        '     },
        '     {
        '         "code": "towel",
        '         "price": 499,
        '         "label": "expensive"
        '     }
        ' ]

        Console.WriteLine("' using Visual Basic (.NET) Array.map() built-in method ""Array.Select(DirectCast()).ToList()""")

        ProductsLabeled = Products.Select(Function(ByVal Product As Object) DirectCast(SpreadSyntaxObject(Product, New Dictionary(Of String, Object) From {{"label", If((Product("price") > 100), "expensive", "cheap")}}), Object)).ToList()
        Console.WriteLine($"labeled products: {PrettyJsonStringify(ProductsLabeled)}")
        ' labeled products: [
        '     {
        '         "code": "pasta",
        '         "price": 321,
        '         "label": "expensive"
        '     },
        '     {
        '         "code": "bubble_gum",
        '         "price": 233,
        '         "label": "expensive"
        '     },
        '     {
        '         "code": "potato_chips",
        '         "price": 5,
        '         "label": "cheap"
        '     },
        '     {
        '         "code": "towel",
        '         "price": 499,
        '         "label": "expensive"
        '     }
        ' ]
    End Sub
End Module
