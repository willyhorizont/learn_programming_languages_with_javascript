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

    Sub Main(Args As String())
        Console.WriteLine($"{Environment.NewLine}' JavaScript-like Spread Syntax (...) in Visual Basic (.NET)")

        ' There's no JavaScript-like Spread Syntax (...) in Visual Basic (.NET).
        ' But, we can create our own function to mimic it in Visual Basic (.NET).

        Dim Fruits As List(Of Object) = New List(Of Object) From {"Mango", "Melon", "Banana"}
        Console.WriteLine("Fruits: " & PrettyArrayOfPrimitives(Fruits))

        Dim Vegetables As List(Of Object) = New List(Of Object) From {"Carrot", "Tomato"}
        Console.WriteLine("Vegetables: " & PrettyArrayOfPrimitives(Vegetables))

        Dim CountryCapitalsInAsia As Dictionary(Of String, Object) = New Dictionary(Of String, Object) From {
            {"Thailand", "Bangkok"},
            {"China", "Beijing"},
            {"Japan", "Tokyo"}
        }
        Console.WriteLine("CountryCapitalsInAsia: " & PrettyJsonStringify(CountryCapitalsInAsia))

        Dim CountryCapitalsInEurope As Dictionary(Of String, Object) = New Dictionary(Of String, Object) From {
            {"France", "Paris"},
            {"England", "London"}
        }
        Console.WriteLine("CountryCapitalsInEurope: " & PrettyJsonStringify(CountryCapitalsInEurope))

        Console.WriteLine($"{Environment.NewLine}' [...array1, ...array2]:{Environment.NewLine}")

        Dim Combination1 = SpreadSyntaxArray(Fruits, Vegetables)
        Console.WriteLine("Combination1: " & PrettyJsonStringify(Combination1))
        ' Combination1: [
        '     "Mango",
        '     "Melon",
        '     "Banana",
        '     "Carrot",
        '     "Tomato"
        ' ]

        Dim Combination2 = SpreadSyntaxArray(Fruits, New List(Of Object) From {"Cucumber", "Cabbage"})
        Console.WriteLine("Combination2: " & PrettyJsonStringify(Combination2))
        ' Combination2: [
        '     "Mango",
        '     "Melon",
        '     "Banana",
        '     "Cucumber",
        '     "Cabbage"
        ' ]

        Console.WriteLine($"{Environment.NewLine}' {{ ...object1, ...object2 }}:{Environment.NewLine}")

        Dim Combination3 = SpreadSyntaxObject(CountryCapitalsInAsia, CountryCapitalsInEurope)
        Console.WriteLine("Combination3: " & PrettyJsonStringify(Combination3))
        ' Combination3: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "France": "Paris",
        '     "England": "London"
        ' }

        Dim Combination4 = SpreadSyntaxObject(CountryCapitalsInAsia, New Dictionary(Of String, Object) From {{"Germany", "Berlin"}, {"Italy", "Rome"}})
        Console.WriteLine("Combination4: " & PrettyJsonStringify(Combination4))
        ' Combination4: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "Germany": "Berlin",
        '     "Italy": "Rome"
        ' }

        Console.WriteLine($"{Environment.NewLine}' [...array1, array2]:{Environment.NewLine}")

        Dim Combination5 = SpreadSyntaxArray(Fruits, New Dictionary(Of String, Object) From {{"Vegetables", Vegetables}})
        Console.WriteLine("Combination5: " & PrettyJsonStringify(Combination5))
        ' Combination5: [
        '     "Mango",
        '     "Melon",
        '     "Banana",
        '     [
        '         "Carrot",
        '         "Tomato"
        '     ]
        ' ]

        Dim Combination6 = SpreadSyntaxArray(Fruits, New Dictionary(Of String, Object) From {{"Vegetables", New List(Of Object) From {"Cucumber", "Cabbage"}}})
        Console.WriteLine("Combination6: " & PrettyJsonStringify(Combination6))
        ' Combination6: [
        '     "Mango",
        '     "Melon",
        '     "Banana",
        '     [
        '         "Cucumber",
        '         "Cabbage"
        '     ]
        ' ]

        Console.WriteLine($"{Environment.NewLine}' [...array1, object1]:{Environment.NewLine}")

        Dim Combination7 = SpreadSyntaxArray(Fruits, New Dictionary(Of String, Object) From {{"CountryCapitalsInAsia", CountryCapitalsInAsia}})
        Console.WriteLine("Combination7: " & PrettyJsonStringify(Combination7))
        ' Combination7: [
        '     "Mango",
        '     "Melon",
        '     "Banana",
        '     {
        '         "Thailand": "Bangkok",
        '         "China": "Beijing",
        '         "Japan": "Tokyo"
        '     }
        ' ]

        Dim Combination8 = SpreadSyntaxArray(Fruits, New Dictionary(Of String, Object) From {{"CountryCapitalsInEurope", New Dictionary(Of String, Object) From {{"Germany", "Berlin"}, {"Italy", "Rome"}}}})
        Console.WriteLine("Combination8: " & PrettyJsonStringify(Combination8))
        ' Combination8: [
        '     "Mango",
        '     "Melon",
        '     "Banana",
        '     {
        '         "Germany": "Berlin",
        '         "Italy": "Rome"
        '     }
        ' ]

        Console.WriteLine($"{Environment.NewLine}' {{ ...object1, object2 }}:{Environment.NewLine}")

        Dim Combination9 = SpreadSyntaxObject(CountryCapitalsInAsia, New Dictionary(Of String, Object) From {{"CountryCapitalsInEurope", CountryCapitalsInEurope}})
        Console.WriteLine("Combination9: " & PrettyJsonStringify(Combination9))
        ' Combination9: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "CountryCapitalsInEurope": {
        '         "France": "Paris",
        '         "England": "London"
        '     }
        ' }

        Dim Combination10 = SpreadSyntaxObject(CountryCapitalsInAsia, New Dictionary(Of String, Object) From {{"CountryCapitalsInEurope", New Dictionary(Of String, Object) From {{"Germany", "Berlin"}, {"Italy", "Rome"}}}})
        Console.WriteLine("Combination10: " & PrettyJsonStringify(Combination10))
        ' Combination10: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "CountryCapitalsInEurope": {
        '         "Germany": "Berlin",
        '         "Italy": "Rome"
        '     }
        ' }

        Console.WriteLine($"{Environment.NewLine}' {{ ...object1, array2 }}:{Environment.NewLine}")

        Dim Combination11 = SpreadSyntaxObject(CountryCapitalsInAsia, New Dictionary(Of String, Object) From {{"Vegetables", Vegetables}})
        Console.WriteLine("Combination11: " & PrettyJsonStringify(Combination11))
        ' Combination11: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "Vegetables": [
        '         "Carrot",
        '         "Tomato"
        '     ]
        ' }

        Dim Combination12 = SpreadSyntaxObject(CountryCapitalsInAsia, New Dictionary(Of String, Object) From {{"Vegetables", New List(Of Object) From {"Cucumber", "Cabbage"}}})
        Console.WriteLine("Combination12: " & PrettyJsonStringify(Combination12))
        ' Combination12: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "Vegetables": [
        '         "Cucumber",
        '         "Cabbage"
        '     ]
        ' }

        Console.WriteLine($"{Environment.NewLine}' {{ ...object1, ...array2 }}:{Environment.NewLine}")

        Dim Combination13 = SpreadSyntaxObject(CountryCapitalsInAsia, Vegetables)
        Console.WriteLine("Combination13: " & PrettyJsonStringify(Combination13))
        ' Combination13: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "0": "Carrot",
        '     "1": "Tomato"
        ' }

        Dim Combination14 = SpreadSyntaxObject(CountryCapitalsInAsia, New List(Of Object) From {"Cucumber", "Cabbage"})
        Console.WriteLine("Combination14: " & PrettyJsonStringify(Combination14))
        ' Combination14: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "0": "Cucumber",
        '     "1": "Cabbage"
        ' }

        ' Console.WriteLine($"{Environment.NewLine}' [...array1, ...object1] ` this combination throw an error in JavaScript:{Environment.NewLine}")

        ' this combination throw an error in JavaScript
        ' Dim CombinationErrorInJavascript1 = SpreadSyntaxArray(Fruits, CountryCapitalsInAsia)
        ' Console.WriteLine("CombinationErrorInJavascript1: " & PrettyJsonStringify(CombinationErrorInJavascript1))

        ' this combination throw an error in JavaScript
        ' Dim CombinationErrorInJavascript2 = SpreadSyntaxArray(Fruits, New Dictionary(Of String, Object) From {{"Germany", "Berlin"}, {"Italy", "Rome"}})
        ' Console.WriteLine("CombinationErrorInJavascript2: " & PrettyJsonStringify(CombinationErrorInJavascript2))
    End Sub
End Module
