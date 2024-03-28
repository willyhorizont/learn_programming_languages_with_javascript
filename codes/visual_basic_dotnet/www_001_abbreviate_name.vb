Imports System.Collections.Generic ' Dictionary, KeyValuePair

' Source:
'     https://www.codewars.com/kata/57eadb7ecd143f4c9c0000a3
' Title:
'     Abbreviate a Two Word Name
' Description:
'     Write a function to convert a name into initials. This kata strictly takes two words with one space in between them.
'     The output should be two capital letters with a dot separating them.
'     It should look like this:
'     Sam Harris => S.H
'     patrick feeney => P.F

Module Program
    Function AbbreviateNameV1(ByVal CompleteName As String) As String
        Return Join(CompleteName.Split(" ").Select(Function(ByVal AName As String) AName(0).ToString().ToUpper()).ToArray(), ".")
    End Function

    Sub Main(Args As String())
        Console.WriteLine(AbbreviateNameV1("Sam Harris"))
        ' S.H
        Console.WriteLine(AbbreviateNameV1("patrick feeney"))
        ' P.F

        Dim AbbreviateNameV2 = Function(ByVal CompleteName As String) Join(CompleteName.Split(" ").Select(Function(ByVal AName As String) AName(0).ToString().ToUpper()).ToArray(), ".")
        Console.WriteLine(AbbreviateNameV2("Sam Harris"))
        ' S.H
        Console.WriteLine(AbbreviateNameV2("patrick feeney"))
        ' P.F
    End Sub
End Module
