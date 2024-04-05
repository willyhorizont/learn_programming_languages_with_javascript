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

# Relational Operators / Comparison Operators:
# equal to (==)
# not equal to (!=)
# greater than (>)
# less than (<)
# greater than or equal to (>=)
# less than or equal to (<=)

# Logical Operators:
# Logical AND (&&)
# Logical OR (||)
# Logical NOT (!)

CORRECT_ANSWER <- 100

cat("\n# basic conditional control flow\n")

myAge <- 10
cat(paste(sep = "", "myAge: ", myAge, "\n"))
if (myAge > 24) {
    cat("you are old\n")
} else if (myAge > 17) {
    cat("you are young\n")
} else {
    cat("you are under age\n")
}

cat("\n# equal to (==)\n")

myAnswer <- "100"
cat(paste(sep = "", "myAnswer: ", myAnswer, "\n"))
cat(paste(sep = "", "CORRECT_ANSWER: ", CORRECT_ANSWER, "\n"))
cat("(myAnswer == CORRECT_ANSWER):\n")
if (myAnswer == CORRECT_ANSWER) {
    cat("Your answer is correct\n")
} else {
    cat("Your answer is wrong\n")
}

cat("\n# not equal to (!=)\n")

myAnswer <- "25"
cat(paste(sep = "", "myAnswer: ", myAnswer, "\n"))
cat(paste(sep = "", "CORRECT_ANSWER: ", CORRECT_ANSWER, "\n"))
cat("(myAnswer != CORRECT_ANSWER):\n")
if (myAnswer != CORRECT_ANSWER) {
    cat("Your answer is correct\n")
} else {
    cat("Your answer is wrong\n")
}

cat("\n# greater than (>)\n")

myAge <- 70
cat(paste(sep = "", "myAge: ", myAge, "\n"))
cat("(myAge > 50):\n")
if (myAge > 50) cat("You are old\n")

cat("\n# less than (<)\n")

myAge <- 16
cat(paste(sep = "", "myAge: ", myAge, "\n"))
cat("(myAge < 20):\n")
if (myAge < 20) cat("You are young\n")

cat("\n# greater than or equal to (>=)\n")

myAge <- 73
cat(paste(sep = "", "myAge: ", myAge, "\n"))
cat("(myAge >= 65):\n")
if (myAge >= 65) cat("You are allowed to retire\n")

cat("\n# less than or equal to (<=)\n")

myAge <- 14
cat(paste(sep = "", "myAge: ", myAge, "\n"))
cat("(myAge <= 16):\n")
if (myAge <= 16) cat("You are not allowed to drive\n")

cat("\n# Logical AND (&&)\n")

myAge <- 17
cat(paste(sep = "", "myAge: ", myAge, "\n"))
hasDrivingLicense <- FALSE
cat(paste(sep = "", "hasDrivingLicense: ", jsonStringify(hasDrivingLicense), "\n"))
cat("((myAge >= 17) && (hasDrivingLicense == true)):\n")
if ((myAge >= 17) && (hasDrivingLicense == TRUE)) {
    cat("You are allowed to drive\n")
} else {
    cat("You are not allowed to drive\n")
}

myAge <- 17
cat(paste(sep = "", "myAge: ", myAge, "\n"))
hasDrivingLicense <- TRUE
cat(paste(sep = "", "hasDrivingLicense: ", jsonStringify(hasDrivingLicense), "\n"))
cat("((myAge >= 17) && (hasDrivingLicense == true)):\n")
if ((myAge >= 17) && (hasDrivingLicense == TRUE)) {
    cat("You are allowed to drive\n")
} else {
    cat("You are not allowed to drive\n")
}

cat("\n# Logical OR (||)\n")

myAge <- 2
cat(paste(sep = "", "myAge: ", myAge, "\n"))
cat("((myAge <= 3) || (myAge >= 65)):\n")
if ((myAge <= 3) || (myAge >= 65)) cat("You should stay home\n")

myAge <- 89
cat(paste(sep = "", "myAge: ", myAge, "\n"))
cat("((myAge <= 3) || (myAge >= 65)):\n")
if ((myAge <= 3) || (myAge >= 65)) cat("You should stay home\n")

cat("\n# Logical NOT (!)\n")

canDrive <- FALSE
cat(paste(sep = "", "canDrive: ", jsonStringify(canDrive), "\n"))
cat(paste(sep = "", "!canDrive: ", jsonStringify(!canDrive), "\n"))

canDrive <- TRUE
cat(paste(sep = "", "canDrive: ", jsonStringify(canDrive), "\n"))
cat(paste(sep = "", "!canDrive: ", jsonStringify(!canDrive), "\n"))
