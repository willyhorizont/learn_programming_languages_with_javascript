import java.util.HashMap;
import java.util.Arrays;

class oret2 {
    public static void main(String[] args) {
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