library(jsonlite)

prettyJsonStringify <- function(anything) {
    prettyJsonStringWithTrailingNewLine <- prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4)
    prettyJsonStringWithoutTrailingNewLine <- gsub("\\n$", "", prettyJsonStringWithTrailingNewLine, perl = TRUE)
    prettyJsonStringWithoutTrailingNewLineAndWithProperNull <- gsub("\\{\\s*\\n\\s*\\}", "null", prettyJsonStringWithoutTrailingNewLine, perl = TRUE)
    return(prettyJsonStringWithoutTrailingNewLineAndWithProperNull)
}

cat("\n# Ternary Operator in R\n")

CORRECT_ANSWER <- "foo"
cat(paste(sep = "", "correct answer: ", prettyJsonStringify(CORRECT_ANSWER), "\n"))

myAnswer <- "bar"
cat(paste(sep = "", "my answer: ", myAnswer, "\n"))
cat(paste(sep = "", "is my answer correct: ", (if (myAnswer == CORRECT_ANSWER) "correct!" else "wrong!"), "\n"))
# is my answer correct: wrong!

myAnswer <- "foo"
cat(paste(sep = "", "my answer: ", myAnswer, "\n"))
cat(paste(sep = "", "is my answer correct: ", (if (myAnswer == CORRECT_ANSWER) "correct!" else "wrong!"), "\n"))
# is my answer correct: correct!
