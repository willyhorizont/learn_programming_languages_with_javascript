(*
Source:
    https://www.codewars.com/kata/54ff3102c1bad923760001f3
Title:
    Vowel Count
Description:
    Return the number (count) of vowels in the given string.
    We will consider a, e, i, o, u as vowels for this Kata (but not y).
    The input string will only consist of lower case letters and/or spaces.
*)

CountVowelsV1 = (Module[{AString = #}, Fold[(Module[{CurrentResult = #1, ACharacter = #2}, If[MemberQ[{"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}, ACharacter], (CurrentResult + 1), CurrentResult]] &), 0, Characters[AString]]] &);
Print[CountVowelsV1["Hello World"]]; (* 3 *)

CountVowelsV2 = (Module[{AString = #}, Fold[(Module[{CurrentResult = #1, ACharacter = #2}, If[MemberQ[{"A", "I", "U", "E", "O"}, ToUpperCase[ACharacter]], (CurrentResult + 1), CurrentResult]] &), 0, Characters[AString]]] &);
Print[CountVowelsV2["Hello World"]]; (* 3 *)

CountVowelsV3 = (Module[{AString = #}, Fold[(Module[{CurrentResult = #1, ACharacter = #2}, If[StringContainsQ["aiueoAIUEO", ACharacter], (CurrentResult + 1), CurrentResult]] &), 0, Characters[AString]]] &);
Print[CountVowelsV3["Hello World"]]; (* 3 *)

CountVowelsV4 = (Module[{AString = #}, Fold[(Module[{CurrentResult = #1, ACharacter = #2}, If[StringContainsQ["AIUEO", ToUpperCase[ACharacter]], (CurrentResult + 1), CurrentResult]] &), 0, Characters[AString]]] &);
Print[CountVowelsV4["Hello World"]]; (* 3 *)

CountVowelsV5 = (Module[{AString = #}, Length[Select[Characters[AString], (Module[{ACharacter = #1}, MemberQ[{"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}, ACharacter]] &)]]] &);
Print[CountVowelsV5["Hello World"]]; (* 3 *)

CountVowelsV6 = (Module[{AString = #}, Length[Select[Characters[AString], (Module[{ACharacter = #1}, MemberQ[{"A", "I", "U", "E", "O"}, ToUpperCase[ACharacter]]] &)]]] &);
Print[CountVowelsV6["Hello World"]]; (* 3 *)

CountVowelsV7 = (Module[{AString = #}, Length[Select[Characters[AString], (Module[{ACharacter = #1}, StringContainsQ["aiueoAIUEO", ACharacter]] &)]]] &);
Print[CountVowelsV7["Hello World"]]; (* 3 *)

CountVowelsV8 = (Module[{AString = #}, Length[Select[Characters[AString], (Module[{ACharacter = #1}, StringContainsQ["AIUEO", ToUpperCase[ACharacter]]] &)]]] &);
Print[CountVowelsV8["Hello World"]]; (* 3 *)

CountVowelsV9 = (Module[{AString = #}, Length[Cases[Characters[AString], _?(Module[{ACharacter = #1}, MemberQ[{"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}, ACharacter]] &)]]] &);
Print[CountVowelsV9["Hello World"]]; (* 3 *)

CountVowelsV10 = (Module[{AString = #}, Length[Cases[Characters[AString], _?(Module[{ACharacter = #1}, MemberQ[{"A", "I", "U", "E", "O"}, ToUpperCase[ACharacter]]] &)]]] &);
Print[CountVowelsV10["Hello World"]]; (* 3 *)

CountVowelsV11 = (Module[{AString = #}, Length[Cases[Characters[AString], _?(Module[{ACharacter = #1}, StringContainsQ["aiueoAIUEO", ACharacter]] &)]]] &);
Print[CountVowelsV11["Hello World"]]; (* 3 *)

CountVowelsV12 = (Module[{AString = #}, Length[Cases[Characters[AString], _?(Module[{ACharacter = #1}, StringContainsQ["AIUEO", ToUpperCase[ACharacter]]] &)]]] &);
Print[CountVowelsV12["Hello World"]]; (* 3 *)
