def MyObject(objectEntries: (String, Any)*): Map[String, Any] = (if (objectEntries.isEmpty) Map.empty[String, Any] else objectEntries.toMap[String, Any])
def MyArray(arrayItems: Any*): Array[Any] = (if (arrayItems.isEmpty) Array.empty[Any] else arrayItems.toArray[Any])
val isNumeric = ((anything: Any) => (if (anything.isInstanceOf[Byte] || anything.isInstanceOf[Int] || anything.isInstanceOf[Long] || anything.isInstanceOf[Short] || anything.isInstanceOf[Double] || anything.isInstanceOf[Float] || anything.isInstanceOf[BigInt] || anything.isInstanceOf[BigDecimal]) true else false): Boolean)
def jsonStringify(anything: Any = null, indent: String = "    ", pretty: Boolean = false): String = {
    var indentLevel: Int = 0
    def jsonStringifyInner(anythingInner: Any, indentInner: String, prettyInner: Boolean): String = {
        if (anythingInner == null) return "null"
        if (anythingInner.isInstanceOf[String]) return s"\"${anythingInner}\""
        if (isNumeric(anythingInner) || anythingInner.isInstanceOf[Boolean]) return s"${anythingInner}"
        if (anythingInner.isInstanceOf[Array[_]]) {
            if (anythingInner.asInstanceOf[Array[Any]].length == 0) return "[]"
            indentLevel += 1
            var result: String = s"[${if (pretty == true) s"\n${indentInner * indentLevel}" else ""}"
            for ((arrayItem, arrayItemIndex) <- anythingInner.asInstanceOf[Array[Any]].zipWithIndex) {
                result += jsonStringifyInner(arrayItem, indentInner, prettyInner)
                if ((arrayItemIndex + 1) != anythingInner.asInstanceOf[Array[Any]].length) result += s",${if (pretty == false) " " else ""}${if (pretty == true) s"\n${indentInner * indentLevel}" else ""}"
            }
            indentLevel -= 1
            result += s"${if (pretty == true) s"\n${indentInner * indentLevel}" else ""}]"
            return result
        }
        if (anythingInner.isInstanceOf[Map[_, _]]) {
            if (anythingInner.asInstanceOf[Map[String, Any]].size == 0) return "{}"
            indentLevel += 1
            var result: String = s"{${if (pretty == true) s"\n${indentInner * indentLevel}" else ""}"
            for (((objectKey, objectValue), objectEntryIndex) <- anythingInner.asInstanceOf[Map[String, Any]].toArray[Any].zipWithIndex) {
                result += s"\"${objectKey}\": ${jsonStringifyInner(objectValue, indentInner, prettyInner)}"
                if ((objectEntryIndex + 1) != anythingInner.asInstanceOf[Map[String, Any]].size) result += s",${if (pretty == false) " " else ""}${if (pretty == true) s"\n${indentInner * indentLevel}" else ""}"
            }
            indentLevel -= 1
            result += s"${if (pretty == true) s"\n${indentInner * indentLevel}" else ""}}"
            return result
        }
        return "null"
    }
    jsonStringifyInner(anything, indent, pretty)
}

// ? function statement or function declaration

def getRectangleAreaV1(rectangleWidth: Int, rectangleLength: Int): Int = {
    return (rectangleWidth * rectangleLength)
}
// call the function example: getRectangleAreaV1(7, 5)

def getRectangleAreaV2(rectangleWidth: Int, rectangleLength: Int): Int = (rectangleWidth * rectangleLength)
// call the function example: getRectangleAreaV2(7, 5)

// ? function expression

// the best way
val getRectangleAreaV3 = new Function2[Int, Int, Int] {
    def apply(rectangleWidth: Int, rectangleLength: Int): Int = {
        return (rectangleWidth * rectangleLength): Int
    }
}
// call the function example: getRectangleAreaV3(7, 5)
// ! this type of function can't have explicit `return` 🤮
val getRectangleAreaV4 = { (rectangleWidth: Int, rectangleLength: Int) => (rectangleWidth * rectangleLength): Int }
// call the function example: getRectangleAreaV4(7, 5)
// ! this type of function can't have explicit `return` 🤮
val getRectangleAreaV5 = ((rectangleWidth: Int, rectangleLength: Int) => (rectangleWidth * rectangleLength): Int)
// call the function example: getRectangleAreaV5(7, 5)

// ? anonymous function

// new Function2[Int, Int, Int] {
//     def apply(rectangleWidth: Int, rectangleLength: Int): Int = {
//         return (rectangleWidth * rectangleLength): Int
//     }
// }

// ! this type of function can't have explicit `return` 🤮
// { (rectangleWidth: Int, rectangleLength: Int) => (rectangleWidth * rectangleLength): Int }

// ! this type of function can't have explicit `return` 🤮
// ((rectangleWidth: Int, rectangleLength: Int) => (rectangleWidth * rectangleLength): Int)

// ? Passing functions as arguments to other functions

def sayHello(callbackFunction: () => Unit): Unit = {
    println("hello")
    callbackFunction()
}

def sayHowAreYou(): Unit = {
    println("how are you?")
}

sayHello(sayHowAreYou _)

sayHello(new Function0[Unit] {
    def apply(): Unit = {
        println("how are you?")
    }
})

sayHello(() => {
    println("how are you?")
})

sayHello(() => println("how are you?"))

// ? Assigning functions to variables or storing them in data structures

val getRectangleAreaV3Copy = new Function2[Int, Int, Int] {
    def apply(rectangleWidth: Int, rectangleLength: Int): Int = {
        return (rectangleWidth * rectangleLength): Int
    }
}

val getRectangleAreaV4Copy = { (rectangleWidth: Int, rectangleLength: Int) => (rectangleWidth * rectangleLength): Int }

val getRectangleAreaV5Copy = ((rectangleWidth: Int, rectangleLength: Int) => (rectangleWidth * rectangleLength): Int)

val myArrayOfGetRectangleAreaFunctions = MyArray(
    getRectangleAreaV1 _,
    new Function2[Int, Int, Int] {
        def apply(rectangleWidth: Int, rectangleLength: Int): Int = {
            return (rectangleWidth * rectangleLength): Int
        }
    },
    { (rectangleWidth: Int, rectangleLength: Int) => (rectangleWidth * rectangleLength): Int },
    ((rectangleWidth: Int, rectangleLength: Int) => (rectangleWidth * rectangleLength): Int)
)
val getRectangleAreaFunctionResult1 = myArrayOfGetRectangleAreaFunctions.asInstanceOf[Array[Any]](0).asInstanceOf[(Int, Int) => Int](7, 5)
val getRectangleAreaFunctionResult2 = myArrayOfGetRectangleAreaFunctions.asInstanceOf[Array[Any]](1).asInstanceOf[(Int, Int) => Int](7, 5)
val getRectangleAreaFunctionResult3 = myArrayOfGetRectangleAreaFunctions.asInstanceOf[Array[Any]](2).asInstanceOf[(Int, Int) => Int](7, 5)
val getRectangleAreaFunctionResult4 = myArrayOfGetRectangleAreaFunctions.asInstanceOf[Array[Any]](3).asInstanceOf[(Int, Int) => Int](7, 5)

def exponentiation(a: Int, b: Int): Int = {
    return Math.pow(a, b).toInt: Int
}

val simpleCalculator = MyObject(
    "exponentiation" -> exponentiation _,
    "multiplication" -> new Function2[Int, Int, Int] {
        def apply(a: Int, b: Int): Int = {
            return (a * b): Int
        }
    },
    "addition" -> { (a: Int, b: Int) => (a + b): Int },
    "subtraction" -> ((a: Int, b: Int) => (a - b): Int)
)
val simpleCalculatorResult1 = simpleCalculator.asInstanceOf[Map[String, Any]]("exponentiation").asInstanceOf[(Int, Int) => Int](2, 4)
val simpleCalculatorResult2 = simpleCalculator.asInstanceOf[Map[String, Any]]("multiplication").asInstanceOf[(Int, Int) => Int](7, 5)
val simpleCalculatorResult3 = simpleCalculator.asInstanceOf[Map[String, Any]]("addition").asInstanceOf[(Int, Int) => Int](9, 3)
val simpleCalculatorResult4 = simpleCalculator.asInstanceOf[Map[String, Any]]("subtraction").asInstanceOf[(Int, Int) => Int](35, 8)

// ? Returning functions as values from other functions

def multiplyV1(a: Int): (Int) => Int = {
    return new Function1[Int, Int] {
        def apply(b: Int): Int = {
            return (a * b): Int
        }
    }
}
val multiplyBy2 = multiplyV1(2)
val multiplyBy2Result = multiplyBy2.asInstanceOf[(Int) => Int](10) // 20

def multiplyV2(a: Int): (Int) => Int = {
    return { (b: Int) => (a * b): Int }
}
val multiplyBy3 = multiplyV2(3)
val multiplyBy3Result = multiplyBy3.asInstanceOf[(Int) => Int](10) // 30

def multiplyV3(a: Int): (Int) => Int = {
    return ((b: Int) => (a * b): Int)
}
val multiplyBy4 = multiplyV3(4)
val multiplyBy4Result = multiplyBy4.asInstanceOf[(Int) => Int](10) // 40

def multiplyV4(a: Int): (Int) => Int = { (b: Int) => (a * b): Int }
val multiplyBy5 = multiplyV4(5)
val multiplyBy5Result = multiplyBy5.asInstanceOf[(Int) => Int](10) // 50

def multiplyV5(a: Int): (Int) => Int = ((b: Int) => (a * b): Int)
val multiplyBy6 = multiplyV5(6)
val multiplyBy6Result = multiplyBy6.asInstanceOf[(Int) => Int](10) // 60

val multiplyV6 = new Function1[Int, (Int) => Int] {
    def apply(a: Int): (Int) => Int = {
        return new Function1[Int, Int] {
            def apply(b: Int): Int = {
                return (a * b): Int
            }
        }
    }
}
val multiplyBy7 = multiplyV6.asInstanceOf[(Int) => (Int) => Int](7)
val multiplyBy7Result = multiplyBy7.asInstanceOf[(Int) => Int](10) // 70

val multiplyV7 = new Function1[Int, (Int) => Int] {
    def apply(a: Int): (Int) => Int = {
        return { (b: Int) => (a * b): Int }
    }
}
val multiplyBy8 = multiplyV7.asInstanceOf[(Int) => (Int) => Int](8)
val multiplyBy8Result = multiplyBy8.asInstanceOf[(Int) => Int](10) // 80

val multiplyV8 = new Function1[Int, (Int) => Int] {
    def apply(a: Int): (Int) => Int = {
        return ((b: Int) => (a * b): Int)
    }
}
val multiplyBy9 = multiplyV8.asInstanceOf[(Int) => (Int) => Int](9)
val multiplyBy9Result = multiplyBy9.asInstanceOf[(Int) => Int](10) // 90

val multiplyV9 = { (a: Int) => { (b: Int) => (a * b): Int } }
val multiplyBy10 = multiplyV9.asInstanceOf[(Int) => (Int) => Int](10)
val multiplyBy10Result = multiplyBy10.asInstanceOf[(Int) => Int](10) // 100

val multiplyV10 = { (a: Int) => ((b: Int) => (a * b): Int) }
val multiplyBy11 = multiplyV10.asInstanceOf[(Int) => (Int) => Int](11)
val multiplyBy11Result = multiplyBy11.asInstanceOf[(Int) => Int](10) // 110

val multiplyV11 = ((a: Int) => ((b: Int) => (a * b): Int))
val multiplyBy12 = multiplyV11.asInstanceOf[(Int) => (Int) => Int](12)
val multiplyBy12Result = multiplyBy12.asInstanceOf[(Int) => Int](10) // 120
