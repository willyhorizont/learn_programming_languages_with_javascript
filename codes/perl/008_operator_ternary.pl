use strict;
use warnings;
use JSON;

print("\n# Ternary Operator in Perl\n");

my $CORRECT_ANSWER = "foo";
print("correct answer: \"$CORRECT_ANSWER\"\n");

my $my_answer;

$my_answer = "bar";
print("my answer: \"$my_answer\"\n");
print("is my answer correct: " . (($my_answer eq $CORRECT_ANSWER) ? "correct!" : "wrong!") . "\n");
# is my answer correct: wrong!

$my_answer = "foo";
print("my answer: \"$my_answer\"\n");
print("is my answer correct: " . (($my_answer eq $CORRECT_ANSWER) ? "correct!" : "wrong!") . "\n");
# is my answer correct: correct!
