library(jsonlite)

# There's no JavaScript-like Array.includes() in R.
# But, we can create our own function to mimic it in R.

prettyJsonStringify <- function(anything) (if (is.null(anything) == TRUE) "NULL" else if (is.character(anything) == TRUE) paste(sep = "", "\"", anything, "\"") else prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4))

prettyArrayOfPrimitives <- function(anArrayOfPrimitives) {
    result <- "["
    for (arrayItemIndex in seq_along(anArrayOfPrimitives)) {
        arrayItem <- anArrayOfPrimitives[[arrayItemIndex]]
        if ((is.character(arrayItem) == FALSE) && (is.numeric(arrayItem) == FALSE) && (is.logical(arrayItem) == FALSE) && (is.null(arrayItem) == FALSE)) next
        if (is.character(arrayItem) == TRUE) {
            result <- paste(sep = "", result, "\"", arrayItem, "\"")
        }
        if ((is.numeric(arrayItem) == TRUE) || (is.logical(arrayItem) == TRUE)) {
            result <- paste(sep = "", result, arrayItem)
        }
        if (is.null(arrayItem) == TRUE) {
            result <- paste(sep = "", result, "NULL")
        }
        if (arrayItemIndex != length(anArrayOfPrimitives)) {
            result <- paste(sep = "", result, ", ")
        }
    }
    result <- paste(sep = "", result, "]")
    return(result)
}

arrayIncludesV1 <- function(searchElement, anArray) {
    # JavaScript-like Array.includes() function
    elementFound <- FALSE
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- (arrayItem == searchElement)
        if (isConditionMatch == TRUE) {
            elementFound <- TRUE
            break
        }
    }
    return(elementFound)
}

arrayIncludesV2 <- function(searchElement, anArray) {
    # JavaScript-like Array.includes() function
    elementFound <- FALSE
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        if (arrayItem == searchElement) {
            elementFound <- TRUE
            break
        }
    }
    return(elementFound)
}

arrayIncludesV3 <- function(searchElement, anArray) {
    # JavaScript-like Array.includes() function
    elementFound <- FALSE
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- (arrayItem == searchElement)
        if (isConditionMatch == TRUE) {
            elementFound <- TRUE
            return(elementFound)
        }
    }
    return(elementFound)
}

arrayIncludesV4 <- function(searchElement, anArray) {
    # JavaScript-like Array.includes() function
    elementFound <- FALSE
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        if (arrayItem == searchElement) {
            elementFound <- TRUE
            return(elementFound)
        }
    }
    return(elementFound)
}

arrayIncludesV5 <- function(searchElement, anArray) {
    # JavaScript-like Array.includes() function
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        isConditionMatch <- (arrayItem == searchElement)
        if (isConditionMatch == TRUE) return(TRUE)
    }
    return(FALSE)
}

arrayIncludesV6 <- function(searchElement, anArray) {
    # JavaScript-like Array.includes() function
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        if (arrayItem == searchElement) return(TRUE)
    }
    return(FALSE)
}

cat("\n# JavaScript-like Array.includes() in R\n")

myFriends <- list("Alisa", "Trivia")
cat(paste(sep = "", "my friends: ", prettyArrayOfPrimitives(myFriends), "\n"))

cat("# using JavaScript-like Array.includes() function \"arrayIncludesV1\"\n")

name <- "Alisa"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV1(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Alisa": TRUE

name <- "Trivia"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV1(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Trivia": TRUE

name <- "Tony"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV1(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Tony": FALSE

name <- "Ezekiel"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV1(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Ezekiel": FALSE

cat("# using JavaScript-like Array.includes() function \"arrayIncludesV2\"\n")

name <- "Alisa"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV2(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Alisa": TRUE

name <- "Trivia"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV2(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Trivia": TRUE

name <- "Tony"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV2(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Tony": FALSE

name <- "Ezekiel"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV2(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Ezekiel": FALSE

cat("# using JavaScript-like Array.includes() function \"arrayIncludesV3\"\n")

name <- "Alisa"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV3(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Alisa": TRUE

name <- "Trivia"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV3(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Trivia": TRUE

name <- "Tony"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV3(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Tony": FALSE

name <- "Ezekiel"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV3(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Ezekiel": FALSE

cat("# using JavaScript-like Array.includes() function \"arrayIncludesV4\"\n")

name <- "Alisa"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV4(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Alisa": TRUE

name <- "Trivia"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV4(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Trivia": TRUE

name <- "Tony"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV4(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Tony": FALSE

name <- "Ezekiel"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV4(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Ezekiel": FALSE

cat("# using JavaScript-like Array.includes() function \"arrayIncludesV5\"\n")

name <- "Alisa"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV5(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Alisa": TRUE

name <- "Trivia"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV5(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Trivia": TRUE

name <- "Tony"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV5(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Tony": FALSE

name <- "Ezekiel"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV5(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Ezekiel": FALSE

cat("# using JavaScript-like Array.includes() function \"arrayIncludesV6\"\n")

name <- "Alisa"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV6(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Alisa": TRUE

name <- "Trivia"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV6(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Trivia": TRUE

name <- "Tony"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV6(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Tony": FALSE

name <- "Ezekiel"
cat(paste(sep = "", "name: ", prettyJsonStringify(name), "\n"))
isMyFriend <- arrayIncludesV6(name, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(name), ": ", isMyFriend, "\n"))
# is my friends includes "Ezekiel": FALSE
