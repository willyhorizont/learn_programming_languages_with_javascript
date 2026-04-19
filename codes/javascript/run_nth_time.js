import {
    runNthTime,
} from "./utils.js";

const runNthTimeV1 = (() => {
    const keyCountMap = new Map();
    return ({ keyString = "something", runTime = 1 } = {}, callbackFunction = (() => undefined)) => {
        const currentRunTime = (keyCountMap.get(keyString) || 0);
        if (currentRunTime >= runTime) return;
        keyCountMap.set(keyString, (currentRunTime + 1));
        return callbackFunction(runTime, keyCountMap.get(keyString));
    };
})();

const runNthTimeV2 = runNthTime;

const animals = ["Elephant", "Lion", "Tiger", "Bear", "Deer"];

animals.forEach((animal) => {
    runNthTimeV2({ keyString: "animal", runTime: 2 }, (totalRunTime, currentRunTime) => console.log(`(${currentRunTime}/${totalRunTime}) print animal: ${animal}`));
});
