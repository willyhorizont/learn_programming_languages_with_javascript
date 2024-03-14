Imports System.Collections.Generic ' Dictionary, KeyValuePair

' Source:
'     https://www.codewars.com/kata/54ff3102c1bad923760001f3
' Title:
'     Vowel Count
' Description:
'     Return the number (count) of vowels in the given string.
'     We will consider a, e, i, o, u as vowels for this Kata (but not y).
'     The input string will only consist of lower case letters and/or spaces.

Module Program
    Function CountVowelsV1(ByVal AString As String) As Integer
        Return AString.ToCharArray().Aggregate(0, Function(ByVal Result As Integer, ByVal ALetter As String) If(New List(Of Object) From {"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}.Contains(ALetter), (Result + 1), Result))
    End Function

    Function CountVowelsV2(ByVal AString As String) As Integer
        Return AString.ToCharArray().Aggregate(0, Function(ByVal Result As Integer, ByVal ALetter As String) If(New List(Of Object) From {"A", "I", "U", "E", "O"}.Contains(ALetter.ToUpper()), (Result + 1), Result))
    End Function

    Function CountVowelsV3(ByVal AString As String) As Integer
        Return AString.ToCharArray().Aggregate(0, Function(ByVal Result As Integer, ByVal ALetter As String) If("aiueoAIUEO".Contains(ALetter), (Result + 1), Result))
    End Function

    Function CountVowelsV4(ByVal AString As String) As Integer
        Return AString.ToCharArray().Aggregate(0, Function(ByVal Result As Integer, ByVal ALetter As String) If("AIUEO".Contains(ALetter.ToUpper()), (Result + 1), Result))
    End Function

    Function CountVowelsV5(ByVal AString As String) As Integer
        Return AString.ToCharArray().Where(Function(ByVal ALetter As String) New List(Of Object) From {"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}.Contains(ALetter)).ToList().Count
    End Function

    Function CountVowelsV6(ByVal AString As String) As Integer
        Return AString.ToCharArray().Where(Function(ByVal ALetter As String) New List(Of Object) From {"A", "I", "U", "E", "O"}.Contains(ALetter.ToUpper())).ToList().Count
    End Function

    Function CountVowelsV7(ByVal AString As String) As Integer
        Return AString.ToCharArray().Where(Function(ByVal ALetter As String) "aiueoAIUEO".Contains(ALetter)).ToList().Count
    End Function

    Function CountVowelsV8(ByVal AString As String) As Integer
        Return AString.ToCharArray().Where(Function(ByVal ALetter As String) "AIUEO".Contains(ALetter.ToUpper())).ToList().Count
    End Function

    Sub Main(Args As String())
        Dim CountVowelsV9 = Function(ByVal AString As String) AString.ToCharArray().Aggregate(0, Function(ByVal Result As Integer, ByVal ALetter As String) If(New List(Of Object) From {"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}.Contains(ALetter), (Result + 1), Result))
        Dim CountVowelsV10 = Function(ByVal AString As String) AString.ToCharArray().Aggregate(0, Function(ByVal Result As Integer, ByVal ALetter As String) If(New List(Of Object) From {"A", "I", "U", "E", "O"}.Contains(ALetter.ToUpper()), (Result + 1), Result))
        Dim CountVowelsV11 = Function(ByVal AString As String) AString.ToCharArray().Aggregate(0, Function(ByVal Result As Integer, ByVal ALetter As String) If("aiueoAIUEO".Contains(ALetter), (Result + 1), Result))
        Dim CountVowelsV12 = Function(ByVal AString As String) AString.ToCharArray().Aggregate(0, Function(ByVal Result As Integer, ByVal ALetter As String) If("AIUEO".Contains(ALetter.ToUpper()), (Result + 1), Result))
        Dim CountVowelsV13 = Function(ByVal AString As String) AString.ToCharArray().Where(Function(ByVal ALetter As String) New List(Of Object) From {"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}.Contains(ALetter)).ToList().Count
        Dim CountVowelsV14 = Function(ByVal AString As String) AString.ToCharArray().Where(Function(ByVal ALetter As String) New List(Of Object) From {"A", "I", "U", "E", "O"}.Contains(ALetter.ToUpper())).ToList().Count
        Dim CountVowelsV15 = Function(ByVal AString As String) AString.ToCharArray().Where(Function(ByVal ALetter As String) "aiueoAIUEO".Contains(ALetter)).ToList().Count
        Dim CountVowelsV16 = Function(ByVal AString As String) AString.ToCharArray().Where(Function(ByVal ALetter As String) "AIUEO".Contains(ALetter.ToUpper())).ToList().Count

        Console.WriteLine(CountVowelsV1("Hello World")) ' 3
        Console.WriteLine(CountVowelsV2("Hello World")) ' 3
        Console.WriteLine(CountVowelsV3("Hello World")) ' 3
        Console.WriteLine(CountVowelsV4("Hello World")) ' 3
        Console.WriteLine(CountVowelsV5("Hello World")) ' 3
        Console.WriteLine(CountVowelsV6("Hello World")) ' 3
        Console.WriteLine(CountVowelsV7("Hello World")) ' 3
        Console.WriteLine(CountVowelsV8("Hello World")) ' 3
        Console.WriteLine(CountVowelsV9("Hello World")) ' 3
        Console.WriteLine(CountVowelsV10("Hello World")) ' 3
        Console.WriteLine(CountVowelsV11("Hello World")) ' 3
        Console.WriteLine(CountVowelsV12("Hello World")) ' 3
        Console.WriteLine(CountVowelsV13("Hello World")) ' 3
        Console.WriteLine(CountVowelsV14("Hello World")) ' 3
        Console.WriteLine(CountVowelsV15("Hello World")) ' 3
        Console.WriteLine(CountVowelsV16("Hello World")) ' 3
    End Sub
End Module
