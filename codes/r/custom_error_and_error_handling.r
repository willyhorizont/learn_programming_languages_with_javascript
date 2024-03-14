cat("\n# Custom Error and Error Handling in R\n")

giveMeRespect <- function(parameter) {
    # Custom Error
    if (parameter != 0) stop("You should give me \"respect\"!")
    return("Thank you for giving me \"respect\"!")
}

# Error Handling
tryCatch(
    expr = {
        response <- giveMeRespect("boo!")
        cat(paste(sep = "", response, "\n"))
    },
    error = function(anError) {
        cat(paste(sep = "", anError))
    }
)
cat(paste(sep = "", "I'm sorry!", "\n"))

# Without Error Handling
response <- giveMeRespect("boo!")
# this will never executed
cat(paste(sep = "", response, "\n"))
cat(paste(sep = "", "I'm sorry!", "\n"))
