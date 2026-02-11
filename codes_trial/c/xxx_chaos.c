#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdarg.h>

int* createArray(int firstArgument, ...) {
    int* newArray = NULL;
    int newArrayLength = 0;

    va_list restArguments;
    va_start(restArguments, firstArgument);

    for (int currentArgument = firstArgument; (currentArgument != -1); currentArgument = va_arg(restArguments, int)) {
        newArrayLength += 1;
        newArray = realloc(newArray, (newArrayLength * sizeof(int)));
        newArray[newArrayLength - 1] = currentArgument;
    }

    va_end(restArguments);

    newArrayLength += 1;
    newArray = realloc(newArray, (newArrayLength * sizeof(int)));
    newArray[newArrayLength - 1] = -1;

    return newArray;
}

int main() {
    int* myArray = createArray(
        1,
        2,
        3,
        -1
    );

    for (int i = 0; (myArray[i] != -1); i += 1) {
        printf("myArray: %lld\n", myArray[i]);
    }
return 0;}
