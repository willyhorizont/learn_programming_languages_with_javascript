print("\n// Custom Error and Error Handling in Swift")

enum GenericException: Error {
    case genericError(String)
}

func giveMeRespect(_ argument: String) throws -> String {
    if (argument != "respect") {
        // Custom Error
        throw GenericException.genericError("You should give me \"respect\"!")
    }
    return "Thank you for giving me \"respect\"!"
}

// Error Handling
do {
    let response = try giveMeRespect("boo!")
    print(response)
} catch GenericException.genericError(let errorMessage) {
    print(errorMessage)
}
print("I'm sorry!")
