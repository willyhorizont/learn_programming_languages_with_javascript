console.log('\n// Nullish Coalescing Operator (??) in JavaScript');

const JSON_OBJECT = {
    "foo": {
        "bar": "baz",
    }
};
console.log(`JSON_OBJECT: ${JSON.stringify(JSON_OBJECT, null, ' '.repeat(4))}`);

console.log('JSON_OBJECT?.foo?.bar ?? "not found":', JSON_OBJECT?.foo?.bar ?? "not found");
// JSON_OBJECT?.foo?.bar ?? "not found": baz

console.log('JSON_OBJECT?.foo?.baz ?? "not found":', JSON_OBJECT?.foo?.baz ?? "not found");
// JSON_OBJECT?.foo?.baz ?? "not found": not found
