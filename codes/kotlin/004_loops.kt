@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
    // while loop

    var i1 = 1
    while (true) {
        if (i1 == 2) {
            if (i1 >= 5) break
            i1 += 1
            continue
        }
        println("while loop v1, i1 is ${i1}")
        if (i1 >= 5) break
        i1 += 1
    }

    var i2 = 1
    while (i2 <= 5) {
        if (i2 == 2) {
            i2 += 1
            continue
        }
        println("while loop v2, i2 is ${i2}")
        i2 += 1
    }

    // for loop

    for (i3 in ((1..10) step 1)) {
        if (i3 > 5) {
            break
        }
        if (i3 == 2) {
            continue
        }
        println("for loop v1 ascending v1, i3 is ${i3}")
    }

    for (i4 in 1 until (10 + 1) step 1) {
        if (i4 > 5) {
            break
        }
        if (i4 == 2) {
            continue
        }
        println("for loop v2 ascending v2, i4 is ${i4}")
    }

    for (i5 in ((1..10).reversed() step 1)) {
        if (i5 <= 5) {
            break
        }
        if (i5 == 9) {
            continue
        }
        println("for loop v1 descending v1, i5 is ${i5}")
    }

    for (i6 in 10 downTo 1 step 1) {
        if (i6 <= 5) {
            break
        }
        if (i6 == 9) {
            continue
        }
        println("for loop v3 descending v2, i6 is ${i6}")
    }

    ((1..10) step 1).forEach { i7 ->
        if (i7 > 5) {
            return@forEach
        }
        if (i7 == 2) {
            return@forEach
        }
        println("for loop v4 ascending, i7 is ${i7}")
    }

    ((1..10) step 1).reversed().forEach { i8 ->
        if (i8 <= 5) {
            return@forEach
        }
        if (i8 == 9) {
            return@forEach
        }
        println("for loop v4 descending, i8 is ${i8}")
    }
}
