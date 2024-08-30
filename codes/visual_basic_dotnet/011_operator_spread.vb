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

    ' There's no JavaScript-like Spread Syntax (...) in Visual Basic (.NET).
    ' But, we can create our own function to mimic it in Visual Basic (.NET).

    Function SpreadObject(ByVal ParamArray Parameters() As Object) As Dictionary(Of String, Object)
        Dim NewObject As New Dictionary(Of String, Object)()
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

    Function SpreadArray(ByVal ParamArray Parameters() As Object) As List(Of Object)
        Dim NewArray As New List(Of Object)()
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

        Dim Fruits As List(Of Object) = New List(Of Object) From {"Mango", "Melon", "Banana"}
        Console.WriteLine("Fruits: " & JsonStringify(Fruits))

        Dim Vegetables As List(Of Object) = New List(Of Object) From {"Carrot", "Tomato"}
        Console.WriteLine("Vegetables: " & JsonStringify(Vegetables))

        Dim CountryCapitalsInAsia As Dictionary(Of String, Object) = New Dictionary(Of String, Object) From {
            {"Thailand", "Bangkok"},
            {"China", "Beijing"},
            {"Japan", "Tokyo"}
        }
        Console.WriteLine("CountryCapitalsInAsia: " & JsonStringify(CountryCapitalsInAsia, Pretty:=True))

        Dim CountryCapitalsInEurope As Dictionary(Of String, Object) = New Dictionary(Of String, Object) From {
            {"France", "Paris"},
            {"England", "London"}
        }
        Console.WriteLine("CountryCapitalsInEurope: " & JsonStringify(CountryCapitalsInEurope, Pretty:=True))

        Console.WriteLine($"{Environment.NewLine}' [...array1, ...array2]:{Environment.NewLine}")

        Dim Combination1 = SpreadArray(Fruits, Vegetables)
        Console.WriteLine("Combination1: " & JsonStringify(Combination1, Pretty:=True))
        ' Combination1: [
        '     "Mango",
        '     "Melon",
        '     "Banana",
        '     "Carrot",
        '     "Tomato"
        ' ]

        Dim Combination2 = SpreadArray(Fruits, New List(Of Object) From {"Cucumber", "Cabbage"})
        Console.WriteLine("Combination2: " & JsonStringify(Combination2, Pretty:=True))
        ' Combination2: [
        '     "Mango",
        '     "Melon",
        '     "Banana",
        '     "Cucumber",
        '     "Cabbage"
        ' ]

        Console.WriteLine($"{Environment.NewLine}' {{ ...object1, ...object2 }}:{Environment.NewLine}")

        Dim Combination3 = SpreadObject(CountryCapitalsInAsia, CountryCapitalsInEurope)
        Console.WriteLine("Combination3: " & JsonStringify(Combination3, Pretty:=True))
        ' Combination3: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "France": "Paris",
        '     "England": "London"
        ' }

        Dim Combination4 = SpreadObject(CountryCapitalsInAsia, New Dictionary(Of String, Object) From {{"Germany", "Berlin"}, {"Italy", "Rome"}})
        Console.WriteLine("Combination4: " & JsonStringify(Combination4, Pretty:=True))
        ' Combination4: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "Germany": "Berlin",
        '     "Italy": "Rome"
        ' }

        Console.WriteLine($"{Environment.NewLine}' [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:{Environment.NewLine}")

        Dim Combination5 = SpreadArray(Fruits, New Dictionary(Of String, Object) From {{"Vegetables", Vegetables}})
        Console.WriteLine("Combination5: " & JsonStringify(Combination5, Pretty:=True))
        ' Combination5: [
        '     "Mango",
        '     "Melon",
        '     "Banana",
        '     [
        '         "Carrot",
        '         "Tomato"
        '     ]
        ' ]

        Dim Combination6 = SpreadArray(Fruits, New Dictionary(Of String, Object) From {{"Vegetables", New List(Of Object) From {"Cucumber", "Cabbage"}}})
        Console.WriteLine("Combination6: " & JsonStringify(Combination6, Pretty:=True))
        ' Combination6: [
        '     "Mango",
        '     "Melon",
        '     "Banana",
        '     [
        '         "Cucumber",
        '         "Cabbage"
        '     ]
        ' ]

        Console.WriteLine($"{Environment.NewLine}' [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:{Environment.NewLine}")

        Dim Combination7 = SpreadArray(Fruits, New Dictionary(Of String, Object) From {{"CountryCapitalsInAsia", CountryCapitalsInAsia}})
        Console.WriteLine("Combination7: " & JsonStringify(Combination7, Pretty:=True))
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

        Dim Combination8 = SpreadArray(Fruits, New Dictionary(Of String, Object) From {{"CountryCapitalsInEurope", New Dictionary(Of String, Object) From {{"Germany", "Berlin"}, {"Italy", "Rome"}}}})
        Console.WriteLine("Combination8: " & JsonStringify(Combination8, Pretty:=True))
        ' Combination8: [
        '     "Mango",
        '     "Melon",
        '     "Banana",
        '     {
        '         "Germany": "Berlin",
        '         "Italy": "Rome"
        '     }
        ' ]

        Console.WriteLine($"{Environment.NewLine}' {{ ...object1, object2 }} || {{ ...object1, objectKey: objectValue }}:{Environment.NewLine}")

        Dim Combination9 = SpreadObject(CountryCapitalsInAsia, New Dictionary(Of String, Object) From {{"CountryCapitalsInEurope", CountryCapitalsInEurope}})
        Console.WriteLine("Combination9: " & JsonStringify(Combination9, Pretty:=True))
        ' Combination9: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "CountryCapitalsInEurope": {
        '         "France": "Paris",
        '         "England": "London"
        '     }
        ' }

        Dim Combination10 = SpreadObject(CountryCapitalsInAsia, New Dictionary(Of String, Object) From {{"CountryCapitalsInEurope", New Dictionary(Of String, Object) From {{"Germany", "Berlin"}, {"Italy", "Rome"}}}})
        Console.WriteLine("Combination10: " & JsonStringify(Combination10, Pretty:=True))
        ' Combination10: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "CountryCapitalsInEurope": {
        '         "Germany": "Berlin",
        '         "Italy": "Rome"
        '     }
        ' }

        Console.WriteLine($"{Environment.NewLine}' {{ ...object1, array2 }} || {{ ...object1, objectKey: objectValue }}:{Environment.NewLine}")

        Dim Combination11 = SpreadObject(CountryCapitalsInAsia, New Dictionary(Of String, Object) From {{"Vegetables", Vegetables}})
        Console.WriteLine("Combination11: " & JsonStringify(Combination11, Pretty:=True))
        ' Combination11: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "Vegetables": [
        '         "Carrot",
        '         "Tomato"
        '     ]
        ' }

        Dim Combination12 = SpreadObject(CountryCapitalsInAsia, New Dictionary(Of String, Object) From {{"Vegetables", New List(Of Object) From {"Cucumber", "Cabbage"}}})
        Console.WriteLine("Combination12: " & JsonStringify(Combination12, Pretty:=True))
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

        Dim Combination13 = SpreadObject(CountryCapitalsInAsia, Vegetables)
        Console.WriteLine("Combination13: " & JsonStringify(Combination13, Pretty:=True))
        ' Combination13: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "0": "Carrot",
        '     "1": "Tomato"
        ' }

        Dim Combination14 = SpreadObject(CountryCapitalsInAsia, New List(Of Object) From {"Cucumber", "Cabbage"})
        Console.WriteLine("Combination14: " & JsonStringify(Combination14, Pretty:=True))
        ' Combination14: {
        '     "Thailand": "Bangkok",
        '     "China": "Beijing",
        '     "Japan": "Tokyo",
        '     "0": "Cucumber",
        '     "1": "Cabbage"
        ' }

        ' Console.WriteLine($"{Environment.NewLine}' [...array1, ...object1]: ` this combination throw an error in JavaScript:{Environment.NewLine}")

        ' this combination throw an error in JavaScript
        ' Dim CombinationErrorInJavascript1 = SpreadArray(Fruits, CountryCapitalsInAsia)
        ' Console.WriteLine("CombinationErrorInJavascript1: " & JsonStringify(CombinationErrorInJavascript1, Pretty:=True))

        ' this combination throw an error in JavaScript
        ' Dim CombinationErrorInJavascript2 = SpreadArray(Fruits, New Dictionary(Of String, Object) From {{"Germany", "Berlin"}, {"Italy", "Rome"}})
        ' Console.WriteLine("CombinationErrorInJavascript2: " & JsonStringify(CombinationErrorInJavascript2, Pretty:=True))
    End Sub
End Module
