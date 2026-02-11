#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int a;
    int (*func)(struct MultiplyClosure*, int);
} MultiplyClosure;

int multiplyFunc(MultiplyClosure* closure, int b) {
    return closure->a * b;
}

MultiplyClosure* multiply(int a) {
    MultiplyClosure* closure = malloc(sizeof(MultiplyClosure));
    closure->a = a;
    closure->func = multiplyFunc;
    return closure;
}

int main() {
    MultiplyClosure* multiplyBy2 = multiply(2);
    int multiplyBy2Result = multiplyBy2->func(multiplyBy2, 10);
    free(multiplyBy2);
    return 0;
}
