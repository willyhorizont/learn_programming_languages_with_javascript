#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdarg.h>

#include "utils.c"
/* 
JsLikeAny* sayHello(JsLikeAny* languageVariadicArgumentsFirstArgument, ...) {
    JsLikeAny* callbackFunction = languageVariadicArgumentsFirstArgument;
    printf("hello\n");
    callJsLikeFunction(callbackFunction, NULL);
    freeMemory(callbackFunction);

    return createJsLikeNull();
}
 */
/* 
 JsLikeAny* sayHowAreYou(JsLikeAny* languageVariadicArgumentsFirstArgument, ...) {
    printf("how are you?\n");

    return createJsLikeNull();
}
 */
/* 
JsLikeAny* multiplyBy(JsLikeAny* languageVariadicArgumentsFirstArgument, ...) {
    va_list vaList;
    va_start(vaList, languageVariadicArgumentsFirstArgument);
    JsLikeAny** restArguments = va_arg(vaList, JsLikeAny**);
    va_end(vaList);

    JsLikeAny* jsLikeFunctionParentLocalScopeVariable = restArguments[1];
    JsLikeAny* b = languageVariadicArgumentsFirstArgument;
    JsLikeAny* a = getJsLikeFunctionParentLocalScopeVariableValue(jsLikeFunctionParentLocalScopeVariable, "a");

    if (!a || !b) {
        return createJsLikeNull();
    }

    if ((JS_LIKE_INT == (*a).type) && (JS_LIKE_INT == (*b).type)) {
        return createJsLikeNumeric(((JsLikeInt)((JS_LIKE_INT == (*a).value.jsLikeInt) ? (*a).value.jsLikeInt : (*a).value.jsLikeInt)) * ((JsLikeInt)((JS_LIKE_INT == (*b).value.jsLikeInt) ? (*b).value.jsLikeInt : (*b).value.jsLikeInt)));
    }

    return createJsLikeNull();
}
 */
/* 
JsLikeAny* multiply(JsLikeAny* languageVariadicArgumentsFirstArgument, ...) {
    JsLikeAny* a = languageVariadicArgumentsFirstArgument;

    return createJsLikeFunction(&multiplyBy, createJsLikeObject(createJsLikeObjectEntry("a", a)));
}
 */
int main() {
    printf("Hello, World!");

    /*
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
    */

    JsLikeAny* something = NULL;
    reassignValue(&something, createJsLikeString("foo"));
    reassignValue(&something, createJsLikeNumeric(123));
    reassignValue(&something, createJsLikeNumeric(123.789));
    reassignValue(&something, createJsLikeNumeric(-123));
    reassignValue(&something, createJsLikeNumeric(-123.789));
    reassignValue(&something, createJsLikeBoolean(true));
    reassignValue(&something, createJsLikeBoolean(false));
    reassignValue(&something, createJsLikeNull());
    reassignValue(&something, createJsLikeArray(createJsLikeNumeric(1), createJsLikeNumeric(2), createJsLikeNumeric(3)));
    reassignValue(&something, createJsLikeObject(createJsLikeArray(createJsLikeString("foo"), createJsLikeString("bar"))));

    freeMemory(something);

    /*
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
    */
   // TODO

    /*
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
    */
    JsLikeAny* myObject = createJsLikeObject(
        createJsLikeArray(createJsLikeString("my_string"), createJsLikeString("foo")),
        createJsLikeArray(createJsLikeString("my_numeric_1"), createJsLikeNumeric(123)),
        createJsLikeArray(createJsLikeString("my_numeric_2"), createJsLikeNumeric(123.789)),
        createJsLikeArray(createJsLikeString("my_numeric_3"), createJsLikeNumeric(-123)),
        createJsLikeArray(createJsLikeString("my_numeric_4"), createJsLikeNumeric(-123.789)),
        createJsLikeArray(createJsLikeString("my_boolean_1"), createJsLikeBoolean(true)),
        createJsLikeArray(createJsLikeString("my_boolean_2"), createJsLikeBoolean(false)),
        createJsLikeArray(createJsLikeString("my_null"), createJsLikeNull()),
        createJsLikeArray(createJsLikeString("my_array"), createJsLikeArray(createJsLikeNumeric(1), createJsLikeNumeric(2), createJsLikeNumeric(3))),
        createJsLikeArray(createJsLikeString("my_object"), createJsLikeObject(createJsLikeArray(createJsLikeString("foo"), createJsLikeString("bar"))))
    );

    /*
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
    */
    JsLikeAny* myArray = createJsLikeArray(
        createJsLikeString("foo"),
        createJsLikeNumeric(123),
        createJsLikeNumeric(123.789),
        createJsLikeNumeric(-123),
        createJsLikeNumeric(-123.789),
        createJsLikeBoolean(true),
        createJsLikeBoolean(false),
        createJsLikeNull(),
        createJsLikeArray(createJsLikeNumeric(1), createJsLikeNumeric(2), createJsLikeNumeric(3)),
        createJsLikeObject(createJsLikeArray(createJsLikeString("foo"), createJsLikeString("bar")))
    );

    /*
x. support passing functions as arguments to other functions
    */
    // sayHello(createJsLikeFunction(&sayHowAreYou, NULL), NULL);

    /*
x. support returning functions as values from other functions
    */
    // JsLikeAny* multiplyBy2 = multiply(createJsLikeNumeric(2));
    // JsLikeAny* multiplyBy2Result = callJsLikeFunction(multiplyBy2, createJsLikeNumeric(10), NULL);
    // if (JS_LIKE_INT == (*multiplyBy2Result).type) {
    //     printf("multiplyBy2Result: %lld\n", ((JS_LIKE_INT == (*multiplyBy2Result).value.jsLikeInt) ? (*multiplyBy2Result).value.jsLikeInt : (*multiplyBy2Result).value.jsLikeInt));
    // }
    // freeMemory(multiplyBy2);

    JsLikeAny* myString = createJsLikeString("foo");
    JsLikeAny* myNumberOne = createJsLikeNumeric(123);
    JsLikeAny* myNumberTwo = createJsLikeNumeric(123.789);
    JsLikeAny* myNumberThree = createJsLikeNumeric(-123);
    JsLikeAny* myNumberFour = createJsLikeNumeric(-123.789);
    JsLikeAny* myBooleanOne = createJsLikeBoolean(true);
    JsLikeAny* myBooleanTwo = createJsLikeBoolean(false);
    JsLikeAny* myNull = createJsLikeNull();

    freeMemory(myString);
    freeMemory(myNumberOne);
    freeMemory(myNumberTwo);
    freeMemory(myNumberThree);
    freeMemory(myNumberFour);
    freeMemory(myBooleanOne);
    freeMemory(myBooleanTwo);
    freeMemory(myNull);
    freeMemory(myArray);
    freeMemory(myObject);
return 0;}
