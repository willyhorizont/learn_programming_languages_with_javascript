myFruitsInFridge <- list("apple", "mango", "orange")

cat(paste(sep = "", "array length: ", length(myFruitsInFridge), "\n"))

for (arrayItemIndex in seq_along(myFruitsInFridge)) {
    arrayItem <- myFruitsInFridge[arrayItemIndex]
    cat(paste(sep="", arrayItemIndex, "\n"))
}

# array length: 3
# 1
# 2
# 3