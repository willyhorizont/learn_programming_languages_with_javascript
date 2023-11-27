void main() {
    // while loop

    dynamic i1 = 1;
    while (true) {
        if (i1 == 2) {
            i1 += 1;
            if (i1 > 5) break;
            continue;
        }
        print("while loop v1, i1 is ${i1}");
        i1 += 1;
        if (i1 > 5) break;
    }

    dynamic i2 = 1;
    while (i2 <= 5) {
        if (i2 == 2) {
            i2 += 1;
            continue;
        }
        print("while loop v2, i2 is ${i2}");
        i2 += 1;
    }

    // for loop

    for (dynamic i3 = 1; i3 <= 5; i3 += 1) {
        if (i3 == 2) continue;
        print("for loop, i3 is ${i3}");
    }
}
