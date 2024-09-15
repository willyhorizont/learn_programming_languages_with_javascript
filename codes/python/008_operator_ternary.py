print("\n# Ternary Operator in Python")

CORRECT_ANSWER = 'foo'
print(f'correct answer: "{CORRECT_ANSWER}"')

my_answer = 'bar'
print(f'my answer: "{my_answer}"')
print(f'is my answer correct: {"correct!" if (my_answer == CORRECT_ANSWER) else "wrong!"}')
# is my answer correct: wrong!

my_answer = 'foo'
print(f'my answer: "{my_answer}"')
print(f'is my answer correct: {"correct!" if (my_answer == CORRECT_ANSWER) else "wrong!"}')
# is my answer correct: correct!
