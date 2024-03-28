cat("\n# FizzBuzz(n) in R\n")

fizbuzzV1 <- function(stopNumber) {
    if (is.numeric(stopNumber) == FALSE) stop("argument should be a stopNumber")
    if (stopNumber < 1) stop("Argument should be > 0")
    result <- ""
    number <- 1
    while (TRUE) {
        if (result == "") {
            result <- paste(sep = "", number)
            if (number >= stopNumber) break
            number <- (number + 1)
            next
        }
        if (((number %% 3) == 0) && ((number %% 5) == 0)) {
            result <- paste(sep = "", result, ", FizzBuzz")
            if (number >= stopNumber) break
            number <- (number + 1)
            next
        }
        if ((number %% 3) == 0) {
            result <- paste(sep = "", result, ", Fizz")
            if (number >= stopNumber) break
            number <- (number + 1)
            next
        }
        if ((number %% 5) == 0) {
            result <- paste(sep = "", result, ", Buzz")
            if (number >= stopNumber) break
            number <- (number + 1)
            next
        }
        result <- paste(sep = "", result, ", ", number)
        if (number >= stopNumber) break
        number <- (number + 1)
    }
    return(result)
}

fizbuzzV2 <- function(stopNumber) {
    if (is.numeric(stopNumber) == FALSE) stop("argument should be a stopNumber")
    if (stopNumber < 1) stop("Argument should be > 0")
    result <- ""
    number <- 1
    while (number <= stopNumber) {
        if (result == "") {
            result <- paste(sep = "", number)
            number <- (number + 1)
            next
        }
        if (((number %% 3) == 0) && ((number %% 5) == 0)) {
            result <- paste(sep = "", result, ", FizzBuzz")
            number <- (number + 1)
            next
        }
        if ((number %% 3) == 0) {
            result <- paste(sep = "", result, ", Fizz")
            number <- (number + 1)
            next
        }
        if ((number %% 5) == 0) {
            result <- paste(sep = "", result, ", Buzz")
            number <- (number + 1)
            next
        }
        result <- paste(sep = "", result, ", ", number)
        number <- (number + 1)
    }
    return(result)
}

fizbuzzV3 <- function(stopNumber) {
    if (is.numeric(stopNumber) == FALSE) stop("argument should be a stopNumber")
    if (stopNumber < 1) stop("Argument should be > 0")
    result <- ""
    number <- 1
    while (TRUE) {
        if (result == "") {
            result <- paste(sep = "", number)
        } else if (((number %% 3) == 0) && ((number %% 5) == 0)) {
            result <- paste(sep = "", result, ", FizzBuzz")
        } else if ((number %% 3) == 0) {
            result <- paste(sep = "", result, ", Fizz")
        } else if ((number %% 5) == 0) {
            result <- paste(sep = "", result, ", Buzz")
        } else {
            result <- paste(sep = "", result, ", ", number)
        }
        if (number >= stopNumber) break
        number <- (number + 1)
    }
    return(result)
}

fizbuzzV4 <- function(stopNumber) {
    if (is.numeric(stopNumber) == FALSE) stop("argument should be a stopNumber")
    if (stopNumber < 1) stop("Argument should be > 0")
    result <- ""
    number <- 1
    while (number <= stopNumber) {
        if (result == "") {
            result <- paste(sep = "", number)
        } else if (((number %% 3) == 0) && ((number %% 5) == 0)) {
            result <- paste(sep = "", result, ", FizzBuzz")
        } else if ((number %% 3) == 0) {
            result <- paste(sep = "", result, ", Fizz")
        } else if ((number %% 5) == 0) {
            result <- paste(sep = "", result, ", Buzz")
        } else {
            result <- paste(sep = "", result, ", ", number)
        }
        number <- (number + 1)
    }
    return(result)
}

fizbuzzV5 <- function(stopNumber) {
    if (is.numeric(stopNumber) == FALSE) stop("argument should be a stopNumber")
    if (stopNumber < 1) stop("Argument should be > 0")
    result <- ""
    number <- 1
    while (TRUE) {
        result <- (if (result == "") paste(sep = "", number) else if (((number %% 3) == 0) && ((number %% 5) == 0)) paste(sep = "", result, ", FizzBuzz") else if ((number %% 3) == 0) paste(sep = "", result, ", Fizz") else if ((number %% 5) == 0) paste(sep = "", result, ", Buzz") else paste(sep = "", result, ", ", number))
        if (number >= stopNumber) break
        number <- (number + 1)
    }
    return(result)
}

fizbuzzV6 <- function(stopNumber) {
    if (is.numeric(stopNumber) == FALSE) stop("argument should be a stopNumber")
    if (stopNumber < 1) stop("Argument should be > 0")
    result <- ""
    number <- 1
    while (number <= stopNumber) {
        result <- (if (result == "") paste(sep = "", number) else if (((number %% 3) == 0) && ((number %% 5) == 0)) paste(sep = "", result, ", FizzBuzz") else if ((number %% 3) == 0) paste(sep = "", result, ", Fizz") else if ((number %% 5) == 0) paste(sep = "", result, ", Buzz") else paste(sep = "", result, ", ", number))
        number <- (number + 1)
    }
    return(result)
}

fizbuzzV7 <- function(stopNumber) {
    if (is.numeric(stopNumber) == FALSE) stop("argument should be a stopNumber")
    if (stopNumber < 1) stop("Argument should be > 0")
    result <- ""
    for (number in 1:stopNumber) { # (start, stop)
        if (result == "") {
            result <- paste(sep = "", number)
            next
        }
        if (((number %% 3) == 0) && ((number %% 5) == 0)) {
            result <- paste(sep = "", result, ", FizzBuzz")
            next
        }
        if ((number %% 3) == 0) {
            result <- paste(sep = "", result, ", Fizz")
            next
        }
        if ((number %% 5) == 0) {
            result <- paste(sep = "", result, ", Buzz")
            next
        }
        result <- paste(sep = "", result, ", ", number)
    }
    return(result)
}

fizbuzzV8 <- function(stopNumber) {
    if (is.numeric(stopNumber) == FALSE) stop("argument should be a stopNumber")
    if (stopNumber < 1) stop("Argument should be > 0")
    result <- ""
    for (number in 1:stopNumber) { # (start, stop)
        if (result == "") {
            result <- paste(sep = "", number)
        } else if (((number %% 3) == 0) && ((number %% 5) == 0)) {
            result <- paste(sep = "", result, ", FizzBuzz")
        } else if ((number %% 3) == 0) {
            result <- paste(sep = "", result, ", Fizz")
        } else if ((number %% 5) == 0) {
            result <- paste(sep = "", result, ", Buzz")
        } else {
            result <- paste(sep = "", result, ", ", number)
        }
    }
    return(result)
}

fizbuzzV9 <- function(stopNumber) {
    if (is.numeric(stopNumber) == FALSE) stop("argument should be a stopNumber")
    if (stopNumber < 1) stop("Argument should be > 0")
    result <- ""
    for (number in 1:stopNumber) { # (start, stop)
        result <- (if (result == "") paste(sep = "", number) else if (((number %% 3) == 0) && ((number %% 5) == 0)) paste(sep = "", result, ", FizzBuzz") else if ((number %% 3) == 0) paste(sep = "", result, ", Fizz") else if ((number %% 5) == 0) paste(sep = "", result, ", Buzz") else paste(sep = "", result, ", ", number))
    }
    return(result)
}

fizbuzzV10 <- function(stopNumber) {
    if (is.numeric(stopNumber) == FALSE) stop("argument should be a stopNumber")
    if (stopNumber < 1) stop("Argument should be > 0")
    return(Reduce(function(currentResult, currentNumber) (if (currentResult == "") paste(sep = "", currentNumber) else if (((currentNumber %% 3) == 0) && ((currentNumber %% 5) == 0)) paste(sep = "", currentResult, ", FizzBuzz") else if ((currentNumber %% 3) == 0) paste(sep = "", currentResult, ", Fizz") else if ((currentNumber %% 5) == 0) paste(sep = "", currentResult, ", Buzz") else paste(sep = "", currentResult, ", ", currentNumber)), 1:stopNumber, ""))
}

cat("# using fizzbuzz function \"fizbuzzV1\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzzV1(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzzV2\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzzV2(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzzV3\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzzV3(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzzV4\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzzV4(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzzV5\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzzV5(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzzV6\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzzV6(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzzV7\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzzV7(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzzV8\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzzV8(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzzV9\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzzV9(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzzV10\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzzV10(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
