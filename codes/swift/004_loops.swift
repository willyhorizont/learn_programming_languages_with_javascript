// while loop

var i1 = 1
while (true) {
    if (i1 == 2) {
        if (i1 >= 5) {
            break
        }
        i1 += 1
        continue
    }
    print("while loop v1, i1 is \(i1)")
    if (i1 >= 5) {
        break
    }
    i1 += 1
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

for i3 in (1...10) {
    if (i3 > 5) {
        break
    }
    if (i3 == 2) {
        continue
    }
    print("for loop v1 ascending, i3 is \(i3)")
}

for i4 in (1...10).reversed() {
    if (i4 <= 5) {
        break
    }
    if (i4 == 9) {
        continue
    }
    print("for loop v1 descending, i4 is \(i4)")
}

for i5 in stride(from: 1, to: (10 + 1), by: 1) {
    if (i5 > 5) {
        break
    }
    if (i5 == 2) {
        continue
    }
    print("for loop v2 ascending, i5 is \(i5)")
}

for i6 in stride(from: 10, to: (1 - 1), by: -1) {
    if (i6 <= 5) {
        break
    }
    if (i6 == 9) {
        continue
    }
    print("for loop v2 descending, i6 is \(i6)")
}

for i7 in stride(from: 1, through: 10, by: 1) {
    if (i7 > 5) {
        break
    }
    if (i7 == 2) {
        continue
    }
    print("for loop v3 ascending, i7 is \(i7)")
}

for i8 in stride(from: 10, through: 1, by: -1) {
    if (i8 <= 5) {
        break
    }
    if (i8 == 9) {
        continue
    }
    print("for loop v3 descending, i8 is \(i8)")
}

// foreach loop

(1...10).forEach { i9 in
    if (i9 > 5) {
        break
    }
    if (i9 == 2) {
        return
    }
    print("foreach loop ascending, i9 is \(i9)")
}

(1...10).reversed().forEach { i10 in
    if (i10 <= 5) {
        break
    }
    if (i10 == 9) {
        return
    }
    print("foreach loop descending, i10 is \(i10)")
}
