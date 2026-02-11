const catchAsyncFunctionAnyError = (asyncFunction) => asyncFunction.then((anyResult) => ([null, anyResult])).catch((anyError) => ([anyError, null]));

const catchNonAsyncFunctionAnyError = (anyNonAsyncFunction) => {
    try {
        const anyResult = anyNonAsyncFunction();
        return [null, anyResult];
    } catch (anyError) {
        console.log(anyError);
        return [anyError, null];
    }
};
