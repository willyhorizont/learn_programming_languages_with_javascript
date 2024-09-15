println("\n// Custom Error and Error Handling in Scala")

def giveMeRespect(argument: String): String = {
    // Custom Error
    if (argument != "respect") throw new Exception("Exception: You should give me \"respect\"!")
    return "Thank you for giving me \"respect\"!"
}

var response: String = null

// Error Handling
try {
    response = giveMeRespect("boo!")
    println(response)
} catch {
    case anException: Exception => {
        println(anException.getMessage)
    }
}
println("I'm sorry!")

// Without Error Handling
response = giveMeRespect("boo!")
// this will never executed
println(response)
println("I'm sorry!")
