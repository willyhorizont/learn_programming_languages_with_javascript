println("\n# Custom Error and Error Handling in Julia")

function give_me_respect(argument::String)
    # Custom Error
    if (argument != "respect") throw(ErrorException("Exception: You should give me \"respect\"!")) end
    return "Thank you for giving me \"respect\"!"
end

# Error Handling
try
    response_1::Any = give_me_respect("boo!")
    println(response_1)
catch an_exception
    println(an_exception.msg)
end
println("I'm so sorry!")

# Without Error Handling
response_2::Any = give_me_respect("boo!")
# this will never executed
println(response_2)
println("I'm so sorry!")
