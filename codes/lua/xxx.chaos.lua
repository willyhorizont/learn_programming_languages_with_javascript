--declare variables
boolVal = true;
int_value = 1024;
stringVal = "hello world";
floatVal = 12.90;
nilVal = nil;

--display the data type returned for each declared value.
print(type(boolVal) == "boolean");
print(type(int_value) == "number");
print(type(stringVal) == "string");
print(type(floatVal) == "number");
print(type(nilVal) == "nil");
print(tostring(nil));

local t = { "a", "b", "c" }
for k, v in pairs(t) do
    print(k, v)
end

local t = { "a", "b", "c" }
for i, v in ipairs(t) do
    print(i, v)
end