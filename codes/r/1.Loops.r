# while loop

i <- 1
while (TRUE) {
    if (i == 2) {
        i <- i + 1
        if (i > 5) break
        next
    }
    cat(paste(sep="", "while loop v1, i is ", i, "\n"))
    i <- i + 1
    if (i > 5) break
}

i <- 1
while (i <= 5) {
    if (i == 2) {
        i <- i + 1
        next
    }
    cat(paste(sep="", "while loop v1, i is ", i, "\n"))
    i <- i + 1
}

# for loop

for (i in seq(1, 5, by = 1)) {
    if (i == 2) next
    cat(paste(sep="", "for loop, i is ", i, "\n"))
}
