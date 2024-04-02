// There's no "break" and "continue" in Scala.
// But, we can create our own function to mimic it in Scala.

// while loop

def myWhileLoopV1(i: Int = 0): Unit = {
    var iInner: Int = i
    while (true) {
        if (iInner == 2) {
            if (iInner >= 5) return // break
            iInner += 1
            myWhileLoopV1(iInner) // continue
            return
        }
        println(s"while loop v1, iInner is ${iInner}")
        if (iInner >= 5) return // break
        iInner += 1
    }
}
myWhileLoopV1(1)

def myWhileLoopV2(i: Int = 0): Unit = {
    var iInner: Int = i
    while (iInner <= 5) {
        if (iInner == 2) {
            iInner += 1
            myWhileLoopV2(iInner) // continue
            return
        }
        println(s"while loop v2, iInner is ${iInner}")
        iInner += 1
    }
}
myWhileLoopV2(1)

// for loop

def myForLoopAscending(i: Int = 0): Unit = {
    for (iInner <- (i to 10 by 1)) {
        if (iInner > 5) return // break
        if (iInner == 2) {
            myForLoopAscending(iInner + 1) // continue
            return
        }
        println(s"for loop ascending, iInner is ${iInner}")
    }
}
myForLoopAscending(1)

def myForLoopDescending(i: Int = (10 - 1)): Unit = {
    for (iInner <- (i to 1 by -1)) {
        if (iInner <= 5) return // break
        if (iInner == 9) {
            myForLoopDescending(iInner - 1) // continue
            return
        }
        println(s"for loop descending, iInner is ${iInner}")
    }
}
myForLoopDescending(10)

// forEach loop

(1 to 10 by 1).foreach(new Function1[Int, Unit] {
    def apply(i: Int): Unit = {
        if (i > 5) return
        if (i == 2) return
        println(s"forEach loop v1 ascending, i is ${i}")
    }
})

(10 to 1 by -1).foreach(new Function1[Int, Unit] {
    def apply(i: Int): Unit = {
        if (i <= 5) return
        if (i == 9) return
        println(s"forEach loop v1 descending, i is ${i}")
    }
})

(1 until (10 + 1) by 1).foreach(new Function1[Int, Unit] {
    def apply(i: Int): Unit = {
        if (i > 5) return
        if (i == 2) return
        println(s"forEach loop v2 ascending, i is ${i}")
    }
})

(10 until (1 - 1) by -1).foreach(new Function1[Int, Unit] {
    def apply(i: Int): Unit = {
        if (i <= 5) return
        if (i == 9) return
        println(s"forEach loop v2 descending, i is ${i}")
    }
})

// (start, stop, step)
Range.inclusive(1, 10, 1).foreach(new Function1[Int, Unit] {
    def apply(i: Int): Unit = {
        if (i > 5) return
        if (i == 2) return
        println(s"forEach loop v3 ascending, i is ${i}")
    }
})

// (start, stop, step)
Range.inclusive(10, 1, -1).foreach(new Function1[Int, Unit] {
    def apply(i: Int): Unit = {
        if (i <= 5) return
        if (i == 9) return
        println(s"forEach loop v3 descending, i is ${i}")
    }
})

// (start, stop, step)
Range(1, (10 + 1), 1).foreach(new Function1[Int, Unit] {
    def apply(i: Int): Unit = {
        if (i > 5) return
        if (i == 2) return
        println(s"forEach loop v4 ascending, i is ${i}")
    }
})

// (start, stop, step)
Range(10, (1 - 1), -1).foreach(new Function1[Int, Unit] {
    def apply(i: Int): Unit = {
        if (i <= 5) return
        if (i == 9) return
        println(s"forEach loop v4 descending, i is ${i}")
    }
})
