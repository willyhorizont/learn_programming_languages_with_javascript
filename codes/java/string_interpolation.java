import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.AbstractMap;
import java.util.Map;

@SuppressWarnings("unchecked")
public class Program {
    public static String jsTypeNull = "Null";
    public static String jsTypeString = "String";
    public static String jsTypeNumeric = "Numeric";
    public static String jsTypeBoolean = "Boolean";
    public static String jsTypeObject = "Object";
    public static String jsTypeArray = "Array";
    public static String jsTypeFunction = "Function";
    @FunctionalInterface
    public interface VariadicFunctionExpression<ReturnType> {
        ReturnType apply(Object... restArguments);
    }
    public static Object optionalChaining(VariadicFunctionExpression<Object> callbackFunction) {
        try {
            return callbackFunction.apply();
        } catch (Throwable throwable) {
            return null;
        }
    }
    public static Object[] createVariable(Object anything) {
        return new Object[]{optionalChaining((optionalChainingRestArguments) -> anything)};
    }
    public static ArrayList<Object> createNewArray(Object... restArguments) {
        ArrayList<Object> newArray = new ArrayList<Object>();
        for (int currentArgumentIndex = 0; (currentArgumentIndex < restArguments.length); currentArgumentIndex += 1) {
            newArray.add(restArguments[currentArgumentIndex]);
        }
        return newArray;
    }
    public static AbstractMap.SimpleEntry<String, Object> createNewObjectEntry(String objectKey, Object objectValue) {
        AbstractMap.SimpleEntry<String, Object> newObjectEntry = new AbstractMap.SimpleEntry<String, Object>(((String) (objectKey)), objectValue);
        return newObjectEntry;
    }
    public static HashMap<String, Object> createNewObject(Object... restArguments) {
        HashMap<String, Object> newObject = new HashMap<String, Object>();
        for (int currentArgumentIndex = 0; (currentArgumentIndex < restArguments.length); currentArgumentIndex += 1) {
            AbstractMap.SimpleEntry<String, Object> currentArgumentAsObjectEntry = (AbstractMap.SimpleEntry<String, Object>) restArguments[currentArgumentIndex];
            String objectKey = currentArgumentAsObjectEntry.getKey();
            Object objectValue = currentArgumentAsObjectEntry.getValue();
            newObject.put(objectKey, objectValue);
        }
        return newObject;
    }
    public static Object arrayReduce(VariadicFunctionExpression<Object> callbackFunction, ArrayList<Object> anyArray, Object initialValue) {
        // JavaScript-like Array.reduce() function
        Object result = initialValue;
        for (int arrayItemIndex = 0; (arrayItemIndex < anyArray.size()); arrayItemIndex += 1) {
            Object arrayItem = anyArray.get(arrayItemIndex);
            result = (callbackFunction.apply(result, arrayItem, arrayItemIndex, anyArray));
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
        if (isLikeJsNull(anything) == true) return false;
        if ((anything instanceof HashMap) == false) return false;
        for (Map.Entry<?, ?> objectEntry : ((HashMap<?, ?>) anything).entrySet()) {
            Object objectKey = objectEntry.getKey();
            Object objectValue = objectEntry.getValue();
            if ((objectKey instanceof String) == false) return false;
            if ((objectValue instanceof Object) == false) return false;
        }
        return true;
    }
    public static boolean isLikeJsArray(Object anything) {
        if (isLikeJsNull(anything) == true) return false;
        if ((anything instanceof ArrayList) == false) return false;
        for (Object arrayItem : ((ArrayList<?>) anything)) {
            if ((arrayItem instanceof Object) == false) return false;
        }
        return true;
    }
    public static boolean isLikeJsFunction(Object anything) {
        if (isLikeJsNull(anything) == true) return false;
        if ((anything instanceof VariadicFunctionExpression) == false) return false;
        try {
            VariadicFunctionExpression<Object> callbackFunction = (VariadicFunctionExpression<Object>) anything;
            callbackFunction.apply();
            return true;
        } catch (Throwable throwable) {
            return false;
        }
    }
    public static String getType(Object anything) {
        if (isLikeJsNull(anything) == true) return jsTypeNull;
        if (isLikeJsBoolean(anything) == true) return jsTypeBoolean;
        if (isLikeJsString(anything) == true) return jsTypeString;
        if (isLikeJsNumeric(anything) == true) return jsTypeNumeric;
        if (isLikeJsObject(anything) == true) return jsTypeObject;
        if (isLikeJsArray(anything) == true) return jsTypeArray;
        if (isLikeJsFunction(anything) == true) return jsTypeFunction;
        return anything.getClass().getName();
    }
    public static Object nullishCoalescing(Object anything, Object defaultValue) {
        return ((isLikeJsNull(anything) == true) ? defaultValue : anything);
    }
    public static String jsonStringify(Object... restArguments) {
        // custom JSON.stringify() function
        Object anything = restArguments[0];
        boolean pretty = (boolean) nullishCoalescing(optionalChaining((optionalChainingRestArguments) -> restArguments[1]), false);
        String indent = " ".repeat(4);
        Object[] indentLevel = createVariable(0);
        Object[] jsonStringifyInner = createVariable(null);
        jsonStringifyInner[0] = (VariadicFunctionExpression<Object>) (restArgumentsInner) -> {
            Object anythingInner = restArgumentsInner[0];
            String anythingInnerType = getType(anythingInner);
            if (anythingInnerType.equals(jsTypeNull) == true) return "null";
            if (anythingInnerType.equals(jsTypeString) == true) return "\"" + ((String) anythingInner) + "\"";
            if (anythingInnerType.equals(jsTypeNumeric) == true) return String.valueOf(anythingInner);
            if (anythingInnerType.equals(jsTypeBoolean) == true) return String.valueOf(anythingInner);
            if (anythingInnerType.equals(jsTypeObject) == true) {
                HashMap<String, Object> anythingInnerAsObject = (HashMap<String, Object>) anythingInner;
                if (anythingInnerAsObject.size() == 0) return "{}";
                indentLevel[0] = (int) indentLevel[0] + 1;
                Object[] result = createVariable((pretty == true) ? ("{\n" + indent.repeat((int) indentLevel[0])) : "{ ");
                Object[] objectEntryIndex = createVariable(0);
                for (Map.Entry<String, Object> objectEntry : anythingInnerAsObject.entrySet()) {
                    String objectKey = objectEntry.getKey();
                    Object objectValue = objectEntry.getValue();
                    result[0] = (String) result[0] + "\"" + objectKey + "\": " + ((String) ((VariadicFunctionExpression<Object>) jsonStringifyInner[0]).apply(objectValue));
                    if (((int) objectEntryIndex[0] + 1) != anythingInnerAsObject.size()) {
                        result[0] = ((String) result[0] + ((((boolean) pretty) == true) ? (",\n" + indent.repeat((int) indentLevel[0])) : ", "));
                    }
                    objectEntryIndex[0] = (int) objectEntryIndex[0] + 1;
                }
                indentLevel[0] = (int) indentLevel[0] - 1;
                result[0] = (String) result[0] + ((pretty == true) ? ("\n" + indent.repeat((int) indentLevel[0]) + "}") : " }");
                return result[0];
            }
            if (anythingInnerType.equals(jsTypeArray) == true) {
                ArrayList<Object> anythingInnerAsArray = (ArrayList<Object>) anythingInner;
                if (anythingInnerAsArray.size() == 0) return "[]";
                indentLevel[0] = (int) indentLevel[0] + 1;
                Object[] result = createVariable((pretty == true) ? ("[\n" + indent.repeat((int) indentLevel[0])) : "[");
                for (int arrayItemIndex = 0; (arrayItemIndex < anythingInnerAsArray.size()); arrayItemIndex += 1) {
                    Object arrayItem = anythingInnerAsArray.get(arrayItemIndex);
                    result[0] = (String) result[0] + ((String) ((VariadicFunctionExpression<Object>) jsonStringifyInner[0]).apply(arrayItem));
                    if ((arrayItemIndex + 1) != anythingInnerAsArray.size()) {
                        result[0] = (String) result[0] + ((pretty == true) ? (",\n" + indent.repeat((int) indentLevel[0])) : ", ");
                    }
                }
                indentLevel[0] = (int) indentLevel[0] - 1;
                result[0] = (String) result[0] + ((pretty == true) ? ("\n" + indent.repeat((int) indentLevel[0]) + "]") : "]");
                return result[0];
            }
            if (anythingInnerType.equals(jsTypeFunction) == true) return "[object Function]";
            return anythingInnerType;
        };
        return (String) ((VariadicFunctionExpression<Object>) jsonStringifyInner[0]).apply(anything);
    }
    public static String stringInterpolation(Object... restArguments) {
        return (String) arrayReduce((arrayReduceRestArguments) -> {
            String currentResult = (String) arrayReduceRestArguments[0];
            Object currentArgument = arrayReduceRestArguments[1];
            String currentArgumentType = getType(currentArgument);
            return currentResult + ((currentArgumentType.equals("String") == true) ? currentArgument : ((((currentArgumentType.equals("Array")) == true) && ((((ArrayList<Object>) (currentArgument)).size()) == 1)) ? ((String) (jsonStringify(optionalChaining(((optionalChainingRestArguments) -> (((ArrayList<Object>) (currentArgument)).get(0))))))) : jsonStringify(currentArgument)));
        }, createNewArray(restArguments), "");
    }
    public static void consoleLog(Object... restArguments) {
        System.out.println(stringInterpolation(restArguments));
    }
    public static void main(String[] args) {
        consoleLog("// JavaScript-like Template literals / Template strings (String Interpolation) in Java (none :D)");
        Object myName = "Alisa";
        Object myAge = 25;
        consoleLog(stringInterpolation("my name is ", myName, " and I am ", myAge, "."));
        consoleLog(stringInterpolation("my name is ", createNewArray(myName), " and I am ", createNewArray(myAge), "."));

        consoleLog(stringInterpolation("1 + 2 + 3 + 4 = ", 1 + 2 + 3 + 4));
        consoleLog(stringInterpolation("1 + 2 + 3 + 4 = ", (1 + 2 + 3 + 4)));
        consoleLog(stringInterpolation("1 + 2 + 3 + 4 = ", createNewArray(1 + 2 + 3 + 4)));

        VariadicFunctionExpression<Object> getRectangleArea = (restArgumentsInner) -> {
            Object rectangleLength = restArgumentsInner[0];
            Object rectangleWidth = restArgumentsInner[1];
            return (int) rectangleWidth * (int) rectangleLength;
        };
        consoleLog(stringInterpolation("getRectangleArea(7, 5): ", getRectangleArea.apply(7, 5)));

        Object anyString = "foo";
        consoleLog(stringInterpolation("any string: ", jsonStringify(anyString)));
        Object anyNumeric = 123;
        consoleLog(stringInterpolation("any numeric: ", jsonStringify(anyNumeric)));
        Object anyBoolean = true;
        consoleLog(stringInterpolation("any boolean: ", jsonStringify(anyBoolean)));
        Object anyNull = null;
        consoleLog(stringInterpolation("any null: ", jsonStringify(anyNull)));
        Object anyArray = createNewArray(1, 2, 3);
        consoleLog(stringInterpolation("any array: ", jsonStringify(anyArray)));
        consoleLog(stringInterpolation("any array first element: ", jsonStringify(((ArrayList<Object>) anyArray).get(0))));
        Object anyObject = createNewObject(createNewObjectEntry("foo", "bar"));
        consoleLog(stringInterpolation("any object: ", jsonStringify(anyObject)));
        consoleLog(stringInterpolation("any object foo value: ", jsonStringify(((HashMap<String, Object>) anyObject).get("foo"))));
    }
}
