JsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]] &);

SPrint = (Module[{AParameters = {##}}, Print[StringJoin[MapIndexed[(Module[{ArrayItem = #1, ArrayItemIndex = #2[[1]]}, If[((ArrayQ[ArrayItem] == True) && Length[ArrayItem] == 1), JsonStringify[ArrayItem[[1]]], If[(StringQ[ArrayItem] == True), ArrayItem, ""]]] &), AParameters]]]] &);

Print["\n(* JavaScript-like Array.includes() in Wolfram *)"];

MyFriends = {"Alisa", "Trivia"};
SPrint["MyFriends: ", {MyFriends}];

Print["(* using Wolfram Array.includes() built-in function \"MemberQ[]\" *)"];

AName = "Alisa";
IsMyFriend = MemberQ[MyFriends, AName];
Print["is my friends includes ", JsonStringify[AName], ": ", JsonStringify[IsMyFriend]];
(* is my friends includes "Alisa": true *)

AName = "Trivia";
IsMyFriend = MemberQ[MyFriends, AName];
Print["is my friends includes ", JsonStringify[AName], ": ", JsonStringify[IsMyFriend]];
(* is my friends includes "Trivia": true *)

AName = "Tony";
IsMyFriend = MemberQ[MyFriends, AName];
Print["is my friends includes ", JsonStringify[AName], ": ", JsonStringify[IsMyFriend]];
(* is my friends includes "Tony": false *)

AName = "Ezekiel";
IsMyFriend = MemberQ[MyFriends, AName];
Print["is my friends includes ", JsonStringify[AName], ": ", JsonStringify[IsMyFriend]];
(* is my friends includes "Ezekiel": false *)
