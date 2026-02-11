import {
    jsonStringify,
} from "./utils.js";

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
