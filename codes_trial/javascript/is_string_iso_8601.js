import {
    isString,
    isNumeric,
} from "../../codes/javascript/utils.js";

const isStringIso8601v1 = (anything) => {
    if (isString(anything) === false) return false;
    if (/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?Z$/.test(anything) === false) return false;
    const dateParsedFromString = new Date(anything);
    if (isNumeric(dateParsedFromString.getTime()) === false) return false;
    return (dateParsedFromString.toISOString().replace(/\.000Z$/, "Z") === anything);
};
console.log(`isStringIso8601v1("2025-06-25T08:00:00Z"): ${isStringIso8601v1("2025-06-25T08:00:00Z")}`);

const isStringIso8601v2 = (anything) => ((isString(anything) === false) ? false : ((/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?Z$/.test(anything) === false) ? false : ((dateParsedFromString) => ((isNumeric(dateParsedFromString.getTime()) === false) ? false : (dateParsedFromString.toISOString().replace(/\.000Z$/, "Z") === anything)))(new Date(anything))));

console.log(`isStringIso8601v2("2025-06-25T08:00:00Z"): ${isStringIso8601v2("2025-06-25T08:00:00Z")}`);
