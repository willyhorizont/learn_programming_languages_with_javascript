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

    // for loop and also forEach loop

    for (i3 in ((1..10) step 1)) {
        if (i3 > 5) break
        if (i3 == 2) continue
        println("for loop v1 ascending, i3 is ${i3}")
    }

    for (i4 in ((1..10).reversed() step 1)) {
        if (i4 <= 5) break
        if (i4 == 9) continue
        println("for loop v1 descending, i4 is ${i4}")
    }

    ((1..10) step 1).forEach { i5 ->
        if (i5 > 5) return@forEach
        if (i5 == 2) return@forEach
        println("for loop v3 ascending, i5 is ${i5}")
    }

    ((1..10) step 1).reversed().forEach { i6 ->
        if (i6 <= 5) return@forEach
        if (i6 == 9) return@forEach
        println("for loop v3 descending, i6 is ${i6}")
    }

    for (i7 in 1.rangeTo(10 + 1) step 1) {
        if (i7 > 5) break
        if (i7 == 2) continue
        println("for loop v2 ascending v2, i7 is ${i7}")
    }

    for (i8 in 1.rangeUntil(10) step 1) {
        if (i8 > 5) break
        if (i8 == 2) continue
        println("for loop v2 ascending v3, i8 is ${i8}")
    }

    for (i9 in 1 until (10 + 1) step 1) {
        if (i9 > 5) break
        if (i9 == 2) continue
        println("for loop v2 ascending v1, i9 is ${i9}")
    }

    for (i10 in 10 downTo 1 step 1) {
        if (i10 <= 5) break
        if (i10 == 9) continue
        println("for loop v2 descending, i10 is ${i10}")
    }

    fun range(start: Int, stop: Int, stepSize: Int = 1): IntProgression {
        if (stepSize < 0) return (start downTo stop step Math.abs(stepSize)) as IntProgression
        return (start until (stop + 1) step stepSize) as IntProgression
    }

    for (i11 in range(1, 10, 1)) {
        if (i11 > 5) break
        if (i11 == 2) continue
        println("for loop v3 ascending, i11 is ${i11}")
    }

    for (i12 in range(10, 1, -1)) {
        if (i12 <= 5) break
        if (i12 == 9) continue
        println("for loop v3 descending, i12 is ${i12}")
    }
}
