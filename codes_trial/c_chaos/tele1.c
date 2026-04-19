any* multiplyBy(any* this, any* anything) {
    if ((*anything).type != ANY_ARRAY) return createJsLikeNull();

    any* a = getJsLikeFunctionParentLocalScopeVariableValue(&this, craeteJsLikeString("a"));
    any* b = (*anything).value.jsLikeArray.value[0];

    if ((!a || !b) || (!((ANY_NUMERIC == (*a).type) && (ANY_NUMERIC == (*b).type)))) return createJsLikeNull();

    long double aInNumeric = ((ANY_NUMERIC_INT == (*a).value.jsLikeNumeric.type) ? (*a).value.jsLikeNumeric.value.jsLikeNumericInt : (*a).value.jsLikeNumeric.value.jsLikeNumericFloat);
    long double bInNumeric = ((ANY_NUMERIC_INT == (*b).value.jsLikeNumeric.type) ? (*b).value.jsLikeNumeric.value.jsLikeNumericInt : (*b).value.jsLikeNumeric.value.jsLikeNumericFloat);

    return createJsLikeNumeric(aInNumeric * bInNumeric);
}

any* multiply(any* this, any* anything) {
    if ((*anything).type != ANY_ARRAY) return createJsLikeNull();

    any* a = (*anything).value.jsLikeArray.value[0];

    return createJsLikeFunction(createJsLikeObject(createJsLikeObjectEntry("a", a)), &multiplyBy);
}

any* multiplyBy2 = multiply((JsLikeObjectEntry){ NULL, NULL }, createJsLikeNumeric(2));
any* multiplyBy2Result = callJsLikeFunction(&multiplyBy2, createJsLikeNumeric(10));
