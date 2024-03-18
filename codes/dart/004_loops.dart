void main() {
    // while loop

    dynamic i1 = 1;
    while (true) {
        if (i1 == 2) {
            if (i1 >= 5) break;
            i1 += 1;
            continue;
        }
        print("while loop v1, i1 is ${i1}");
        if (i1 >= 5) break;
        i1 += 1;
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
        print("for loop v1, i3 is ${i3}");
    }

	// foreach loop

	Iterable.generate(5, (i) => i + 1).forEach((i4) {
		if (i4 == 2) return;
        print("foreach loop v1 ascending, i4 is ${i4}");
	});

	Iterable.generate(5, (i) => 5 - i).forEach((i5) {
		if (i5 == 2) return;
        print("foreach loop v1 descending, i5 is ${i5}");
	});

	List.generate(5, (i) => i + 1).forEach((i6) {
		if (i6 == 2) return;
        print("foreach loop v2 ascending, i6 is ${i6}");
	});

	List.generate(5, (i) => 5 - i).forEach((i7) {
		if (i7 == 2) return;
        print("foreach loop v2 descending, i7 is ${i7}");
	});
}
