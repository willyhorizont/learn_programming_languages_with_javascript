/* eslint-disable func-names */

const jsonStringify = (anything, { pretty = false } = {}) => ((pretty === true) ? (JSON.stringify(anything, null, " ".repeat(4))) : (JSON.stringify(anything)?.split?.(",")?.join?.(", ")?.split?.(":")?.join?.(": ")?.split?.("{")?.join?.("{ ")?.split?.("}")?.join?.(" }")));

console.log("// Function Optional Argument and Function Default Argument Value in JavaScript");

function functionV1OptionalArgumentDefaultArgumentValue(anything, { pretty = false } = {}) {
    console.log(`optional argument default value function v1 optional argument pretty: ${jsonStringify(pretty)}`);
}
functionV1OptionalArgumentDefaultArgumentValue(["apple", "banana", "cherry"], { pretty: true });
functionV1OptionalArgumentDefaultArgumentValue(["apple", "banana", "cherry"]);

const functionV2OptionalArgumentDefaultArgumentValue = function (anything, { pretty = false } = {}) {
    console.log(`optional argument default value function v2 optional argument pretty: ${jsonStringify(pretty)}`);
};
functionV2OptionalArgumentDefaultArgumentValue(["apple", "banana", "cherry"], { pretty: true });
functionV2OptionalArgumentDefaultArgumentValue(["apple", "banana", "cherry"]);

const functionV3OptionalArgumentDefaultArgumentValue = (anything, { pretty = false } = {}) => {
    console.log(`optional argument default value function v3 optional argument pretty: ${jsonStringify(pretty)}`);
};
functionV3OptionalArgumentDefaultArgumentValue(["apple", "banana", "cherry"], { pretty: true });
functionV3OptionalArgumentDefaultArgumentValue(["apple", "banana", "cherry"]);

const functionV4OptionalArgumentDefaultArgumentValue = (anything, { pretty = false } = {}) => console.log(`optional argument default value function v4 optional argument pretty: ${jsonStringify(pretty)}`);
functionV4OptionalArgumentDefaultArgumentValue(["apple", "banana", "cherry"], { pretty: true });
functionV4OptionalArgumentDefaultArgumentValue(["apple", "banana", "cherry"]);
