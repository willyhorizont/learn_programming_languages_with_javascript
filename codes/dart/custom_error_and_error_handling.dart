void main() {
    print("\n// Custom Error and Error Handling in Dart");

    dynamic giveMeRespect(String parameter) {
        if (parameter != "respect") throw Exception("You should give me \"respect\"!");
        return "Thank you for giving me \"respect\"!";
    }

    dynamic response;

    // Error Handling
    try {
        response = giveMeRespect("boo!");
        print(response);
    } catch (anErrorMessage) {
        print(anErrorMessage);
    }
    print("I'm sorry!");

    // Without Error Handling
    response = giveMeRespect("boo!");
    // this will never executed
    print(response);
    print("I'm sorry!");
}
