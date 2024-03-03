<?php

echo("\n\n# Ternary Operator in PHP");

$CORRECT_ANSWER = 'foo';
echo("\ncorrect answer: \"$CORRECT_ANSWER\"");

$my_answer = 'bar';
echo("\nmy answer: \"$my_answer\"");
echo("\nis my answer correct: " . (($my_answer == $CORRECT_ANSWER) ? 'correct!' : 'wrong!'));
# is my answer correct: wrong!

$my_answer = 'foo';
echo("\nmy answer: \"$my_answer\"");
echo("\nis my answer correct: " . (($my_answer == $CORRECT_ANSWER) ? 'correct!' : 'wrong!'));
# is my answer correct: correct!
