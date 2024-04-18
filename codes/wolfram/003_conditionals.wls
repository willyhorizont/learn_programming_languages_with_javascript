(*
Relational Operators / Comparison Operators:
equal to (==)
not equal to (!=)
greater than (>)
less than (<)
greater than or equal to (>=)
less than or equal to (<=)

Logical Operators:
Logical AND (&&)
Logical OR (||)
Logical NOT (!)
*)

CORRECTANSWER = 100;

Print["\n(* basic conditional control flow *)\n"];

MyAge = 10;
Print["MyAge: ", MyAge];
If[(MyAge > 24),
    Print["you are old"],
    If[(MyAge > 17),
        Print["you are young"],
        Print["you are under age"];
    ];
];

Print["equal to (==) "];

MyAnswer = 100;
Print["MyAnswer: ", MyAnswer];
Print["CORRECTANSWER: ", CORRECTANSWER];
Print["(MyAnswer == CORRECTANSWER):"];
If[(MyAnswer == CORRECTANSWER),
    Print["Your answer is correct"],
    Print["Your answer is wrong"]
];

Print["not equal to (!=) "];

MyAnswer = 25;
Print["MyAnswer: ", MyAnswer];
Print["CORRECTANSWER: ", CORRECTANSWER];
Print["(MyAnswer != CORRECTANSWER):"];
If[(MyAnswer != CORRECTANSWER),
    Print["Your answer is correct"],
    Print["Your answer is wrong"]
];

Print["greater than (>) "];

MyAge = 70;
Print["MyAge: ", MyAge];
Print["(MyAge > 50):"];
If[(MyAge > 50), Print["You are old"]];

Print["less than (<) "];

MyAge = 16;
Print["MyAge: ", MyAge];
Print["(MyAge < 20):"];
If[(MyAge < 20), Print["You are young"]];

Print["greater than or equal to (>=) "];

MyAge = 73;
Print["MyAge: ", MyAge];
Print["(MyAge >= 65):"];
If[(MyAge >= 65), Print["You are allowed to retire"]];

Print["less than or equal to (<=) "];

MyAge = 14;
Print["MyAge: ", MyAge];
Print["(MyAge <= 16):"];
If[(MyAge <= 16), Print["You are not allowed to drive"]];

Print["Logical AND (&&) "];

MyAge = 17;
Print["MyAge: ", MyAge];
HasDrivingLicense = False;
Print["HasDrivingLicense: ", HasDrivingLicense];
Print["((MyAge >= 17) && (HasDrivingLicense === true)):"];
Print[If[((MyAge >= 17) && (HasDrivingLicense === True)), "You are allowed to drive", "You are not allowed to drive"]];

MyAge = 17;
Print["MyAge: ", MyAge];
HasDrivingLicense = True;
Print["HasDrivingLicense: ", HasDrivingLicense];
Print["((MyAge >= 17) && (HasDrivingLicense === true)):"];
Print[If[((MyAge >= 17) && (HasDrivingLicense === True)), "You are allowed to drive", "You are not allowed to drive"]];

Print["Logical OR (||) "];

MyAge = 2;
Print["MyAge: ", MyAge];
Print["((MyAge <= 3) || (MyAge >= 65)):"];
If[((MyAge <= 3) || (MyAge >= 65)), Print["You should stay home"]];

MyAge = 89;
Print["MyAge: ", MyAge];
Print["((MyAge <= 3) || (MyAge >= 65)):"];
If[((MyAge <= 3) || (MyAge >= 65)), Print["You should stay home"]];

Print["Logical NOT (!) "];

CanDrive = False;
Print["CanDrive: ", CanDrive];
Print["!CanDrive: ", !CanDrive];

CanDrive = True;
Print["CanDrive: ", CanDrive];
Print["!CanDrive: ", !CanDrive];
