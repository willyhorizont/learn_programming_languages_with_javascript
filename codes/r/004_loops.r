# while loop

i <- 1
while (TRUE) {
    if (i == 2) {
        if (i >= 5) break
        i <- i + 1
        next
    }
    cat(paste(sep = "", "while loop v1, i is ", i, "\n"))
    if (i >= 5) break
    i <- i + 1
}

i <- 1
while (i <= 5) {
    if (i == 2) {
        i <- i + 1
        next
    }
    cat(paste(sep = "", "while loop v1, i is ", i, "\n"))
    i <- i + 1
}

# for loop

for (i in (1:5)) { # (start, stop)
    if (i == 2) next
    cat(paste(sep = "", "for loop v1 ascending, i is ", i, "\n"))
}

for (i in (5:1)) { # (start, stop)
    if (i == 2) next
    cat(paste(sep = "", "for loop v1 descending, i is ", i, "\n"))
}

for (i in seq(1, 5, by = 1)) { # (start, stop, by = step)
    if (i == 2) next
    cat(paste(sep = "", "for loop v2 ascending, i is ", i, "\n"))
}

for (i in seq(5, 1, by = -1)) { # (start, stop, by = step)
    if (i == 2) next
    cat(paste(sep = "", "for loop v2 descending, i is ", i, "\n"))
}
