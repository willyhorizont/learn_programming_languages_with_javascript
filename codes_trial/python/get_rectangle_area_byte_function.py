import types

# Bytecode: rectangle_width * rectangle_length
bytecode = bytes([
    124, 0,  # LOAD_FAST 0 (rectangle_width)
    124, 1,  # LOAD_FAST 1 (rectangle_length)
    20, 0,   # BINARY_MULTIPLY
    83, 0    # RETURN_VALUE
])

constants = (None,)  # no constants used
varnames = ("rectangle_width", "rectangle_length")

# Create the code object (Python 3.10 signature)
code = types.CodeType(
    2,         # co_argcount
    0,         # co_posonlyargcount
    0,         # co_kwonlyargcount
    2,         # co_nlocals
    2,         # co_stacksize
    0x43,      # co_flags (OPTIMIZED | NEWLOCALS | NOFREE)
    bytecode,  # co_code
    constants, # co_consts
    (),        # co_names
    varnames,  # co_varnames
    "<manual>",# co_filename
    "get_rectangle_area_v1",  # co_name
    1,         # co_firstlineno
    b"\x00\x01",  # co_lnotab (Python 3.10)
    (),        # co_freevars
    (),        # co_cellvars
)

# Create the function
get_rectangle_area_v1 = types.FunctionType(code, globals(), "get_rectangle_area_v1")

# Test
print(get_rectangle_area_v1(7, 5))  # Output: 50
