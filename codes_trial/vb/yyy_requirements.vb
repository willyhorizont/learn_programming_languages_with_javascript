Imports System.Collections.Generic ' Dictionary, KeyValuePair

Module Program
    Function PrettyJsonStringify(ByVal Anything As Object, Optional ByVal Indent As String = "    ") As String
        Dim IndentLevel As Integer = 0
        Dim PrettyJsonStringifyInner As Func(Of Object, String, String) = Function(ByVal AnythingInner As Object, ByVal IndentInner As String)
            If IsNothing(AnythingInner) Then
                Return "undefined"
            End If
            If TypeOf AnythingInner Is String AndAlso AnythingInner = "null" Then
                Return "null"
            End If
            If TypeOf AnythingInner Is String AndAlso AnythingInner = "undefined" Then
                Return "undefined"
            End If
            If TypeOf AnythingInner Is String Then
                Return """" & AnythingInner & """"
            End If
            If IsNumeric(AnythingInner) OrElse TypeOf AnythingInner Is Boolean Then
                Return CStr(AnythingInner)
            End If
            If TypeOf AnythingInner Is Object() Then
                IndentLevel += 1
                Dim Result As String = "[" & Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel))
                Dim ArrayItemIndex As Integer = 0
                For Each ArrayItem As Object In AnythingInner
                    Result &= PrettyJsonStringifyInner(ArrayItem, IndentInner)
                    If ((ArrayItemIndex + 1) <> AnythingInner.Length) Then
                        Result &= "," & Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel))
                    End If
                    ArrayItemIndex += 1
                Next
                IndentLevel -= 1
                Result &= Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel)) & "]"
                Return Result
            End If
            If TypeOf AnythingInner Is Dictionary(Of String, Object) Then
                IndentLevel += 1
                Dim Result As String = "{" & Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel))
                Dim IterationIndex As Integer = 0
                For Each objectEntry As KeyValuePair(Of String, Object) In AnythingInner
                    Dim ObjectKey = objectEntry.Key
                    Dim ObjectValue = objectEntry.Value
                    Result &= """" & ObjectKey & """: " & PrettyJsonStringifyInner(ObjectValue, IndentInner)
                    If ((IterationIndex + 1) <> AnythingInner.Count) Then
                        Result &= "," & Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel))
                    End If
                    IterationIndex += 1
                Next
                IndentLevel -= 1
                Result &= Environment.NewLine & String.Concat(Enumerable.Repeat(IndentInner, IndentLevel)) & "}"
                Return Result
            End If
            Return "undefined"
        End Function
        Return PrettyJsonStringifyInner(Anything, Indent)
    End Function
    Sub Main(args As String())
        ' 1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
        ' ```javascript
        ' let something = 123;
        ' console.log("something:", something);
        ' something = "foo";
        ' console.log("something:", something);
        ' something = true;
        ' console.log("something:", something);
        ' something = null;
        ' console.log("something:", something);
        ' something = [1, 2, 3];
        ' console.log("something:", something);
        ' something = { "foo": "bar" };
        ' console.log("something:", something);
        ' ```
        ' 
        ' ```go
        ' type Any interface{}
        ' ```
        Dim Something As Object = 123
        Console.WriteLine("Something: " & PrettyJsonStringify(Something))
        Something = "foo"
        Console.WriteLine("Something: " & PrettyJsonStringify(Something))
        Something = True
        Console.WriteLine("Something: " & PrettyJsonStringify(Something))
        Something = Nothing
        Console.WriteLine("Something: " & PrettyJsonStringify(Something))
        Something = New Object() {1, 2, 3}
        Console.WriteLine("Something: " & PrettyJsonStringify(Something))
        Something = New Dictionary(Of String, Object) From {{"foo", "bar"}}
        Console.WriteLine("Something: " & PrettyJsonStringify(Something))

        ' 2. it's possible to access and modify variables defined outside of the current scope within nested functions
        ' ```javascript
        ' function getModifiedIndentLevel() {
        '     let indentLevel = 0;
        '     function changeIndentLevel() {
        '         indentLevel += 1;
        '         if (indentLevel < 5) changeIndentLevel();
        '         return indentLevel;
        '     }
        '     return changeIndentLevel();
        ' }
        ' console.log("getModifiedIndentLevel():", getModifiedIndentLevel());
        ' ```
        Dim GetModifiedIndentLevel As Func(Of Integer) = Function()
            Dim IndentLevel As Integer = 0
            Dim ChangeIndentLevel As Func(Of Integer) = Function()
                IndentLevel += 1
                If (IndentLevel < 5) Then
                    ChangeIndentLevel()
                End If
                Return IndentLevel
            End Function
            Return ChangeIndentLevel()
        End Function
        Console.WriteLine("GetModifiedIndentLevel: " & GetModifiedIndentLevel())

        ' 3. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
        ' ```javascript
        ' const myObject = {
        '     "my_string": "foo",
        '     "my_number": 123,
        '     "my_bool": true,
        '     "my_null": null,
        '     "my_object": {
        '         "foo": "bar"
        '     },
        '     "my_array": [1, 2, 3],
        ' }
        ' ```
        Dim MyObject As Object = New Dictionary(Of String, Object) From {
            {"my_string", "foo"},
            {"my_number", 123},
            {"my_bool", true},
            {"my_null", Nothing},
            {"my_object", New Dictionary(Of String, Object) From {
                    {"foo", "bar"}
                }
            },
            {"my_array", New Object() {1, 2, 3}}
        }
        Console.WriteLine("MyObject: " & PrettyJsonStringify(MyObject))

        ' 4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
        ' ```javascript
        ' const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
        ' console.log("myArray:", myArray);
        ' ```
        Dim MyArray As Object = New Object() {"foo", 123, true, Nothing, New Object() {1, 2, 3}, New Dictionary(Of String, Object) From {{"foo", "bar"}}}
        Console.WriteLine("MyArray: " & PrettyJsonStringify(MyArray))

        ' 5. support passing functions as arguments to other functions
        ' ```javascript
        ' function sayHello(callbackFunction) {
        '     console.log("hello");
        '     callbackFunction();
        ' }
        ' function sayHowAreYou() {
        '     console.log("how are you?");
        ' }
        ' sayHello(sayHowAreYou);
        ' sayHello(function () {
        '     console.log("how are you?");
        ' });
        ' ```
        Dim SayHello As Action(Of Action) = Sub(CallbackFunction)
            Console.WriteLine("hello")
            CallbackFunction()
        End Sub
        Dim SayHowAreYou As Action = Sub() Console.WriteLine("how are you?")
        SayHello(SayHowAreYou)
        SayHello(Sub() Console.WriteLine("how are you?"))

        ' 6. support returning functions as values from other functions
        ' ```javascript
        ' function multiply(a) {
        '     return function (b) {
        '         return a * b;
        '     };
        ' }
        ' const multiplyBy2 = multiply(2);
        ' const multiplyBy2Result = multiplyBy2(10); // 20
        ' console.log("multiplyBy2Result:", multiplyBy2Result);
        ' ```
        Dim Multiply As Func(Of Integer, Func(Of Integer, Integer)) = Function(ByVal a)
            Return Function(ByVal b)
                Return a * b
            End Function
        End Function
        Dim MultiplyBy2 = Multiply(2)
        Dim MultiplyBy2Result = MultiplyBy2(10)
        Console.WriteLine("MultiplyBy2Result: " & MultiplyBy2Result)

        ' 7. support assigning functions to variables
        ' ```javascript
        ' const getRectangleArea = function (rectangleWidth, rectangleLength) {
        '     return rectangleWidth * rectangleLength;
        ' };
        ' console.log("getRectangleArea(7, 5):", getRectangleArea(7, 5));;
        ' ```
        Dim GetRectangleArea = Function(ByVal RectangleWidth As Integer, ByVal RectangleLength As Integer) As Integer
            Return RectangleWidth * RectangleLength
        End Function
        Console.WriteLine("GetRectangleArea(7, 5): " & GetRectangleArea(7, 5))

        ' 8. support storing functions in data structures like array/list/slice/ordered-list-data-structure or object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure
        ' ```javascript
        ' const myArray2 = [
        '     function (rectangleWidth, rectangleLength) {
        '         return rectangleWidth * rectangleLength;
        '     },
        '     "foo",
        '     123,
        '     true,
        '     null
        '     [1, 2, 3],
        '     { "foo": "bar" },
        ' ];
        ' console.log("myArray2[0](7, 5):", myArray2[0](7, 5));

        ' const myObject2 = {
        '     "my_function": function (a, b) {
        '         return a * b;
        '     },
        '     "my_string": "foo",
        '     "my_number": 123,
        '     "my_bool": true,
        '     "my_null": null,
        '     "my_object": {
        '         "foo": "bar"
        '     },
        '     "my_array": [1, 2, 3],
        ' }
        ' console.log("myObject2.my_function(7, 5):", myObject2.my_function(7, 5));
        ' ```
        ' Dim MyArray2 = New Object() {"foo", 123, true, Nothing, New Object() {1, 2, 3}, New Dictionary(Of String, Object) From {{"foo", "bar"}}}
        Dim MyArray2 = New Object() {
            DirectCast(Function(ByVal a As Integer, ByVal b As Integer) a * b, Func(Of Integer, Integer, Integer)),
            "foo",
            123,
            True,
            Nothing,
            New Object() {1, 2, 3},
            New Dictionary(Of String, Object) From {{"foo", "bar"}}
        }
        Console.WriteLine("myArray2[0](7, 5): " & DirectCast(MyArray2(0), Func(Of Integer, Integer, Integer))(7, 5))
        Dim MyObject2 As Object = New Dictionary(Of String, Object) From {
            {"my_function", DirectCast(Function(ByVal a As Integer, ByVal b As Integer) a * b, Func(Of Integer, Integer, Integer))},
            {"my_string", "foo"},
            {"my_number", 123},
            {"my_bool", true},
            {"my_null", Nothing},
            {"my_object", New Dictionary(Of String, Object) From {
                    {"foo", "bar"}
                }
            },
            {"my_array", New Object() {1, 2, 3}}
        }
        Console.WriteLine("myObject2.my_function(7, 5): " & DirectCast(MyObject2("my_function"), Func(Of Integer, Integer, Integer))(7, 5))
    End Sub
End Module
