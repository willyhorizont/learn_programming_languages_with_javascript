import {
    getType,
    jsonStringify,
} from "./utils.js";

console.log("something get type of something in JavaScript");

{
    const something = "foo";
    console.log(`something: ${jsonStringify(something)}`);
    console.log(`type of something: ${jsonStringify(getType(something))}`);
}

{
    const something = 123;
    console.log(`something: ${jsonStringify(something)}`);
    console.log(`type of something: ${jsonStringify(getType(something))}`);
}

{
    const something = 123.789;
    console.log(`something: ${jsonStringify(something)}`);
    console.log(`type of something: ${jsonStringify(getType(something))}`);
}

{
    const something = -123;
    console.log(`something: ${jsonStringify(something)}`);
    console.log(`type of something: ${jsonStringify(getType(something))}`);
}

{
    const something = -123.789;
    console.log(`something: ${jsonStringify(something)}`);
    console.log(`type of something: ${jsonStringify(getType(something))}`);
}

{
    const something = true;
    console.log(`something: ${jsonStringify(something)}`);
    console.log(`type of something: ${jsonStringify(getType(something))}`);
}

{
    const something = false;
    console.log(`something: ${jsonStringify(something)}`);
    console.log(`type of something: ${jsonStringify(getType(something))}`);
}

{
    const something = null;
    console.log(`something: ${jsonStringify(something)}`);
    console.log(`type of something: ${jsonStringify(getType(something))}`);
}

{
    const something = undefined;
    console.log(`something: ${jsonStringify(something)}`);
    console.log(`type of something: ${jsonStringify(getType(something))}`);
}

{
    const something = [1, 2, 3];
    console.log(`something: ${jsonStringify(something)}`);
    console.log(`type of something: ${jsonStringify(getType(something))}`);
}

{
    const something = { "foo": "bar" };
    console.log(`something: ${jsonStringify(something)}`);
    console.log(`type of something: ${jsonStringify(getType(something))}`);
}

{
    const something = (a, b) => (a * b);
    console.log(`something: ${jsonStringify(something)}`);
    console.log(`type of something: ${jsonStringify(getType(something))}`);
}
