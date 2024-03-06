@Suppress("UNUSED_VARIABLE", "UNCHECKED_CAST", "USELESS_CAST")

fun main() {
    // while loop

    var i1 = 1
    while (true) {
        if (i1 == 2) {
            i1 += 1
            if (i1 > 5) break
            continue
        }
        println("while loop v1, i1 is ${i1}")
        i1 += 1
        if (i1 > 5) break
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

    for (i3 in 1..5 step 1) {
        if (i3 == 2) {
            continue
        }
        println("for loop descending, i3 is ${i3}")
    }

    for (i4 in 5 downTo 1 step 1) {
        if (i4 == 2) {
            continue
        }
        println("for loop ascending, i4 is ${i4}")
    }
}
