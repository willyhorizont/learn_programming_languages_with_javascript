cat("\n# Factorial(n) in R\n")

factorial_v1 <- function(number) {
    if (is.numeric(number) == FALSE) stop("Argument should be a number")
    if (number < 0) stop("Argument should be >= 0")
    if (number == 0) return(1)
    result <- 1
    i <- number
    while (TRUE) {
        result <- result * i
        if (i <= 1) break
        i <- (i - 1)
    }
    return(result)
}

factorial_v2 <- function(number) {
    if (is.numeric(number) == FALSE) stop("Argument should be a number")
    if (number < 0) stop("Argument should be >= 0")
    if (number == 0) return(1)
    result <- 1
    i <- number
    while (i >= 1) {
        result <- result * i
        i <- (i - 1)
    }
    return(result)
}

factorial_v3 <- function(number) {
    if (is.numeric(number) == FALSE) stop("Argument should be a number")
    if (number < 0) stop("Argument should be >= 0")
    if (number == 0) return(1)
    result <- 1
    for (i in seq(number, 1, by = -1)) { # (start, stop, by = step)
        result <- result * i
    }
    return(result)
}

factorial_v4 <- function(number) {
    if (is.numeric(number) == FALSE) stop("Argument should be a number")
    if (number < 0) stop("Argument should be >= 0")
    if (number == 0) return(1)
    return(number * factorial_v4(number - 1))
}

cat("# using factorial function \"factorial_v1\"\n")
cat(paste(sep = "", "Factorial(5): ", factorial_v1(5), "\n"))
# Factorial(5): 120

cat("# using factorial function \"factorial_v2\"\n")
cat(paste(sep = "", "Factorial(5): ", factorial_v2(5), "\n"))
# Factorial(5): 120

cat("# using factorial function \"factorial_v3\"\n")
cat(paste(sep = "", "Factorial(5): ", factorial_v3(5), "\n"))
# Factorial(5): 120

cat("# using factorial function \"factorial_v4\"\n")
cat(paste(sep = "", "Factorial(5): ", factorial_v4(5), "\n"))
# Factorial(5): 120
