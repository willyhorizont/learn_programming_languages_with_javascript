cat("\n# FizzBuzz(n) in R\n")

fizbuzz_v1 <- function(stop_number) {
    if (is.numeric(stop_number) == FALSE) stop("argument should be a stop_number")
    if (stop_number < 1) stop("Argument should be > 0")
    result <- ""
    number <- 1
    while (TRUE) {
        if (result == "") {
            result <- paste(sep = "", number)
            if (number >= stop_number) break
            number <- (number + 1)
            next
        }
        if (((number %% 3) == 0) && ((number %% 5) == 0)) {
            result <- paste(sep = "", result, ", FizzBuzz")
            if (number >= stop_number) break
            number <- (number + 1)
            next
        }
        if ((number %% 3) == 0) {
            result <- paste(sep = "", result, ", Fizz")
            if (number >= stop_number) break
            number <- (number + 1)
            next
        }
        if ((number %% 5) == 0) {
            result <- paste(sep = "", result, ", Buzz")
            if (number >= stop_number) break
            number <- (number + 1)
            next
        }
        result <- paste(sep = "", result, ", ", number)
        if (number >= stop_number) break
        number <- (number + 1)
    }
    return(result)
}

fizbuzz_v2 <- function(stop_number) {
    if (is.numeric(stop_number) == FALSE) stop("argument should be a stop_number")
    if (stop_number < 1) stop("Argument should be > 0")
    result <- ""
    number <- 1
    while (number <= stop_number) {
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

fizbuzz_v3 <- function(stop_number) {
    if (is.numeric(stop_number) == FALSE) stop("argument should be a stop_number")
    if (stop_number < 1) stop("Argument should be > 0")
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
        if (number >= stop_number) break
        number <- (number + 1)
    }
    return(result)
}

fizbuzz_v4 <- function(stop_number) {
    if (is.numeric(stop_number) == FALSE) stop("argument should be a stop_number")
    if (stop_number < 1) stop("Argument should be > 0")
    result <- ""
    number <- 1
    while (number <= stop_number) {
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

fizbuzz_v5 <- function(stop_number) {
    if (is.numeric(stop_number) == FALSE) stop("argument should be a stop_number")
    if (stop_number < 1) stop("Argument should be > 0")
    result <- ""
    number <- 1
    while (TRUE) {
        result <- (if (result == "") paste(sep = "", number) else if (((number %% 3) == 0) && ((number %% 5) == 0)) paste(sep = "", result, ", FizzBuzz") else if ((number %% 3) == 0) paste(sep = "", result, ", Fizz") else if ((number %% 5) == 0) paste(sep = "", result, ", Buzz") else paste(sep = "", result, ", ", number))
        if (number >= stop_number) break
        number <- (number + 1)
    }
    return(result)
}

fizbuzz_v6 <- function(stop_number) {
    if (is.numeric(stop_number) == FALSE) stop("argument should be a stop_number")
    if (stop_number < 1) stop("Argument should be > 0")
    result <- ""
    number <- 1
    while (number <= stop_number) {
        result <- (if (result == "") paste(sep = "", number) else if (((number %% 3) == 0) && ((number %% 5) == 0)) paste(sep = "", result, ", FizzBuzz") else if ((number %% 3) == 0) paste(sep = "", result, ", Fizz") else if ((number %% 5) == 0) paste(sep = "", result, ", Buzz") else paste(sep = "", result, ", ", number))
        number <- (number + 1)
    }
    return(result)
}

fizbuzz_v7 <- function(stop_number) {
    if (is.numeric(stop_number) == FALSE) stop("argument should be a stop_number")
    if (stop_number < 1) stop("Argument should be > 0")
    result <- ""
    for (number in 1:stop_number) { # (start, stop)
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

fizbuzz_v8 <- function(stop_number) {
    if (is.numeric(stop_number) == FALSE) stop("argument should be a stop_number")
    if (stop_number < 1) stop("Argument should be > 0")
    result <- ""
    for (number in 1:stop_number) { # (start, stop)
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

fizbuzz_v9 <- function(stop_number) {
    if (is.numeric(stop_number) == FALSE) stop("argument should be a stop_number")
    if (stop_number < 1) stop("Argument should be > 0")
    result <- ""
    for (number in 1:stop_number) { # (start, stop)
        result <- (if (result == "") paste(sep = "", number) else if (((number %% 3) == 0) && ((number %% 5) == 0)) paste(sep = "", result, ", FizzBuzz") else if ((number %% 3) == 0) paste(sep = "", result, ", Fizz") else if ((number %% 5) == 0) paste(sep = "", result, ", Buzz") else paste(sep = "", result, ", ", number))
    }
    return(result)
}

fizbuzz_v10 <- function(stop_number) {
    if (is.numeric(stop_number) == FALSE) stop("argument should be a stop_number")
    if (stop_number < 1) stop("Argument should be > 0")
    return(Reduce(function(current_result, current_number) (if (current_result == "") paste(sep = "", current_number) else if (((current_number %% 3) == 0) && ((current_number %% 5) == 0)) paste(sep = "", current_result, ", FizzBuzz") else if ((current_number %% 3) == 0) paste(sep = "", current_result, ", Fizz") else if ((current_number %% 5) == 0) paste(sep = "", current_result, ", Buzz") else paste(sep = "", current_result, ", ", current_number)), 1:stop_number, ""))
}

cat("# using fizzbuzz function \"fizbuzz_v1\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzz_v1(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzz_v2\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzz_v2(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzz_v3\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzz_v3(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzz_v4\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzz_v4(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzz_v5\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzz_v5(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzz_v6\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzz_v6(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzz_v7\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzz_v7(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzz_v8\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzz_v8(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzz_v9\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzz_v9(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

cat("# using fizzbuzz function \"fizbuzz_v10\"\n")
cat(paste(sep = "", "FizzBuzz(36): ", fizbuzz_v10(36), "\n"))
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
