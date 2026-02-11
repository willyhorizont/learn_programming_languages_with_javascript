import {
    jsonStringify,
} from "./utils.js";

console.log("// Function Optional Keyword Argument and Function Default Argument Value in JavaScript");

function functionV1OptionalKeywordArgumentDefaultArgumentValue(anything, { pretty = false } = {}) {
    console.log(`main function argument: ${jsonStringify(anything)}`);
    console.log(`optional function keyword argument default value "pretty": ${jsonStringify(pretty)}`);
}
functionV1OptionalKeywordArgumentDefaultArgumentValue(["apple", "banana", "cherry"], { pretty: true });
functionV1OptionalKeywordArgumentDefaultArgumentValue(["apple", "banana", "cherry"]);

const functionV2OptionalKeywordArgumentDefaultArgumentValue = function (anything, { pretty = false } = {}) {
    console.log(`main function argument: ${jsonStringify(anything)}`);
    console.log(`optional function keyword argument default value "pretty": ${jsonStringify(pretty)}`);
};
functionV2OptionalKeywordArgumentDefaultArgumentValue(["apple", "banana", "cherry"], { pretty: true });
functionV2OptionalKeywordArgumentDefaultArgumentValue(["apple", "banana", "cherry"]);

const functionV3OptionalKeywordArgumentDefaultArgumentValue = (anything, { pretty = false } = {}) => {
    console.log(`main function argument: ${jsonStringify(anything)}`);
    console.log(`optional function keyword argument default value "pretty": ${jsonStringify(pretty)}`);
};
functionV3OptionalKeywordArgumentDefaultArgumentValue(["apple", "banana", "cherry"], { pretty: true });
functionV3OptionalKeywordArgumentDefaultArgumentValue(["apple", "banana", "cherry"]);
