println("\n# Custom Error and Error Handling in Julia")

function give_me_respect(parameter::String)
    # Custom Error
    if (parameter != "respect") throw(ErrorException("Exception: You should give me \"respect\"!")) end
    return "Thank you for giving me \"respect\"!"
end

# Error Handling
try
    response = give_me_respect("boo!")
    println(response)
catch an_exception
    println(an_exception.msg)
end
println("I'm so sorry!")

# Without Error Handling
response = give_me_respect("boo!")
# this will never executed
println(response)
println("I'm so sorry!")
