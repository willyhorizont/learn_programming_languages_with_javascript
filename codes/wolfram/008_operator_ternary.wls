Print["\n(* Ternary Operator in Wolfram *)"];

CORRECTANSWER = "foo";
Print["correct answer: ", CORRECTANSWER];

Print["(* using Wolfram built-in function \"If[]\" *)"];

MyAnswer = "bar";
Print["my answer: ", MyAnswer];
Print["is my answer correct: ", If[(MyAnswer == CORRECTANSWER), "correct!", "wrong!"]];
(* is my answer correct: wrong! *)

MyAnswer = "foo";
Print["my answer: ", MyAnswer];
Print["is my answer correct: ", If[(MyAnswer == CORRECTANSWER), "correct!", "wrong!"]];
(* is my answer correct: correct! *)
