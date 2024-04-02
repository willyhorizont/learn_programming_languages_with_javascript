using System; // Console, Func<>, Action<>, Action
using System.Linq; // Enumerable
using System.Collections.Generic; // Dictionary<>, List<>, KeyValuePair<>, IEnumerable<>

class Program {
    static void Main(string[] Args) {
        /*
            Source:
                https://www.codewars.com/kata/57eadb7ecd143f4c9c0000a3
            Title:
                Abbreviate a Two Word Name
            Description:
                Write a function to convert a name into initials. This kata strictly takes two words with one space in between them.
                The output should be two capital letters with a dot separating them.
                It should look like this:
                Sam Harris => S.H
                patrick feeney => P.F
        */
        dynamic AbbreviateName = (Func<string, string>)((string CompleteName) => String.Join(".", ((IEnumerable<string>)CompleteName.Split((char)" "[0])).Select((Func<string, string>)((string AName) => AName[0].ToString().ToUpper())).ToList()));
        Console.WriteLine(AbbreviateName("Sam Harris"));
        // S.H
        Console.WriteLine(AbbreviateName("patrick feeney"));
        // P.F
    }
}
