// dart compile exe filename.dart && ./xxx.filename.exe
// dart run filename.dart
void main() {
    print('Hello, World!');

    dynamic something = 123;
    print(something); // Output: 123

    something = 123;
    print(something); // Output: foo

    something = true;
    print(something); // Output: true

    something = [1, 2, 3];
    print(something); // Output: [1, 2, 3]

    something = {"foo": "bar"};
    print(something); // Output: {foo: bar}
}
