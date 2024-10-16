import scala.collection.mutable

println("Hello, World!")

var something: Any = "foo"

something = Array(1, 2, 3).asInstanceOf[Array[_]].map(_.asInstanceOf[Any]).asInstanceOf[Array[Any]]

for ((value, index) <- something.asInstanceOf[Array[_]].map(_.asInstanceOf[Any]).asInstanceOf[Array[Any]].zipWithIndex) {
    println(s"Index $index: $value")
}

something = Map(
    "foo" -> "bar",
    "asd" -> "zxc",
    "hello" -> "world",
).asInstanceOf[Map[String, Any]]

for (((key, value), index) <- something.asInstanceOf[Map[String, Any]].toList.zipWithIndex) {
    println(s"Index ${index + 1}: Key: $key, Value: $value")
}

def isNumeric(anything: Any): Boolean = anything match {
    case _: Byte => true
    case _: Int => true
    case _: Long => true
    case _: Short => true
    case _: Double => true
    case _: Float => true
    case _: BigInt => true
    case _: BigDecimal => true
    case _ => false
}

def getTypeAsString(anything: Any): String = anything match {
    case m: Map[_, _] if m.asInstanceOf[Map[Any, Any]].keySet.forall(_.isInstanceOf[String]) => "Map[String, Any]"
    case _: Array[Any] => "Array[Any]"
    case _: String => "String"
    case _: Boolean => "Boolean"
    case _: Byte => "Byte"
    case _: Int => "Int"
    case _: Long => "Long"
    case _: Short => "Short"
    case _: Double => "Double"
    case _: Float => "Float"
    case _: BigInt => "BigInt"
    case _: BigDecimal => "BigDecimal"
    case null => "null"
    case _ => "Unknown"
}

def doSomething(asd: Int, zxc: Int = 666, qwe: Int = 69): Unit = {
    println("asd: " + asd)
    println("zxc: " + zxc)
    println("qwe: " + qwe)
}
doSomething(27, qwe = 45)

def isNumericV1(anything: Any): Boolean = anything match {
    case _: Byte | _: Int | _: Long | _: Short | _: Double | _: Float | _: BigInt | _: BigDecimal => true
    case _ => false
}

def isNumericV2(anything: Any): Boolean = (if (anything.isInstanceOf[Byte] || anything.isInstanceOf[Int] || anything.isInstanceOf[Long] || anything.isInstanceOf[Short] || anything.isInstanceOf[Double] || anything.isInstanceOf[Float] || anything.isInstanceOf[BigInt] || anything.isInstanceOf[BigDecimal]) true else false)

val isNumericV3 = ((anything: Any) => (if (anything.isInstanceOf[Byte] || anything.isInstanceOf[Int] || anything.isInstanceOf[Long] || anything.isInstanceOf[Short] || anything.isInstanceOf[Double] || anything.isInstanceOf[Float] || anything.isInstanceOf[BigInt] || anything.isInstanceOf[BigDecimal]) true else false): Boolean)

var emptyMap: Map[String, Any] = Map.empty[String, Any]

// Add a new key-value pair to the emptyMap
emptyMap += ("newKey" -> "newValue")

// Print the updated map
println(emptyMap)

def toDoubleV1(anything: Any): Double = {
    if (anything.isInstanceOf[Byte]) return anything.asInstanceOf[Byte].toDouble
    if (anything.isInstanceOf[Int]) return anything.asInstanceOf[Int].toDouble
    if (anything.isInstanceOf[Long]) return anything.asInstanceOf[Long].toDouble
    if (anything.isInstanceOf[Short]) return anything.asInstanceOf[Short].toDouble
    if (anything.isInstanceOf[Double]) return anything.asInstanceOf[Double].toDouble
    if (anything.isInstanceOf[Float]) return anything.asInstanceOf[Float].toDouble
    if (anything.isInstanceOf[BigInt]) return anything.asInstanceOf[BigInt].toDouble
    if (anything.isInstanceOf[BigDecimal]) return anything.asInstanceOf[BigDecimal].toDouble
    return 0.0
}

val toDoubleV2 = ((anything: Any) => (if (anything.isInstanceOf[Byte]) anything.asInstanceOf[Byte].toDouble else (if (anything.isInstanceOf[Int]) anything.asInstanceOf[Int].toDouble else (if (anything.isInstanceOf[Long]) anything.asInstanceOf[Long].toDouble else (if (anything.isInstanceOf[Short]) anything.asInstanceOf[Short].toDouble else (if (anything.isInstanceOf[Double]) anything.asInstanceOf[Double].toDouble else (if (anything.isInstanceOf[Float]) anything.asInstanceOf[Float].toDouble else (if (anything.isInstanceOf[BigInt]) anything.asInstanceOf[BigInt].toDouble else (if (anything.isInstanceOf[BigDecimal]) anything.asInstanceOf[BigDecimal].toDouble else 0.0)))))))): Double)

def MyArrayV1(arrayItem: Any*): Array[Any] = if (arrayItem.toArray[Any].length == 0) Array.empty[Any].asInstanceOf[Array[Any]] else arrayItem.toArray[Any]

def MyArrayV2(arrayItem: Any*): Array[Any] = (if (arrayItem.isEmpty) Array.empty[Any] else arrayItem.toArray[Any])

def MyObjectV1(anObject: Any): Map[String, Any] = if (anObject.asInstanceOf[Map[String, Any]].size == 0) Map.empty[String, Any].asInstanceOf[Map[String, Any]] else anObject.asInstanceOf[Map[String, Any]]

def MyObjectV2(objectEntry: (String, Any)*): Map[String, Any] = (if (objectEntry.isEmpty) Map.empty[String, Any] else objectEntry.toMap[String, Any])

def MyObjectV3(objectEntry: (String, Any)*): mutable.Map[String, Any] = (if (objectEntry.isEmpty) mutable.Map.empty[String, Any] else mutable.Map(objectEntry: _*))

import scala.collection.immutable.ArraySeq

// def createObject(objectEntry: (String, Any)*): mutable.Map[String, Any] = (if (objectEntry.isEmpty) mutable.Map.empty[String, Any] else mutable.Map(objectEntry: _*))

val createObject = new Function1[Array[(String, Any)], mutable.Map[String, Any]] {
    def apply(objectEntry: Array[(String, Any)]): mutable.Map[String, Any] = {
        return (if (objectEntry.isEmpty) mutable.Map.empty[String, Any] else mutable.Map(ArraySeq.unsafeWrapArray(objectEntry.toArray): _*)): mutable.Map[String, Any]
    }
}
