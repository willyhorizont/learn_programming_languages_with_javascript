Object optionalChaining = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    try {
        Object callbackFunction = restArguments[0];
        return (((VariadicFunctionExpression<Object>) (callbackFunction)).apply());
    } catch (Throwable throwable) {
        return null;
    }
}));

Object createVariable = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object anything = (((VariadicFunctionExpression<Object>) (optionalChaining)).apply(((VariadicFunctionExpression<Object>) ((optionalChainingRestArguments) -> (restArguments[0])))));
    return ((Object[]) (new Object[]{anything}));
}));

Object createNewArray = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object newArray = new ArrayList<Object>();
    for (Object currentArgumentIndex = 0; (((int) (currentArgumentIndex)) < restArguments.length); currentArgumentIndex = (((int) (currentArgumentIndex)) + 1)) {
        Object currentArgument = restArguments[((int) (currentArgumentIndex))];
        ((ArrayList<Object>) (newArray)).add(currentArgument);
    }
    return newArray;
}));

Object createNewObjectEntry = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object objectKey = restArguments[0];
    Object objectValue = restArguments[1];
    return new AbstractMap.SimpleEntry<String, Object>(((String) (objectKey)), objectValue);
}));

Object createNewObject = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object newObject = new HashMap<String, Object>();
    for (Object currentArgumentIndex = 0; (((int) (currentArgumentIndex)) < restArguments.length); currentArgumentIndex = (((int) (currentArgumentIndex)) + 1)) {
        Object currentArgument = restArguments[((int) (currentArgumentIndex))];
        Object objectKey = (((AbstractMap.SimpleEntry<String, Object>) currentArgument).getKey());
        Object objectValue = (((AbstractMap.SimpleEntry<String, Object>) currentArgument).getValue());
        ((HashMap<String, Object>) (newObject)).put((String) (objectKey), objectValue);
    }
    return newObject;
}));

Object jsLikeType = ((VariadicFunctionExpression<Object>) (createNewObject)).apply(
    (((VariadicFunctionExpression<Object>) (createNewObjectEntry)).apply("Null", "Null")),
    (((VariadicFunctionExpression<Object>) (createNewObjectEntry)).apply("Boolean", "Boolean")),
    (((VariadicFunctionExpression<Object>) (createNewObjectEntry)).apply("String", "String")),
    (((VariadicFunctionExpression<Object>) (createNewObjectEntry)).apply("Numeric", "Numeric")),
    (((VariadicFunctionExpression<Object>) (createNewObjectEntry)).apply("Object", "Object")),
    (((VariadicFunctionExpression<Object>) (createNewObjectEntry)).apply("Array", "Array")),
    (((VariadicFunctionExpression<Object>) (createNewObjectEntry)).apply("Function", "Function"))
);

Object arrayReduce = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    // JavaScript-like Array.reduce() function
    Object callbackFunction = restArguments[0];
    Object anyArray = restArguments[1];
    Object initialValue = restArguments[2];
    Object result = initialValue;
    for (Object arrayItemIndex = 0; (((int) (arrayItemIndex)) < (((ArrayList<Object>) (anyArray)).size())); arrayItemIndex = (((int) (arrayItemIndex)) + 1)) {
        Object arrayItem = (((ArrayList<Object>) (anyArray)).get(((int) (arrayItemIndex))));
        result = (((VariadicFunctionExpression<Object>) (callbackFunction)).apply(result, arrayItem, arrayItemIndex, anyArray));
    }
    return result;
}));

Object isLikeJsNull = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object anything = restArguments[0];
    return (anything == null);
}));

Object isLikeJsBoolean = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object anything = restArguments[0];
    if (((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsNull)).apply(anything))) == true) return false;
    return (anything instanceof Boolean);
}));

Object isLikeJsString = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object anything = restArguments[0];
    if (((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsNull)).apply(anything))) == true) return false;
    return (anything instanceof String);
}));

Object isLikeJsNumeric = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object anything = restArguments[0];
    if (((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsNull)).apply(anything))) == true) return false;
    return (anything instanceof Number);
}));

Object isLikeJsObject = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object anything = restArguments[0];
    if (((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsNull)).apply(anything))) == true) return false;
    if ((anything instanceof HashMap) == false) return false;
    for (Map.Entry<?, ?> objectEntry : ((HashMap<?, ?>) anything).entrySet()) {
        Object objectKey = objectEntry.getKey();
        Object objectValue = objectEntry.getValue();
        if ((objectKey instanceof String) == false) return false;
        if ((objectValue instanceof Object) == false) return false;
    }
    return true;
}));

Object isLikeJsArray = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object anything = restArguments[0];
    if (((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsNull)).apply(anything))) == true) return false;
    if ((anything instanceof ArrayList) == false) return false;
    for (Object arrayItem : ((ArrayList<?>) anything)) {
        if ((arrayItem instanceof Object) == false) return false;
    }
    return true;
}));

Object isLikeJsFunction = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object anything = restArguments[0];
    if (((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsNull)).apply(anything))) == true) return false;
    return (anything instanceof VariadicFunctionExpression);
}));

Object getType = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object anything = restArguments[0];
    if (((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsNull)).apply(anything))) == true) return ((String) ((HashMap<String, Object>) (jsLikeType)).get("Null"));
    if (((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsBoolean)).apply(anything))) == true) return ((String) ((HashMap<String, Object>) (jsLikeType)).get("Boolean"));
    if (((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsString)).apply(anything))) == true) return ((String) ((HashMap<String, Object>) (jsLikeType)).get("String"));
    if (((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsNumeric)).apply(anything))) == true) return ((String) ((HashMap<String, Object>) (jsLikeType)).get("Numeric"));
    if (((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsObject)).apply(anything))) == true) return ((String) ((HashMap<String, Object>) (jsLikeType)).get("Object"));
    if (((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsArray)).apply(anything))) == true) return ((String) ((HashMap<String, Object>) (jsLikeType)).get("Array"));
    if (((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsFunction)).apply(anything))) == true) return ((String) ((HashMap<String, Object>) (jsLikeType)).get("Function"));
    return (anything.getClass().getName());
}));

Object nullishCoalescing = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object anything = restArguments[0];
    Object defaultValue = restArguments[1];
    return ((((boolean) (((VariadicFunctionExpression<Object>) (isLikeJsNull)).apply(anything))) == true) ? defaultValue : anything);
}));

Object jsonStringify = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    // custom JSON.stringify() function
    Object anything = restArguments[0];
    Object pretty = (((VariadicFunctionExpression<Object>) (nullishCoalescing)).apply(((VariadicFunctionExpression<Object>) (optionalChaining)).apply(((VariadicFunctionExpression<Object>) ((optionalChainingRestArguments) -> (restArguments[1])))), false));
    Object indent = (((String) " ").repeat(4));
    Object indentLevel = (((VariadicFunctionExpression<Object>) (createVariable)).apply(0));
    Object jsonStringifyInner = (((VariadicFunctionExpression<Object>) (createVariable)).apply());
    (((Object[]) (jsonStringifyInner))[0]) = ((VariadicFunctionExpression<Object>) ((restArgumentsInner) -> {
        Object anythingInner = restArgumentsInner[0];
        Object anythingInnerType = (((VariadicFunctionExpression<Object>) (getType)).apply(anythingInner));
        if ((((String) (anythingInnerType)).equals(((HashMap<String, Object>) (jsLikeType)).get("Null"))) == true) return "null";
        if ((((String) (anythingInnerType)).equals(((HashMap<String, Object>) (jsLikeType)).get("String"))) == true) return ("\"" + ((String) anythingInner) + "\"");
        if ((((String) (anythingInnerType)).equals(((HashMap<String, Object>) (jsLikeType)).get("Numeric"))) == true) return (String.valueOf(anythingInner));
        if ((((String) (anythingInnerType)).equals(((HashMap<String, Object>) (jsLikeType)).get("Boolean"))) == true) return (String.valueOf(anythingInner));
        if ((((String) (anythingInnerType)).equals(((HashMap<String, Object>) (jsLikeType)).get("Object"))) == true) {
            if ((((HashMap<String, Object>) anythingInner).size()) == 0) return "{}";
            (((Object[]) (indentLevel))[0]) = (((int) (((Object[]) (indentLevel))[0])) + 1);
            Object result = (((VariadicFunctionExpression<Object>) (createVariable)).apply((((boolean) pretty) == true) ? ("{\n" + (((String) (indent)).repeat((int) (((Object[]) (indentLevel))[0])))) : "{ "));
            Object objectEntryIndex = (((VariadicFunctionExpression<Object>) (createVariable)).apply(0));
            for (Map.Entry<String, Object> objectEntry : ((HashMap<String, Object>) anythingInner).entrySet()) {
                Object objectKey = objectEntry.getKey();
                Object objectValue = objectEntry.getValue();
                (((Object[]) (result))[0]) = (((String) (((Object[]) (result))[0])) + "\"" + objectKey + "\": " + ((String) ((VariadicFunctionExpression<Object>) (((Object[]) (jsonStringifyInner))[0])).apply(objectValue)));
                if ((((int) (((Object[]) objectEntryIndex)[0])) + 1) != (((HashMap<String, Object>) anythingInner).size())) {
                    (((Object[]) (result))[0]) = (((String) (((Object[]) (result))[0])) + ((((boolean) pretty) == true) ? (",\n" + (((String) (indent)).repeat((int) (((Object[]) (indentLevel))[0])))) : ", "));
                }
                (((Object[]) objectEntryIndex)[0]) = (((int) (((Object[]) objectEntryIndex)[0])) + 1);
            }
            (((Object[]) (indentLevel))[0]) = (((int) (((Object[]) (indentLevel))[0])) - 1);
            (((Object[]) (result))[0]) = (((String) (((Object[]) (result))[0])) + ((((boolean) pretty) == true) ? ("\n" + (((String) (indent)).repeat((int) (((Object[]) (indentLevel))[0]))) + "}") : " }"));
            return (((Object[]) (result))[0]);
        }
        if ((((String) (anythingInnerType)).equals(((HashMap<String, Object>) (jsLikeType)).get("Array"))) == true) {
            if ((((ArrayList<Object>) (anythingInner)).size()) == 0) return "[]";
            (((Object[]) (indentLevel))[0]) = (((int) (((Object[]) (indentLevel))[0])) + 1);
            Object result = (((VariadicFunctionExpression<Object>) (createVariable)).apply((((boolean) pretty) == true) ? ("[\n" + (((String) (indent)).repeat((int) (((Object[]) (indentLevel))[0])))) : "["));
            for (Object arrayItemIndex = 0; (((int) (arrayItemIndex)) < (((ArrayList<Object>) (anythingInner)).size())); arrayItemIndex = (((int) (arrayItemIndex)) + 1)) {
                Object arrayItem = (((ArrayList<Object>) (anythingInner)).get(((int) (arrayItemIndex))));
                (((Object[]) (result))[0]) = (((String) (((Object[]) (result))[0])) + ((String) ((VariadicFunctionExpression<Object>) (((Object[]) (jsonStringifyInner))[0])).apply(arrayItem)));
                if (((int) (arrayItemIndex) + 1) != (((ArrayList<Object>) (anythingInner)).size())) {
                    (((Object[]) (result))[0]) = (((String) (((Object[]) (result))[0])) + ((((boolean) pretty) == true) ? (",\n" + (((String) (indent)).repeat((int) (((Object[]) (indentLevel))[0])))) : ", "));
                }
            }
            (((Object[]) (indentLevel))[0]) = (((int) (((Object[]) (indentLevel))[0])) - 1);
            (((Object[]) (result))[0]) = (((String) (((Object[]) (result))[0])) + ((((boolean) pretty) == true) ? ("\n" + (((String) (indent)).repeat((int) (((Object[]) (indentLevel))[0]))) + "]") : "]"));
            return (((Object[]) (result))[0]);
        }
        if ((((String) (anythingInnerType)).equals(((HashMap<String, Object>) (jsLikeType)).get("Function"))) == true) return "[object Function]";
        return anythingInnerType;
    }));
    return (((VariadicFunctionExpression<Object>) (((Object[]) (jsonStringifyInner))[0])).apply(anything));
}));

Object stringInterpolation = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    return (((VariadicFunctionExpression<Object>) (arrayReduce)).apply(((VariadicFunctionExpression<Object>) ((arrayReduceRestArguments) -> {
        Object currentResult = arrayReduceRestArguments[0];
        Object currentArgument = arrayReduceRestArguments[1];
        Object currentArgumentType = (((VariadicFunctionExpression<Object>) (getType)).apply(currentArgument));
        return (((String) (currentResult)) + (((((String) (currentArgumentType)).equals(((HashMap<String, Object>) (jsLikeType)).get("String"))) == true) ? ((String) (currentArgument)) : ((((((String) (currentArgumentType)).equals(((HashMap<String, Object>) (jsLikeType)).get("Array"))) == true) && ((((ArrayList<Object>) (currentArgument)).size()) == 1)) ? ((String) (((VariadicFunctionExpression<Object>) (jsonStringify)).apply(((VariadicFunctionExpression<Object>) (optionalChaining)).apply(((VariadicFunctionExpression<Object>) ((optionalChainingRestArguments) -> (((ArrayList<Object>) (currentArgument)).get(0)))))))) : ((String) (((VariadicFunctionExpression<Object>) (jsonStringify)).apply(currentArgument))))));
    })), new ArrayList<Object>(Arrays.asList(restArguments)), ""));
}));

Object consoleLog = ((VariadicFunctionExpression<Object>) ((restArguments) -> {
    System.out.println((((VariadicFunctionExpression<Object>) (stringInterpolation)).apply(restArguments)) + "\n");
    return null;
}));

System.out.println("arrayReduce test result: " + ((VariadicFunctionExpression<Object>) arrayReduce).apply(((VariadicFunctionExpression<Object>) ((restArguments) -> {
    Object currentResult = restArguments[0];
    Object currentValue = restArguments[1];
    return (((int) (currentResult)) + ((int) (currentValue)));
})), (((VariadicFunctionExpression<Object>) (createNewArray)).apply(1, 2, 3)), 0));

Object something = "foo";

// ((VariadicFunctionExpression<Object>) (consoleLog)).apply("something: ", ((String) (((VariadicFunctionExpression<Object>) (jsonStringify)).apply(something))));
System.out.println(((String) (((VariadicFunctionExpression<Object>) (stringInterpolation)).apply("key: ", "value"))));

System.out.println("something: " + ((String) (((VariadicFunctionExpression<Object>) (jsonStringify)).apply(something))));
something = 123;
System.out.println("something: " + ((String) (((VariadicFunctionExpression<Object>) (jsonStringify)).apply(something))));
something = true;
System.out.println("something: " + ((String) (((VariadicFunctionExpression<Object>) (jsonStringify)).apply(something))));
something = null;
System.out.println("something: " + ((String) (((VariadicFunctionExpression<Object>) (jsonStringify)).apply(something))));
something = ((VariadicFunctionExpression<Object>) (createNewArray)).apply(1, 2, 3);
System.out.println("something: " + ((String) (((VariadicFunctionExpression<Object>) (jsonStringify)).apply(something))));
something = ((VariadicFunctionExpression<Object>) (createNewObject)).apply(((VariadicFunctionExpression<Object>) (createNewObjectEntry)).apply("foo", "bar"));
System.out.println("something: " + ((String) (((VariadicFunctionExpression<Object>) (jsonStringify)).apply(something))));
