println("\n# Custom Error and Error Handling in Julia")

function give_me_respect(argument::Any)::Any
    # Custom Error
    if (argument !== "respect") throw(ErrorException("Exception: You should give me \"respect\"!")) end
    return "Thank you for giving me \"respect\"!"
end

(() -> begin
    # Error Handling
    try
        local response::Any = give_me_respect("boo!")
        println(response)
    catch (error_exception)
        println(error_exception.msg)
    end
    println("I'm so sorry!")
end)()

(() -> begin
    # Without Error Handling
    local response::Any = give_me_respect("boo!")
    # this will never executed
    println(response)
    println("I'm so sorry!")
end)()
