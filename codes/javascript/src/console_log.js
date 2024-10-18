const jsType = { "Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function" };

const isNull = (anything) => (((Object.prototype.toString.call(anything) === "[object Null]") && (anything === null)) || ((Object.prototype.toString.call(anything) === "[object Undefined]") && (anything === undefined)));

const isBoolean = (anything) => ((Object.prototype.toString.call(anything) === "[object Boolean]") && ((anything === true) || (anything === false)));

const isString = (anything) => (Object.prototype.toString.call(anything) === "[object String]");

const isNumeric = (anything) => ((Object.prototype.toString.call(anything) === "[object Number]") && (Number.isNaN(anything) === false) && (Number.isFinite(anything) === true));

const isObject = (anything) => (Object.prototype.toString.call(anything) === "[object Object]");

const isArray = (anything) => ((Object.prototype.toString.call(anything) === "[object Array]") && (Array.isArray(anything) === true));

const isFunction = (anything) => (Object.prototype.toString.call(anything) === "[object Function]");

const getType = (anything) => ((isNull(anything) === true) ? jsType.Null : ((isBoolean(anything) === true) ? jsType.Boolean : ((isString(anything) === true) ? jsType.String : ((isNumeric(anything) === true) ? jsType.Numeric : ((isObject(anything) === true) ? jsType.Object : ((isArray(anything) === true) ? jsType.Array : ((isFunction(anything) === true) ? jsType.Function : Object.prototype.toString.call(anything))))))));

const jsonStringify = (anything, { pretty = false } = {}) => {
    // custom JSON.stringify() function jsonStringifyV3
    const indent = " ".repeat(4);
    let indentLevel = 0;
    const jsonStringifyInner = (anythingInner) => {
        const anythingInnerType = getType(anythingInner);
        if (anythingInnerType === jsType.Null) return "null";
        if (anythingInnerType === jsType.String) return `"${anythingInner}"`;
        if ((anythingInnerType === jsType.Numeric) || (anythingInnerType === jsType.Boolean)) return `${anythingInner}`;
        if (anythingInnerType === jsType.Object) {
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
        if (anythingInnerType === jsType.Array) {
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
        if (anythingInnerType === jsType.Function) return "[object Function]";
        return anythingInnerType;
    };
    return jsonStringifyInner(anything);
};

console.log("// console.log()");

const anyString = "foo";
const anyNumeric = 123;
const anyBoolean = true;
const anyNull = null;
const anyArray = [1, 2, 3];
const anyObject = { "foo": "bar" };

// its add whitespace as separator by default
console.log("any string: ", anyString, ", any numeric: ", anyNumeric, ", any boolean: ", anyBoolean, ", any null: ", anyNull, ", any array: ", anyArray, ", any object: ", anyObject);

console.log("any string: ", jsonStringify(anyString), ", any numeric: ", jsonStringify(anyNumeric), ", any boolean: ", jsonStringify(anyBoolean), ", any null: ", jsonStringify(anyNull), ", any array: ", jsonStringify(anyArray), ", any object: ", jsonStringify(anyObject));

console.log("any string:", jsonStringify(anyString), "any numeric:", jsonStringify(anyNumeric), "any boolean:", jsonStringify(anyBoolean), "any null:", jsonStringify(anyNull), "any array:", jsonStringify(anyArray), "any object:", jsonStringify(anyObject));

// ⭐⭐⭐⭐⭐ // using Template literals / Template strings (String Interpolation)
console.log(`any string: ${jsonStringify(anyString)}, any numeric: ${jsonStringify(anyNumeric)}, any boolean: ${jsonStringify(anyBoolean)}, any null: ${jsonStringify(anyNull)}, any array: ${jsonStringify(anyArray)}, any object: ${jsonStringify(anyObject)}`);

const consoleLog = (...restArguments) => console.log(restArguments.join(""));

consoleLog("any string: ", jsonStringify(anyString), ", any numeric: ", jsonStringify(anyNumeric), ", any boolean: ", jsonStringify(anyBoolean), ", any null: ", jsonStringify(anyNull), ", any array: ", jsonStringify(anyArray), ", any object: ", jsonStringify(anyObject));
