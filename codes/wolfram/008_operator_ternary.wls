JsonStringify = (Module[{Anything = #}, StringReplace[StringReplace[ExportString[Anything, "JSON", "Compact" -> True], RegularExpression["(?<=[a-zA-Z0-9\}\]\"])\\,(?=[a-zA-Z0-9\{\\[\"])"] -> ", "], RegularExpression["(?<=[a-zA-Z0-9\"])\\:(?=[a-zA-Z0-9\{\\[\"])"] -> ": "]] &);

SPrint = (Module[{AParameters = {##}}, Print[StringJoin[MapIndexed[(Module[{ArrayItem = #1, ArrayItemIndex = #2[[1]]}, If[((ArrayQ[ArrayItem] == True) && Length[ArrayItem] == 1), JsonStringify[ArrayItem[[1]]], If[(StringQ[ArrayItem] == True), ArrayItem, ""]]] &), AParameters]]]] &);

Print["\n(* Ternary Operator in Wolfram *)"];

CORRECTANSWER = "foo";
SPrint["correct answer: ", {CORRECTANSWER}];

Print["(* using Wolfram built-in function \"If[]\" *)"];

MyAnswer = "bar";
SPrint["my answer: ", {MyAnswer}];
SPrint["is my answer correct: ", If[(MyAnswer == CORRECTANSWER), "correct!", "wrong!"]];
(* is my answer correct: wrong! *)

MyAnswer = "foo";
SPrint["my answer: ", {MyAnswer}];
SPrint["is my answer correct: ", If[(MyAnswer == CORRECTANSWER), "correct!", "wrong!"]];
(* is my answer correct: correct! *)
