const anyRecursiveFunction = (i = 1) => {
    if (i > 5) return;
    console.log(`i: ${i}`);
    return anyRecursiveFunction(i + 1);
}
anyRecursiveFunction();
