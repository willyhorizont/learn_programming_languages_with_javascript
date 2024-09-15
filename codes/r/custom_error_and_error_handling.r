cat("\n# Custom Error and Error Handling in R\n")

give_me_respect <- function(argument) {
    # Custom Error
    if (argument != 0) stop("Error: You should give me \"respect\"!")
    return("Thank you for giving me \"respect\"!")
}

# Error Handling
tryCatch(
    expr = {
        response <- give_me_respect("boo!")
        cat(paste(sep = "", response, "\n"))
    },
    error = function(an_error) {
        cat(paste(sep = "", conditionMessage(an_error), "\n"))
    }
)
cat(paste(sep = "", "I'm sorry!", "\n"))

# Without Error Handling
response <- give_me_respect("boo!")
# this will never executed
cat(paste(sep = "", response, "\n"))
cat(paste(sep = "", "I'm sorry!", "\n"))
