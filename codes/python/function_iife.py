print("# Immediately Invoked Function Expression (IIFE) in Python")
print("# a Self-Executing Anonymous Function that runs as soon as it is defined")
print("# https://developer.mozilla.org/en-US/docs/Glossary/IIFE")

@lambda _: _()
def _():
    print("# self-executing after defined")


(lambda : print("# self-executing after defined"))()
