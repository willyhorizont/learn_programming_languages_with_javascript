<?php

echo("\n\n# Ternary Operator in PHP");

$CORRECT_ANSWER = 'foo';
echo("\ncorrect answer: \"$CORRECT_ANSWER\"");

$my_answer = 'hello';
echo("\nmy answer: \"$my_answer\"");
$is_my_answer_correct = $my_answer == $CORRECT_ANSWER ? 'congrats!' : 'wrong answer!';
echo("\nresult: $is_my_answer_correct");
# result: wrong answer!

$my_answer = 'foo';
echo("\nmy answer: \"$my_answer\"");
$is_my_answer_correct = $my_answer == $CORRECT_ANSWER ? 'congrats!' : 'wrong answer!';
echo("\nresult: $is_my_answer_correct");
# result: congrats!
