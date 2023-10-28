// Compile and run the application command:
// kotlinc Array.every.kt -include-runtime -d Array.every.jar && kotlin Array.every.jar

fun main() {
    println("\n// Array.every() in Kotlin mutableListOf")

    val numbers = mutableListOf(12, 34, 27, 23, 65, 93, 36, 87, 4, 254);
    println("numbers $numbers");
    
    val isAllNumberLessThan500 = numbers.all { number -> number % 2 < 500 }
    println("is all number < 500: $isAllNumberLessThan500");
    // is all number < 500: true

    val isAllNumberMoreThan500 = numbers.all { number -> number % 2> 500 }
    println("is all number > 500: $isAllNumberMoreThan500");
    // is all number > 500: false

    println("\n// Array.every() in Kotlin mutableListOf of mutableMapOfs")

    val products = mutableListOf(
        mutableMapOf<String, Any>(
            "code" to "pasta",
            "price" to 321
        ),
        mutableMapOf<String, Any>(
            "code" to "bubble_gum",
            "price" to 233
        ),
        mutableMapOf<String, Any>(
            "code" to "potato_chips",
            "price" to 5
        ),
        mutableMapOf<String, Any>(
            "code" to "towel",
            "price" to 499
        )
    )
    println("products ${products.joinToString(separator = ", ", prefix = "[", postfix = "]")}");
    println("products $products");
    // products [{code=pasta, price=321}, {code=bubble_gum, price=233}, {code=potato_chips, price=5}, {code=towel, price=499}]

    val isAllProductPriceLessThan500 = products.all { product -> (product["price"] as? Int ?: 0) < 500 }
    println("is all product price < 500: $isAllProductPriceLessThan500")
    // is all product price < 500: true

    val isAnyProductPriceMoreThan500 = products.any { product -> (product["price"] as? Int ?: 0) > 500 }
    println("is any product price > 500: $isAnyProductPriceMoreThan500")
    // is all product price > 500: false
}