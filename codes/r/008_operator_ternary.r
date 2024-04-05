cat("\n# Ternary Operator in R\n")

cat("# using R built-in operator \"if else\"\n")

CORRECT_ANSWER <- "foo"
cat(paste(sep = "", "correct answer: ", CORRECT_ANSWER, "\n"))

myAnswer <- "bar"
cat(paste(sep = "", "my answer: ", myAnswer, "\n"))
cat(paste(sep = "", "is my answer correct: ", (if (myAnswer == CORRECT_ANSWER) "correct!" else "wrong!"), "\n"))
# is my answer correct: wrong!

myAnswer <- "foo"
cat(paste(sep = "", "my answer: ", myAnswer, "\n"))
cat(paste(sep = "", "is my answer correct: ", (if (myAnswer == CORRECT_ANSWER) "correct!" else "wrong!"), "\n"))
# is my answer correct: correct!

cat("# using R built-in function \"ifelse()\"\n")

myAnswer <- "bar"
cat(paste(sep = "", "my answer: ", myAnswer, "\n"))
cat(paste(sep = "", "is my answer correct: ", (ifelse((myAnswer == CORRECT_ANSWER), "correct!", "wrong!")), "\n"))
# is my answer correct: wrong!

myAnswer <- "foo"
cat(paste(sep = "", "my answer: ", myAnswer, "\n"))
cat(paste(sep = "", "is my answer correct: ", (ifelse((myAnswer == CORRECT_ANSWER), "correct!", "wrong!")), "\n"))
# is my answer correct: correct!
