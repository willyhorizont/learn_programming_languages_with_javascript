print("Variables and Scopes in Python")

# global scope

yyy = "global_scope, 1"
print(f"yyy: {yyy}")  # yyy: global_scope, 1

# local scope


@lambda _: _()
def _():
    yyy = "local_scope, 1"
    aaa = "local_scope, 2"
    print(f"yyy: {yyy}")  # yyy: local_scope, 1
    print(f"aaa: {aaa}")  # aaa: local_scope, 2


# print(f"aaa: {aaa}")  # "aaa" is not defined
print(f"yyy: {yyy}")  # yyy: global_scope, 1

yyy = "global_scope, 1"
# local scope, can access global variables but to modify them need to use "global" keyword


@lambda _: _()
def _():
    global yyy
    yyy = "local_scope, 1"
    aaa = "local_scope, 2"
    print(f"yyy: {yyy}")  # yyy: local_scope, 1
    print(f"aaa: {aaa}")  # aaa: local_scope, 2


# print(f"aaa: {aaa}")  # "aaa" is not defined
print(f"yyy: {yyy}")  # yyy: local_scope, 1

yyy = "global_scope, 1"
# local scope, can access variables from enclosing (outer) function but to modify them need to use "nonlocal" keyword


@lambda _: _()
def _():
    yyy = "local_scope outer, 1"
    aaa = "local_scope outer, 2"
    print(f"yyy: {yyy}")  # yyy: local_scope outer, 1
    print(f"aaa: {aaa}")  # aaa: local_scope outer, 2


    @lambda _: _()
    def _():
        nonlocal yyy
        yyy = "local_scope inner, 10"
        aaa = "local_scope inner, 20"
        print(f"yyy: {yyy}")  # yyy: local_scope inner, 10
        print(f"aaa: {aaa}")  # aaa: local_scope inner, 20
    

    print(f"yyy: {yyy}")  # yyy: local_scope inner, 10
    print(f"aaa: {aaa}")  # aaa: local_scope outer, 2


# print(f"aaa: {aaa}")  # "aaa" is not defined
print(f"yyy: {yyy}")  # yyy: global_scope, 1

yyy = "global_scope, 1"
