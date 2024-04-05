library(jsonlite)

jsonStringify <- function(anything, pretty = FALSE, indent = strrep(" ", 4)) {
    if (pretty == TRUE) {
        prettyJsonStringWithTrailingNewLine <- prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 3)
        prettyJsonStringWithCustomIndent <- gsub(strrep(" ", 3), indent, prettyJsonStringWithTrailingNewLine, perl = TRUE)
        prettyJsonStringWithoutTrailingNewLine <- gsub("\\n$", "", prettyJsonStringWithCustomIndent, perl = TRUE)
        prettyJsonStringWithoutTrailingNewLineAndWithProperNull <- gsub("\\{\\s*\\n\\s*\\}", "null", prettyJsonStringWithoutTrailingNewLine, perl = TRUE)
        return(prettyJsonStringWithoutTrailingNewLineAndWithProperNull)
    }
    jsonStringWithoutSpaceDelimiter <- toJSON(anything, pretty = FALSE, auto_unbox = TRUE)
    jsonStringWithSpaceDelimiterAfterComma <- gsub(",", ", ", jsonStringWithoutSpaceDelimiter, perl = TRUE)
    jsonStringWithSpaceDelimiterAfterCommaAndColon <- gsub(":", ": ", jsonStringWithSpaceDelimiterAfterComma, perl = TRUE)
    jsonStringWithSpaceDelimiterAfterCommaAndColonAndWithProperNull <- gsub("{}", "null", jsonStringWithSpaceDelimiterAfterCommaAndColon, perl = TRUE)
    return(jsonStringWithSpaceDelimiterAfterCommaAndColonAndWithProperNull)
}

# There's no JavaScript-like Array.includes() in R.
# But, we can create our own function to mimic it in R.

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
cat(paste(sep = "", "my friends: ", jsonStringify(myFriends), "\n"))

cat("# using JavaScript-like Array.includes() function \"arrayIncludesV1\"\n")

aName <- "Alisa"
isMyFriend <- arrayIncludesV1(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", jsonStringify(aName), ": ", jsonStringify(isMyFriend), "\n"))
# is my friends includes "Alisa": true

aName <- "Trivia"
isMyFriend <- arrayIncludesV1(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", jsonStringify(aName), ": ", jsonStringify(isMyFriend), "\n"))
# is my friends includes "Trivia": true

aName <- "Tony"
isMyFriend <- arrayIncludesV1(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", jsonStringify(aName), ": ", jsonStringify(isMyFriend), "\n"))
# is my friends includes "Tony": false

aName <- "Ezekiel"
isMyFriend <- arrayIncludesV1(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", jsonStringify(aName), ": ", jsonStringify(isMyFriend), "\n"))
# is my friends includes "Ezekiel": false

cat("# using JavaScript-like Array.includes() function \"arrayIncludesV2\"\n")

aName <- "Alisa"
isMyFriend <- arrayIncludesV2(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", jsonStringify(aName), ": ", jsonStringify(isMyFriend), "\n"))
# is my friends includes "Alisa": true

aName <- "Trivia"
isMyFriend <- arrayIncludesV2(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", jsonStringify(aName), ": ", jsonStringify(isMyFriend), "\n"))
# is my friends includes "Trivia": true

aName <- "Tony"
isMyFriend <- arrayIncludesV2(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", jsonStringify(aName), ": ", jsonStringify(isMyFriend), "\n"))
# is my friends includes "Tony": false

aName <- "Ezekiel"
isMyFriend <- arrayIncludesV2(aName, myFriends)
cat(paste(sep = "", "is my friends includes ", jsonStringify(aName), ": ", jsonStringify(isMyFriend), "\n"))
# is my friends includes "Ezekiel": false
