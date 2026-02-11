import {
    datePrettier,
    jsonStringify,
} from "./utils.js";

const getDayInNumericOfDateStringYyyyMinusMmMinusDd = (dateStringYyyyMinusMmMinusDd) => (parseInt(dateStringYyyyMinusMmMinusDd.split("-")[2], 10));
const getMonthInNumericOfDateStringYyyyMinusMmMinusDd = (dateStringYyyyMinusMmMinusDd) => (parseInt(dateStringYyyyMinusMmMinusDd.split("-")[1], 10));
const getYearInNumericOfDateStringYyyyMinusMmMinusDd = (dateStringYyyyMinusMmMinusDd) => (parseInt(dateStringYyyyMinusMmMinusDd.split("-")[0], 10));

const myDateStringYyyyMinusMmMinusDd = "2025-08-05";
console.log(getDayInNumericOfDateStringYyyyMinusMmMinusDd(myDateStringYyyyMinusMmMinusDd));
console.log(getMonthInNumericOfDateStringYyyyMinusMmMinusDd(myDateStringYyyyMinusMmMinusDd));
console.log(getYearInNumericOfDateStringYyyyMinusMmMinusDd(myDateStringYyyyMinusMmMinusDd));

const updateDateStringYyyyMinusMmMinusDdByNumericVariableOld = (dateStringYyyyMinusMmMinusDd, numericVariable) => {
    const dateStringYyyyMinusMmMinusDdParsedToDate = new Date(dateStringYyyyMinusMmMinusDd);
    const dateStringYyyyMinusMmMinusDdParsedToDateClone = new Date(dateStringYyyyMinusMmMinusDdParsedToDate);
    dateStringYyyyMinusMmMinusDdParsedToDateClone.setDate(dateStringYyyyMinusMmMinusDdParsedToDateClone.getDate() + numericVariable);
    return dateStringYyyyMinusMmMinusDdParsedToDateClone.toISOString();
};

const updateDateStringYyyyMinusMmMinusDdByNumericVariable = (dateStringYyyyMinusMmMinusDd, numericVariable) => (((dateStringYyyyMinusMmMinusDdParsedToDate) => (((dateStringYyyyMinusMmMinusDdParsedToDateClone) => ([(dateStringYyyyMinusMmMinusDdParsedToDateClone.setDate(dateStringYyyyMinusMmMinusDdParsedToDateClone.getDate() + numericVariable)), (dateStringYyyyMinusMmMinusDdParsedToDateClone.toISOString())].at(-1)))(new Date(dateStringYyyyMinusMmMinusDdParsedToDate))))(new Date(dateStringYyyyMinusMmMinusDd)));

const myDate = new Date("2025-08-04");
console.log(`myDate: ${datePrettier(myDate)}`);

console.log(`-4: ${datePrettier(updateDateStringYyyyMinusMmMinusDdByNumericVariable(myDate, -4))}`);
console.log(`-3: ${datePrettier(updateDateStringYyyyMinusMmMinusDdByNumericVariable(myDate, -3))}`);
console.log(`-2: ${datePrettier(updateDateStringYyyyMinusMmMinusDdByNumericVariable(myDate, -2))}`);
console.log(`-1: ${datePrettier(updateDateStringYyyyMinusMmMinusDdByNumericVariable(myDate, -1))}`);
console.log(`0: ${datePrettier(updateDateStringYyyyMinusMmMinusDdByNumericVariable(myDate, 0))}`);
console.log(`1: ${datePrettier(updateDateStringYyyyMinusMmMinusDdByNumericVariable(myDate, 1))}`);
console.log(`2: ${datePrettier(updateDateStringYyyyMinusMmMinusDdByNumericVariable(myDate, 2))}`);
console.log(`3: ${datePrettier(updateDateStringYyyyMinusMmMinusDdByNumericVariable(myDate, 3))}`);
console.log(`4: ${datePrettier(updateDateStringYyyyMinusMmMinusDdByNumericVariable(myDate, 4))}`);

const getPrefixSuffixOfTextOld = (anyString, textToFind) => {
    const indexOfTextToFind = anyString.indexOf(textToFind);
    const textToFindPrefix = anyString.substring(0, indexOfTextToFind).trim();
    const textToFindSuffix = anyString.substring((indexOfTextToFind + textToFind.length), anyString.length).trim();
    return [textToFindPrefix, textToFindSuffix];
};
const getPrefixSuffixOfText = (anyString, textToFind) => (((indexOfTextToFind) => ([(anyString.substring(0, indexOfTextToFind)), (anyString.substring((indexOfTextToFind + textToFind.length), anyString.length))]))(anyString.indexOf(textToFind)));
const textToFind = "Idul Fitri";
const eventName = "Hari Idul Fitri 1 Syawal";
console.log(getPrefixSuffixOfText(eventName, textToFind));
