/* eslint-disable func-names */

const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("// Variadic Function Rest Arguments in JavaScript");

function functionV1Variadic(...restArguments) {
    console.log(`function v1 variadic rest arguments: ${jsonStringify(restArguments)}`);
}
functionV1Variadic(1, 2, 3, 4);

const functionV2Variadic = function (...restArguments) {
    console.log(`function v2 variadic rest arguments: ${jsonStringify(restArguments)}`);
};
functionV2Variadic(1, 2, 3, 4);

const functionV3Variadic = (...restArguments) => {
    console.log(`function v3 variadic rest arguments: ${jsonStringify(restArguments)}`);
};
functionV3Variadic(1, 2, 3, 4);

const functionV4Variadic = (...restArguments) => console.log(`function v4 variadic rest arguments: ${jsonStringify(restArguments)}`);
functionV4Variadic(1, 2, 3, 4);
