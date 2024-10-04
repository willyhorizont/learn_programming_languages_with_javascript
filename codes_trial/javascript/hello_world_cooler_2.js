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
    if (printedCharacter === expectedPrintedCharacter) return;
    const anyCharacter = charactersString[Math.floor(Math.random() * charactersString.length)];
    printedCharacter = anyCharacter;
    resultContainer[targetStringIndex] = [resultContainer[targetStringIndex][0], anyCharacter];
    await pythonLikeSleep(0.05);
};

const main = async () => {
    const characterPrinters = targetString.split("").map((anyCharacter, targetStringIndex) => (() => printCharacter(anyCharacter, targetStringIndex)));
    let resultString = "";
    while (resultString !== targetString) {
        const anyCharacterPrinter = characterPrinters[Math.floor(Math.random() * characterPrinters.length)];
        // eslint-disable-next-line no-await-in-loop
        await anyCharacterPrinter();
        resultString = resultContainer.reduce((currentResult, currentArray) => (`${currentResult}${currentArray[1]}`), "");
        console.log(resultString);
    }
    for (let i = 0; i < 10; i += 1) {
        console.log(targetString);
    }
};

main();
