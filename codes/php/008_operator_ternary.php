<?php

echo("\n\n# Ternary Operator in PHP");

$CORRECT_ANSWER = 'foo';
echo("\n" . "correct answer: \"$CORRECT_ANSWER\"");

$my_answer = 'bar';
echo("\n" . "my answer: \"$my_answer\"");
echo("\n" . "is my answer correct: " . (($my_answer == $CORRECT_ANSWER) ? 'correct!' : 'wrong!'));
# is my answer correct: wrong!

$my_answer = 'foo';
echo("\n" . "my answer: \"$my_answer\"");
echo("\n" . "is my answer correct: " . (($my_answer == $CORRECT_ANSWER) ? 'correct!' : 'wrong!'));
# is my answer correct: correct!
