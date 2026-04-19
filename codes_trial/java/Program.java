import java.util.Objects;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.AbstractMap;

@SuppressWarnings("unchecked")
public class Program {
    @FunctionalInterface
    interface VariadicFunctionExpression<Result> {
        Result apply(Object... args);
    }
    public static Object optionalChaining(Object callbackFunction) {
        try {
            return (((VariadicFunctionExpression<Object>) callbackFunction).apply());
        }
        catch (Throwable throwable) {
            return null;
        }
    }
    public static ArrayList<Object> createNewArray(Object... restArguments) {
        ArrayList<Object> newArray = new ArrayList<>();
        for (Object currentArgument : restArguments) {
            newArray.add(currentArgument);
        }
        return newArray;
    }
    public static AbstractMap.SimpleEntry<String, Object> createNewObjectEntry(Object objectKey, Object objectValue) {
        return new AbstractMap.SimpleEntry<String, Object>(((String) objectKey), objectValue);
    }
    public static HashMap<String, Object> createNewObject(Object... restArguments) {
        HashMap<String, Object> newObject = new HashMap<>();
        for (int arrayItemIndex = 0; arrayItemIndex < restArguments.length; arrayItemIndex += 1) {
            Object currentArgument = restArguments[arrayItemIndex];
            Object objectKey = (((AbstractMap.SimpleEntry<String, Object>) currentArgument).getKey());
            Object objectValue = (((AbstractMap.SimpleEntry<String, Object>) currentArgument).getValue());
            newObject.put((String) objectKey, objectValue);
        }
        return newObject;
    }
    public static HashMap<String, Object> jsLikeType = createNewObject(
        createNewObjectEntry("Null", "Null"),
        createNewObjectEntry("Boolean", "Boolean"),
        createNewObjectEntry("String", "String"),
        createNewObjectEntry("Numeric", "Numeric"),
        createNewObjectEntry("Object", "Object"),
        createNewObjectEntry("Array", "Array"),
        createNewObjectEntry("Function", "Function")
    );
    public static Object arrayReduce(Object callbackFunction, Object anyArray, Object initialValue) {
        // JavaScript-like Array.reduce() function
        Object result = initialValue;
        for (int arrayItemIndex = 0; arrayItemIndex < ((ArrayList<Object>) anyArray).size(); arrayItemIndex += 1) {
            Object arrayItem = ((ArrayList<Object>) anyArray).get(arrayItemIndex);
            result = (((VariadicFunctionExpression<Object>) callbackFunction).apply(result, arrayItem, arrayItemIndex, anyArray));
        }
        return result;
    }
    public static boolean isLikeJsNull(Object anything) {
        return (anything == null);
    }
    public static boolean isLikeJsBoolean(Object anything) {
        if (isLikeJsNull(anything) == true) return false;
        return (anything instanceof Boolean);
    }
    public static boolean isLikeJsString(Object anything) {
        if (isLikeJsNull(anything) == true) return false;
        return (anything instanceof String);
    }
    public static boolean isLikeJsNumeric(Object anything) {
        if (isLikeJsNull(anything) == true) return false;
        return (anything instanceof Number);
    }
    public static boolean isLikeJsObject(Object anything) {
        if ((anything instanceof HashMap) == false) return false;
        for (Object objectKey : ((HashMap<?, ?>) anything).keySet()) {
            if ((objectKey instanceof String) == false) return false;
        }
        for (Object objectValue : ((HashMap<?, ?>) anything).values()) {
            if ((objectValue instanceof Object) == false) return false;
        }
        return true;
    }
    public static boolean isLikeJsArray(Object anything) {
        if ((anything instanceof ArrayList) == false) return false;
        for (Object arrayItem : ((ArrayList<?>) anything)) {
            if ((arrayItem instanceof Object) == false) return false;
        }
        return true;
    }
    public static boolean isLikeJsFunction(Object anything) {
        if (isLikeJsNull(anything) == true) return false;
        return (anything instanceof VariadicFunctionExpression);
    }
    public static String getType(Object anything) {
        if (isLikeJsNull(anything) == true) return ((String) jsLikeType.get("Null"));
        if (isLikeJsBoolean(anything) == true) return ((String) jsLikeType.get("Boolean"));
        if (isLikeJsString(anything) == true) return ((String) jsLikeType.get("String"));
        if (isLikeJsNumeric(anything) == true) return ((String) jsLikeType.get("Numeric"));
        if (isLikeJsObject(anything) == true) return ((String) jsLikeType.get("Object"));
        if (isLikeJsArray(anything) == true) return ((String) jsLikeType.get("Array"));
        if (isLikeJsFunction(anything) == true) return ((String) jsLikeType.get("Function"));
        return anything.getClass().getName();
    }
    public static Object nullishCoalescingV1(Object anything, Object defaultValue) {
        return Objects.requireNonNullElse(anything, defaultValue);
    }
    public static Object nullishCoalescingV2(Object anything, Object defaultValue) {
        return Objects.requireNonNullElseGet(anything, () -> defaultValue);
    }
    public static Object nullishCoalescingV3(Object anything, Object defaultValue) {
        return ((isLikeJsNull(anything) == true) ? defaultValue : anything);
    }
    public static Object nullishCoalescing(Object anything, Object defaultValue) {
        return ((isLikeJsNull(anything) == true) ? defaultValue : anything);
    }
    public static Object jsonStringify(Object anything, Object pretty) {
        // custom JSON.stringify() function
        Object indent = ((String) " ").repeat(4);
        Object indentLevel = ((int) 0);
        Object jsonStringifyInner = ((VariadicFunctionExpression<Object>) (restArguments) -> {
            Object anythingInner = restArguments[0];
            Object anythingInnerType = getType(anythingInner);
            if (anythingInnerType.equals(jsLikeType.get("Null")) == true) return "null";
            return anythingInnerType;
        });
        return (((VariadicFunctionExpression<Object>) jsonStringifyInner).apply(anything));
    }
    public static Object jsonStringify(Object anything) {
        // custom JSON.stringify() function
        Object pretty = false;
        Object indent = ((String) " ").repeat(4);
        Object indentLevel = ((int) 0);
        Object jsonStringifyInner = ((VariadicFunctionExpression<Object>) (restArguments) -> {
            Object anythingInner = restArguments[0];
            Object anythingInnerType = getType(anythingInner);
            if (anythingInnerType.equals(jsLikeType.get("Null")) == true) return "null";
            if (anythingInnerType.equals(jsLikeType.get("String")) == true) return ("\"" + ((String) anythingInner) + "\"");
            if (anythingInnerType.equals(jsLikeType.get("Numeric")) == true) return (String.valueOf(anythingInner));
            if (anythingInnerType.equals(jsLikeType.get("Boolean")) == true) return (String.valueOf(anythingInner));
            if (anythingInnerType.equals(jsLikeType.get("Object")) == true) {
                for (int objectEntryIndex = 0; objectEntryIndex < ((HashMap<String, Object>) anythingInner).size(); objectEntryIndex += 1) {
                    // Object arrayItem = ((ArrayList<Object>) anyArray).get(arrayItemIndex);
                    // result = (((VariadicFunctionExpression<Object>) callbackFunction).apply(result, arrayItem, arrayItemIndex, anyArray));
                }
            }
            if (anythingInnerType.equals(jsLikeType.get("Array")) == true) return (String.valueOf(anythingInner));
            return anythingInnerType;
        });
        return (((VariadicFunctionExpression<Object>) jsonStringifyInner).apply(anything));
    }
    public static void main(String[] args) {
        try {
            Object something = "foo";
            System.out.println("something: " + ((String) jsonStringify(something)) + " (" + getType(something) + ")");
            something = 123;
            System.out.println("something: " + ((String) jsonStringify(something)) + " (" + getType(something) + ")");
            something = true;
            System.out.println("something: " + ((String) jsonStringify(something)) + " (" + getType(something) + ")");
            something = null;
            System.out.println("something: " + ((String) jsonStringify(something)) + " (" + getType(something) + ")");
            something = createNewArray(1, 2, 3, "asd");
            System.out.println("something: " + ((String) jsonStringify(something)) + " (" + getType(something) + ")");
            something = createNewObject(createNewObjectEntry("foo", "bar"));
            System.out.println("something: " + ((String) jsonStringify(something)) + " (" + getType(something) + ")");

            something = ((VariadicFunctionExpression<Object>) (restArguments) -> (((double) restArguments[0]) + ((double) restArguments[1])));

            // System.out.println("getType(something):" + " (" + getType(something) + ")");
            // System.out.println("something: " + ((double) ((VariadicFunctionExpression<Object>) something).apply((double) 1, (double) 2)));
        } catch (Throwable throwable) {
            System.out.println("Caught a Throwable: " + throwable);
        }
    }
}
