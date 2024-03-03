// while loop

var i1 = 1
while (true) {
    if (i1 == 2) {
        i1 += 1
        if (i1 > 5) {
            break
        }
        continue
    }
    print("while loop v1, i1 is \(i1)")
    i1 += 1
    if (i1 > 5) {
        break
    }
}

var i2 = 1
while (i2 <= 5) {
    if (i2 == 2) {
        i2 += 1
        continue
    }
    print("while loop v2, i2 is \(i2)")
    i2 += 1
}

// for loop

for i3 in (1...5) {
    if (i3 == 2) {
        continue
    }
    print("for loop ascending v1, i3 is \(i3)")
}

for i4 in stride(from: 1, to: (5 + 1), by: 1) {
    if (i4 == 2) {
        continue
    }
    print("for loop ascending v2, i4 is \(i4)")
}

for i5 in stride(from: 1, through: 5, by: 1) {
    if (i5 == 2) {
        continue
    }
    print("for loop ascending v2, i5 is \(i5)")
}

for i6 in (1...5).reversed() {
    if (i6 == 2) {
        continue
    }
    print("for loop descending v1, i6 is \(i6)")
}

for i7 in stride(from: 5, to: (1 - 1), by: -1) {
    if (i7 == 2) {
        continue
    }
    print("for loop descending v2, i7 is \(i7)")
}

for i8 in stride(from: 5, through: 1, by: -1) {
    if (i8 == 2) {
        continue
    }
    print("for loop descending v3, i8 is \(i8)")
}
