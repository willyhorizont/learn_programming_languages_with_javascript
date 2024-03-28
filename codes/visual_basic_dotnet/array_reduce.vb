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

    Function SpreadSyntaxArray(ByVal ParamArray Parameters() As Object) As List(Of Object)
        Dim NewArray As New List(Of Object)
        Dim ParameterIndex As Integer = 0
        For Each Parameter As Object In Parameters
            If (TypeOf Parameter Is Dictionary(Of String, Object)) Then
                If (Parameter.Count = 1) Then
                    For Each ObjectEntry As KeyValuePair(Of String, Object) In Parameter
                        Dim ObjectKey = ObjectEntry.Key
                        Dim ObjectValue = ObjectEntry.Value
                        NewArray.Add(ObjectValue)
                    Next
                    Continue For
                End If
                NewArray.Add(Parameter)
                Continue For
            End If
            If (TypeOf Parameter Is List(Of Object)) Then
                Dim ArrayItemIndex As Integer = 0
                For Each ArrayItem As Object In Parameter
                    NewArray.Add(ArrayItem)
                    ArrayItemIndex += 1
                Next
                Continue For
            End If
            ParameterIndex += 1
        Next
        Return NewArray
    End Function

    Function ArrayReduce(ByVal CallbackFunction As Func(Of Object, Object, Integer, List(Of Object), Object), ByVal AnArray As List(Of Object), ByVal InitialValue As Object) As Object
        ' JavaScript-like Array.reduce() function
        Dim Result As Object = InitialValue
        Dim ArrayItemIndex As Integer = 0
        For Each ArrayItem As Object In AnArray
            Result = CallbackFunction(Result, ArrayItem, ArrayItemIndex, AnArray)
            ArrayItemIndex += 1
        Next
        Return Result
    End Function

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.reduce() in Visual Basic (.NET) List")

        Dim Numbers As List(Of Object) = New List(Of Object) From {36, 57, 2.7, 2.3, -12, -34, -6.5, -4.3}
        Console.WriteLine($"Numbers: {PrettyArrayOfPrimitives(Numbers)}")

        Dim NumbersTotal As Double = 0.0

        Console.WriteLine("' using JavaScript-like Array.reduce() function ""ArrayReduce""")

        NumbersTotal = ArrayReduce(Function(ByVal CurrentResult As Object, ByVal CurrentNumber As Double, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) (CurrentResult + CurrentNumber), Numbers, 0.0)
        Console.WriteLine($"total number: {PrettyJsonStringify(NumbersTotal)}")
        ' total number: 41.2

        Console.WriteLine("' using Visual Basic (.NET) Array.reduce() built-in method ""Array.Aggregate()""")

        NumbersTotal = Numbers.Aggregate(0.0, Function(ByVal CurrentResult As Object, ByVal CurrentNumber As Double) (CurrentResult + CurrentNumber))
        Console.WriteLine($"total number: {PrettyJsonStringify(NumbersTotal)}")
        ' total number: 41.2

        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Array.reduce() in Visual Basic (.NET) List of Dictionaries")

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

        Dim ProductsGrouped As Object

        Console.WriteLine("' using JavaScript-like Array.reduce() function ""ArrayReduce""")

        ProductsGrouped = ArrayReduce(Function(ByVal CurrentResult As Object, ByVal CurrentProduct As Object, ByVal ArrayItemIndex As Integer, ByVal AnArray As List(Of Object)) If((CurrentProduct("price") > 100), SpreadSyntaxObject(CurrentResult, New Dictionary(Of String, Object) From {{"expensive", SpreadSyntaxArray(CurrentResult("expensive"), New Dictionary(Of String, Object) From {{"CurrentProduct", CurrentProduct}})}}), SpreadSyntaxObject(CurrentResult, New Dictionary(Of String, Object) From {{"cheap", SpreadSyntaxArray(CurrentResult("cheap"), New Dictionary(Of String, Object) From {{"CurrentProduct", CurrentProduct}})}})), Products, New Dictionary(Of String, Object) From {{"expensive", New List(Of Object)}, {"cheap", New List(Of Object)}})
        Console.WriteLine($"grouped products: {PrettyJsonStringify(ProductsGrouped)}")
        ' grouped products: {
        '     "expensive": [
        '         {
        '             "code": "pasta",
        '             "price": 321
        '         },
        '         {
        '             "code": "bubble_gum",
        '             "price": 233
        '         },
        '         {
        '             "code": "towel",
        '             "price": 499
        '         }
        '     ],
        '     "cheap": [
        '         {
        '             "code": "potato_chips",
        '             "price": 5
        '         }
        '     ]
        ' }

        Console.WriteLine("' using Visual Basic (.NET) Array.reduce() built-in method ""Array.Aggregate()""")

        ProductsGrouped = Products.Aggregate(New Dictionary(Of String, Object) From {{"expensive", New List(Of Object)}, {"cheap", New List(Of Object)}}, Function(ByVal CurrentResult As Object, ByVal CurrentProduct As Object) If((CurrentProduct("price") > 100), SpreadSyntaxObject(CurrentResult, New Dictionary(Of String, Object) From {{"expensive", SpreadSyntaxArray(CurrentResult("expensive"), New Dictionary(Of String, Object) From {{"CurrentProduct", CurrentProduct}})}}), SpreadSyntaxObject(CurrentResult, New Dictionary(Of String, Object) From {{"cheap", SpreadSyntaxArray(CurrentResult("cheap"), New Dictionary(Of String, Object) From {{"CurrentProduct", CurrentProduct}})}})))
        Console.WriteLine($"grouped products: {PrettyJsonStringify(ProductsGrouped)}")
        ' grouped products: {
        '     "expensive": [
        '         {
        '             "code": "pasta",
        '             "price": 321
        '         },
        '         {
        '             "code": "bubble_gum",
        '             "price": 233
        '         },
        '         {
        '             "code": "towel",
        '             "price": 499
        '         }
        '     ],
        '     "cheap": [
        '         {
        '             "code": "potato_chips",
        '             "price": 5
        '         }
        '     ]
        ' }
    End Sub
End Module
