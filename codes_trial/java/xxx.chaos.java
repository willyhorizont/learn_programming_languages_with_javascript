import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.function.IntUnaryOperator;
import java.util.function.BiFunction;

import static java.util.Map.entry;

@FunctionalInterface
interface LambdaArgs3<Args1, Args2, Args3, Result> {
    Result apply(Args1 args1, Args2 args2, Args3 args3);
}

@FunctionalInterface
interface LambdaArgs4<Args1, Args2, Args3, Args4, Result> {
    Result apply(Args1 args1, Args2 args2, Args3 args3, Args4 args4);
}

class Program {
    public static void main(String[] args) {
        Object something = 123;
        System.out.println("something: " + something);
        something = 123;
        System.out.println("something: " + something);
        something = true;
        System.out.println("something: " + something);
        something = null;
        System.out.println("something: " + something);
        something = new Object[]{1, 2, 3};
        System.out.println("something: " + something);
        something = new HashMap<String, Object>() {
            {
                put("foo", "bar");
            }
        };
        System.out.println("something: " + something);
        something = new HashMap<String, Object>(Map.of("foo", "bar"));
        System.out.println("something: " + something);
        something = new HashMap<String, Object>(Map.ofEntries(
            entry("foo", "bar")
        ));
        System.out.println("something: " + something);
        something = Map.of("foo", "bar");
        System.out.println("something: " + something);
        something = Map.ofEntries(
            entry("foo", "bar")
        );
        System.out.println("something: " + something);

        BiFunction<Integer, Integer, Integer> getRectangleArea = (rectangleWidth, rectangleLength) -> {
            return rectangleWidth * rectangleLength;
        };
        System.out.println("getRectangleArea.apply(3, 4): " + getRectangleArea.apply(3, 4));
        LambdaArgs3<Integer, Integer, Integer, Integer> getCubeVolume = (cubeWidth, cubeLength, cubeHeight) -> {
            return cubeWidth * cubeLength * cubeHeight;
        };
        System.out.println("getCubeVolume.apply(3, 4, 5): " + getCubeVolume.apply(3, 4, 5));
        LambdaArgs4<Integer, Integer, Integer, Integer, Integer> multiplyArgs5 = (mult1, mult2, mult3, mult4) -> {
            return mult1 * mult2 * mult3 * mult4;
        };
        System.out.println("multiplyArgs5.apply(3, 4, 5, 6): " + multiplyArgs5.apply(3, 4, 5, 6));

        HashMap<String, Object> jason = new HashMap<String, Object>() {{
            put("int", 123);
            put("string", "hello");
            put("bool", false);
            put("float,decimal,double", 67.8);
            put("array", new Object[] {1,2,3});
            put("object", new HashMap<String, Object>() {{
                put("string2", "world");
            }});
            put("null", null);
        }};
        System.out.println(jason.get("string"));
        System.out.println(jason);

        Object[] products = {
            new HashMap<String, Object>() {{
                put("code", "pasta");
                put("price", 30);
            }},
            new HashMap<String, Object>() {{
                put("code", "bubble_gum");
                put("price", 233);
            }},
            new HashMap<String, Object>() {{
                put("code", "potato_chips");
                put("price", 5);
            }},
            new HashMap<String, Object>() {{
                put("code", "towel");
                put("price", 499);
            }},
        };
        System.out.println(products[0]);

        HashMap<String, Object> obj = new HashMap<String, Object>() {{
            put("greet", "hello_world");
        }};

        System.out.println(obj.get("greet"));

        // Object[] cheapProductsOnly = Arrays.stream(products).filter(product -> product.get("price") <= 100).toArray();
        // System.out.println(cheapProductsOnly[0]);

        int[] nums = {12, 34, 27, 23, 65, 93, 36, 87, 4, 254};
        int[] evenNums = Arrays.stream(nums).filter(num -> num % 2 == 0).toArray();
        for (int evenNum : evenNums){
            System.out.println(evenNum);
        }

        // String [] myArray = {"1", "2", "3", "4"};
        // Integer[] integerList = Arrays.stream(myArray).map(Integer::valueOf).toArray(Integer[]::new);
        // System.out.print(integerList[0]);
    }
}