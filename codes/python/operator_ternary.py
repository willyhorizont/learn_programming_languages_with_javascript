print('\n# Ternary Operator in Python')

CORRECT_ANSWER = 'foo'
print(f'correct answer: "{CORRECT_ANSWER}"')

my_answer = 'hello'
print(f'my answer: "{my_answer}"')
is_my_answer_correct = 'congrats!' if my_answer == CORRECT_ANSWER else 'wrong answer!'
print(f'result: {is_my_answer_correct}')
# result: wrong answer!

my_answer = 'foo'
print(f'my answer: "{my_answer}"')
is_my_answer_correct = 'congrats!' if my_answer == CORRECT_ANSWER else 'wrong answer!'
print(f'result: {is_my_answer_correct}')
# result: congrats!
