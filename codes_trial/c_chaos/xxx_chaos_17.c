#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdarg.h>

#include "utils.c"

any* sayHello(any* firstArgument, ...) {
    va_list vaList;
    va_start(vaList, firstArgument);
    
    /*
    for (any* currentArgument = firstArgument; (currentArgument != NULL); currentArgument = va_arg(vaList, any*)) {
        // do something with currentArgument
    }
    */

    va_end(vaList);

    any* callbackFunction = firstArgument;
    printf("hello\n");
    callJsLikeFunction(callbackFunction, NULL);
    freeMemory(callbackFunction);

    return createJsLikeNull();
}

any* sayHowAreYou(any* firstArgument, ...) {
    va_list vaList;
    va_start(vaList, firstArgument);

    /*
    for (any* currentArgument = firstArgument; (currentArgument != NULL); currentArgument = va_arg(vaList, any*)) {
        // do something with currentArgument
    }
    */

    va_end(vaList);

    printf("how are you?\n");

    return createJsLikeNull();
}

any* multiplyBy(any* firstArgument, ...) {
    va_list vaList;
    va_start(vaList, firstArgument);

    /*
    for (any* currentArgument = firstArgument; (currentArgument != NULL); currentArgument = va_arg(vaList, any*)) {
        // do something with currentArgument
    }
    */

    any** restArguments = va_arg(vaList, any**);
    any* this = restArguments[0];

    // va_end(vaList);

    any* b = firstArgument;
    any* a = getJsLikeFunctionParentLocalScopeVariableValue(this, "a");

    if (!a || !b) {
        va_end(vaList);
        return createJsLikeNull();
    }

    if ((ANY_NUMERIC == (*a).type) && (ANY_NUMERIC == (*b).type)) {
        long double aInNumeric = ((ANY_NUMERIC_INT == (*a).value.jsLikeNumeric.type) ? (*a).value.jsLikeNumeric.value.jsLikeNumericInt : (*a).value.jsLikeNumeric.value.jsLikeNumericFloat);
        long double bInNumeric = ((ANY_NUMERIC_INT == (*b).value.jsLikeNumeric.type) ? (*b).value.jsLikeNumeric.value.jsLikeNumericInt : (*b).value.jsLikeNumeric.value.jsLikeNumericFloat);

        va_end(vaList);
        return createJsLikeNumeric(aInNumeric * bInNumeric);
    }

    va_end(vaList);
    return createJsLikeNull();
}

any* multiply(any* firstArgument, ...) {
    va_list vaList;
    va_start(vaList, firstArgument);

    /*
    for (any* currentArgument = firstArgument; (currentArgument != NULL); currentArgument = va_arg(vaList, any*)) {
        // do something with currentArgument
    }
    */

    va_end(vaList);

    any* a = firstArgument;

    return createJsLikeFunction(&multiplyBy, createJsLikeObject(createJsLikeObjectEntry("a", a), NULL));
}

int main() {
    /*
x. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
    */
    any* something = NULL;
    reassignValue(&something, createJsLikeString("foo"));
    reassignValue(&something, createJsLikeNumeric(123));
    reassignValue(&something, createJsLikeNumeric(123.789));
    reassignValue(&something, createJsLikeNumeric(-123));
    reassignValue(&something, createJsLikeNumeric(-123.789));
    reassignValue(&something, createJsLikeBoolean(true));
    reassignValue(&something, createJsLikeBoolean(false));
    reassignValue(&something, createJsLikeNull());
    reassignValue(&something, createJsLikeArray(createJsLikeNumeric(1), createJsLikeNumeric(2), createJsLikeNumeric(3), NULL));
    reassignValue(&something, createJsLikeObject(createJsLikeObjectEntry("foo", createJsLikeString("bar")), NULL));

    freeMemory(something);

    /*
x. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
    */
   // TODO

    /*
x. object/dictionary/associative-array/hash/hashmap/map/unordered-list-key-value-pair-data-structure can store dynamic data type and dynamic value
    */
    any* myObject = createJsLikeObject(
        createJsLikeObjectEntry("my_string", createJsLikeString("foo")),
        createJsLikeObjectEntry("my_numeric_1", createJsLikeNumeric(123)),
        createJsLikeObjectEntry("my_numeric_2", createJsLikeNumeric(123.789)),
        createJsLikeObjectEntry("my_numeric_3", createJsLikeNumeric(-123)),
        createJsLikeObjectEntry("my_numeric_4", createJsLikeNumeric(-123.789)),
        createJsLikeObjectEntry("my_boolean_1", createJsLikeBoolean(true)),
        createJsLikeObjectEntry("my_boolean_2", createJsLikeBoolean(false)),
        createJsLikeObjectEntry("my_null", createJsLikeNull()),
        createJsLikeObjectEntry("my_array", createJsLikeArray(createJsLikeNumeric(1), createJsLikeNumeric(2), createJsLikeNumeric(3), NULL)),
        createJsLikeObjectEntry("my_object", createJsLikeObject(createJsLikeObjectEntry("foo", createJsLikeString("bar")), NULL)),
    NULL);

    /*
x. array/list/slice/ordered-list-data-structure can store dynamic data type and dynamic value
    */
    any* myArray = createJsLikeArray(
        createJsLikeString("foo"),
        createJsLikeNumeric(123),
        createJsLikeNumeric(123.789),
        createJsLikeNumeric(-123),
        createJsLikeNumeric(-123.789),
        createJsLikeBoolean(true),
        createJsLikeBoolean(false),
        createJsLikeNull(),
        createJsLikeArray(createJsLikeNumeric(1), createJsLikeNumeric(2), createJsLikeNumeric(3), NULL),
        createJsLikeObject(createJsLikeObjectEntry("foo", createJsLikeString("bar")), NULL),
    NULL);

    /*
x. support passing functions as arguments to other functions
    */
    sayHello(createJsLikeFunction(&sayHowAreYou, NULL), NULL);

    /*
x. support returning functions as values from other functions
    */
    any* multiplyBy2 = multiply(createJsLikeNumeric(2));
    any* multiplyBy2Result = callJsLikeFunction(multiplyBy2, createJsLikeNumeric(10), NULL);
    if (ANY_NUMERIC == (*multiplyBy2Result).type) {
        printf("multiplyBy2Result: %.17Lg\n", ((ANY_NUMERIC_INT == (*multiplyBy2Result).value.jsLikeNumeric.type) ? (*multiplyBy2Result).value.jsLikeNumeric.value.jsLikeNumericInt : (*multiplyBy2Result).value.jsLikeNumeric.value.jsLikeNumericFloat));
    }
    freeMemory(multiplyBy2);



    any* myString = createJsLikeString("foo");
    any* myNumberOne = createJsLikeNumeric(123);
    any* myNumberTwo = createJsLikeNumeric(123.789);
    any* myNumberThree = createJsLikeNumeric(-123);
    any* myNumberFour = createJsLikeNumeric(-123.789);
    any* myBooleanOne = createJsLikeBoolean(true);
    any* myBooleanTwo = createJsLikeBoolean(false);
    any* myNull = createJsLikeNull();

    if (ANY_STRING == (*myString).type) {
        printf("myString: %s\n", (*myString).value.jsLikeString);
    } else {
        printf("myString: not myString\n");
    }

    if ((ANY_NUMERIC == (*myNumberOne).type) && (ANY_NUMERIC_INT == (*myNumberOne).value.jsLikeNumeric.type)) {
        printf("myNumberOne: %lld\n", (*myNumberOne).value.jsLikeNumeric.value.jsLikeNumericInt);
    } else {
        printf("myNumberOne: not myNumberOne\n");
    }

    if ((ANY_NUMERIC == (*myNumberTwo).type) && (ANY_NUMERIC_FLOAT == (*myNumberTwo).value.jsLikeNumeric.type)) {
        printf("myNumberTwo: %.17Lg\n", (*myNumberTwo).value.jsLikeNumeric.value.jsLikeNumericFloat);
    } else {
        printf("myNumberTwo: not myNumberTwo\n");
    }

    if ((ANY_NUMERIC == (*myNumberThree).type) && (ANY_NUMERIC_INT == (*myNumberThree).value.jsLikeNumeric.type)) {
        printf("myNumberThree: %lld\n", (*myNumberThree).value.jsLikeNumeric.value.jsLikeNumericInt);
    } else {
        printf("myNumberThree: not myNumberThree\n");
    }

    if ((ANY_NUMERIC == (*myNumberFour).type) && (ANY_NUMERIC_FLOAT == (*myNumberFour).value.jsLikeNumeric.type)) {
        printf("myNumberFour: %.17Lg\n", (*myNumberFour).value.jsLikeNumeric.value.jsLikeNumericFloat);
    } else {
        printf("myNumberFour: not myNumberFour\n");
    }

    if (ANY_BOOL == (*myBooleanOne).type) {
        printf("myBooleanOne: %s\n", ((*myBooleanOne).value.jsLikeBoolean ? "true" : "false"));
    } else {
        printf("myBooleanOne: not myBooleanOne\n");
    }

    if (ANY_BOOL == (*myBooleanTwo).type) {
        printf("myBooleanTwo: %s\n", ((*myBooleanTwo).value.jsLikeBoolean ? "true" : "false"));
    } else {
        printf("myBooleanTwo: not myBooleanTwo\n");
    }

    if (ANY_NULL == (*myNull).type) {
        printf("myNull: null\n");
    } else {
        printf("myNull: not myNull\n");
    }

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
