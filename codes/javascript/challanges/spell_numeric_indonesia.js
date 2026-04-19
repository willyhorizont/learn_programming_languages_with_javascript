import {
    AnyType,
    getType,
} from "../utils.js";

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

const getStringSpellNumericToWordIndonesia = (anything) => {
    const anythingType = getType(anything);
    if ((anythingType !== AnyType["Numeric"]) && (anythingType !== AnyType["String"]) && (anything?.trim?.() === "")) return "invalid input";
    const anythingAsString = ((anythingType === AnyType["Numeric"]) ? anything.toString() : parseInt(anything.split("_").join(""), 10).toString());
    const anythingAsNumeric = parseInt(anythingAsString, 10);
    if (anythingAsNumeric === 11) return `${numericSpellingIndonesia["se"]}${numericSpellingIndonesia["belas"]}`;
    if (anythingAsNumeric === 10) return `${numericSpellingIndonesia["se"]}${numericSpellingIndonesia["puluh"]}`;
    if (anythingAsNumeric === 100) return `${numericSpellingIndonesia["se"]}${numericSpellingIndonesia["ratus"]}`;
    if (anythingAsNumeric === 1_000) return `${numericSpellingIndonesia["se"]}${numericSpellingIndonesia["ribu"]}`;
    if (anythingAsNumeric === 1_000_000) return `${numericSpellingIndonesia["1"]} ${numericSpellingIndonesia["juta"]}`;
    if (anythingAsNumeric === 1_000_000_000) return `${numericSpellingIndonesia["1"]} ${numericSpellingIndonesia["miliar"]}`;
    if (anythingAsNumeric === 1_000_000_000_000) return `${numericSpellingIndonesia["1"]} ${numericSpellingIndonesia["triliun"]}`;
    if (isSatuan(anythingAsNumeric) === true) return numericSpellingIndonesia?.[anythingAsString];
    if (isBelasan(anythingAsNumeric) === true) return `${getStringSpellNumericToWordIndonesia(anythingAsString.charAt(1))} ${numericSpellingIndonesia["belas"]}`;
    if (isPuluhan(anythingAsNumeric) === true) return `${getStringSpellNumericToWordIndonesia(anythingAsString.charAt(0))} ${numericSpellingIndonesia["puluh"]}${((anythingAsString.charAt(1) === "0") ? "" : (` ${getStringSpellNumericToWordIndonesia(anythingAsString.slice(1))}`))}`;
    if (isRatusan(anythingAsNumeric) === true) return `${(anythingAsString.charAt(0) === "1") ? numericSpellingIndonesia["se"] : `${getStringSpellNumericToWordIndonesia(anythingAsString.charAt(0))} `}${numericSpellingIndonesia["ratus"]}${((anythingAsString.charAt(1) === "0") ? "" : (` ${getStringSpellNumericToWordIndonesia(anythingAsString.slice(1))}`))}`;
    if (isRibuan(anythingAsNumeric) === true) return `${getStringSpellNumericToWordIndonesia(anythingAsString.slice(0, -3))} ${numericSpellingIndonesia["ribu"]}${((parseInt(anythingAsString.slice(-3)) !== 0) ? ` ${getStringSpellNumericToWordIndonesia(anythingAsString.slice(-3))}` : "")}`;
    if (isJutaan(anythingAsNumeric) === true) return `${getStringSpellNumericToWordIndonesia(anythingAsString.slice(0, -6))} ${numericSpellingIndonesia["juta"]}${((parseInt(anythingAsString.slice(-6)) !== 0) ? ` ${getStringSpellNumericToWordIndonesia(anythingAsString.slice(-6))}` : "")}`;
    if (isMiliaran(anythingAsNumeric) === true) return `${getStringSpellNumericToWordIndonesia(anythingAsString.slice(0, -9))} ${numericSpellingIndonesia["miliar"]}${((parseInt(anythingAsString.slice(-9)) !== 0) ? ` ${getStringSpellNumericToWordIndonesia(anythingAsString.slice(-9))}` : "")}`;
    if (isTriliunan(anythingAsNumeric) === true) return `${getStringSpellNumericToWordIndonesia(anythingAsString.slice(0, -12))} ${numericSpellingIndonesia["triliun"]}${((parseInt(anythingAsString.slice(-12)) !== 0) ? ` ${getStringSpellNumericToWordIndonesia(anythingAsString.slice(-12))}` : "")}`;
    return "tak terhingga";
};

console.log(`1: "${getStringSpellNumericToWordIndonesia(1)}"`);
console.log(`11: "${getStringSpellNumericToWordIndonesia(11)}"`);
console.log(`19: "${getStringSpellNumericToWordIndonesia(19)}"`);
console.log(`10: "${getStringSpellNumericToWordIndonesia(10)}"`);
console.log(`100: "${getStringSpellNumericToWordIndonesia(100)}"`);
console.log(`1_000: "${getStringSpellNumericToWordIndonesia(1_000)}"`);
console.log(`10_000: "${getStringSpellNumericToWordIndonesia(10_000)}"`);
console.log(`100_000: "${getStringSpellNumericToWordIndonesia(100_000)}"`);
console.log(`1_000_000: "${getStringSpellNumericToWordIndonesia(1_000_000)}"`);
console.log(`1_000_000_000: "${getStringSpellNumericToWordIndonesia(1_000_000_000)}"`);
console.log(`1_000_000_000_000: "${getStringSpellNumericToWordIndonesia(1_000_000_000_000)}"`);

console.log(`2: "${getStringSpellNumericToWordIndonesia(2)}"`);
console.log(`20: "${getStringSpellNumericToWordIndonesia(20)}"`);
console.log(`200: "${getStringSpellNumericToWordIndonesia(200)}"`);
console.log(`2_000: "${getStringSpellNumericToWordIndonesia(2_000)}"`);
console.log(`20_000: "${getStringSpellNumericToWordIndonesia(20_000)}"`);
console.log(`200_000: "${getStringSpellNumericToWordIndonesia(200_000)}"`);
console.log(`2_000_000: "${getStringSpellNumericToWordIndonesia(2_000_000)}"`);
console.log(`2_000_000_000: "${getStringSpellNumericToWordIndonesia(2_000_000_000)}"`);
console.log(`2_000_000_000_000: "${getStringSpellNumericToWordIndonesia(2_000_000_000_000)}"`);

console.log(`99: "${getStringSpellNumericToWordIndonesia(99)}"`);
console.log(`999: "${getStringSpellNumericToWordIndonesia(999)}"`);
console.log(`9_999: "${getStringSpellNumericToWordIndonesia(9_999)}"`);

console.log(`19_999: "${getStringSpellNumericToWordIndonesia(19_999)}"`);

console.log(`99_999: "${getStringSpellNumericToWordIndonesia(99_999)}"`);
console.log(`999_999: "${getStringSpellNumericToWordIndonesia(999_999)}"`);
console.log(`9_999_999: "${getStringSpellNumericToWordIndonesia(9_999_999)}"`);

console.log(`19_999_999: "${getStringSpellNumericToWordIndonesia(19_999_999)}"`);

console.log(`99_999_999: "${getStringSpellNumericToWordIndonesia(99_999_999)}"`);
console.log(`999_999_999: "${getStringSpellNumericToWordIndonesia(999_999_999)}"`);
console.log(`9_999_999_999: "${getStringSpellNumericToWordIndonesia(9_999_999_999)}"`);

console.log(`19_999_999_999: "${getStringSpellNumericToWordIndonesia(19_999_999_999)}"`);

console.log(`99_999_999_999: "${getStringSpellNumericToWordIndonesia(99_999_999_999)}"`);
console.log(`999_999_999_999: "${getStringSpellNumericToWordIndonesia(999_999_999_999)}"`);
console.log(`9_999_999_999_999: "${getStringSpellNumericToWordIndonesia(9_999_999_999_999)}"`);

console.log(`19_999_999_999_999: "${getStringSpellNumericToWordIndonesia(19_999_999_999_999)}"`);

console.log(`99_999_999_999_999: "${getStringSpellNumericToWordIndonesia(99_999_999_999_999)}"`);
console.log(`999_999_999_999_999: "${getStringSpellNumericToWordIndonesia(999_999_999_999_999)}"`);

console.log(`23: "${getStringSpellNumericToWordIndonesia(23)}"`);
console.log(`456: "${getStringSpellNumericToWordIndonesia(456)}"`);
console.log(`7890: "${getStringSpellNumericToWordIndonesia(7890)}"`);

console.log(`12_345: "${getStringSpellNumericToWordIndonesia(12_345)}"`);

console.log(`23_456: "${getStringSpellNumericToWordIndonesia(23_456)}"`);
console.log(`789_012: "${getStringSpellNumericToWordIndonesia(789_012)}"`);
console.log(`3_456_789: "${getStringSpellNumericToWordIndonesia(3_456_789)}"`);

console.log(`12_345_678: "${getStringSpellNumericToWordIndonesia(12_345_678)}"`);

console.log(`90_123_456: "${getStringSpellNumericToWordIndonesia(90_123_456)}"`);
console.log(`789_012_345: "${getStringSpellNumericToWordIndonesia(789_012_345)}"`);
console.log(`6_789_012_345: "${getStringSpellNumericToWordIndonesia(6_789_012_345)}"`);

console.log(`12_345_678_901: "${getStringSpellNumericToWordIndonesia(12_345_678_901)}"`);

console.log(`23_456_789_012: "${getStringSpellNumericToWordIndonesia(23_456_789_012)}"`);
console.log(`345_678_901_234: "${getStringSpellNumericToWordIndonesia(345_678_901_234)}"`);
console.log(`5_678_901_234_567: "${getStringSpellNumericToWordIndonesia(5_678_901_234_567)}"`);

console.log(`12_345_678_901_234: "${getStringSpellNumericToWordIndonesia(12_345_678_901_234)}"`);

console.log(`56_789_012_345_678: "${getStringSpellNumericToWordIndonesia(56_789_012_345_678)}"`);
console.log(`901_234_567_890_123: "${getStringSpellNumericToWordIndonesia(901_234_567_890_123)}"`);
