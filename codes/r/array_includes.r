typeOf <- function(anything) {
    if (is.list(anything) == FALSE) return(class(anything))
    if (length(anything) == 0) return("array")
    if (is.null(names(anything)) == TRUE) return("array")
    return("object")
}

jsonStringify <- function(anything, pretty = FALSE, indent = strrep(" ", 4)) {
    indentLevel <- 0
    jsonStringifyInner <- function(anythingInner, indentInner) {
        if (is.null(anythingInner)) return("null")
        if (is.character(anythingInner)) return(paste(sep = "", "\"", anythingInner, "\""))
        if (is.numeric(anythingInner) || is.logical(anythingInner)) return(paste(sep = "", anythingInner))
        if (typeOf(anythingInner) == "array") {
            if (length(anythingInner) == 0) return("[]")
            indentLevel <<- (indentLevel + 1)
            result <- (if (pretty == TRUE) paste(sep = "", "[\n", strrep(indentInner, indentLevel)) else "[")
            for (arrayItemIndex in seq_along(anythingInner)) {
                arrayItem <- anythingInner[[arrayItemIndex]]
                result <- paste(sep = "", result, jsonStringifyInner(arrayItem, indentInner))
                if (arrayItemIndex != length(anythingInner)) result <- (if (pretty == TRUE) paste(sep = "", result, ",\n", strrep(indentInner, indentLevel)) else paste(sep = "", result, ", "))
            }
            indentLevel <<- (indentLevel - 1)
            result <- (if (pretty == TRUE) paste(sep = "", result, "\n", strrep(indentInner, indentLevel), "]") else paste(sep = "", result, "]"))
            return(result)
        }
        if (typeOf(anythingInner) == "object") {
            if (length(names(anythingInner)) == 0) return("{}")
            indentLevel <<- (indentLevel + 1)
            result <- (if (pretty == TRUE) paste(sep = "", "{\n", strrep(indentInner, indentLevel)) else "{")
            for (objectEntryIndex in seq_along(anythingInner)) {
                objectKey <- names(anythingInner)[objectEntryIndex]
                objectValue <- anythingInner[[objectEntryIndex]]
                result <- paste(sep = "", result, "\"", objectKey, "\": ", jsonStringifyInner(objectValue, indentInner))
                if (objectEntryIndex != length(names(anythingInner))) result <- (if (pretty == TRUE) paste(sep = "", result, ",\n", strrep(indentInner, indentLevel)) else paste(sep = "", result, ", "))
            }
            indentLevel <<- (indentLevel - 1)
            result <- (if (pretty == TRUE) paste(sep = "", result, "\n", strrep(indentInner, indentLevel), "}") else paste(sep = "", result, "}"))
            return(result)
        }
        return("null")
    }
    return(jsonStringifyInner(anything, indent))
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
