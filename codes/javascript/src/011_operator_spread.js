const jsType = {
    "Null": "Null",
    "Boolean": "Boolean",
    "String": "String",
    "Numeric": "Numeric",
    "Object": "Object",
    "Array": "Array",
    "Function": "Function"
};

const isNull = (anything) => (((Object.prototype.toString.call(anything) === "[object Null]") && (anything === null)) || ((Object.prototype.toString.call(anything) === "[object Undefined]") && (anything === undefined)));

const isBoolean = (anything) => ((Object.prototype.toString.call(anything) === "[object Boolean]") && ((anything === true) || (anything === false)));

const isString = (anything) => (Object.prototype.toString.call(anything) === "[object String]");

const isNumeric = (anything) => ((Object.prototype.toString.call(anything) === "[object Number]") && (Number.isNaN(anything) === false) && (Number.isFinite(anything) === true));

const isObject = (anything) => (Object.prototype.toString.call(anything) === "[object Object]");

const isArray = (anything) => ((Object.prototype.toString.call(anything) === "[object Array]") && (Array.isArray(anything) === true));

const isFunction = (anything) => (Object.prototype.toString.call(anything) === "[object Function]");

const getType = (anything) => {
    if (isNull(anything) === true) return jsType.Null;
    if (isBoolean(anything) === true) return jsType.Boolean;
    if (isString(anything) === true) return jsType.String;
    if (isNumeric(anything) === true) return jsType.Numeric;
    if (isObject(anything) === true) return jsType.Object;
    if (isArray(anything) === true) return jsType.Array;
    if (isFunction(anything) === true) return jsType.Function;
    return Object.prototype.toString.call(anything);
};

const jsonStringify = (anything, { pretty = false } = {}) => {
    // custom JSON.stringify() function jsonStringifyV3
    const indent = " ".repeat(4);
    let indentLevel = 0;
    const jsonStringifyInner = (anythingInner) => {
        if (getType(anythingInner) === jsType.Null) return "null";
        if (getType(anythingInner) === jsType.String) return `"${anythingInner}"`;
        if ((getType(anythingInner) === jsType.Numeric) || (getType(anythingInner) === jsType.Boolean)) return `${anythingInner}`;
        if (getType(anythingInner) === jsType.Object) {
            if (Object.keys(anythingInner).length === 0) return "{}";
            indentLevel += 1;
            let result = ((pretty === true) ? (`{\n${indent.repeat(indentLevel)}`) : "{ ");
            Object.entries(anythingInner).forEach(([objectKey, objectValue], objectEntryIndex) => {
                result = `${result}"${objectKey}": ${jsonStringifyInner(objectValue)}`;
                if ((objectEntryIndex + 1) !== Object.keys(anythingInner).length) {
                    result = `${result}${((pretty === true) ? (`,\n${indent.repeat(indentLevel)}`) : ", ")}`;
                }
            });
            indentLevel -= 1;
            result = `${result}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}}`) : " }")}`;
            return result;
        }
        if (getType(anythingInner) === jsType.Array) {
            if (anythingInner.length === 0) return "[]";
            indentLevel += 1;
            let result = ((pretty === true) ? (`[\n${indent.repeat(indentLevel)}`) : "[");
            anythingInner.forEach((arrayItem, arrayItemIndex) => {
                result = `${result}${jsonStringifyInner(arrayItem)}`;
                if ((arrayItemIndex + 1) !== anythingInner.length) {
                    result = `${result}${((pretty === true) ? (`,\n${indent.repeat(indentLevel)}`) : ", ")}`;
                }
            });
            indentLevel -= 1;
            result = `${result}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}]`) : "]")}`;
            return result;
        }
        if (getType(anythingInner) === jsType.Function) return '"[object Function]"';
        return `"${getType(anything)}"`;
    };
    return jsonStringifyInner(anything);
};

console.log("\n// Spread Syntax (...)");

const fruits = ["Mango", "Melon", "Banana"];
console.log(`fruits: ${jsonStringify(fruits)}`);

const vegetables = ["Carrot", "Tomato"];
console.log(`vegetables: ${jsonStringify(vegetables)}`);

const countryCapitalsInAsia = {
    "Thailand": "Bangkok",
    "China": "Beijing",
    "Japan": "Tokyo"
};
console.log(`countryCapitalsInAsia: ${jsonStringify(countryCapitalsInAsia, { pretty: true })}`);

const countryCapitalsInEurope = {
    "France": "Paris",
    "England": "London"
};
console.log(`countryCapitalsInEurope: ${jsonStringify(countryCapitalsInEurope, { pretty: true })}`);

console.log("\n// [...array1, ...array2]:\n");

const combination1 = [...fruits, ...vegetables];
console.log(`combination1: ${jsonStringify(combination1, { pretty: true })}`);
// combination1: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Carrot",
//     "Tomato"
// ]

const combination2 = [...fruits, ...["Cucumber", "Cabbage"]];
console.log(`combination2: ${jsonStringify(combination2, { pretty: true })}`);
// combination2: [
//     "Mango",
//     "Melon",
//     "Banana",
//     "Cucumber",
//     "Cabbage"
// ]

console.log("\n// { ...object1, ...object2 }:\n");

const combination3 = { ...countryCapitalsInAsia, ...countryCapitalsInEurope };
console.log(`combination3: ${jsonStringify(combination3, { pretty: true })}`);
// combination3: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "France": "Paris",
//     "England": "London"
// }

const combination4 = { ...countryCapitalsInAsia, ...{ "Germany": "Berlin", "Italy": "Rome" } };
console.log(`combination4: ${jsonStringify(combination4, { pretty: true })}`);
// combination4: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "Germany": "Berlin",
//     "Italy": "Rome"
// }

console.log("\n// [...array1, array2] || [...array1, newArrayItem1, newArrayItem2]:\n");

const combination5 = [...fruits, vegetables];
console.log(`combination5: ${jsonStringify(combination5, { pretty: true })}`);
// combination5: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Carrot",
//         "Tomato"
//     ]
// ]

const combination6 = [...fruits, ["Cucumber", "Cabbage"]];
console.log(`combination6: ${jsonStringify(combination6, { pretty: true })}`);
// combination6: [
//     "Mango",
//     "Melon",
//     "Banana",
//     [
//         "Cucumber",
//         "Cabbage"
//     ]
// ]

console.log("\n// [...array1, object1] || [...array1, newArrayItem1, newArrayItem2]:\n");

const combination7 = [...fruits, countryCapitalsInAsia];
console.log(`combination7: ${jsonStringify(combination7, { pretty: true })}`);
// combination7: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Thailand": "Bangkok",
//         "China": "Beijing",
//         "Japan": "Tokyo"
//     }
// ]

const combination8 = [...fruits, { "Germany": "Berlin", "Italy": "Rome" }];
console.log(`combination8: ${jsonStringify(combination8, { pretty: true })}`);
// combination8: [
//     "Mango",
//     "Melon",
//     "Banana",
//     {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// ]

console.log("\n// { ...object1, object2 } || { ...object1, objectKey: objectValue }:\n");

const combination9 = { ...countryCapitalsInAsia, countryCapitalsInEurope };
console.log(`combination9: ${jsonStringify(combination9, { pretty: true })}`);
// combination9: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "countryCapitalsInEurope" : {
//       "France" : "Paris",
//       "England" : "London"
//    }
// }

const combination10 = { ...countryCapitalsInAsia, "countryCapitalsInEurope": { "Germany": "Berlin", "Italy": "Rome" } };
console.log(`combination10: ${jsonStringify(combination10, { pretty: true })}`);
// combination10: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "countryCapitalsInEurope": {
//         "Germany": "Berlin",
//         "Italy": "Rome"
//     }
// }

console.log("\n// { ...object1, array2 } || { ...object1, objectKey: objectValue }:\n");

const combination11 = { ...countryCapitalsInAsia, vegetables };
console.log(`combination11: ${jsonStringify(combination11, { pretty: true })}`);
// combination11: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Carrot",
//         "Tomato"
//     ]
// }

const combination12 = { ...countryCapitalsInAsia, "vegetables": ["Cucumber", "Cabbage"] };
console.log(`combination12: ${jsonStringify(combination12, { pretty: true })}`);
// combination12: {
//     "Thailand": "Bangkok",
//     "China": "Beijing",
//     "Japan": "Tokyo",
//     "vegetables": [
//         "Cucumber",
//         "Cabbage"
//     ]
// }

console.log("\n// { ...object1, ...array2 }:\n");

const combination13 = { ...countryCapitalsInAsia, ...vegetables };
console.log(`combination13: ${jsonStringify(combination13, { pretty: true })}`);
// combination13: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Carrot",
//    "1" : "Tomato"
// }

const combination14 = { ...countryCapitalsInAsia, ...["Cucumber", "Cabbage"] };
console.log(`combination14: ${jsonStringify(combination14, { pretty: true })}`);
// combination14: {
//    "Thailand" : "Bangkok",
//    "China" : "Beijing",
//    "Japan" : "Tokyo",
//    "0" : "Cucumber",
//    "1" : "Cabbage"
// }

// console.log("\n// [...array1, ...object1]: // this combination throw an error\n");

// this combination throw an error
// const combinationError1 = [...fruits, ...countryCapitalsInAsia];
// console.log(`combinationError1: ${jsonStringify(combinationError1, { pretty: true })}`);

// this combination throw an error
// const combinationError2 = [...fruits, ...{ "Germany": "Berlin", "Italy": "Rome" }];
// console.log(`combinationError2: ${jsonStringify(combinationError2, { pretty: true })}`);
