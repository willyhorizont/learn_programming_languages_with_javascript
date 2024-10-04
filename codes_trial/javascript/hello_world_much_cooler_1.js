const pythonLikeSleep = (seconds) => {
    const secondInMiliseconds = 1_000;
    return new Promise((resolve) => {
        setTimeout(resolve, seconds * 1 * secondInMiliseconds);
    });
};

const charactersString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ `~!@#$%^&*()_+-=[]\\{}|;':\",./<>?";
const targetString = "Hello, World!";
const resultContainer = Array.from(targetString, (anyCharacter) => [anyCharacter, ""]);

const printCharacter = async (expectedPrintedCharacter, targetStringIndex) => {
    let printedCharacter = resultContainer[targetStringIndex][1];
    while (printedCharacter !== expectedPrintedCharacter) {
        const anyCharacter = charactersString[Math.floor(Math.random() * charactersString.length)];
        printedCharacter = anyCharacter;
        resultContainer[targetStringIndex] = [resultContainer[targetStringIndex][0], anyCharacter];
        const resultString = resultContainer.reduce((currentResult, currentArray) => `${currentResult}${currentArray[1]}`, "");
        console.log(resultString);
        // eslint-disable-next-line no-await-in-loop
        await pythonLikeSleep(0.05);
    }
};

const main = async () => {
    const characterPrinterPromises = [];
    for (let targetStringIndex = 0; (targetStringIndex < targetString.length); targetStringIndex += 1) {
        const anyCharacter = targetString[targetStringIndex];
        characterPrinterPromises.push(printCharacter(anyCharacter, targetStringIndex));
    }
    await Promise.all(characterPrinterPromises);
};

main();
