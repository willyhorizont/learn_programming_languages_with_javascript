cat("\n# Ternary Operator in R\n")

cat("# using R built-in operator \"if else\"\n")

CORRECT_ANSWER <- "foo"
cat(paste(sep = "", "correct answer: ", CORRECT_ANSWER, "\n"))

my_answer <- "bar"
cat(paste(sep = "", "my answer: ", my_answer, "\n"))
cat(paste(sep = "", "is my answer correct: ", (if (my_answer == CORRECT_ANSWER) "correct!" else "wrong!"), "\n"))
# is my answer correct: wrong!

my_answer <- "foo"
cat(paste(sep = "", "my answer: ", my_answer, "\n"))
cat(paste(sep = "", "is my answer correct: ", (if (my_answer == CORRECT_ANSWER) "correct!" else "wrong!"), "\n"))
# is my answer correct: correct!

cat("# using R built-in function \"ifelse()\"\n")

my_answer <- "bar"
cat(paste(sep = "", "my answer: ", my_answer, "\n"))
cat(paste(sep = "", "is my answer correct: ", (ifelse((my_answer == CORRECT_ANSWER), "correct!", "wrong!")), "\n"))
# is my answer correct: wrong!

my_answer <- "foo"
cat(paste(sep = "", "my answer: ", my_answer, "\n"))
cat(paste(sep = "", "is my answer correct: ", (ifelse((my_answer == CORRECT_ANSWER), "correct!", "wrong!")), "\n"))
# is my answer correct: correct!
