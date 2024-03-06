import java.util.HashMap;
import java.util.function.IntUnaryOperator;

@FunctionalInterface
interface LambdaArgs2<Args1, Args2, Result> {
    Result apply(Args1 args1, Args2 args2);
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
        Object something = "foo";
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

        /*
        3. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
        ```javascript
        const myObject = {
            "my_string": "foo",
            "my_number": 123,
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
        HashMap<String, Object> myObject = new HashMap<String, Object>() {
            {
                put("my_string", "foo");
                put("my_number", 123);
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
        const myArray = ["foo", 123, true, null, [1, 2, 3], { "foo": "bar" }];
        console.log("myArray: ", myArray);
        ```
        */
        Object[] myArray = new Object[]{"foo", 123, true, null, new Object[]{1, 2, 3}, new HashMap<String, Object>() {
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
        const multiplyBy2Result = multiplyBy2(10);
        console.log("multiplyBy2Result: ", multiplyBy2Result);
        ```
        */
        IntUnaryOperator multiplyBy2 = multiply(2);
        int multiplyBy2Result = multiplyBy2.applyAsInt(10);
        System.out.println("multiplyBy2Result: " + multiplyBy2Result);

        /*
        7. support assigning functions to variables
        ```javascript
        const getRectangleArea = function (rectangleWidth, rectangleLength) {
            return rectangleWidth * rectangleLength;
        };
        console.log("getRectangleArea(7, 5): ", getRectangleArea(7, 5));
        ```
        */
        LambdaArgs2<Integer, Integer, Integer> getRectangleArea = (rectangleWidth, rectangleLength) -> {
            return rectangleWidth * rectangleLength;
        };
        System.out.println("getRectangleArea.apply(7, 5): " + getRectangleArea.apply(7, 5));

        /*
        8. support storing functions in data structures like array/list/slice/ordered-list-data-structure or object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure
        ```javascript
        const myArray2 = [
            function (a, b) {
                return a * b;
            },
            "foo",
            123,
            true,
            null,
            [1, 2, 3],
            { "foo": "bar" },
        ];
        console.log("myArray2[0](7, 5): ", myArray2[0](7, 5));

        const myObject2 = {
            "my_function": function (a, b) {
                return a * b;
            },
            "my_string": "foo",
            "my_number": 123,
            "my_bool": true,
            "my_null": null,
            "my_object": {
                "foo": "bar"
            },
            "my_array": [1, 2, 3]
        };
        console.log("myObject2.my_function(7, 5): ", myObject2.my_function(7, 5));
        ```
        */
        Object[] myArray2 = new Object[]{
            (LambdaArgs2<Integer, Integer, Integer>) (a, b) -> a * b,
            "foo",
            123,
            true,
            null,
            new Object[]{1, 2, 3},
            new HashMap<String, Object>() {
                {
                    put("foo", "bar");
                }
            }
        };
        System.out.println("myArray2[0](7, 5): " + ((LambdaArgs2<Integer, Integer, Integer>) myArray2[0]).apply(7, 5));

        HashMap<String, Object> myObject2 = new HashMap<String, Object>() {
            {
                put("my_function", (LambdaArgs2<Integer, Integer, Integer>) (a, b) -> a * b);
                put("my_string", "foo");
                put("my_number", 123);
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
        System.out.println("myObject2.my_function(7, 5): " + ((LambdaArgs2<Integer, Integer, Integer>) myObject2.get("my_function")).apply(7, 5));
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
