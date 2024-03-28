Imports System.Collections.Generic ' Dictionary, KeyValuePair

Module Program
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


    ' ? < function statement or function declaration

    Function GetRectangleAreaV1(ByVal RectangleWidth As Integer, ByVal RectangleLength As Integer) As Integer
        Return (RectangleWidth * RectangleLength)
    End Function
    ' call the function example: GetRectangleAreaV1(7, 5)

    ' ? function statement or function declaration />


    ' ? < Returning functions as values from other functions

    Function MultiplyV1(ByVal A As Integer) As Func(Of Integer, Integer)
        Dim MultiplyBy As Func(Of Integer, Integer) = Function(ByVal B As Integer) As Integer
            Return (A * B)
        End Function
        Return MultiplyBy
    End Function

    Function MultiplyV2(ByVal A As Integer) As Func(Of Integer, Integer)
        Dim MultiplyBy As Func(Of Integer, Integer) = Function(ByVal B As Integer) (A * B)
        Return MultiplyBy
    End Function

    Function MultiplyV3(ByVal A As Integer) As Func(Of Integer, Integer)
        Return Function(ByVal B As Integer) As Integer
            Return (A * B)
        End Function
    End Function

    Function MultiplyV4(ByVal A As Integer) As Func(Of Integer, Integer)
        Return Function(ByVal B As Integer) (A * B)
    End Function

    ' ? Returning functions as values from other functions />


    Sub Main(Args As String())
        ' ? function expression

        Dim GetRectangleAreaV2 = Function(ByVal RectangleWidth As Integer, ByVal RectangleLength As Integer) As Integer
            Return (RectangleWidth * RectangleLength)
        End Function
        ' call the function example: GetRectangleAreaV2(7, 5)

        Dim GetRectangleAreaV3 = Function(ByVal RectangleWidth As Integer, ByVal RectangleLength As Integer) (RectangleWidth * RectangleLength)
        ' call the function example: GetRectangleAreaV3(7, 5)

        ' ? anonymous function

        ' Function(ByVal RectangleWidth As Integer, ByVal RectangleLength As Integer) As Integer
        '     Return (RectangleWidth * RectangleLength)
        ' End Function

        ' Function(ByVal RectangleWidth As Integer, ByVal RectangleLength As Integer) (RectangleWidth * RectangleLength)

        ' ? Passing functions as arguments to other functions

        Dim SayHello As Action(Of Action) = Sub(CallbackFunction)
            Console.WriteLine("hello")
            CallbackFunction()
        End Sub

        Dim SayHowAreYou As Action = Sub()
            Console.WriteLine("how are you?")
        End Sub

        SayHello(SayHowAreYou)

        SayHello(Sub()
            Console.WriteLine("how are you?")
        End Sub)

        SayHello(Sub() Console.WriteLine("how are you?"))

        ' ? Assigning functions to variables or storing them in data structures

        Dim GetRectangleAreaV2Copy = Function(ByVal RectangleWidth As Integer, ByVal RectangleLength As Integer) As Integer
            Return (RectangleWidth * RectangleLength)
        End Function

        Dim GetRectangleAreaV3Copy = Function(ByVal RectangleWidth As Integer, ByVal RectangleLength As Integer) (RectangleWidth * RectangleLength)

        Dim MyArrayOfGetRectangleAreaFunctions As List(Of Object) = New List(Of Object) From {
            DirectCast(Function(ByVal RectangleWidth As Integer, ByVal RectangleLength As Integer) As Integer
                Return (RectangleWidth * RectangleLength)
            End Function, Func(Of Integer, Integer, Integer)),
            DirectCast(Function(ByVal RectangleWidth As Integer, ByVal RectangleLength As Integer) (RectangleWidth * RectangleLength), Func(Of Integer, Integer, Integer))
        }
        Dim GetRectangleAreaFunctionResult1 = DirectCast(MyArrayOfGetRectangleAreaFunctions(0), Func(Of Integer, Integer, Integer))(7, 5)
        Dim GetRectangleAreaFunctionResult2 = DirectCast(MyArrayOfGetRectangleAreaFunctions(1), Func(Of Integer, Integer, Integer))(7, 5)

        Dim Exponentiation As Func(Of Integer, Integer, Integer) = Function(ByVal A As Integer, ByVal B As Integer) As Integer
            Return (a ^ B)
        End Function

        Dim SimpleCalculator As Object = New Dictionary(Of String, Object) From {
            {"Exponentiation", DirectCast(Exponentiation, Func(Of Integer, Integer, Integer))},
            {"Multiplication", DirectCast(Function(A As Integer, B As Integer) As Integer
                Return (a * B)
            End Function, Func(Of Integer, Integer, Integer))},
            {"Addition", DirectCast(Function(A As Integer, B As Integer) (a + B), Func(Of Integer, Integer, Integer))}
        }
        Dim SimpleCalculatorResult1 = DirectCast(SimpleCalculator("Exponentiation"), Func(Of Integer, Integer, Integer))(2, 4)
        Dim SimpleCalculatorResult2 = DirectCast(SimpleCalculator("Multiplication"), Func(Of Integer, Integer, Integer))(7, 5)
        Dim SimpleCalculatorResult3 = DirectCast(SimpleCalculator("Addition"), Func(Of Integer, Integer, Integer))(9, 3)

        ' ? Returning functions as values from other functions

        Dim MultiplyBy2 = MultiplyV1(2)
        Dim MultiplyBy2Result = MultiplyBy2(10) ' 20

        Dim MultiplyBy3 = MultiplyV2(3)
        Dim MultiplyBy3Result = MultiplyBy3(10) ' 30

        Dim MultiplyBy4 = MultiplyV3(4)
        Dim MultiplyBy4Result = MultiplyBy4(10) ' 40

        Dim MultiplyBy5 = MultiplyV4(5)
        Dim MultiplyBy5Result = MultiplyBy5(10) ' 50

        Dim MultiplyV5 As Func(Of Integer, Func(Of Integer, Integer)) = Function(ByVal A As Integer) As Func(Of Integer, Integer)
            Dim MultiplyBy As Func(Of Integer, Integer) = Function(ByVal B As Integer) As Integer
                Return (A * B)
            End Function
            Return MultiplyBy
        End Function
        Dim MultiplyBy6 = MultiplyV5(6)
        Dim MultiplyBy6Result = MultiplyBy6(10) ' 60

        Dim MultiplyV6 As Func(Of Integer, Func(Of Integer, Integer)) = Function(ByVal A As Integer) As Func(Of Integer, Integer)
            Dim MultiplyBy As Func(Of Integer, Integer) = Function(ByVal B As Integer) (A * B)
            Return MultiplyBy
        End Function
        Dim MultiplyBy7 = MultiplyV6(7)
        Dim MultiplyBy7Result = MultiplyBy7(10) ' 70

        Dim MultiplyV7 As Func(Of Integer, Func(Of Integer, Integer)) = Function(ByVal A As Integer) As Func(Of Integer, Integer)
            Return Function(ByVal B As Integer) As Integer
                Return (A * B)
            End Function
        End Function
        Dim MultiplyBy8 = MultiplyV7(8)
        Dim MultiplyBy8Result = MultiplyBy8(10) ' 80

        Dim MultiplyV8 As Func(Of Integer, Func(Of Integer, Integer)) = Function(ByVal A As Integer) As Func(Of Integer, Integer)
            Return Function(ByVal B As Integer) (A * B)
        End Function
        Dim MultiplyBy9 = MultiplyV8(9)
        Dim MultiplyBy9Result = MultiplyBy9(10) ' 90

        Dim MultiplyV9 As Func(Of Integer, Func(Of Integer, Integer)) = Function(ByVal A As Integer) Function(ByVal B As Integer) (A * B)
        Dim MultiplyBy10 = MultiplyV9(10)
        Dim MultiplyBy10Result = MultiplyBy10(10) ' 100
    End Sub
End Module
