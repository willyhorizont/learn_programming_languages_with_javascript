Print["\n(* Custom Error and Error Handling in Wolfram *)"];

GiveMeRespect = (Module[{AParameter = #},
    (* Custom Error *)
    If[(AParameter != "respect"), Throw["Error: You should give me \"respect\"!"]];
    Return["Thank you for giving me \"respect\"!", Module];
] &);

(* Error Handling *)
ErrorMessage = Catch[
    Response = GiveMeRespect["boo!"];
    Print[Response];
];
Print[ErrorMessage];
Print["I'm sorry!"];

(* Without Error Handling *)
Response = GiveMeRespect["boo!"];
(* this will never executed *)
Print[Response];
Print["I'm sorry!"];
