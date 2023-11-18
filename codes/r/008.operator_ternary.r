library(jsonlite)

prettyJsonStringify <- function(anything) (if (is.null(anything) == TRUE) "NULL" else if (is.character(anything) == TRUE) paste(sep = "", "\"", anything, "\"") else prettify(toJSON(anything, pretty = TRUE, auto_unbox = TRUE), indent = 4))

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
