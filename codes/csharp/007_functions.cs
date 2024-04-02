using System; // Console, Func<>, Action<>, Action
using System.Linq; // Enumerable
using System.Collections.Generic; // Dictionary<>, List<>, KeyValuePair<>, IEnumerable<>

class Program {
    static void Main(string[] Args) {
        // ? function statement or function declaration

        dynamic GetRectangleAreaV1(dynamic RectangleWidth, dynamic RectangleLength) {
            return (RectangleWidth * RectangleLength);
        }
        // call the function example: GetRectangleAreaV1(7, 5)

        // ? function expression or named lambda expression

        dynamic GetRectangleAreaV2 = (Func<dynamic, dynamic, dynamic>)((dynamic RectangleWidth, dynamic RectangleLength) => {
            return (RectangleWidth * RectangleLength);
        });
        // call the function example: GetRectangleAreaV2(7, 5)

        dynamic GetRectangleAreaV3 = (Func<dynamic, dynamic, dynamic>)((dynamic RectangleWidth, dynamic RectangleLength) => (RectangleWidth * RectangleLength));
        // call the function example: GetRectangleAreaV3(7, 5)

        // ? anonymous function or lambda expression

        // (Func<dynamic, dynamic, dynamic>)((dynamic RectangleWidth, dynamic RectangleLength) => {
        //     return (RectangleWidth * RectangleLength);
        // });

        // (Func<dynamic, dynamic, dynamic>)((dynamic RectangleWidth, dynamic RectangleLength) => (RectangleWidth * RectangleLength));

        // ? Passing functions as arguments to other functions

        void SayHelloV1(Action CallbackFunction) {
            Console.WriteLine("hello");
            CallbackFunction();
        }

        void SayHowAreYouV1() {
            Console.WriteLine("how are you?");
        }

        SayHelloV1(SayHowAreYouV1);

        SayHelloV1((Action)(() => {
            Console.WriteLine("how are you?");
        }));

        SayHelloV1((Action)(() => Console.WriteLine("how are you?")));

        dynamic SayHelloV2 = (Action<Action>)((Action CallbackFunction) => {
            Console.WriteLine("hello");
            CallbackFunction();
        });

        dynamic SayHowAreYouV2 = (Action)(() => {
            Console.WriteLine("how are you?");
        });

        SayHelloV2(SayHowAreYouV2);

        SayHelloV2((Action)(() => {
            Console.WriteLine("how are you?");
        }));

        SayHelloV2((Action)(() => Console.WriteLine("how are you?")));

        // ? Assigning functions to variables or storing them in data structures

        dynamic GetRectangleAreaV2Copy = (Func<dynamic, dynamic, dynamic>)((dynamic RectangleWidth, dynamic RectangleLength) => {
            return (RectangleWidth * RectangleLength);
        });

        dynamic GetRectangleAreaV3Copy = (Func<dynamic, dynamic, dynamic>)((dynamic RectangleWidth, dynamic RectangleLength) => (RectangleWidth * RectangleLength));

        dynamic MyArrayOfGetRectangleAreaFunctions = new List<dynamic>() {
            (Func<dynamic, dynamic, dynamic>)GetRectangleAreaV1,
            (Func<dynamic, dynamic, dynamic>)((dynamic RectangleWidth, dynamic RectangleLength) => {
                return (RectangleWidth * RectangleLength);
            }),
            (Func<dynamic, dynamic, dynamic>)((dynamic RectangleWidth, dynamic RectangleLength) => (RectangleWidth * RectangleLength))
        };
        dynamic GetRectangleAreaFunctionResult1 = MyArrayOfGetRectangleAreaFunctions[0](7, 5);
        dynamic GetRectangleAreaFunctionResult2 = MyArrayOfGetRectangleAreaFunctions[1](7, 5);
        dynamic GetRectangleAreaFunctionResult3 = MyArrayOfGetRectangleAreaFunctions[2](7, 5);

        dynamic Exponentiation = (Func<dynamic, dynamic, dynamic>)((dynamic A, dynamic B) => {
            return Math.Pow(A, B);
        });

        dynamic SimpleCalculator = new Dictionary<string, dynamic>() {
            {"Exponentiation", (Func<dynamic, dynamic, dynamic>)Exponentiation},
            {"Addition", (Func<dynamic, dynamic, dynamic>)((dynamic A, dynamic B) => {
                return (A + B);
            })},
            {"Subtraction", (Func<dynamic, dynamic, dynamic>)((dynamic A, dynamic B) => (A - B))}
        };
        dynamic simpleCalculatorResult1 = SimpleCalculator["Exponentiation"](2, 4);
        dynamic simpleCalculatorResult2 = SimpleCalculator["Addition"](9, 3);
        dynamic simpleCalculatorResult3 = SimpleCalculator["Subtraction"](35, 8);

        // ? Returning functions as values from other functions

        Func<dynamic, dynamic> MultiplyV1(dynamic A) {
            dynamic MultiplyBy = (Func<dynamic, dynamic>)((B) => {
                return (A * B);
            });
            return MultiplyBy;
        }
        dynamic MultiplyBy2 = (Func<dynamic, dynamic>)(MultiplyV1(2));
        dynamic MultiplyBy2Result = MultiplyBy2(10); // 20

        Func<dynamic, dynamic> MultiplyV2(dynamic A) {
            return (Func<dynamic, dynamic>)((B) => {
                return (A * B);
            });
        }
        dynamic MultiplyBy3 = (Func<dynamic, dynamic>)(MultiplyV2(3));
        dynamic MultiplyBy3Result = MultiplyBy3(10); // 30

        Func<dynamic, dynamic> MultiplyV3(dynamic A) {
            return (Func<dynamic, dynamic>)((B) => (A * B));
        }
        dynamic MultiplyBy4 = (Func<dynamic, dynamic>)(MultiplyV3(4));
        dynamic MultiplyBy4Result = MultiplyBy4(10); // 40

        dynamic MultiplyV4 = (Func<dynamic, Func<dynamic, dynamic>>)((A) => {
            dynamic MultiplyBy = (Func<dynamic, dynamic>)((B) => {
                return (A * B);
            });
            return MultiplyBy;
        });
        dynamic MultiplyBy5 = (Func<dynamic, dynamic>)(MultiplyV4(5));
        dynamic MultiplyBy5Result = MultiplyBy5(10); // 50

        dynamic MultiplyV5 = (Func<dynamic, Func<dynamic, dynamic>>)((A) => {
            return (Func<dynamic, dynamic>)((B) => {
                return (A * B);
            });
        });
        dynamic MultiplyBy6 = (Func<dynamic, dynamic>)(MultiplyV5(6));
        dynamic MultiplyBy6Result = MultiplyBy6(10); // 60

        dynamic MultiplyV6 = (Func<dynamic, Func<dynamic, dynamic>>)((A) => {
            return (Func<dynamic, dynamic>)((B) => (A * B));
        });
        dynamic MultiplyBy7 = (Func<dynamic, dynamic>)(MultiplyV6(7));
        dynamic MultiplyBy7Result = MultiplyBy7(10); // 70

        dynamic MultiplyV7 = (Func<dynamic, Func<dynamic, dynamic>>)((A) => (Func<dynamic, dynamic>)((B) => (A * B)));
        dynamic MultiplyBy8 = (Func<dynamic, dynamic>)(MultiplyV7(8));
        dynamic MultiplyBy8Result = MultiplyBy8(10); // 80
    }
}
