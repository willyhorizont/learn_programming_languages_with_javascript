print("\n# Custom Error and Error Handling in Python")


def give_me_respect(argument):
    if (argument != "respect"):
        # Custom Error
        raise Exception('Exception: You should give me "respect"!')
    return 'Thank you for giving me "respect"!'


# Error Handling
try:
    response = give_me_respect("boo!")
    print(response)
except Exception as any_exception:
    print(str(any_exception))
print("I'm sorry!")

# Without Error Handling
response = give_me_respect("boo!")
# this will never executed
print(response)
print("I'm sorry!")
