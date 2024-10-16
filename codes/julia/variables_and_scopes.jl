println("\n# Variables and Scopes in Python")

# global scope

xxx::Any = "global_scope, 1"
println("xxx: $(xxx)")  # xxx: global_scope, 1

# local scope: function scope, loop scope (for, while)

# local scope loop scope for

for i in (1:1:1) # (start:step:stop)
    local xxx::Any = "local_scope_loop_scope for, 10"
    local aaa::Any = "local_scope_loop_scope for, 20"
    println("xxx: $(xxx)")  # xxx: local_scope_loop_scope for, 10
    println("aaa: $(aaa)")  # aaa: local_scope_loop_scope for, 20
    break
end

# println("aaa: $(aaa)")  # "aaa" is not defined
println("xxx: $(xxx)")  # xxx: global_scope, 1

xxx::Any = "global_scope, 1"
# local scope, can access global variables but to modify them need to use "global" keyword

for i in (1:1:1) # (start:step:stop)
    global xxx::Any = "local_scope_loop_scope for, 10"
    local aaa::Any = "local_scope_loop_scope for, 20"
    println("xxx: $(xxx)")  # xxx: local_scope_loop_scope for, 10
    println("aaa: $(aaa)")  # aaa: local_scope_loop_scope for, 20
    break
end

# println("aaa: $(aaa)")  # "aaa" is not defined
println("xxx: $(xxx)")  # xxx: local_scope_loop_scope for, 10

xxx::Any = "global_scope, 1"

# local scope loop scope while

while (true)
    local xxx::Any = "local_scope_loop_scope while, 10"
    local aaa::Any = "local_scope_loop_scope while, 20"
    println("xxx: $(xxx)")  # xxx: local_scope_loop_scope while, 10
    println("aaa: $(aaa)")  # aaa: local_scope_loop_scope while, 20
    break
end

# println("aaa: $(aaa)")  # "aaa" is not defined
println("xxx: $(xxx)")  # xxx: global_scope, 1

xxx::Any = "global_scope, 1"
# local scope, can access global variables but to modify them need to use "global" keyword

while (true)
    global xxx::Any = "local_scope_loop_scope while, 10"
    local aaa::Any = "local_scope_loop_scope while, 20"
    println("xxx: $(xxx)")  # xxx: local_scope_loop_scope while, 10
    println("aaa: $(aaa)")  # aaa: local_scope_loop_scope while, 20
    break
end

# println("aaa: $(aaa)")  # "aaa" is not defined
println("xxx: $(xxx)")  # xxx: local_scope_loop_scope while, 10

xxx::Any = "global_scope, 1"

# local scope function scope

(function ()
    xxx::Any = "local_scope_function_scope, 100"
    local aaa::Any = "local_scope_function_scope, 200"
    println("xxx: $(xxx)")  # xxx: local_scope_function_scope, 100
    println("aaa: $(aaa)")  # aaa: local_scope_function_scope, 200
end)()

# println("aaa: $(aaa)")  # "aaa" is not defined
println("xxx: $(xxx)")  # xxx: global_scope, 1

xxx::Any = "global_scope, 1"
# local scope, can access global variables but to modify them need to use "global" keyword

(function ()
    global xxx = "local_scope_function_scope, 100"
    local aaa::Any = "local_scope_function_scope, 200"
    println("xxx: $(xxx)")  # xxx: local_scope_function_scope, 100
    println("aaa: $(aaa)")  # aaa: local_scope_function_scope, 200
end)()

# println("aaa: $(aaa)")  # "aaa" is not defined
println("xxx: $(xxx)")  # xxx: local_scope_function_scope, 100

xxx::Any = "global_scope, 1"
