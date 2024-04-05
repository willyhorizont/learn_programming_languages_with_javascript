<?php

echo("\n# Ternary Operator in PHP" . "\n");

$CORRECT_ANSWER = 'foo';
echo("correct answer: \"$CORRECT_ANSWER\"" . "\n");

$my_answer = 'bar';
echo("my answer: \"$my_answer\"" . "\n");
echo("is my answer correct: " . (($my_answer == $CORRECT_ANSWER) ? 'correct!' : 'wrong!') . "\n");
# is my answer correct: wrong!

$my_answer = 'foo';
echo("my answer: \"$my_answer\"" . "\n");
echo("is my answer correct: " . (($my_answer == $CORRECT_ANSWER) ? 'correct!' : 'wrong!') . "\n");
# is my answer correct: correct!
