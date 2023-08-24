use strict;
use warnings;
use JSON;

print("\n# Ternary Operator in Perl\n");

my $CORRECT_ANSWER = "foo";
print("correct answer: \"$CORRECT_ANSWER\"\n");

my $my_answer;
my $is_my_answer_correct;

$my_answer = 'hello';
print("my answer: \"$my_answer\"\n");
$is_my_answer_correct = $my_answer eq $CORRECT_ANSWER ? "congrats!" : "wrong answer!";
print("result: $is_my_answer_correct\n");
# result: wrong answer!

$my_answer = 'foo';
print("my answer: \"$my_answer\"\n");
$is_my_answer_correct = $my_answer eq $CORRECT_ANSWER ? "congrats!" : "wrong answer!";
print("result: $is_my_answer_correct\n");
# result: congrats!
