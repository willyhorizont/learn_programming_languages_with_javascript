const jsType = { "Null": "Null", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function" };

const isNull = (anything) => (((Object.prototype.toString.call(anything) === "[object Null]") && (anything === null)) || ((Object.prototype.toString.call(anything) === "[object Undefined]") && (anything === undefined)));

const isBoolean = (anything) => ((Object.prototype.toString.call(anything) === "[object Boolean]") && ((anything === true) || (anything === false)));

const isString = (anything) => (Object.prototype.toString.call(anything) === "[object String]");

const isNumeric = (anything) => ((Object.prototype.toString.call(anything) === "[object Number]") && (Number.isNaN(anything) === false) && (Number.isFinite(anything) === true));

const isObject = (anything) => (Object.prototype.toString.call(anything) === "[object Object]");

const isArray = (anything) => ((Object.prototype.toString.call(anything) === "[object Array]") && (Array.isArray(anything) === true));

const isFunction = (anything) => (Object.prototype.toString.call(anything) === "[object Function]");

const getType = (anything) => ((isNull(anything) === true) ? jsType.Null : ((isBoolean(anything) === true) ? jsType.Boolean : ((isString(anything) === true) ? jsType.String : ((isNumeric(anything) === true) ? jsType.Numeric : ((isObject(anything) === true) ? jsType.Object : ((isArray(anything) === true) ? jsType.Array : ((isFunction(anything) === true) ? jsType.Function : Object.prototype.toString.call(anything))))))));

const jsonStringify = (anything, { pretty = false, indent = " ".repeat(4), indentLevel = 0, argumentType = getType(anything) } = {}) => ((argumentType === jsType.Null) ? "null" : ((argumentType === jsType.String) ? `"${anything}"` : (((argumentType === jsType.Numeric) || (argumentType === jsType.Boolean)) ? `${anything}` : ((argumentType === jsType.Object) ? ((Object.keys(anything).length === 0) ? "{}" : (`${((pretty === true) ? (`{\n${indent.repeat(indentLevel + 1)}`) : "{ ")}${Object.entries(anything).reduce((currentResult, [objectKey, objectValue], objectEntryIndex) => (`${currentResult}${(((objectEntryIndex + 1) !== Object.keys(anything).length) ? `"${objectKey}": ${jsonStringify(objectValue, { pretty, indentLevel: (indentLevel + 1) })}${((pretty === true) ? (`,\n${indent.repeat(indentLevel + 1)}`) : ", ")}` : `"${objectKey}": ${jsonStringify(objectValue, { pretty, indentLevel: (indentLevel + 1) })}`)}`), "")}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}}`) : " }")}`)) : ((argumentType === jsType.Array) ? ((anything.length === 0) ? "[]" : (`${((pretty === true) ? (`[\n${indent.repeat(indentLevel + 1)}`) : "[")}${anything.reduce((currentResult, arrayItem, arrayItemIndex) => ((((arrayItemIndex + 1) !== anything.length) ? `${currentResult}${jsonStringify(arrayItem, { pretty, indentLevel: (indentLevel + 1) })}${((pretty === true) ? (`,\n${indent.repeat(indentLevel + 1)}`) : ", ")}` : `${currentResult}${jsonStringify(arrayItem, { pretty, indentLevel: (indentLevel + 1) })}`)), "")}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}]`) : "]")}`)) : ((argumentType === jsType.Function) ? "[object Function]" : argumentType)))))); // custom JSON.stringify() function jsonStringifyV4

const numericSpellingIndonesia = {
    "0": "nol",
    "1": "satu",
    "2": "dua",
    "3": "tiga",
    "4": "empat",
    "5": "lima",
    "6": "enam",
    "7": "tujuh",
    "8": "delapan",
    "9": "sembilan",
    "se": "se",
    "belas": "belas",
    "puluh": "puluh",
    "ratus": "ratus",
    "ribu": "ribu",
    "juta": "juta",
    "miliar": "miliar",
    "triliun": "triliun",
};

const isSatuan = (anythingAsNumeric) => ((anythingAsNumeric.toString().length === 1) && (anythingAsNumeric <= 9));
const isBelasan = (anythingAsNumeric) => ((anythingAsNumeric.toString().length === 2) && (anythingAsNumeric.toString().charAt(0) === "1") && ((anythingAsNumeric >= 11) && (anythingAsNumeric <= 19)));
const isPuluhan = (anythingAsNumeric) => ((anythingAsNumeric.toString().length === 2) && (parseInt(anythingAsNumeric.toString().charAt(0), 10) > 1) && ((anythingAsNumeric === 10) || ((anythingAsNumeric >= 20) && (anythingAsNumeric <= 99))));
const isRatusan = (anythingAsNumeric) => ((anythingAsNumeric.toString().length === 3) && ((anythingAsNumeric >= 100) && (anythingAsNumeric <= 999)));
const isRibuan = (anythingAsNumeric) => (((anythingAsNumeric.toString().length >= 4) && (anythingAsNumeric.toString().length <= 6)) && ((anythingAsNumeric >= 1_000) && (anythingAsNumeric <= 999_999)));
const isJutaan = (anythingAsNumeric) => (((anythingAsNumeric.toString().length >= 7) && (anythingAsNumeric.toString().length <= 9)) && ((anythingAsNumeric >= 1_000_000) && (anythingAsNumeric <= 999_999_999)));
const isMiliaran = (anythingAsNumeric) => (((anythingAsNumeric.toString().length >= 10) && (anythingAsNumeric.toString().length <= 12)) && ((anythingAsNumeric >= 1_000_000_000) && (anythingAsNumeric <= 999_999_999_999)));
const isTriliunan = (anythingAsNumeric) => (((anythingAsNumeric.toString().length >= 13) && (anythingAsNumeric.toString().length <= 15)) && ((anythingAsNumeric >= 1_000_000_000_000) && (anythingAsNumeric <= 999_999_999_999_999)));

const spellNumericToWordIndonesia = (anything) => {
    if ((isNumeric(anything) === false) && (isString(anything) === false) && (anything?.trim?.() === "")) return "invalid input";
    const anythingAsString = ((isNumeric(anything) === true) ? anything.toString() : parseInt(anything.split("_").join(""), 10).toString());
    const anythingAsNumeric = parseInt(anythingAsString, 10);
    if (anythingAsNumeric === 11) return `${numericSpellingIndonesia["se"]}${numericSpellingIndonesia["belas"]}`;
    if (anythingAsNumeric === 10) return `${numericSpellingIndonesia["se"]}${numericSpellingIndonesia["puluh"]}`;
    if (anythingAsNumeric === 100) return `${numericSpellingIndonesia["se"]}${numericSpellingIndonesia["ratus"]}`;
    if (anythingAsNumeric === 1_000) return `${numericSpellingIndonesia["se"]}${numericSpellingIndonesia["ribu"]}`;
    if (anythingAsNumeric === 1_000_000) return `${numericSpellingIndonesia["1"]} ${numericSpellingIndonesia["juta"]}`;
    if (anythingAsNumeric === 1_000_000_000) return `${numericSpellingIndonesia["1"]} ${numericSpellingIndonesia["miliar"]}`;
    if (anythingAsNumeric === 1_000_000_000_000) return `${numericSpellingIndonesia["1"]} ${numericSpellingIndonesia["triliun"]}`;
    if (isSatuan(anythingAsNumeric) === true) return numericSpellingIndonesia?.[anythingAsString];
    if (isBelasan(anythingAsNumeric) === true) return `${spellNumericToWordIndonesia(anythingAsString.charAt(1))} ${numericSpellingIndonesia["belas"]}`;
    if (isPuluhan(anythingAsNumeric) === true) return `${spellNumericToWordIndonesia(anythingAsString.charAt(0))} ${numericSpellingIndonesia["puluh"]}${((anythingAsString.charAt(1) === "0") ? "" : (` ${spellNumericToWordIndonesia(anythingAsString.slice(1))}`))}`;
    if (isRatusan(anythingAsNumeric) === true) return `${(anythingAsString.charAt(0) === "1") ? numericSpellingIndonesia["se"] : `${spellNumericToWordIndonesia(anythingAsString.charAt(0))} `}${numericSpellingIndonesia["ratus"]}${((anythingAsString.charAt(1) === "0") ? "" : (` ${spellNumericToWordIndonesia(anythingAsString.slice(1))}`))}`;
    if (isRibuan(anythingAsNumeric) === true) return `${spellNumericToWordIndonesia(anythingAsString.slice(0, -3))} ${numericSpellingIndonesia["ribu"]}${((parseInt(anythingAsString.slice(-3)) !== 0) ? ` ${spellNumericToWordIndonesia(anythingAsString.slice(-3))}` : "")}`;
    if (isJutaan(anythingAsNumeric) === true) return `${spellNumericToWordIndonesia(anythingAsString.slice(0, -6))} ${numericSpellingIndonesia["juta"]}${((parseInt(anythingAsString.slice(-6)) !== 0) ? ` ${spellNumericToWordIndonesia(anythingAsString.slice(-6))}` : "")}`;
    if (isMiliaran(anythingAsNumeric) === true) return `${spellNumericToWordIndonesia(anythingAsString.slice(0, -9))} ${numericSpellingIndonesia["miliar"]}${((parseInt(anythingAsString.slice(-9)) !== 0) ? ` ${spellNumericToWordIndonesia(anythingAsString.slice(-9))}` : "")}`;
    if (isTriliunan(anythingAsNumeric) === true) return `${spellNumericToWordIndonesia(anythingAsString.slice(0, -12))} ${numericSpellingIndonesia["triliun"]}${((parseInt(anythingAsString.slice(-12)) !== 0) ? ` ${spellNumericToWordIndonesia(anythingAsString.slice(-12))}` : "")}`;
    return "tak terhingga";
};

console.log(`1: ${jsonStringify(spellNumericToWordIndonesia(1))}`);
console.log(`11: ${jsonStringify(spellNumericToWordIndonesia(11))}`);
console.log(`19: ${jsonStringify(spellNumericToWordIndonesia(19))}`);
console.log(`10: ${jsonStringify(spellNumericToWordIndonesia(10))}`);
console.log(`100: ${jsonStringify(spellNumericToWordIndonesia(100))}`);
console.log(`1_000: ${jsonStringify(spellNumericToWordIndonesia(1_000))}`);
console.log(`10_000: ${jsonStringify(spellNumericToWordIndonesia(10_000))}`);
console.log(`100_000: ${jsonStringify(spellNumericToWordIndonesia(100_000))}`);
console.log(`1_000_000: ${jsonStringify(spellNumericToWordIndonesia(1_000_000))}`);
console.log(`1_000_000_000: ${jsonStringify(spellNumericToWordIndonesia(1_000_000_000))}`);
console.log(`1_000_000_000_000: ${jsonStringify(spellNumericToWordIndonesia(1_000_000_000_000))}`);

console.log(`2: ${jsonStringify(spellNumericToWordIndonesia(2))}`);
console.log(`20: ${jsonStringify(spellNumericToWordIndonesia(20))}`);
console.log(`200: ${jsonStringify(spellNumericToWordIndonesia(200))}`);
console.log(`2_000: ${jsonStringify(spellNumericToWordIndonesia(2_000))}`);
console.log(`20_000: ${jsonStringify(spellNumericToWordIndonesia(20_000))}`);
console.log(`200_000: ${jsonStringify(spellNumericToWordIndonesia(200_000))}`);
console.log(`2_000_000: ${jsonStringify(spellNumericToWordIndonesia(2_000_000))}`);
console.log(`2_000_000_000: ${jsonStringify(spellNumericToWordIndonesia(2_000_000_000))}`);
console.log(`2_000_000_000_000: ${jsonStringify(spellNumericToWordIndonesia(2_000_000_000_000))}`);

console.log(`99: ${jsonStringify(spellNumericToWordIndonesia(99))}`);
console.log(`999: ${jsonStringify(spellNumericToWordIndonesia(999))}`);
console.log(`9_999: ${jsonStringify(spellNumericToWordIndonesia(9_999))}`);

console.log(`19_999: ${jsonStringify(spellNumericToWordIndonesia(19_999))}`);

console.log(`99_999: ${jsonStringify(spellNumericToWordIndonesia(99_999))}`);
console.log(`999_999: ${jsonStringify(spellNumericToWordIndonesia(999_999))}`);
console.log(`9_999_999: ${jsonStringify(spellNumericToWordIndonesia(9_999_999))}`);

console.log(`19_999_999: ${jsonStringify(spellNumericToWordIndonesia(19_999_999))}`);

console.log(`99_999_999: ${jsonStringify(spellNumericToWordIndonesia(99_999_999))}`);
console.log(`999_999_999: ${jsonStringify(spellNumericToWordIndonesia(999_999_999))}`);
console.log(`9_999_999_999: ${jsonStringify(spellNumericToWordIndonesia(9_999_999_999))}`);

console.log(`19_999_999_999: ${jsonStringify(spellNumericToWordIndonesia(19_999_999_999))}`);

console.log(`99_999_999_999: ${jsonStringify(spellNumericToWordIndonesia(99_999_999_999))}`);
console.log(`999_999_999_999: ${jsonStringify(spellNumericToWordIndonesia(999_999_999_999))}`);
console.log(`9_999_999_999_999: ${jsonStringify(spellNumericToWordIndonesia(9_999_999_999_999))}`);

console.log(`19_999_999_999_999: ${jsonStringify(spellNumericToWordIndonesia(19_999_999_999_999))}`);

console.log(`99_999_999_999_999: ${jsonStringify(spellNumericToWordIndonesia(99_999_999_999_999))}`);
console.log(`999_999_999_999_999: ${jsonStringify(spellNumericToWordIndonesia(999_999_999_999_999))}`);

console.log(`23: ${jsonStringify(spellNumericToWordIndonesia(23))}`);
console.log(`456: ${jsonStringify(spellNumericToWordIndonesia(456))}`);
console.log(`7890: ${jsonStringify(spellNumericToWordIndonesia(7890))}`);

console.log(`12_345: ${jsonStringify(spellNumericToWordIndonesia(12_345))}`);

console.log(`23_456: ${jsonStringify(spellNumericToWordIndonesia(23_456))}`);
console.log(`789_012: ${jsonStringify(spellNumericToWordIndonesia(789_012))}`);
console.log(`3_456_789: ${jsonStringify(spellNumericToWordIndonesia(3_456_789))}`);

console.log(`12_345_678: ${jsonStringify(spellNumericToWordIndonesia(12_345_678))}`);

console.log(`90_123_456: ${jsonStringify(spellNumericToWordIndonesia(90_123_456))}`);
console.log(`789_012_345: ${jsonStringify(spellNumericToWordIndonesia(789_012_345))}`);
console.log(`6_789_012_345: ${jsonStringify(spellNumericToWordIndonesia(6_789_012_345))}`);

console.log(`12_345_678_901: ${jsonStringify(spellNumericToWordIndonesia(12_345_678_901))}`);

console.log(`23_456_789_012: ${jsonStringify(spellNumericToWordIndonesia(23_456_789_012))}`);
console.log(`345_678_901_234: ${jsonStringify(spellNumericToWordIndonesia(345_678_901_234))}`);
console.log(`5_678_901_234_567: ${jsonStringify(spellNumericToWordIndonesia(5_678_901_234_567))}`);

console.log(`12_345_678_901_234: ${jsonStringify(spellNumericToWordIndonesia(12_345_678_901_234))}`);

console.log(`56_789_012_345_678: ${jsonStringify(spellNumericToWordIndonesia(56_789_012_345_678))}`);
console.log(`901_234_567_890_123: ${jsonStringify(spellNumericToWordIndonesia(901_234_567_890_123))}`);
