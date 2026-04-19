const runOnce = ((keySet) => (anyStringKey = "something", callbackFunction = (() => undefined)) => (keySet.has(anyStringKey) ? undefined : ([(keySet.add(anyStringKey)), (callbackFunction())].at(-1))))(new Set()); /* runOnceV2 */
const runNthTime = ((keyCountMap) => (({ keyString = "something", runTime = 1 } = {}, callbackFunction = (() => undefined)) => (((keyCountMap.get(keyString) ?? 0) >= runTime) ? undefined : ([(keyCountMap.set(keyString, ((keyCountMap.get(keyString) ?? 0) + 1))), (callbackFunction(runTime, keyCountMap.get(keyString)))].at(-1)))))(new Map()); /* runNthTimeV2 */
const printOnce = ((keySet) => (anything, { key, title, formatter = ((anythingInner) => anythingInner) } = {}) => (((anyStringKey) => (keySet.has(anyStringKey) ? anything : ([(keySet.add(anyStringKey)), (console.log(`${title ? `${title}: ` : ""}${formatter(anything)}`)), anything].at(-1))))(key || title || "first")))(new Set()); /* printOnceV2 */
const printAndReturn = (anything, { key, title, formatter = ((anythingInner) => anythingInner) } = {}) => ([(console.log(`${title ? `${title}: ` : ""}${formatter(anything)}`)), anything].at(-1));
const formatDate = (timestamp, ...restArguments) => (new Intl.DateTimeFormat(...restArguments).format(timestamp)); /* formatDateV2 */
const extractDate = (anything) => (((anythingType) => (((anyDate) => ((anyDate === undefined) ? undefined : (((anyDate) => ((([hourMinuteTwentyFourHourClockAllZeroPaddedJoinByColon, amPm], [zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute]) => ((([zeroPaddedHourTwelveHourClock, _]) => ([(String(anyDate.getFullYear())), (String(anyDate.getMonth() + 1).padStart(2, "0")), (formatDate(anyDate, "en-US", { month: "short" })), (String(anyDate.getDate()).padStart(2, "0")), (formatDate(anyDate, "en-US", { weekday: "short" })), zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, (String(anyDate.getSeconds()).padStart(2, "0")), (String(anyDate.getMilliseconds()).padStart(3, "0"))]))(hourMinuteTwentyFourHourClockAllZeroPaddedJoinByColon.split(":"))))((formatDate(anyDate, "en-US", { hour: "2-digit", minute: "2-digit", hour12: true }).split(" ")), (formatDate(anyDate, "en-GB", { hour: "2-digit", minute: "2-digit", hour12: false }).split(":")))))(new Date(anything)))))((anythingType === AnyType["String"]) ? new Date(anything) : ((anythingType === AnyType["Date"]) ? anything : undefined))))(getType(anything))); /* extractDateV3 */
const prettyFormatDate = (precise, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit) => (`((${fullYear}//(${zeroPaddedMonth}|${monthThreeFirstLetter})//(${zeroPaddedDay}|${dayThreeFirstLetter})||(${(precise === true) ? "(" : ""}${zeroPaddedHourTwelveHourClock}:${zeroPaddedMinute}${amPm}|${zeroPaddedHourTwentyFourHourClock}:${zeroPaddedMinute})${(precise === true) ? (`:${zeroPaddedSecond}.${zeroPaddedMiliSecondThreeDigit}`) : ("")}${(precise === true) ? ")" : ""}))`); /* prettyFormatDateV2 */
const datePrettier = (anything = new Date(), { precise = false } = {}) => (((anythingType) => ((([fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit]) => (prettyFormatDate(precise, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit)))((anythingType === AnyType["String"]) ? extractDate(new Date(anything).toISOString()) : ((anythingType === AnyType["Date"]) ? extractDate(anything.toISOString()) : []))))(getType(anything))); /* datePrettierV2 */
const generateTimestamp = ({ precise = false } = {}) => ((([fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit]) => (prettyFormatDate(precise, fullYear, zeroPaddedMonth, monthThreeFirstLetter, zeroPaddedDay, dayThreeFirstLetter, zeroPaddedHourTwelveHourClock, amPm, zeroPaddedHourTwentyFourHourClock, zeroPaddedMinute, zeroPaddedSecond, zeroPaddedMiliSecondThreeDigit)))(extractDate(new Date().toISOString()))); /* generateTimestampV2 */
const AnyType = { "Null": "Null", "Undefined": "Undefined", "Boolean": "Boolean", "String": "String", "Numeric": "Numeric", "Object": "Object", "Array": "Array", "Function": "Function", "Error": "Error", "Date": "Date" };
const isNull = (anything) => ((Object.prototype.toString.call(anything) === "[object Null]") && (anything === null));
const isUndefined = (anything) => ((Object.prototype.toString.call(anything) === "[object Undefined]") && (anything === undefined));
const isBoolean = (anything) => ((Object.prototype.toString.call(anything) === "[object Boolean]") && ((anything === true) || (anything === false)));
const isString = (anything) => (Object.prototype.toString.call(anything) === "[object String]");
const isNumeric = (anything) => ((Object.prototype.toString.call(anything) === "[object Number]") && (Number.isNaN(anything) === false) && (Number.isFinite(anything) === true));
const isObject = (anything) => (Object.prototype.toString.call(anything) === "[object Object]");
const isArray = (anything) => ((Object.prototype.toString.call(anything) === "[object Array]") && (Array.isArray(anything) === true));
const isFunction = (anything) => (Object.prototype.toString.call(anything) === "[object Function]");
const isError = (anything) => (Object.prototype.toString.call(anything) === "[object Error]");
const isStringIso8601 = (anything) => ((isString(anything) === false) ? false : ((/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?Z$/.test(anything) === false) ? false : ((dateParsedFromString) => ((isNumeric(dateParsedFromString.getTime()) === false) ? false : (dateParsedFromString.toISOString().replace(/\.000Z$/, "Z") === anything)))(new Date(anything))));
const isDate = (anything) => (Object.prototype.toString.call(anything) === "[object Date]");
const getType = (anything) => ((isUndefined(anything) === true) ? AnyType["Undefined"] : ((isNull(anything) === true) ? AnyType["Null"] : ((isBoolean(anything) === true) ? AnyType["Boolean"] : ((isString(anything) === true) ? AnyType["String"] : ((isNumeric(anything) === true) ? AnyType["Numeric"] : ((isObject(anything) === true) ? AnyType["Object"] : ((isArray(anything) === true) ? AnyType["Array"] : ((isFunction(anything) === true) ? AnyType["Function"] : ((isDate(anything) === true) ? AnyType["Date"] : ((isError(anything) === true) ? AnyType["Error"] : Object.prototype.toString.call(anything)))))))))));
const jsonStringify = (anything, { pretty = false } = {}) => ((temporaryMap) => ([(temporaryMap.set("f", ((anythingInner, { indent = " ".repeat(4), indentLevel = 0, argumentType = getType(anythingInner) } = {}) => ((isStringIso8601(anythingInner) === true) ? (temporaryMap.get("f")({ "pretty": generateTimestamp(anythingInner), "ISO8601": anythingInner }, { indentLevel })) : ((argumentType === AnyType["Undefined"]) ? ('"undefined"') : ((argumentType === AnyType["Null"]) ? ("null") : ((argumentType === AnyType["Error"]) ? (`"${anythingInner.toString()}"`) : ((argumentType === AnyType["Date"]) ? (temporaryMap.get("f")({ "pretty": generateTimestamp(anythingInner), "ISO8601": anythingInner.toISOString() }, { indentLevel })) : ((argumentType === AnyType["String"]) ? (`"${anythingInner}"`) : (((argumentType === AnyType["Numeric"]) || (argumentType === AnyType["Boolean"])) ? (`${anythingInner}`) : ((argumentType === AnyType["Object"]) ? ((Object.keys(anythingInner).length === 0) ? ("{}") : ((Object.keys(anythingInner).includes("ISO8601") === true) ? (`${((pretty === true) ? (`{\n${indent.repeat(indentLevel + 1)}`) : "{ ")}${(`"pretty": "${anythingInner["pretty"]}"${(pretty === true) ? (`,\n${indent.repeat(indentLevel + 1)}`) : ", "}"ISO8601": "${anythingInner["ISO8601"]}"${(pretty === true) ? "," : ""}`)}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}}`) : " }")}`) : (`${((pretty === true) ? (`{\n${indent.repeat(indentLevel + 1)}`) : "{ ")}${Object.entries(anythingInner).reduce((currentResult, [objectKey, objectValue], objectEntryIndex) => (`${currentResult}"${objectKey}": ${temporaryMap.get("f")(objectValue, { indentLevel: (indentLevel + 1) })}${((objectEntryIndex + 1) !== Object.keys(anythingInner).length) ? ((pretty === true) ? (`,\n${indent.repeat(indentLevel + 1)}`) : ", ") : ""}`), "")}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}}`) : " }")}`))) : ((argumentType === AnyType["Array"]) ? ((anythingInner.length === 0) ? ("[]") : (`${((pretty === true) ? (`[\n${indent.repeat(indentLevel + 1)}`) : "[")}${anythingInner.reduce((currentResult, arrayItem, arrayItemIndex) => (`${currentResult}${temporaryMap.get("f")(arrayItem, { indentLevel: (indentLevel + 1) })}${((arrayItemIndex + 1) !== anythingInner.length) ? ((pretty === true) ? (`,\n${indent.repeat(indentLevel + 1)}`) : ", ") : ""}`), "")}${((pretty === true) ? (`\n${indent.repeat(indentLevel)}]`) : "]")}`)) : ((argumentType === AnyType["Function"]) ? (`"${anythingInner.toString()}"`) : (`${anythingInner}`)))))))))))))), (temporaryMap.get("f")(anything))].at(-1)))(new Map()); /* custom JSON.stringify() function jsonStringifyV5 */
const randomIntInclusive = (lowerBound, upperBound) => (Math.floor(Math.random() * (upperBound - lowerBound + 1)) + lowerBound);
const removeDuplicateItem = (anyArray, callbackFunction = ((anyArrayItem) => anyArrayItem)) => (anyArray.reduce(([uniqueKeyMap, uniqueArray], anyArrayItem) => ((newUniqueKeyString) => ((uniqueKeyMap.get(newUniqueKeyString) !== undefined) ? [uniqueKeyMap, uniqueArray] : ([(uniqueKeyMap.set(newUniqueKeyString, anyArrayItem)), (uniqueArray.push(anyArrayItem)), ([uniqueKeyMap, uniqueArray])].at(-1))))(callbackFunction(anyArrayItem)), [new Map(), []]).at(-1)); /* removeDuplicateItemV2 */
const rangeInclusive = function* (startNumber, stopNumber) {
    const stepNumber = ((startNumber < stopNumber) ? 1 : (startNumber > stopNumber) ? -1 : 0);
    if (stepNumber === 0) {
        yield startNumber;
        return;
    }
    for (let i = startNumber; ((stepNumber > 0) ? (i <= stopNumber) : (i >= stopNumber)); i += stepNumber) {
        yield i;
    }
};
const generatorExpression = function* (anyIterable, callbackFunction, filterConditionFunction = () => true) {
    for (const anyRangeItem of anyIterable) {
        if (filterConditionFunction(anyRangeItem) === true) {
            yield callbackFunction(anyRangeItem);
        }
    }
};
const iterateList = (anyList, callbackFunction) => {
    let i = 0;
    for (const listItem of anyList) {
        callbackFunction(listItem, i, anyList);
        i += 1;
    }
};
const loop = (startNumber, stopNumber) => {
    const anyList = rangeInclusive(startNumber, stopNumber);
    return (callbackFunction) => {
        let i = 0;
        for (const listItem of anyList) {
            callbackFunction(listItem, i, anyList);
            i += 1;
        }
    };
};
const listComprehension = (anyList, callbackFunction, filterConditionFunction) => Array.from(generatorExpression(anyList, callbackFunction, filterConditionFunction));

export {
    runOnce,
    runNthTime,
    printOnce,
    printAndReturn,
    formatDate,
    extractDate,
    prettyFormatDate,
    datePrettier,
    generateTimestamp,
    AnyType,
    isNull,
    isUndefined,
    isBoolean,
    isString,
    isNumeric,
    isObject,
    isArray,
    isFunction,
    isError,
    isStringIso8601,
    isDate,
    getType,
    jsonStringify,
    randomIntInclusive,
    removeDuplicateItem,
    rangeInclusive,
    generatorExpression,
    iterateList,
    loop,
    listComprehension,
};
