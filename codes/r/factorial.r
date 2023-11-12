cat("\n# Factorial(n) in R\n")

factorialV1 <- function(number) {
    if (is.numeric(number) == FALSE) return("argument should be a number")
    if ((number > 1) == FALSE) return(1)
    result <- 1
    i <- number
    while (TRUE) {
        result <- result * i
        i <- i - 1
        if (i <= 0) break
    }
    return(result)
}

factorialV2 <- function(number) {
    if (is.numeric(number) == FALSE) return("argument should be a number")
    if ((number > 1) == FALSE) return(1)
    result <- 1
    i <- number
    while (i >= 1) {
        result <- result * i
        i <- i - 1
    }
    return(result)
}

factorialV3 <- function(number) {
    if (is.numeric(number) == FALSE) return("argument should be a number")
    if ((number > 1) == FALSE) return(1)
    result <- 1
    for (i in seq(number, 1, by = -1)) {
        result <- result * i
    }
    return(result)
}

cat("# using factorial function \"factorialV1\"\n")
cat(paste(sep = "", "Factorial(5): ", factorialV1(5), "\n"))
# Factorial(5): 120

cat("# using factorial function \"factorialV2\"\n")
cat(paste(sep = "", "Factorial(5): ", factorialV2(5), "\n"))
# Factorial(5): 120

cat("# using factorial function \"factorialV3\"\n")
cat(paste(sep = "", "Factorial(5): ", factorialV3(5), "\n"))
# Factorial(5): 120
