extends SceneTree


func main():
    # 1. variable can store dynamic data type and dynamic value, variable can inferred data type from value, value of variable can be reassign with different data type or has option to make variable can store dynamic data type and dynamic value
    # ```javascript
    # let something = "foo";
    # console.log("something:", something);
    # something = 123;
    # console.log("something:", something);
    # something = true;
    # console.log("something:", something);
    # something = null;
    # console.log("something:", something);
    # something = [1, 2, 3];
    # console.log("something:", something);
    # something = { "foo": "bar" };
    # console.log("something:", something);
    # ```
    # ```go
    # type Any interface{}
    # ```
    var something = "foo"
    print("something: ", JSON.stringify(something, "    "))
    something = 123
    print("something: ", JSON.stringify(something, "    "))
    something = true
    print("something: ", JSON.stringify(something, "    "))
    something = null
    print("something: ", JSON.stringify(something, "    "))
    something = [1, 2, 3]
    print("something: ", JSON.stringify(something, "    "))
    something = { "foo": "bar" }
    print("something: ", JSON.stringify(something, "    "))

    # 2. it is possible to access and modify variables defined outside of the current scope within nested functions, so it is possible to have closure too
    # ```javascript
    # function getModifiedIndentLevel() {
    #     let indentLevel = 0;
    #     function changeIndentLevel() {
    #         indentLevel += 1;
    #         if (indentLevel < 5) changeIndentLevel();
    #         return indentLevel;
    #     }
    #     return changeIndentLevel();
    # }
    # console.log("getModifiedIndentLevel():", getModifiedIndentLevel());
    # function createNewGame(initialCredit) {
    #     let currentCredit = initialCredit;
    #     console.log("initial credit:", initialCredit);
    #     return function () {
    #         currentCredit -= 1;
    #         if (currentCredit === 0) {
    #             console.log("not enough credits");
    #             return;
    #         }
    #         console.log(`playing game, ${currentCredit} credit(s) remaining`);
    #     };
    # }
    # const playGame = createNewGame(3);
    # playGame();
    # playGame();
    # playGame();
    # ```
    var get_modified_indent_level = func():
        var indent_level = 0
        var change_indent_level := func():
            indent_level += 1
            if (indent_level < 5):
                change_indent_level.call()  # SCRIPT ERROR: Parse Error: Identifier "change_indent_level" not declared in the current scope.
            return indent_level
        return change_indent_level.call()
    print("get_modified_indent_level.call(): ", get_modified_indent_level.call())


func _init():
    main()
    quit()

