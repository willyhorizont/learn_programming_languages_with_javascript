import java.util.HashMap;

@FunctionalInterface
interface LambdaArgs2<Args1, Args2, Result> {
    Result apply(Args1 args1, Args2 args2);
}

public class deletesoon {
    public static void main(String[] args) {
        Object[] myArray2 = new Object[]{(LambdaArgs2<Integer, Integer, Integer>) (a, b) -> a * b};

        // Retrieve the first element of myArray2 and execute as a function
        // LambdaArgs2<Integer, Integer, Integer> arrayFunction = (LambdaArgs2<Integer, Integer, Integer>) myArray2[0];
        // int arrayResult = ((LambdaArgs2<Integer, Integer, Integer>) myArray2[0]).apply(2, 3);
        System.out.println("Result from myArray2: " + ((LambdaArgs2<Integer, Integer, Integer>) myArray2[0]).apply(2, 3)); // Output: Result from myArray2: 6

        // Create a HashMap to store the lambda expression
        HashMap<String, Object> myObject2 = new HashMap<>();
        myObject2.put("my_function", (LambdaArgs2<Integer, Integer, Integer>) (a, b) -> a * b);

        // Retrieve the lambda expression from myObject2 using its key and execute as a function
        LambdaArgs2<Integer, Integer, Integer> function = (LambdaArgs2<Integer, Integer, Integer>) myObject2.get("my_function");
        int functionResult = function.apply(2, 3);
        System.out.println("Result from myObject2: " + functionResult); // Output: Result from myObject2: 6
    }
}
