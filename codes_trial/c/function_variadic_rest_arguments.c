#include <stdio.h>
#include <stdarg.h>

void functionVariadic(int firstArgument, ...) {
    va_list restArguments;
    va_start(restArguments, firstArgument);
    int value = firstArgument;

    while (value != NULL) {
        printf("%d ", value);
        value = va_arg(restArguments, int);
    }

    va_end(restArguments);
    printf("\n");
}

int main() {
    functionVariadic(1, 2, 3, 4, NULL);
    return 0;
}
