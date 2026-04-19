import {
    randomIntInclusive,
} from "../../codes/javascript/utils.js";

const pickStringChunkRandomly = (anyEvenLengthString, stringChunkLength) => ((({ stringChunkIndex }) => (anyEvenLengthString.slice((stringChunkIndex * stringChunkLength), ((stringChunkIndex * stringChunkLength) + stringChunkLength))))({ stringChunkIndex: randomIntInclusive(0, ((anyEvenLengthString.length / stringChunkLength) - 1)) }));

const abcPassvvordCharacterSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
const abcPassvvordStringSuffixLength = 33;

const getAbcPassvvordStringPrefix = () => (({ myFriendMomFavoriteNumberCombination, myFriendDadFavoriteNumberCombination }) => myFriendMomFavoriteNumberCombination.split("").reduce((currentResult, currentCharacter, currentCharacterIndex) => (`${currentResult}${abcPassvvordCharacterSet[parseInt((`${myFriendMomFavoriteNumberCombination.charAt(currentCharacterIndex)}${myFriendDadFavoriteNumberCombination.charAt(currentCharacterIndex)}`), 10)]}`), ""))({ myFriendMomFavoriteNumberCombination: "005215", myFriendDadFavoriteNumberCombination: "081680" });

const getAbcPassvvord = (abcPassvvordString) => `${getAbcPassvvordStringPrefix()}${pickStringChunkRandomly(abcPassvvordString, abcPassvvordStringSuffixLength)}`;
