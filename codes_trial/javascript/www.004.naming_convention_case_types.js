const capitalLettersString = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
const numbersString = "0123456789";

const splitByCapitalLetter = (aString) => [...aString].reduce((result, currentCharacter) => (capitalLettersString.includes(currentCharacter)
    ? [...result, currentCharacter]
    : ((numbersString.includes(currentCharacter) && numbersString.includes(result[result.length - 1][result[result.length - 1].length - 1]))
        ? [...result.slice(0, -1), `${result[result.length - 1]}${currentCharacter}`]
        : (numbersString.includes(currentCharacter)
            ? [...result, currentCharacter]
            : ((result.length === 0)
                ? [...result.slice(0, -1), currentCharacter]
                : [...result.slice(0, -1), `${result[result.length - 1]}${currentCharacter}`]
            )
        )
    )
), []);

const isCamelCase = (aString) => ((capitalLettersString.toLowerCase().includes(aString.charAt(0)) === false)
    ? false
    : (aString.includes("_")
        ? false
        : (aString.includes("-")
            ? false
            : (aString.includes(" ")
                ? false
                : (capitalLettersString.includes(aString.charAt(0))
                    ? false
                    : ((aString === aString.toUpperCase()) === false)
                )
            )
        )
    )
);

const isPascalCase = (aString) => ((capitalLettersString.includes(aString.charAt(0)) === false)
    ? false
    : (aString.includes("_")
        ? false
        : (aString.includes("-")
            ? false
            : (aString.includes(" ")
                ? false
                : ((aString === aString.toUpperCase()) === false)
            )
        )
    )
);

const isSnakeCase = (aString) => ((capitalLettersString.toLowerCase().includes(aString.charAt(0)) === false)
    ? false
    : (aString.includes("-")
        ? false
        : (aString.includes(" ")
            ? false
            : (aString.split("_").join("").split("").every((aCharacther) => (capitalLettersString.includes(aCharacther) === false)))
        )
    )
);

const isKebabCase = (aString) => ((capitalLettersString.toLowerCase().includes(aString.charAt(0)) === false)
    ? false
    : (aString.includes("_")
        ? false
        : (aString.includes(" ")
            ? false
            : (aString.split("-").join("").split("").every((aCharacther) => (capitalLettersString.includes(aCharacther) === false)))
        )
    )
);

const isConstantCase = (aString) => ((capitalLettersString.includes(aString.charAt(0)) === false)
    ? false
    : (aString.includes("-")
        ? false
        : (aString.includes(" ")
            ? false
            : (aString.split("_").every((aWord) => (aWord === aWord.toUpperCase())))
        )
    )
);

const isCobolCase = (aString) => ((capitalLettersString.includes(aString.charAt(0)) === false)
    ? false
    : (aString.includes("_")
        ? false
        : (aString.includes(" ")
            ? false
            : (aString.split("-").every((aWord) => (aWord === aWord.toUpperCase())))
        )
    )
);

const isTrainCase = (aString) => ((capitalLettersString.includes(aString.charAt(0)) === false)
    ? false
    : (aString.includes("_")
        ? false
        : (aString.includes(" ")
            ? false
            : aString.split("-").every((aWord) => (aWord === `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`))
        )
    )
);

const isTitleCase = (aString) => ((capitalLettersString.includes(aString.charAt(0)) === false)
    ? false
    : (aString.includes("_")
        ? false
        : (aString.includes("-")
            ? false
            : aString.split(" ").every((aWord) => (aWord === `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`))
        )
    )
);

const isPascalSnakeCase = (aString) => ((capitalLettersString.includes(aString.charAt(0)) === false)
    ? false
    : (aString.includes("-")
        ? false
        : (aString.includes(" ")
            ? false
            : aString.split("_").every((aWord) => (aWord === `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`))
        )
    )
);

const isFlatCase = (aString) => ((capitalLettersString.toLowerCase().includes(aString.charAt(0)) === false)
    ? false
    : (aString.includes("_")
        ? false
        : (aString.includes("-")
            ? false
            : (aString.includes(" ")
                ? false
                : (aString === aString.toLowerCase())
            )
        )
    )
);

const isUpperFlatCase = (aString) => ((capitalLettersString.includes(aString.charAt(0)) === false)
    ? false
    : (aString.includes("_")
        ? false
        : (aString.includes("-")
            ? false
            : (aString.includes(" ")
                ? false
                : (aString === aString.toUpperCase())
            )
        )
    )
);

console.log(`isCamelCase("word101"): ${isCamelCase("word101")}`); // true
console.log(`isCamelCase("Word101"): ${isCamelCase("Word101")}`); // false
console.log(`isCamelCase("WORD101"): ${isCamelCase("WORD101")}`); // false
console.log(`isCamelCase("thisIsCamelCase101"): ${isCamelCase("thisIsCamelCase101")}`); // true
console.log(`isCamelCase("this_is_snake_case_101"): ${isCamelCase("this_is_snake_case_101")}`); // false
console.log(`isCamelCase("ThisIsPascalCase101"): ${isCamelCase("ThisIsPascalCase101")}`); // false
console.log(`isCamelCase("this-is-kebab-case-101"): ${isCamelCase("this-is-kebab-case-101")}`); // false
console.log(`isCamelCase("THIS_IS_CONSTANT_CASE_101"): ${isCamelCase("THIS_IS_CONSTANT_CASE_101")}`); // false
console.log(`isCamelCase("THIS-IS-COBOL-CASE-101"): ${isCamelCase("THIS-IS-COBOL-CASE-101")}`); // false
console.log(`isCamelCase("This-Is-Train-Case-101"): ${isCamelCase("This-Is-Train-Case-101")}`); // false
console.log(`isCamelCase("This Is Title Case 101"): ${isCamelCase("This Is Title Case 101")}`); // false
console.log(`isCamelCase("This_Is_Pascal_Snake_Case_101"): ${isCamelCase("This_Is_Pascal_Snake_Case_101")}`); // false
console.log(`isCamelCase("thisisflatcase101"): ${isCamelCase("thisisflatcase101")}`); // true
console.log(`isCamelCase("THISISUPPERFLATCASE101"): ${isCamelCase("THISISUPPERFLATCASE101")}`); // false
console.log(`isPascalCase("word101"): ${isPascalCase("word101")}`); // false
console.log(`isPascalCase("Word101"): ${isPascalCase("Word101")}`); // true
console.log(`isPascalCase("WORD101"): ${isPascalCase("WORD101")}`); // false
console.log(`isPascalCase("thisIsCamelCase101"): ${isPascalCase("thisIsCamelCase101")}`); // false
console.log(`isPascalCase("this_is_snake_case_101"): ${isPascalCase("this_is_snake_case_101")}`); // false
console.log(`isPascalCase("ThisIsPascalCase101"): ${isPascalCase("ThisIsPascalCase101")}`); // true
console.log(`isPascalCase("this-is-kebab-case-101"): ${isPascalCase("this-is-kebab-case-101")}`); // false
console.log(`isPascalCase("THIS_IS_CONSTANT_CASE_101"): ${isPascalCase("THIS_IS_CONSTANT_CASE_101")}`); // false
console.log(`isPascalCase("THIS-IS-COBOL-CASE-101"): ${isPascalCase("THIS-IS-COBOL-CASE-101")}`); // false
console.log(`isPascalCase("This-Is-Train-Case-101"): ${isPascalCase("This-Is-Train-Case-101")}`); // false
console.log(`isPascalCase("This Is Title Case 101"): ${isPascalCase("This Is Title Case 101")}`); // false
console.log(`isPascalCase("This_Is_Pascal_Snake_Case_101"): ${isPascalCase("This_Is_Pascal_Snake_Case_101")}`); // false
console.log(`isPascalCase("thisisflatcase101"): ${isPascalCase("thisisflatcase101")}`); // false
console.log(`isPascalCase("THISISUPPERFLATCASE101"): ${isPascalCase("THISISUPPERFLATCASE101")}`); // false
console.log(`isSnakeCase("word101"): ${isSnakeCase("word101")}`); // true
console.log(`isSnakeCase("Word101"): ${isSnakeCase("Word101")}`); // false
console.log(`isSnakeCase("WORD101"): ${isSnakeCase("WORD101")}`); // false
console.log(`isSnakeCase("thisIsCamelCase101"): ${isSnakeCase("thisIsCamelCase101")}`); // false
console.log(`isSnakeCase("this_is_snake_case_101"): ${isSnakeCase("this_is_snake_case_101")}`); // true
console.log(`isSnakeCase("ThisIsPascalCase101"): ${isSnakeCase("ThisIsPascalCase101")}`); // false
console.log(`isSnakeCase("this-is-kebab-case-101"): ${isSnakeCase("this-is-kebab-case-101")}`); // false
console.log(`isSnakeCase("THIS_IS_CONSTANT_CASE_101"): ${isSnakeCase("THIS_IS_CONSTANT_CASE_101")}`); // false
console.log(`isSnakeCase("THIS-IS-COBOL-CASE-101"): ${isSnakeCase("THIS-IS-COBOL-CASE-101")}`); // false
console.log(`isSnakeCase("This-Is-Train-Case-101"): ${isSnakeCase("This-Is-Train-Case-101")}`); // false
console.log(`isSnakeCase("This Is Title Case 101"): ${isSnakeCase("This Is Title Case 101")}`); // false
console.log(`isSnakeCase("This_Is_Pascal_Snake_Case_101"): ${isSnakeCase("This_Is_Pascal_Snake_Case_101")}`); // false
console.log(`isSnakeCase("thisisflatcase101"): ${isSnakeCase("thisisflatcase101")}`); // true
console.log(`isSnakeCase("THISISUPPERFLATCASE101"): ${isSnakeCase("THISISUPPERFLATCASE101")}`); // false
console.log(`isKebabCase("word101"): ${isKebabCase("word101")}`); // true
console.log(`isKebabCase("Word101"): ${isKebabCase("Word101")}`); // false
console.log(`isKebabCase("WORD101"): ${isKebabCase("WORD101")}`); // false
console.log(`isKebabCase("thisIsCamelCase101"): ${isKebabCase("thisIsCamelCase101")}`); // false
console.log(`isKebabCase("this_is_snake_case_101"): ${isKebabCase("this_is_snake_case_101")}`); // false
console.log(`isKebabCase("ThisIsPascalCase101"): ${isKebabCase("ThisIsPascalCase101")}`); // false
console.log(`isKebabCase("this-is-kebab-case-101"): ${isKebabCase("this-is-kebab-case-101")}`); // true
console.log(`isKebabCase("THIS_IS_CONSTANT_CASE_101"): ${isKebabCase("THIS_IS_CONSTANT_CASE_101")}`); // false
console.log(`isKebabCase("THIS-IS-COBOL-CASE-101"): ${isKebabCase("THIS-IS-COBOL-CASE-101")}`); // false
console.log(`isKebabCase("This-Is-Train-Case-101"): ${isKebabCase("This-Is-Train-Case-101")}`); // false
console.log(`isKebabCase("This Is Title Case 101"): ${isKebabCase("This Is Title Case 101")}`); // false
console.log(`isKebabCase("This_Is_Pascal_Snake_Case_101"): ${isKebabCase("This_Is_Pascal_Snake_Case_101")}`); // false
console.log(`isKebabCase("thisisflatcase101"): ${isKebabCase("thisisflatcase101")}`); // true
console.log(`isKebabCase("THISISUPPERFLATCASE101"): ${isKebabCase("THISISUPPERFLATCASE101")}`); // false
console.log(`isConstantCase("word101"): ${isConstantCase("word101")}`); // false
console.log(`isConstantCase("Word101"): ${isConstantCase("Word101")}`); // false
console.log(`isConstantCase("WORD101"): ${isConstantCase("WORD101")}`); // true
console.log(`isConstantCase("thisIsCamelCase101"): ${isConstantCase("thisIsCamelCase101")}`); // false
console.log(`isConstantCase("this_is_snake_case_101"): ${isConstantCase("this_is_snake_case_101")}`); // false
console.log(`isConstantCase("ThisIsPascalCase101"): ${isConstantCase("ThisIsPascalCase101")}`); // false
console.log(`isConstantCase("this-is-kebab-case-101"): ${isConstantCase("this-is-kebab-case-101")}`); // false
console.log(`isConstantCase("THIS_IS_CONSTANT_CASE_101"): ${isConstantCase("THIS_IS_CONSTANT_CASE_101")}`); // true
console.log(`isConstantCase("THIS-IS-COBOL-CASE-101"): ${isConstantCase("THIS-IS-COBOL-CASE-101")}`); // false
console.log(`isConstantCase("This-Is-Train-Case-101"): ${isConstantCase("This-Is-Train-Case-101")}`); // false
console.log(`isConstantCase("This Is Title Case 101"): ${isConstantCase("This Is Title Case 101")}`); // false
console.log(`isConstantCase("This_Is_Pascal_Snake_Case_101"): ${isConstantCase("This_Is_Pascal_Snake_Case_101")}`); // false
console.log(`isConstantCase("thisisflatcase101"): ${isConstantCase("thisisflatcase101")}`); // false
console.log(`isConstantCase("THISISUPPERFLATCASE101"): ${isConstantCase("THISISUPPERFLATCASE101")}`); // true
console.log(`isTrainCase("word101"): ${isTrainCase("word101")}`); // false
console.log(`isTrainCase("Word101"): ${isTrainCase("Word101")}`); // true
console.log(`isTrainCase("WORD101"): ${isTrainCase("WORD101")}`); // false
console.log(`isTrainCase("thisIsCamelCase101"): ${isTrainCase("thisIsCamelCase101")}`); // false
console.log(`isTrainCase("this_is_snake_case_101"): ${isTrainCase("this_is_snake_case_101")}`); // false
console.log(`isTrainCase("ThisIsPascalCase101"): ${isTrainCase("ThisIsPascalCase101")}`); // false
console.log(`isTrainCase("this-is-kebab-case-101"): ${isTrainCase("this-is-kebab-case-101")}`); // false
console.log(`isTrainCase("THIS_IS_CONSTANT_CASE_101"): ${isTrainCase("THIS_IS_CONSTANT_CASE_101")}`); // false
console.log(`isTrainCase("THIS-IS-COBOL-CASE-101"): ${isTrainCase("THIS-IS-COBOL-CASE-101")}`); // false
console.log(`isTrainCase("This-Is-Train-Case-101"): ${isTrainCase("This-Is-Train-Case-101")}`); // true
console.log(`isTrainCase("This Is Title Case 101"): ${isTrainCase("This Is Title Case 101")}`); // false
console.log(`isTrainCase("This_Is_Pascal_Snake_Case_101"): ${isTrainCase("This_Is_Pascal_Snake_Case_101")}`); // false
console.log(`isTrainCase("thisisflatcase101"): ${isTrainCase("thisisflatcase101")}`); // false
console.log(`isTrainCase("THISISUPPERFLATCASE101"): ${isTrainCase("THISISUPPERFLATCASE101")}`); // false
console.log(`isCobolCase("word101"): ${isCobolCase("word101")}`); // false
console.log(`isCobolCase("Word101"): ${isCobolCase("Word101")}`); // false
console.log(`isCobolCase("WORD101"): ${isCobolCase("WORD101")}`); // true
console.log(`isCobolCase("thisIsCamelCase101"): ${isCobolCase("thisIsCamelCase101")}`); // false
console.log(`isCobolCase("this_is_snake_case_101"): ${isCobolCase("this_is_snake_case_101")}`); // false
console.log(`isCobolCase("ThisIsPascalCase101"): ${isCobolCase("ThisIsPascalCase101")}`); // false
console.log(`isCobolCase("this-is-kebab-case-101"): ${isCobolCase("this-is-kebab-case-101")}`); // false
console.log(`isCobolCase("THIS_IS_CONSTANT_CASE_101"): ${isCobolCase("THIS_IS_CONSTANT_CASE_101")}`); // false
console.log(`isCobolCase("THIS-IS-COBOL-CASE-101"): ${isCobolCase("THIS-IS-COBOL-CASE-101")}`); // true
console.log(`isCobolCase("This-Is-Train-Case-101"): ${isCobolCase("This-Is-Train-Case-101")}`); // false
console.log(`isCobolCase("This Is Title Case 101"): ${isCobolCase("This Is Title Case 101")}`); // false
console.log(`isCobolCase("This_Is_Pascal_Snake_Case_101"): ${isCobolCase("This_Is_Pascal_Snake_Case_101")}`); // false
console.log(`isCobolCase("thisisflatcase101"): ${isCobolCase("thisisflatcase101")}`); // false
console.log(`isCobolCase("THISISUPPERFLATCASE101"): ${isCobolCase("THISISUPPERFLATCASE101")}`); // true
console.log(`isTitleCase("word101"): ${isTitleCase("word101")}`); // false
console.log(`isTitleCase("Word101"): ${isTitleCase("Word101")}`); // true
console.log(`isTitleCase("WORD101"): ${isTitleCase("WORD101")}`); // false
console.log(`isTitleCase("thisIsCamelCase101"): ${isTitleCase("thisIsCamelCase101")}`); // false
console.log(`isTitleCase("this_is_snake_case_101"): ${isTitleCase("this_is_snake_case_101")}`); // false
console.log(`isTitleCase("ThisIsPascalCase101"): ${isTitleCase("ThisIsPascalCase101")}`); // false
console.log(`isTitleCase("this-is-kebab-case-101"): ${isTitleCase("this-is-kebab-case-101")}`); // false
console.log(`isTitleCase("THIS_IS_CONSTANT_CASE_101"): ${isTitleCase("THIS_IS_CONSTANT_CASE_101")}`); // false
console.log(`isTitleCase("THIS-IS-COBOL-CASE-101"): ${isTitleCase("THIS-IS-COBOL-CASE-101")}`); // false
console.log(`isTitleCase("This-Is-Train-Case-101"): ${isTitleCase("This-Is-Train-Case-101")}`); // false
console.log(`isTitleCase("This Is Title Case 101"): ${isTitleCase("This Is Title Case 101")}`); // true
console.log(`isTitleCase("This_Is_Pascal_Snake_Case_101"): ${isTitleCase("This_Is_Pascal_Snake_Case_101")}`); // false
console.log(`isTitleCase("thisisflatcase101"): ${isTitleCase("thisisflatcase101")}`); // false
console.log(`isTitleCase("THISISUPPERFLATCASE101"): ${isTitleCase("THISISUPPERFLATCASE101")}`); // false
console.log(`isPascalSnakeCase("word101"): ${isPascalSnakeCase("word101")}`); // false
console.log(`isPascalSnakeCase("Word101"): ${isPascalSnakeCase("Word101")}`); // true
console.log(`isPascalSnakeCase("WORD101"): ${isPascalSnakeCase("WORD101")}`); // false
console.log(`isPascalSnakeCase("thisIsCamelCase101"): ${isPascalSnakeCase("thisIsCamelCase101")}`); // false
console.log(`isPascalSnakeCase("this_is_snake_case_101"): ${isPascalSnakeCase("this_is_snake_case_101")}`); // false
console.log(`isPascalSnakeCase("ThisIsPascalCase101"): ${isPascalSnakeCase("ThisIsPascalCase101")}`); // false
console.log(`isPascalSnakeCase("this-is-kebab-case-101"): ${isPascalSnakeCase("this-is-kebab-case-101")}`); // false
console.log(`isPascalSnakeCase("THIS_IS_CONSTANT_CASE_101"): ${isPascalSnakeCase("THIS_IS_CONSTANT_CASE_101")}`); // false
console.log(`isPascalSnakeCase("THIS-IS-COBOL-CASE-101"): ${isPascalSnakeCase("THIS-IS-COBOL-CASE-101")}`); // false
console.log(`isPascalSnakeCase("This-Is-Train-Case-101"): ${isPascalSnakeCase("This-Is-Train-Case-101")}`); // false
console.log(`isPascalSnakeCase("This Is Title Case 101"): ${isPascalSnakeCase("This Is Title Case 101")}`); // false
console.log(`isPascalSnakeCase("This_Is_Pascal_Snake_Case_101"): ${isPascalSnakeCase("This_Is_Pascal_Snake_Case_101")}`); // true
console.log(`isPascalSnakeCase("thisisflatcase101"): ${isPascalSnakeCase("thisisflatcase101")}`); // false
console.log(`isPascalSnakeCase("THISISUPPERFLATCASE101"): ${isPascalSnakeCase("THISISUPPERFLATCASE101")}`); // false
console.log(`isFlatCase("word101"): ${isFlatCase("word101")}`); // true
console.log(`isFlatCase("Word101"): ${isFlatCase("Word101")}`); // false
console.log(`isFlatCase("WORD101"): ${isFlatCase("WORD101")}`); // false
console.log(`isFlatCase("thisIsCamelCase101"): ${isFlatCase("thisIsCamelCase101")}`); // false
console.log(`isFlatCase("this_is_snake_case_101"): ${isFlatCase("this_is_snake_case_101")}`); // false
console.log(`isFlatCase("ThisIsPascalCase101"): ${isFlatCase("ThisIsPascalCase101")}`); // false
console.log(`isFlatCase("this-is-kebab-case-101"): ${isFlatCase("this-is-kebab-case-101")}`); // false
console.log(`isFlatCase("THIS_IS_CONSTANT_CASE_101"): ${isFlatCase("THIS_IS_CONSTANT_CASE_101")}`); // false
console.log(`isFlatCase("THIS-IS-COBOL-CASE-101"): ${isFlatCase("THIS-IS-COBOL-CASE-101")}`); // false
console.log(`isFlatCase("This-Is-Train-Case-101"): ${isFlatCase("This-Is-Train-Case-101")}`); // false
console.log(`isFlatCase("This Is Title Case 101"): ${isFlatCase("This Is Title Case 101")}`); // false
console.log(`isFlatCase("This_Is_Pascal_Snake_Case_101"): ${isFlatCase("This_Is_Pascal_Snake_Case_101")}`); // false
console.log(`isFlatCase("thisisflatcase101"): ${isFlatCase("thisisflatcase101")}`); // true
console.log(`isFlatCase("THISISUPPERFLATCASE101"): ${isFlatCase("THISISUPPERFLATCASE101")}`); // false
console.log(`isUpperFlatCase("word101"): ${isUpperFlatCase("word101")}`); // false
console.log(`isUpperFlatCase("Word101"): ${isUpperFlatCase("Word101")}`); // false
console.log(`isUpperFlatCase("WORD101"): ${isUpperFlatCase("WORD101")}`); // true
console.log(`isUpperFlatCase("thisIsCamelCase101"): ${isUpperFlatCase("thisIsCamelCase101")}`); // false
console.log(`isUpperFlatCase("this_is_snake_case_101"): ${isUpperFlatCase("this_is_snake_case_101")}`); // false
console.log(`isUpperFlatCase("ThisIsPascalCase101"): ${isUpperFlatCase("ThisIsPascalCase101")}`); // false
console.log(`isUpperFlatCase("this-is-kebab-case-101"): ${isUpperFlatCase("this-is-kebab-case-101")}`); // false
console.log(`isUpperFlatCase("THIS_IS_CONSTANT_CASE_101"): ${isUpperFlatCase("THIS_IS_CONSTANT_CASE_101")}`); // false
console.log(`isUpperFlatCase("THIS-IS-COBOL-CASE-101"): ${isUpperFlatCase("THIS-IS-COBOL-CASE-101")}`); // false
console.log(`isUpperFlatCase("This-Is-Train-Case-101"): ${isUpperFlatCase("This-Is-Train-Case-101")}`); // false
console.log(`isUpperFlatCase("This Is Title Case 101"): ${isUpperFlatCase("This Is Title Case 101")}`); // false
console.log(`isUpperFlatCase("This_Is_Pascal_Snake_Case_101"): ${isUpperFlatCase("This_Is_Pascal_Snake_Case_101")}`); // false
console.log(`isUpperFlatCase("thisisflatcase101"): ${isUpperFlatCase("thisisflatcase101")}`); // false
console.log(`isUpperFlatCase("THISISUPPERFLATCASE101"): ${isUpperFlatCase("THISISUPPERFLATCASE101")}`); // true

const toCamelCase = (aString) => (isCamelCase(aString)
    ? aString
    : (isPascalCase(aString)
        ? `${aString.charAt(0).toLowerCase()}${aString.slice(1)}`
        : (isSnakeCase(aString)
            ? aString.split("_").map((aWord, wordIndex) => ((wordIndex === 0) ? aWord : `${aWord.charAt(0).toUpperCase()}${aWord.slice(1)}`)).join("")
            : (isKebabCase(aString)
                ? aString.split("-").map((aWord, wordIndex) => ((wordIndex === 0) ? aWord : `${aWord.charAt(0).toUpperCase()}${aWord.slice(1)}`)).join("")
                : (isConstantCase(aString)
                    ? aString.split("_").map((aWord, wordIndex) => ((wordIndex === 0) ? aWord.toLowerCase() : `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`)).join("")
                    : (isCobolCase(aString)
                        ? aString.split("-").map((aWord, wordIndex) => ((wordIndex === 0) ? aWord.toLowerCase() : `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`)).join("")
                        : (isTrainCase(aString)
                            ? aString.split("-").map((aWord, wordIndex) => ((wordIndex === 0) ? `${aWord.charAt(0).toLowerCase()}${aWord.slice(1)}` : aWord)).join("")
                            : (isTitleCase(aString)
                                ? aString.split(" ").map((aWord, wordIndex) => ((wordIndex === 0) ? `${aWord.charAt(0).toLowerCase()}${aWord.slice(1)}` : aWord)).join("")
                                : (isPascalSnakeCase(aString)
                                    ? aString.split("_").map((aWord, wordIndex) => ((wordIndex === 0) ? `${aWord.charAt(0).toLowerCase()}${aWord.slice(1)}` : aWord)).join("")
                                    : (isFlatCase(aString)
                                        ? aString
                                        : (isUpperFlatCase(aString)
                                            ? aString.toLowerCase()
                                            : aString.split(" ").map((aWord, wordIndex) => ((wordIndex === 0) ? aWord : `${aWord.charAt(0).toUpperCase()}${aWord.slice(1)}`)).join("")
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )
);
console.log(`toCamelCase("word101"): ${toCamelCase("word101")}`); // word101
console.log(`toCamelCase("Word101"): ${toCamelCase("Word101")}`); // word101
console.log(`toCamelCase("WORD101"): ${toCamelCase("WORD101")}`); // word101
console.log(`thisIsCamelCase101 toCamelCase("multipleWords101"): ${toCamelCase("multipleWords101")}`); // thisIsCamelCase101 toCamelCase("multipleWords101"): multipleWords101
console.log(`ThisIsPascalCase101 toCamelCase("MultipleWords101"): ${toCamelCase("MultipleWords101")}`); // ThisIsPascalCase101 toCamelCase("MultipleWords101"): multipleWords101
console.log(`this_is_snake_case_101 toCamelCase("multiple_words_101"): ${toCamelCase("multiple_words_101")}`); // this_is_snake_case_101 toCamelCase("multiple_words_101"): multipleWords101
console.log(`this-is-kebab-case-101 toCamelCase("multiple-words-101"): ${toCamelCase("multiple-words-101")}`); // this-is-kebab-case-101 toCamelCase("multiple-words-101"): multipleWords101
console.log(`THIS_IS_CONSTANT_CASE_101 toCamelCase("MULTIPLE_WORDS_101"): ${toCamelCase("MULTIPLE_WORDS_101")}`); // THIS_IS_CONSTANT_CASE_101 toCamelCase("MULTIPLE_WORDS_101"): multipleWords101
console.log(`THIS-IS-COBOL-CASE-101 toCamelCase("MULTIPLE-WORDS-101"): ${toCamelCase("MULTIPLE-WORDS-101")}`); // THIS-IS-COBOL-CASE-101 toCamelCase("MULTIPLE-WORDS-101"): multipleWords101
console.log(`This-Is-Train-Case-101 toCamelCase("Multiple-Words-101"): ${toCamelCase("Multiple-Words-101")}`); // This-Is-Train-Case-101 toCamelCase("Multiple-Words-101"): multipleWords101
console.log(`This Is Title Case 101 toCamelCase("Multiple Words 101"): ${toCamelCase("Multiple Words 101")}`); // This Is Title Case 101 toCamelCase("Multiple Words 101"): multipleWords101
console.log(`This_Is_Pascal_Snake_Case_101 toCamelCase("Multiple_Words_101"): ${toCamelCase("Multiple_Words_101")}`); // This_Is_Pascal_Snake_Case_101 toCamelCase("Multiple_Words_101"): multipleWords101
console.log(`thisisflatcase101 toCamelCase("multiplewords101"): ${toCamelCase("multiplewords101")}`); // thisisflatcase101 toCamelCase("multiplewords101"): multiplewords101
console.log(`THISISUPPERFLATCASE101 toCamelCase("MULTIPLEWORDS101"): ${toCamelCase("MULTIPLEWORDS101")}`); // THISISUPPERFLATCASE101 toCamelCase("MULTIPLEWORDS101"): multiplewords101
console.log(`toCamelCase("multiple words 101"): ${toCamelCase("multiple words 101")}`); // multipleWords101

const toPascalCase = (aString) => (isPascalCase(aString)
    ? aString
    : (isCamelCase(aString)
        ? `${aString.charAt(0).toUpperCase()}${aString.slice(1)}`
        : (isSnakeCase(aString)
            ? aString.split("_").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1)}`).join("")
            : (isKebabCase(aString)
                ? aString.split("-").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1)}`).join("")
                : (isConstantCase(aString)
                    ? aString.split("_").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`).join("")
                    : (isCobolCase(aString)
                        ? aString.split("-").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`).join("")
                        : (isTrainCase(aString)
                            ? aString.split("-").join("")
                            : (isTitleCase(aString)
                                ? aString.split(" ").join("")
                                : (isPascalSnakeCase(aString)
                                    ? aString.split("_").join("")
                                    : (isFlatCase(aString)
                                        ? `${aString.charAt(0).toUpperCase()}${aString.slice(1).toLowerCase()}`
                                        : (isUpperFlatCase(aString)
                                            ? `${aString.charAt(0).toUpperCase()}${aString.slice(1).toLowerCase()}`
                                            : aString.split(" ").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`).join("")
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )
);
console.log(`toPascalCase("word101"): ${toPascalCase("word101")}`); // Word101
console.log(`toPascalCase("Word101"): ${toPascalCase("Word101")}`); // Word101
console.log(`toPascalCase("WORD101"): ${toPascalCase("WORD101")}`); // Word101
console.log(`thisIsCamelCase101 toPascalCase("multipleWords101"): ${toPascalCase("multipleWords101")}`); // thisIsCamelCase101 toPascalCase("multipleWords101"): MultipleWords101
console.log(`ThisIsPascalCase101 toPascalCase("MultipleWords101"): ${toPascalCase("MultipleWords101")}`); // ThisIsPascalCase101 toPascalCase("MultipleWords101"): MultipleWords101
console.log(`this_is_snake_case_101 toPascalCase("multiple_words_101"): ${toPascalCase("multiple_words_101")}`); // this_is_snake_case_101 toPascalCase("multiple_words_101"): MultipleWords101
console.log(`this-is-kebab-case-101 toPascalCase("multiple-words-101"): ${toPascalCase("multiple-words-101")}`); // this-is-kebab-case-101 toPascalCase("multiple-words-101"): MultipleWords101
console.log(`THIS_IS_CONSTANT_CASE_101 toPascalCase("MULTIPLE_WORDS_101"): ${toPascalCase("MULTIPLE_WORDS_101")}`); // THIS_IS_CONSTANT_CASE_101 toPascalCase("MULTIPLE_WORDS_101"): MultipleWords101
console.log(`THIS-IS-COBOL-CASE-101 toPascalCase("MULTIPLE-WORDS-101"): ${toPascalCase("MULTIPLE-WORDS-101")}`); // THIS-IS-COBOL-CASE-101 toPascalCase("MULTIPLE-WORDS-101"): MultipleWords101
console.log(`This-Is-Train-Case-101 toPascalCase("Multiple-Words-101"): ${toPascalCase("Multiple-Words-101")}`); // This-Is-Train-Case-101 toPascalCase("Multiple-Words-101"): MultipleWords101
console.log(`This Is Title Case 101 toPascalCase("Multiple Words 101"): ${toPascalCase("Multiple Words 101")}`); // This Is Title Case 101 toPascalCase("Multiple Words 101"): MultipleWords101
console.log(`This_Is_Pascal_Snake_Case_101 toPascalCase("Multiple_Words_101"): ${toPascalCase("Multiple_Words_101")}`); // This_Is_Pascal_Snake_Case_101 toPascalCase("Multiple_Words_101"): MultipleWords101
console.log(`thisisflatcase101 toPascalCase("multiplewords101"): ${toPascalCase("multiplewords101")}`); // thisisflatcase101 toPascalCase("multiplewords101"): Multiplewords101
console.log(`THISISUPPERFLATCASE101 toPascalCase("MULTIPLEWORDS101"): ${toPascalCase("MULTIPLEWORDS101")}`); // THISISUPPERFLATCASE101 toPascalCase("MULTIPLEWORDS101"): Multiplewords101
console.log(`toPascalCase("multiple words 101"): ${toPascalCase("multiple words 101")}`); // MultipleWords101

const toSnakeCase = (aString) => (isSnakeCase(aString)
    ? aString
    : (isCamelCase(aString)
        ? splitByCapitalLetter(aString).map((aCharacther) => aCharacther.toLowerCase()).join("_")
        : (isPascalCase(aString)
            ? (() => {
                const words = splitByCapitalLetter(aString).map((aWord) => aWord.toLowerCase());
                if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
                return words.join("_");
            })()
            : (isKebabCase(aString)
                ? aString.split("-").map((aWord) => aWord).join("_")
                : (isConstantCase(aString)
                    ? aString.toLowerCase()
                    : (isCobolCase(aString)
                        ? aString.split("-").join("_").toLowerCase()
                        : (isTrainCase(aString)
                            ? aString.split("-").join("_").toLowerCase()
                            : (isTitleCase(aString)
                                ? aString.split(" ").join("_").toLowerCase()
                                : (isPascalSnakeCase(aString)
                                    ? aString.toLowerCase()
                                    : (isFlatCase(aString)
                                        ? aString
                                        : (isUpperFlatCase(aString)
                                            ? aString.toLowerCase()
                                            : aString.split(" ").join("_").toLowerCase()
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )
);
console.log(`toSnakeCase("word101"): ${toSnakeCase("word101")}`); // word101
console.log(`toSnakeCase("Word101"): ${toSnakeCase("Word101")}`); // word101
console.log(`toSnakeCase("WORD101"): ${toSnakeCase("WORD101")}`); // word101
console.log(`thisIsCamelCase101 toSnakeCase("multipleWords101"): ${toSnakeCase("multipleWords101")}`); // thisIsCamelCase101 toSnakeCase("multipleWords101"): multiple_words_101
console.log(`ThisIsPascalCase101 toSnakeCase("MultipleWords101"): ${toSnakeCase("MultipleWords101")}`); // ThisIsPascalCase101 toSnakeCase("MultipleWords101"): multiple_words_101
console.log(`this_is_snake_case_101 toSnakeCase("multiple_words_101"): ${toSnakeCase("multiple_words_101")}`); // this_is_snake_case_101 toSnakeCase("multiple_words_101"): multiple_words_101
console.log(`this-is-kebab-case-101 toSnakeCase("multiple-words-101"): ${toSnakeCase("multiple-words-101")}`); // this-is-kebab-case-101 toSnakeCase("multiple-words-101"): multiple_words_101
console.log(`THIS_IS_CONSTANT_CASE_101 toSnakeCase("MULTIPLE_WORDS_101"): ${toSnakeCase("MULTIPLE_WORDS_101")}`); // THIS_IS_CONSTANT_CASE_101 toSnakeCase("MULTIPLE_WORDS_101"): multiple_words_101
console.log(`THIS-IS-COBOL-CASE-101 toSnakeCase("MULTIPLE-WORDS-101"): ${toSnakeCase("MULTIPLE-WORDS-101")}`); // THIS-IS-COBOL-CASE-101 toSnakeCase("MULTIPLE-WORDS-101"): multiple_words_101
console.log(`This-Is-Train-Case-101 toSnakeCase("Multiple-Words-101"): ${toSnakeCase("Multiple-Words-101")}`); // This-Is-Train-Case-101 toSnakeCase("Multiple-Words-101"): multiple_words_101
console.log(`This Is Title Case 101 toSnakeCase("Multiple Words 101"): ${toSnakeCase("Multiple Words 101")}`); // This Is Title Case 101 toSnakeCase("Multiple Words 101"): multiple_words_101
console.log(`This_Is_Pascal_Snake_Case_101 toSnakeCase("Multiple_Words_101"): ${toSnakeCase("Multiple_Words_101")}`); // This_Is_Pascal_Snake_Case_101 toSnakeCase("Multiple_Words_101"): multiple_words_101
console.log(`thisisflatcase101 toSnakeCase("multiplewords101"): ${toSnakeCase("multiplewords101")}`); // thisisflatcase101 toSnakeCase("multiplewords101"): multiplewords101
console.log(`THISISUPPERFLATCASE101 toSnakeCase("MULTIPLEWORDS101"): ${toSnakeCase("MULTIPLEWORDS101")}`); // THISISUPPERFLATCASE101 toSnakeCase("MULTIPLEWORDS101"): multiplewords101
console.log(`toSnakeCase("multiple words 101"): ${toSnakeCase("multiple words 101")}`); // multiple_words_101

const toKebabCase = (aString) => (isKebabCase(aString)
    ? aString
    : (isCamelCase(aString)
        ? splitByCapitalLetter(aString).map((aCharacther) => aCharacther.toLowerCase()).join("-")
        : (isPascalCase(aString)
            ? (() => {
                const words = splitByCapitalLetter(aString).map((aWord) => aWord.toLowerCase());
                if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
                return words.join("-");
            })()
            : (isSnakeCase(aString)
                ? aString.split("_").join("-")
                : (isConstantCase(aString)
                    ? aString.split("_").join("-").toLowerCase()
                    : (isCobolCase(aString)
                        ? aString.toLowerCase()
                        : (isTrainCase(aString)
                            ? aString.toLowerCase()
                            : (isTitleCase(aString)
                                ? aString.split(" ").join("-").toLowerCase()
                                : (isPascalSnakeCase(aString)
                                    ? aString.split("_").join("-").toLowerCase()
                                    : (isFlatCase(aString)
                                        ? aString
                                        : (isUpperFlatCase(aString)
                                            ? aString.toLowerCase()
                                            : aString.split(" ").join("-").toLowerCase()
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )
);
console.log(`toKebabCase("word101"): ${toKebabCase("word101")}`); // word101
console.log(`toKebabCase("Word101"): ${toKebabCase("Word101")}`); // word101
console.log(`toKebabCase("WORD101"): ${toKebabCase("WORD101")}`); // word101
console.log(`thisIsCamelCase101 toKebabCase("multipleWords101"): ${toKebabCase("multipleWords101")}`); // thisIsCamelCase101 toKebabCase("multipleWords101"): multiple-words-101
console.log(`ThisIsPascalCase101 toKebabCase("MultipleWords101"): ${toKebabCase("MultipleWords101")}`); // ThisIsPascalCase101 toKebabCase("MultipleWords101"): multiple-words-101
console.log(`this_is_snake_case_101 toKebabCase("multiple_words_101"): ${toKebabCase("multiple_words_101")}`); // this_is_snake_case_101 toKebabCase("multiple_words_101"): multiple-words-101
console.log(`this-is-kebab-case-101 toKebabCase("multiple-words-101"): ${toKebabCase("multiple-words-101")}`); // this-is-kebab-case-101 toKebabCase("multiple-words-101"): multiple-words-101
console.log(`THIS_IS_CONSTANT_CASE_101 toKebabCase("MULTIPLE_WORDS_101"): ${toKebabCase("MULTIPLE_WORDS_101")}`); // THIS_IS_CONSTANT_CASE_101 toKebabCase("MULTIPLE_WORDS_101"): multiple-words-101
console.log(`THIS-IS-COBOL-CASE-101 toKebabCase("MULTIPLE-WORDS-101"): ${toKebabCase("MULTIPLE-WORDS-101")}`); // THIS-IS-COBOL-CASE-101 toKebabCase("MULTIPLE-WORDS-101"): multiple-words-101
console.log(`This-Is-Train-Case-101 toKebabCase("Multiple-Words-101"): ${toKebabCase("Multiple-Words-101")}`); // This-Is-Train-Case-101 toKebabCase("Multiple-Words-101"): multiple-words-101
console.log(`This Is Title Case 101 toKebabCase("Multiple Words 101"): ${toKebabCase("Multiple Words 101")}`); // This Is Title Case 101 toKebabCase("Multiple Words 101"): multiple-words-101
console.log(`This_Is_Pascal_Snake_Case_101 toKebabCase("Multiple_Words_101"): ${toKebabCase("Multiple_Words_101")}`); // This_Is_Pascal_Snake_Case_101 toKebabCase("Multiple_Words_101"): multiple-words-101
console.log(`thisisflatcase101 toKebabCase("multiplewords101"): ${toKebabCase("multiplewords101")}`); // thisisflatcase101 toKebabCase("multiplewords101"): multiplewords101
console.log(`THISISUPPERFLATCASE101 toKebabCase("MULTIPLEWORDS101"): ${toKebabCase("MULTIPLEWORDS101")}`); // THISISUPPERFLATCASE101 toKebabCase("MULTIPLEWORDS101"): multiplewords101
console.log(`toKebabCase("multiple words 101"): ${toKebabCase("multiple words 101")}`); // multiple-words-101

const toConstantCase = (aString) => (isConstantCase(aString)
    ? aString
    : (isCamelCase(aString)
        ? (() => {
            const words = splitByCapitalLetter(aString).map((aWord) => aWord.toUpperCase());
            if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
            return words.join("_");
        })()
        : (isPascalCase(aString)
            ? (() => {
                const words = splitByCapitalLetter(aString).map((aWord) => aWord.toUpperCase());
                if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
                return words.join("_");
            })()
            : (isSnakeCase(aString)
                ? aString.toUpperCase()
                : (isKebabCase(aString)
                    ? aString.split("-").join("_").toUpperCase()
                    : (isCobolCase(aString)
                        ? aString.split("-").join("_")
                        : (isTrainCase(aString)
                            ? aString.split("-").join("_").toUpperCase()
                            : (isTitleCase(aString)
                                ? aString.split(" ").join("_").toUpperCase()
                                : (isPascalSnakeCase(aString)
                                    ? aString.toUpperCase()
                                    : (isFlatCase(aString)
                                        ? aString.toUpperCase()
                                        : (isUpperFlatCase(aString)
                                            ? aString
                                            : aString.split(" ").join("_").toUpperCase()
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )
);
console.log(`toConstantCase("word101"): ${toConstantCase("word101")}`); // WORD101
console.log(`toConstantCase("Word101"): ${toConstantCase("Word101")}`); // WORD101
console.log(`toConstantCase("WORD101"): ${toConstantCase("WORD101")}`); // WORD101
console.log(`thisIsCamelCase101 toConstantCase("multipleWords101"): ${toConstantCase("multipleWords101")}`); // thisIsCamelCase101 toConstantCase("multipleWords101"): MULTIPLE_WORDS_101
console.log(`ThisIsPascalCase101 toConstantCase("MultipleWords101"): ${toConstantCase("MultipleWords101")}`); // ThisIsPascalCase101 toConstantCase("MultipleWords101"): MULTIPLE_WORDS_101
console.log(`this_is_snake_case_101 toConstantCase("multiple_words_101"): ${toConstantCase("multiple_words_101")}`); // this_is_snake_case_101 toConstantCase("multiple_words_101"): MULTIPLE_WORDS_101
console.log(`this-is-kebab-case-101 toConstantCase("multiple-words-101"): ${toConstantCase("multiple-words-101")}`); // this-is-kebab-case-101 toConstantCase("multiple-words-101"): MULTIPLE_WORDS_101
console.log(`THIS_IS_CONSTANT_CASE_101 toConstantCase("MULTIPLE_WORDS_101"): ${toConstantCase("MULTIPLE_WORDS_101")}`); // THIS_IS_CONSTANT_CASE_101 toConstantCase("MULTIPLE_WORDS_101"): MULTIPLE_WORDS_101
console.log(`THIS-IS-COBOL-CASE-101 toConstantCase("MULTIPLE-WORDS-101"): ${toConstantCase("MULTIPLE-WORDS-101")}`); // THIS-IS-COBOL-CASE-101 toConstantCase("MULTIPLE-WORDS-101"): MULTIPLE_WORDS_101
console.log(`This-Is-Train-Case-101 toConstantCase("Multiple-Words-101"): ${toConstantCase("Multiple-Words-101")}`); // This-Is-Train-Case-101 toConstantCase("Multiple-Words-101"): MULTIPLE_WORDS_101
console.log(`This Is Title Case 101 toConstantCase("Multiple Words 101"): ${toConstantCase("Multiple Words 101")}`); // This Is Title Case 101 toConstantCase("Multiple Words 101"): MULTIPLE_WORDS_101
console.log(`This_Is_Pascal_Snake_Case_101 toConstantCase("Multiple_Words_101"): ${toConstantCase("Multiple_Words_101")}`); // This_Is_Pascal_Snake_Case_101 toConstantCase("Multiple_Words_101"): MULTIPLE_WORDS_101
console.log(`thisisflatcase101 toConstantCase("multiplewords101"): ${toConstantCase("multiplewords101")}`); // thisisflatcase101 toConstantCase("multiplewords101"): MULTIPLEWORDS101
console.log(`THISISUPPERFLATCASE101 toConstantCase("MULTIPLEWORDS101"): ${toConstantCase("MULTIPLEWORDS101")}`); // THISISUPPERFLATCASE101 toConstantCase("MULTIPLEWORDS101"): MULTIPLEWORDS101
console.log(`toConstantCase("multiple words 101"): ${toConstantCase("multiple words 101")}`); // MULTIPLE_WORDS_101

const toCobolCase = (aString) => (isCobolCase(aString)
    ? aString
    : (isCamelCase(aString)
        ? (() => {
            const words = splitByCapitalLetter(aString).map((aWord) => aWord.toUpperCase());
            if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
            return words.join("-");
        })()
        : (isPascalCase(aString)
            ? (() => {
                const words = splitByCapitalLetter(aString).map((aWord) => aWord.toUpperCase());
                if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
                return words.join("-");
            })()
            : (isSnakeCase(aString)
                ? aString.split("_").join("-").toUpperCase()
                : (isKebabCase(aString)
                    ? aString.toUpperCase()
                    : (isConstantCase(aString)
                        ? aString.split("_").join("-").toUpperCase()
                        : (isTrainCase(aString)
                            ? aString.toUpperCase()
                            : (isTitleCase(aString)
                                ? aString.split(" ").join("-").toUpperCase()
                                : (isPascalSnakeCase(aString)
                                    ? aString.split("_").join("-").toUpperCase()
                                    : (isFlatCase(aString)
                                        ? aString
                                        : (isUpperFlatCase(aString)
                                            ? aString.toUpperCase()
                                            : aString.split(" ").join("-").toUpperCase()
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )
);
console.log(`toCobolCase("word101"): ${toCobolCase("word101")}`); // WORD101
console.log(`toCobolCase("Word101"): ${toCobolCase("Word101")}`); // WORD101
console.log(`toCobolCase("WORD101"): ${toCobolCase("WORD101")}`); // WORD101
console.log(`thisIsCamelCase101 toCobolCase("multipleWords101"): ${toCobolCase("multipleWords101")}`); // thisIsCamelCase101 toCobolCase("multipleWords101"): MULTIPLE-WORDS-101
console.log(`ThisIsPascalCase101 toCobolCase("MultipleWords101"): ${toCobolCase("MultipleWords101")}`); // ThisIsPascalCase101 toCobolCase("MultipleWords101"): MULTIPLE-WORDS-101
console.log(`this_is_snake_case_101 toCobolCase("multiple_words_101"): ${toCobolCase("multiple_words_101")}`); // this_is_snake_case_101 toCobolCase("multiple_words_101"): MULTIPLE-WORDS-101
console.log(`this-is-kebab-case-101 toCobolCase("multiple-words-101"): ${toCobolCase("multiple-words-101")}`); // this-is-kebab-case-101 toCobolCase("multiple-words-101"): MULTIPLE-WORDS-101
console.log(`THIS_IS_CONSTANT_CASE_101 toCobolCase("MULTIPLE_WORDS_101"): ${toCobolCase("MULTIPLE_WORDS_101")}`); // THIS_IS_CONSTANT_CASE_101 toCobolCase("MULTIPLE_WORDS_101"): MULTIPLE-WORDS-101
console.log(`THIS-IS-COBOL-CASE-101 toCobolCase("MULTIPLE-WORDS-101"): ${toCobolCase("MULTIPLE-WORDS-101")}`); // THIS-IS-COBOL-CASE-101 toCobolCase("MULTIPLE-WORDS-101"): MULTIPLE-WORDS-101
console.log(`This-Is-Train-Case-101 toCobolCase("Multiple-Words-101"): ${toCobolCase("Multiple-Words-101")}`); // This-Is-Train-Case-101 toCobolCase("Multiple-Words-101"): MULTIPLE-WORDS-101
console.log(`This Is Title Case 101 toCobolCase("Multiple Words 101"): ${toCobolCase("Multiple Words 101")}`); // This Is Title Case 101 toCobolCase("Multiple Words 101"): MULTIPLE-WORDS-101
console.log(`This_Is_Pascal_Snake_Case_101 toCobolCase("Multiple_Words_101"): ${toCobolCase("Multiple_Words_101")}`); // This_Is_Pascal_Snake_Case_101 toCobolCase("Multiple_Words_101"): MULTIPLE-WORDS-101
console.log(`thisisflatcase101 toCobolCase("multiplewords101"): ${toCobolCase("multiplewords101")}`); // thisisflatcase101 toCobolCase("multiplewords101"): MULTIPLEWORDS101
console.log(`THISISUPPERFLATCASE101 toCobolCase("MULTIPLEWORDS101"): ${toCobolCase("MULTIPLEWORDS101")}`); // THISISUPPERFLATCASE101 toCobolCase("MULTIPLEWORDS101"): MULTIPLEWORDS101
console.log(`toCobolCase("multiple words 101"): ${toCobolCase("multiple words 101")}`); // MULTIPLE-WORDS-101

const toTrainCase = (aString) => (isTrainCase(aString)
    ? aString
    : (isCamelCase(aString)
        ? (() => {
            const words = splitByCapitalLetter(aString).map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`);
            if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
            return words.join("-");
        })()
        : (isPascalCase(aString)
            ? (() => {
                const words = splitByCapitalLetter(aString);
                if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
                return words.join("-");
            })()
            : (isSnakeCase(aString)
                ? aString.split("_").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1)}`).join("-")
                : (isKebabCase(aString)
                    ? aString.split("-").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1)}`).join("-")
                    : (isConstantCase(aString)
                        ? aString.split("_").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`).join("-")
                        : (isCobolCase(aString)
                            ? aString.split("-").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`).join("-")
                            : (isTitleCase(aString)
                                ? aString.split(" ").join("-")
                                : (isPascalSnakeCase(aString)
                                    ? aString.split("_").join("-")
                                    : (isFlatCase(aString)
                                        ? `${aString.charAt(0).toUpperCase()}${aString.slice(1).toLowerCase()}`
                                        : (isUpperFlatCase(aString)
                                            ? `${aString.charAt(0).toUpperCase()}${aString.slice(1).toLowerCase()}`
                                            : aString.split(" ").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`).join("-")
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )
);
console.log(`toTrainCase("word101"): ${toTrainCase("word101")}`); // Word101
console.log(`toTrainCase("Word101"): ${toTrainCase("Word101")}`); // Word101
console.log(`toTrainCase("WORD101"): ${toTrainCase("WORD101")}`); // Word101
console.log(`thisIsCamelCase101 toTrainCase("multipleWords101"): ${toTrainCase("multipleWords101")}`); // thisIsCamelCase101 toTrainCase("multipleWords101"): Multiple-Words-101
console.log(`ThisIsPascalCase101 toTrainCase("MultipleWords101"): ${toTrainCase("MultipleWords101")}`); // ThisIsPascalCase101 toTrainCase("MultipleWords101"): Multiple-Words-101
console.log(`this_is_snake_case_101 toTrainCase("multiple_words_101"): ${toTrainCase("multiple_words_101")}`); // this_is_snake_case_101 toTrainCase("multiple_words_101"): Multiple-Words-101
console.log(`this-is-kebab-case-101 toTrainCase("multiple-words-101"): ${toTrainCase("multiple-words-101")}`); // this-is-kebab-case-101 toTrainCase("multiple-words-101"): Multiple-Words-101
console.log(`THIS_IS_CONSTANT_CASE_101 toTrainCase("MULTIPLE_WORDS_101"): ${toTrainCase("MULTIPLE_WORDS_101")}`); // THIS_IS_CONSTANT_CASE_101 toTrainCase("MULTIPLE_WORDS_101"): Multiple-Words-101
console.log(`THIS-IS-COBOL-CASE-101 toTrainCase("MULTIPLE-WORDS-101"): ${toTrainCase("MULTIPLE-WORDS-101")}`); // THIS-IS-COBOL-CASE-101 toTrainCase("MULTIPLE-WORDS-101"): Multiple-Words-101
console.log(`This-Is-Train-Case-101 toTrainCase("Multiple-Words-101"): ${toTrainCase("Multiple-Words-101")}`); // This-Is-Train-Case-101 toTrainCase("Multiple-Words-101"): Multiple-Words-101
console.log(`This Is Title Case 101 toTrainCase("Multiple Words 101"): ${toTrainCase("Multiple Words 101")}`); // This Is Title Case 101 toTrainCase("Multiple Words 101"): Multiple-Words-101
console.log(`This_Is_Pascal_Snake_Case_101 toTrainCase("Multiple_Words_101"): ${toTrainCase("Multiple_Words_101")}`); // This_Is_Pascal_Snake_Case_101 toTrainCase("Multiple_Words_101"): Multiple-Words-101
console.log(`thisisflatcase101 toTrainCase("multiplewords101"): ${toTrainCase("multiplewords101")}`); // thisisflatcase101 toTrainCase("multiplewords101"): Multiplewords101
console.log(`THISISUPPERFLATCASE101 toTrainCase("MULTIPLEWORDS101"): ${toTrainCase("MULTIPLEWORDS101")}`); // THISISUPPERFLATCASE101 toTrainCase("MULTIPLEWORDS101"): Multiplewords101
console.log(`toTrainCase("multiple words 101"): ${toTrainCase("multiple words 101")}`); // Multiple-Words-101

const toTitleCase = (aString) => (isTitleCase(aString)
    ? aString
    : (isCamelCase(aString)
        ? (() => {
            const words = splitByCapitalLetter(aString).map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`);
            if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
            return words.join(" ");
        })()
        : (isPascalCase(aString)
            ? (() => {
                const words = splitByCapitalLetter(aString);
                if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
                return words.join(" ");
            })()
            : (isSnakeCase(aString)
                ? aString.split("_").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1)}`).join(" ")
                : (isKebabCase(aString)
                    ? aString.split("-").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1)}`).join(" ")
                    : (isConstantCase(aString)
                        ? aString.split("_").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`).join(" ")
                        : (isCobolCase(aString)
                            ? aString.split("-").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`).join(" ")
                            : (isTrainCase(aString)
                                ? aString.split("-").join(" ")
                                : (isPascalSnakeCase(aString)
                                    ? aString.split("_").join(" ")
                                    : (isFlatCase(aString)
                                        ? `${aString.charAt(0).toUpperCase()}${aString.slice(1).toLowerCase()}`
                                        : (isUpperFlatCase(aString)
                                            ? `${aString.charAt(0).toUpperCase()}${aString.slice(1).toLowerCase()}`
                                            : aString.split(" ").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`).join(" ")
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )
);
console.log(`toTitleCase("word101"): ${toTitleCase("word101")}`); // Word101
console.log(`toTitleCase("Word101"): ${toTitleCase("Word101")}`); // Word101
console.log(`toTitleCase("WORD101"): ${toTitleCase("WORD101")}`); // Word101
console.log(`thisIsCamelCase101 toTitleCase("multipleWords101"): ${toTitleCase("multipleWords101")}`); // thisIsCamelCase101 toTitleCase("multipleWords101"): Multiple Words 101
console.log(`ThisIsPascalCase101 toTitleCase("MultipleWords101"): ${toTitleCase("MultipleWords101")}`); // ThisIsPascalCase101 toTitleCase("MultipleWords101"): Multiple Words 101
console.log(`this_is_snake_case_101 toTitleCase("multiple_words_101"): ${toTitleCase("multiple_words_101")}`); // this_is_snake_case_101 toTitleCase("multiple_words_101"): Multiple Words 101
console.log(`this-is-kebab-case-101 toTitleCase("multiple-words-101"): ${toTitleCase("multiple-words-101")}`); // this-is-kebab-case-101 toTitleCase("multiple-words-101"): Multiple Words 101
console.log(`THIS_IS_CONSTANT_CASE_101 toTitleCase("MULTIPLE_WORDS_101"): ${toTitleCase("MULTIPLE_WORDS_101")}`); // THIS_IS_CONSTANT_CASE_101 toTitleCase("MULTIPLE_WORDS_101"): Multiple Words 101
console.log(`THIS-IS-COBOL-CASE-101 toTitleCase("MULTIPLE-WORDS-101"): ${toTitleCase("MULTIPLE-WORDS-101")}`); // THIS-IS-COBOL-CASE-101 toTitleCase("MULTIPLE-WORDS-101"): Multiple Words 101
console.log(`This-Is-Train-Case-101 toTitleCase("Multiple-Words-101"): ${toTitleCase("Multiple-Words-101")}`); // This-Is-Train-Case-101 toTitleCase("Multiple-Words-101"): Multiple Words 101
console.log(`This Is Title Case 101 toTitleCase("Multiple Words 101"): ${toTitleCase("Multiple Words 101")}`); // This Is Title Case 101 toTitleCase("Multiple Words 101"): Multiple Words 101
console.log(`This_Is_Pascal_Snake_Case_101 toTitleCase("Multiple_Words_101"): ${toTitleCase("Multiple_Words_101")}`); // This_Is_Pascal_Snake_Case_101 toTitleCase("Multiple_Words_101"): Multiple Words 101
console.log(`thisisflatcase101 toTitleCase("multiplewords101"): ${toTitleCase("multiplewords101")}`); // thisisflatcase101 toTitleCase("multiplewords101"): Multiplewords101
console.log(`THISISUPPERFLATCASE101 toTitleCase("MULTIPLEWORDS101"): ${toTitleCase("MULTIPLEWORDS101")}`); // THISISUPPERFLATCASE101 toTitleCase("MULTIPLEWORDS101"): Multiplewords101
console.log(`toTitleCase("multiple words 101"): ${toTitleCase("multiple words 101")}`); // Multiple Words 101

const toPascalSnakeCase = (aString) => (isPascalSnakeCase(aString)
    ? aString
    : (isCamelCase(aString)
        ? (() => {
            const words = splitByCapitalLetter(aString).map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`);
            if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
            return words.join("_");
        })()
        : (isPascalCase(aString)
            ? (() => {
                const words = splitByCapitalLetter(aString);
                if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
                return words.join("_");
            })()
            : (isSnakeCase(aString)
                ? aString.split("_").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1)}`).join("_")
                : (isKebabCase(aString)
                    ? aString.split("-").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1)}`).join("_")
                    : (isConstantCase(aString)
                        ? aString.split("_").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`).join("_")
                        : (isCobolCase(aString)
                            ? aString.split("-").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`).join("_")
                            : (isTrainCase(aString)
                                ? aString.split("-").join("_")
                                : (isTitleCase(aString)
                                    ? aString.split(" ").join("_")
                                    : (isFlatCase(aString)
                                        ? `${aString.charAt(0).toUpperCase()}${aString.slice(1).toLowerCase()}`
                                        : (isUpperFlatCase(aString)
                                            ? `${aString.charAt(0).toUpperCase()}${aString.slice(1).toLowerCase()}`
                                            : aString.split(" ").map((aWord) => `${aWord.charAt(0).toUpperCase()}${aWord.slice(1).toLowerCase()}`).join("_")
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )
);
console.log(`toPascalSnakeCase("word101"): ${toPascalSnakeCase("word101")}`); // Word101
console.log(`toPascalSnakeCase("Word101"): ${toPascalSnakeCase("Word101")}`); // Word101
console.log(`toPascalSnakeCase("WORD101"): ${toPascalSnakeCase("WORD101")}`); // Word101
console.log(`thisIsCamelCase101 toPascalSnakeCase("multipleWords101"): ${toPascalSnakeCase("multipleWords101")}`); // thisIsCamelCase101 toPascalSnakeCase("multipleWords101"): Multiple_Words_101
console.log(`ThisIsPascalCase101 toPascalSnakeCase("MultipleWords101"): ${toPascalSnakeCase("MultipleWords101")}`); // ThisIsPascalCase101 toPascalSnakeCase("MultipleWords101"): Multiple_Words_101
console.log(`this_is_snake_case_101 toPascalSnakeCase("multiple_words_101"): ${toPascalSnakeCase("multiple_words_101")}`); // this_is_snake_case_101 toPascalSnakeCase("multiple_words_101"): Multiple_Words_101
console.log(`this-is-kebab-case-101 toPascalSnakeCase("multiple-words-101"): ${toPascalSnakeCase("multiple-words-101")}`); // this-is-kebab-case-101 toPascalSnakeCase("multiple-words-101"): Multiple_Words_101
console.log(`THIS_IS_CONSTANT_CASE_101 toPascalSnakeCase("MULTIPLE_WORDS_101"): ${toPascalSnakeCase("MULTIPLE_WORDS_101")}`); // THIS_IS_CONSTANT_CASE_101 toPascalSnakeCase("MULTIPLE_WORDS_101"): Multiple_Words_101
console.log(`THIS-IS-COBOL-CASE-101 toPascalSnakeCase("MULTIPLE-WORDS-101"): ${toPascalSnakeCase("MULTIPLE-WORDS-101")}`); // THIS-IS-COBOL-CASE-101 toPascalSnakeCase("MULTIPLE-WORDS-101"): Multiple_Words_101
console.log(`This-Is-Train-Case-101 toPascalSnakeCase("Multiple-Words-101"): ${toPascalSnakeCase("Multiple-Words-101")}`); // This-Is-Train-Case-101 toPascalSnakeCase("Multiple-Words-101"): Multiple_Words_101
console.log(`This Is Title Case 101 toPascalSnakeCase("Multiple Words 101"): ${toPascalSnakeCase("Multiple Words 101")}`); // This Is Title Case 101 toPascalSnakeCase("Multiple Words 101"): Multiple_Words_101
console.log(`This_Is_Pascal_Snake_Case_101 toPascalSnakeCase("Multiple_Words_101"): ${toPascalSnakeCase("Multiple_Words_101")}`); // This_Is_Pascal_Snake_Case_101 toPascalSnakeCase("Multiple_Words_101"): Multiple_Words_101
console.log(`thisisflatcase101 toPascalSnakeCase("multiplewords101"): ${toPascalSnakeCase("multiplewords101")}`); // thisisflatcase101 toPascalSnakeCase("multiplewords101"): Multiplewords101
console.log(`THISISUPPERFLATCASE101 toPascalSnakeCase("MULTIPLEWORDS101"): ${toPascalSnakeCase("MULTIPLEWORDS101")}`); // THISISUPPERFLATCASE101 toPascalSnakeCase("MULTIPLEWORDS101"): Multiplewords101
console.log(`toPascalSnakeCase("multiple words 101"): ${toPascalSnakeCase("multiple words 101")}`); // Multiple_Words_101

const toFlatCase = (aString) => (isFlatCase(aString)
    ? aString
    : (isCamelCase(aString)
        ? splitByCapitalLetter(aString).map((aCharacther) => aCharacther.toLowerCase()).join("")
        : (isPascalCase(aString)
            ? (() => {
                const words = splitByCapitalLetter(aString).map((aWord) => aWord.toLowerCase());
                if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
                return words.join("");
            })()
            : (isSnakeCase(aString)
                ? aString.split("_").join("")
                : (isKebabCase(aString)
                    ? aString.split("-").join("")
                    : (isConstantCase(aString)
                        ? aString.split("_").join("").toLowerCase()
                        : (isCobolCase(aString)
                            ? aString.split("-").join("").toLowerCase()
                            : (isTrainCase(aString)
                                ? aString.split("-").join("").toLowerCase()
                                : (isTitleCase(aString)
                                    ? aString.split(" ").join("").toLowerCase()
                                    : (isPascalSnakeCase(aString)
                                        ? aString.split("_").join("").toLowerCase()
                                        : (isUpperFlatCase(aString)
                                            ? aString.toLowerCase()
                                            : aString.split(" ").join("").toLowerCase()
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )
);
console.log(`toFlatCase("word101"): ${toFlatCase("word101")}`); // word101
console.log(`toFlatCase("Word101"): ${toFlatCase("Word101")}`); // word101
console.log(`toFlatCase("WORD101"): ${toFlatCase("WORD101")}`); // word101
console.log(`thisIsCamelCase101 toFlatCase("multipleWords101"): ${toFlatCase("multipleWords101")}`); // thisIsCamelCase101 toFlatCase("multipleWords101"): multiplewords101
console.log(`ThisIsPascalCase101 toFlatCase("MultipleWords101"): ${toFlatCase("MultipleWords101")}`); // ThisIsPascalCase101 toFlatCase("MultipleWords101"): multiplewords101
console.log(`this_is_snake_case_101 toFlatCase("multiple_words_101"): ${toFlatCase("multiple_words_101")}`); // this_is_snake_case_101 toFlatCase("multiple_words_101"): multiplewords101
console.log(`this-is-kebab-case-101 toFlatCase("multiple-words-101"): ${toFlatCase("multiple-words-101")}`); // this-is-kebab-case-101 toFlatCase("multiple-words-101"): multiplewords101
console.log(`THIS_IS_CONSTANT_CASE_101 toFlatCase("MULTIPLE_WORDS_101"): ${toFlatCase("MULTIPLE_WORDS_101")}`); // THIS_IS_CONSTANT_CASE_101 toFlatCase("MULTIPLE_WORDS_101"): multiplewords101
console.log(`THIS-IS-COBOL-CASE-101 toFlatCase("MULTIPLE-WORDS-101"): ${toFlatCase("MULTIPLE-WORDS-101")}`); // THIS-IS-COBOL-CASE-101 toFlatCase("MULTIPLE-WORDS-101"): multiplewords101
console.log(`This-Is-Train-Case-101 toFlatCase("Multiple-Words-101"): ${toFlatCase("Multiple-Words-101")}`); // This-Is-Train-Case-101 toFlatCase("Multiple-Words-101"): multiplewords101
console.log(`This Is Title Case 101 toFlatCase("Multiple Words 101"): ${toFlatCase("Multiple Words 101")}`); // This Is Title Case 101 toFlatCase("Multiple Words 101"): multiplewords101
console.log(`This_Is_Pascal_Snake_Case_101 toFlatCase("Multiple_Words_101"): ${toFlatCase("Multiple_Words_101")}`); // This_Is_Pascal_Snake_Case_101 toFlatCase("Multiple_Words_101"): multiplewords101
console.log(`thisisflatcase101 toFlatCase("multiplewords101"): ${toFlatCase("multiplewords101")}`); // thisisflatcase101 toFlatCase("multiplewords101"): multiplewords101
console.log(`THISISUPPERFLATCASE101 toFlatCase("MULTIPLEWORDS101"): ${toFlatCase("MULTIPLEWORDS101")}`); // THISISUPPERFLATCASE101 toFlatCase("MULTIPLEWORDS101"): multiplewords101
console.log(`toFlatCase("multiple words 101"): ${toFlatCase("multiple words 101")}`); // multiplewords101

const toUpperFlatCase = (aString) => (isUpperFlatCase(aString)
    ? aString
    : (isCamelCase(aString)
        ? (() => {
            const words = splitByCapitalLetter(aString).map((aWord) => aWord.toUpperCase());
            if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
            return words.join("");
        })()
        : (isPascalCase(aString)
            ? (() => {
                const words = splitByCapitalLetter(aString).map((aWord) => aWord.toUpperCase());
                if ((words.length === 2) && words[words.length - 1].split("").every((aCharacther) => numbersString.includes(aCharacther))) return words.join("");
                return words.join("");
            })()
            : (isSnakeCase(aString)
                ? aString.split("_").join("").toUpperCase()
                : (isKebabCase(aString)
                    ? aString.split("-").join("").toUpperCase()
                    : (isConstantCase(aString)
                        ? aString.split("_").join("")
                        : (isCobolCase(aString)
                            ? aString.split("-").join("")
                            : (isTrainCase(aString)
                                ? aString.split("-").join("").toUpperCase()
                                : (isTitleCase(aString)
                                    ? aString.split(" ").join("").toUpperCase()
                                    : (isPascalSnakeCase(aString)
                                        ? aString.split("_").join("").toUpperCase()
                                        : (isFlatCase(aString)
                                            ? aString
                                            : aString.split(" ").join("").toUpperCase()
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
        )
    )
);
console.log(`toUpperFlatCase("word101"): ${toUpperFlatCase("word101")}`); // WORD101
console.log(`toUpperFlatCase("Word101"): ${toUpperFlatCase("Word101")}`); // WORD101
console.log(`toUpperFlatCase("WORD101"): ${toUpperFlatCase("WORD101")}`); // WORD101
console.log(`thisIsCamelCase101 toUpperFlatCase("multipleWords101"): ${toUpperFlatCase("multipleWords101")}`); // thisIsCamelCase101 toUpperFlatCase("multipleWords101"): MULTIPLEWORDS101
console.log(`ThisIsPascalCase101 toUpperFlatCase("MultipleWords101"): ${toUpperFlatCase("MultipleWords101")}`); // ThisIsPascalCase101 toUpperFlatCase("MultipleWords101"): MULTIPLEWORDS101
console.log(`this_is_snake_case_101 toUpperFlatCase("multiple_words_101"): ${toUpperFlatCase("multiple_words_101")}`); // this_is_snake_case_101 toUpperFlatCase("multiple_words_101"): MULTIPLEWORDS101
console.log(`this-is-kebab-case-101 toUpperFlatCase("multiple-words-101"): ${toUpperFlatCase("multiple-words-101")}`); // this-is-kebab-case-101 toUpperFlatCase("multiple-words-101"): MULTIPLEWORDS101
console.log(`THIS_IS_CONSTANT_CASE_101 toUpperFlatCase("MULTIPLE_WORDS_101"): ${toUpperFlatCase("MULTIPLE_WORDS_101")}`); // THIS_IS_CONSTANT_CASE_101 toUpperFlatCase("MULTIPLE_WORDS_101"): MULTIPLEWORDS101
console.log(`THIS-IS-COBOL-CASE-101 toUpperFlatCase("MULTIPLE-WORDS-101"): ${toUpperFlatCase("MULTIPLE-WORDS-101")}`); // THIS-IS-COBOL-CASE-101 toUpperFlatCase("MULTIPLE-WORDS-101"): MULTIPLEWORDS101
console.log(`This-Is-Train-Case-101 toUpperFlatCase("Multiple-Words-101"): ${toUpperFlatCase("Multiple-Words-101")}`); // This-Is-Train-Case-101 toUpperFlatCase("Multiple-Words-101"): MULTIPLEWORDS101
console.log(`This Is Title Case 101 toUpperFlatCase("Multiple Words 101"): ${toUpperFlatCase("Multiple Words 101")}`); // This Is Title Case 101 toUpperFlatCase("Multiple Words 101"): MULTIPLEWORDS101
console.log(`This_Is_Pascal_Snake_Case_101 toUpperFlatCase("Multiple_Words_101"): ${toUpperFlatCase("Multiple_Words_101")}`); // This_Is_Pascal_Snake_Case_101 toUpperFlatCase("Multiple_Words_101"): MULTIPLEWORDS101
console.log(`thisisflatcase101 toUpperFlatCase("multiplewords101"): ${toUpperFlatCase("multiplewords101")}`); // thisisflatcase101 toUpperFlatCase("multiplewords101"): MULTIPLEWORDS101
console.log(`THISISUPPERFLATCASE101 toUpperFlatCase("MULTIPLEWORDS101"): ${toUpperFlatCase("MULTIPLEWORDS101")}`); // THISISUPPERFLATCASE101 toUpperFlatCase("MULTIPLEWORDS101"): MULTIPLEWORDS101
console.log(`toUpperFlatCase("multiple words 101"): ${toUpperFlatCase("multiple words 101")}`); // MULTIPLEWORDS101
