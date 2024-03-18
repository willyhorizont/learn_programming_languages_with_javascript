library(jsonlite)

# There's no JavaScript-like Array.includes() in R.
# But, we can create our own function to mimic it in R.

prettyJsonStringify <- function(anything) {
    prettyJsonStringWithTrailingNewLine <- prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4)
    prettyJsonStringWithoutTrailingNewLine <- gsub("\\n$", "", prettyJsonStringWithTrailingNewLine, perl = TRUE)
    prettyJsonStringWithoutTrailingNewLineAndWithProperNull <- gsub("\\{\\s*\\n\\s*\\}", "null", prettyJsonStringWithoutTrailingNewLine, perl = TRUE)
    return(prettyJsonStringWithoutTrailingNewLineAndWithProperNull)
}

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
            result <- paste(sep = "", result, "null")
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
    isElementFound <- FALSE
    for (arrayItemIndex in seq_along(anArray)) {
        arrayItem <- anArray[[arrayItemIndex]]
        if (arrayItem == searchElement) {
            isElementFound <- TRUE
            break
        }
    }
    return(isElementFound)
}

arrayIncludesV2 <- function(searchElement, anArray) {
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

aName <- "Alisa"
isMyFriend <- arrayIncludesV1(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(aName), ": ", isMyFriend, "\n"))
# is my friends includes "Alisa": TRUE

aName <- "Trivia"
isMyFriend <- arrayIncludesV1(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(aName), ": ", isMyFriend, "\n"))
# is my friends includes "Trivia": TRUE

aName <- "Tony"
isMyFriend <- arrayIncludesV1(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(aName), ": ", isMyFriend, "\n"))
# is my friends includes "Tony": FALSE

aName <- "Ezekiel"
isMyFriend <- arrayIncludesV1(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(aName), ": ", isMyFriend, "\n"))
# is my friends includes "Ezekiel": FALSE

cat("# using JavaScript-like Array.includes() function \"arrayIncludesV2\"\n")

aName <- "Alisa"
isMyFriend <- arrayIncludesV2(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(aName), ": ", isMyFriend, "\n"))
# is my friends includes "Alisa": TRUE

aName <- "Trivia"
isMyFriend <- arrayIncludesV2(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(aName), ": ", isMyFriend, "\n"))
# is my friends includes "Trivia": TRUE

aName <- "Tony"
isMyFriend <- arrayIncludesV2(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(aName), ": ", isMyFriend, "\n"))
# is my friends includes "Tony": FALSE

aName <- "Ezekiel"
isMyFriend <- arrayIncludesV2(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", prettyJsonStringify(aName), ": ", isMyFriend, "\n"))
# is my friends includes "Ezekiel": FALSE
