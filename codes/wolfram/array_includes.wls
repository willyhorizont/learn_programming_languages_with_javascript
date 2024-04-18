JsonStringify[Anything_, OptionsPattern[{"Pretty" -> False, "Indent" -> "    "}]] := Module[{Pretty, Indent},
    Pretty = OptionValue["Pretty"];
    Indent = OptionValue["Indent"];
    If[(Pretty == True),
        Return[StringReplace[StringReplace[ExportString[ImportString[ExportString[Anything, "JSON", "Indent" -> Indent], "RawJSON"], "JSON", "Compact" -> False], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "], "\t" -> Indent]],
        Return[StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]]
    ];
];

Print["\n(* JavaScript-like Array.includes() in Wolfram *)"];

MyFriends = {"Alisa", "Trivia"};
Print["MyFriends: ", JsonStringify[MyFriends]];

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
