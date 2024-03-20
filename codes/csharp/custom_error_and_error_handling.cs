using System; // Console, Func<>, Action<>, Action

class Program {
    static void Main(string[] Args) {
        Console.WriteLine("\n// Custom Error and Error Handling in C#");

        dynamic GiveMeRespect(dynamic Parameter) {
            // Custom Error
            if (Parameter != "respect") throw new InvalidOperationException("Exception: You should give me \"respect\"!");
            return "Thank you for giving me \"respect\"!";
        }

        dynamic Response;

        // Error Handling
        try {
            Response = GiveMeRespect("boo!");
            Console.WriteLine(Response);
        } catch (Exception Ex) {
            Console.WriteLine(Ex.Message);
        }
        Console.WriteLine("I'm sorry!");

        // Without Error Handling
        Response = GiveMeRespect("boo!");
        // this will never executed
        Console.WriteLine(Response);
        Console.WriteLine("I'm sorry!");
    }
}
