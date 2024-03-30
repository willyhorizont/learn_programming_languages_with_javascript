print("\n# Ternary Operator in Raku", "\n");

constant $CORRECT_ANSWER = "foo";
print("correct answer: \"{$CORRECT_ANSWER}\"", "\n");

my $my-answer;

$my-answer = "bar";
print("my answer: \"{$my-answer}\"", "\n");
print("is my answer correct: ", (($my-answer === $CORRECT_ANSWER) ?? "correct!" !! "wrong!"), "\n");
# is my answer correct: wrong!

$my-answer = "foo";
print("my answer: \"{$my-answer}\"", "\n");
print("is my answer correct: ", (($my-answer === $CORRECT_ANSWER) ?? "correct!" !! "wrong!"), "\n");
# is my answer correct: correct!
