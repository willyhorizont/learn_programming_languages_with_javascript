import java.util.HashMap;
import java.util.Map;
import java.util.function.IntUnaryOperator;
import java.util.function.BiFunction;

import static java.util.Map.entry;

@FunctionalInterface
interface LambdaArgs2<Args1, Args2, Result> {
    Result apply(Args1 args1, Args2 args2);
}

@FunctionalInterface
interface LambdaArgs3<Args1, Args2, Args3, Result> {
    Result apply(Args1 args1, Args2 args2, Args3 args3);
}

@FunctionalInterface
interface LambdaArgs4<Args1, Args2, Args3, Args4, Result> {
    Result apply(Args1 args1, Args2 args2, Args3 args3, Args4 args4);
}

class yyy_requirements {
    public static void main(String[] args) {
        /*
        1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type
        ```javascript
        let something = "foo";
        console.log("something:", something);
        something = 123;
        console.log("something:", something);
        something = true;
        console.log("something:", something);
        something = null;
        console.log("something:", something);
        something = [1, 2, 3];
        console.log("something:", something);
        something = { "foo": "bar" };
        console.log("something:", something);
        ```
        */
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
        something = new HashMap<String, Object>(Map.ofEntries(
            entry("foo", "bar")
        ));
        System.out.println("something: " + something);

        /*
        3. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
        ```javascript
        const myObject = {
            "my_string": "foo",
            "my_number": 17,
            "my_bool": true,
            "my_null": null,
            "my_object": {
                "foo": "bar"
            },
            "my_array": [1, 2, 3]
        };
        console.log("myObject: ", myObject);
        ```
        */
        Object myObject = new HashMap<String, Object>() {
            {
                put("my_string", "foo");
                put("my_number", 17);
                put("my_bool", true);
                put("my_null", null);
                put("my_object", new HashMap<String, Object>() {
                    {
                        put("foo", "bar");
                    }
                });
                put("my_array", new Object[]{1, 2, 3});
            }
        };
        System.out.println("myObject: " + myObject);

        /*
        4. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
        ```javascript
        const myArray = ["foo", 17, true, null, [1, 2, 3], { "foo": "bar" }];
        console.log("myArray: ", myArray);
        ```
        */
        Object myArray = new Object[]{"foo", 17, true, null, new Object[]{1, 2, 3}, new HashMap<String, Object>() {
            {
                put("foo", "bar");
            }
        }};
        System.out.println("myArray: " + myArray);

        /*
        5. support passing functions as arguments to other functions
        ```javascript
        function sayHello(callbackFunction) {
            console.log("hello");
            callbackFunction();
        }
        function sayHowAreYou() {
            console.log("how are you?");
        }
        sayHello(sayHowAreYou);
        sayHello(function () {
            console.log("how are you?");
        });
        ```
        */
        sayHello(() -> {
            System.out.println("how are you?");
        });

        /*
        6. support returning functions as values from other functions
        ```javascript
        function multiply(a) {
            return function (b) {
                return a * b;
            };
        }
        const multiplyBy2 = multiply(2);
        const multiplyBy2Result = multiplyBy2(10); // 20
        console.log("multiplyBy2Result: ", multiplyBy2Result);
        ```
        */
        IntUnaryOperator multiplyBy2 = multiply(2);
        int multiplyBy2Result = multiplyBy2.applyAsInt(10); // 20
        System.out.println("multiplyBy2Result: " + multiplyBy2Result);

        /*
        7. support assigning functions to variables
        ```javascript
        const getRectangleArea = function (rectangleWidth, rectangleLength) {
            return rectangleWidth * rectangleLength;
        };
        console.log("getRectangleArea(3, 4): ", getRectangleArea(3, 4));
        ```
        */
        BiFunction<Integer, Integer, Integer> getRectangleArea = (rectangleWidth, rectangleLength) -> {
            return rectangleWidth * rectangleLength;
        };
        System.out.println("getRectangleArea.apply(3, 4): " + getRectangleArea.apply(3, 4));
        LambdaArgs2<Integer, Integer, Integer> getRectangleArea = (rectangleWidth, rectangleLength) -> {
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
    }
    public static void sayHello(Runnable callbackFunction) {
        System.out.println("hello");
        callbackFunction.run();
    }
    public static IntUnaryOperator multiply(int a) {
        return (b) -> {
            return a * b;
        };
    }
}
