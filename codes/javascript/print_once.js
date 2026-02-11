import {
    printOnce,
    jsonStringify,
} from "./utils.js";

const printOnceV1 = (() => {
    const keySet = new Set();
    return (anything, { key, title, formatter = ((anythingInner) => anythingInner) } = {}) => {
        const anyStringKey = (key || title || "first");
        if (keySet.has(anyStringKey)) return anything;
        keySet.add(anyStringKey);
        console.log(`${title ? `${title}: ` : ""}${formatter(anything)}`);
        return anything;
    };
})();

const printOnceV2 = printOnce;

const numbers = [12, 34, 27, 23, 65, 93, 36, 87, 4, 254];
console.log(`numbers: ${jsonStringify(numbers)}`);

numbers.forEach((anyNumber) => {
    printOnceV1(`printOnceV1: only print number once: ${anyNumber}`);
});

numbers.forEach((anyNumber) => {
    printOnceV2(`printOnceV2: only print number once: ${anyNumber}`);
});
