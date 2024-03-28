using System; // Console, Func<>, Action<>, Action
using System.Linq; // Enumerable
using System.Collections.Generic; // Dictionary<>, List<>, KeyValuePair<>, IEnumerable<>

class Program {
    static void Main(string[] Args) {
        /*
        Source:
            https://www.codewars.com/kata/54ff3102c1bad923760001f3
        Title:
            Vowel Count
        Description:
            Return the number (count) of vowels in the given string.
            We will consider a, e, i, o, u as vowels for this Kata (but not y).
            The input string will only consist of lower case letters and/or spaces.
        */
        dynamic CountVowelsV1 = (Func<string, int>)((string AString) => ((IEnumerable<char>)(AString.ToCharArray())).Aggregate(0, (Func<int, char, int>)((int CurrentResult, char ACharacter) => ((new List<dynamic>() {"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}).Contains(ACharacter.ToString()) ? (CurrentResult + 1) : CurrentResult))));
        Console.WriteLine(CountVowelsV1("Hello World")); // 3

        dynamic CountVowelsV2 = (Func<string, int>)((string AString) => ((IEnumerable<char>)(AString.ToCharArray())).Aggregate(0, (Func<int, char, int>)((int CurrentResult, char ACharacter) => ((new List<dynamic>() {"A", "I", "U", "E", "O"}).Contains(ACharacter.ToString().ToUpper()) ? (CurrentResult + 1) : CurrentResult))));
        Console.WriteLine(CountVowelsV2("Hello World")); // 3

        dynamic CountVowelsV3 = (Func<string, int>)((string AString) => ((IEnumerable<char>)(AString.ToCharArray())).Aggregate(0, (Func<int, char, int>)((int CurrentResult, char ACharacter) => ("aiueoAIUEO".Contains(ACharacter.ToString()) ? (CurrentResult + 1) : CurrentResult))));
        Console.WriteLine(CountVowelsV3("Hello World")); // 3

        dynamic CountVowelsV4 = (Func<string, int>)((string AString) => ((IEnumerable<char>)(AString.ToCharArray())).Aggregate(0, (Func<int, char, int>)((int CurrentResult, char ACharacter) => ("AIUEO".Contains(ACharacter.ToString().ToUpper()) ? (CurrentResult + 1) : CurrentResult))));
        Console.WriteLine(CountVowelsV4("Hello World")); // 3

        dynamic CountVowelsV5 = (Func<string, int>)((string AString) => ((IEnumerable<char>)(AString.ToCharArray())).Where((Func<char, bool>)((char ACharacter) => (new List<dynamic>() {"a", "i", "u", "e", "o", "A", "I", "U", "E", "O"}).Contains(ACharacter.ToString()))).ToList().Count);
        Console.WriteLine(CountVowelsV5("Hello World")); // 3

        dynamic CountVowelsV6 = (Func<string, int>)((string AString) => ((IEnumerable<char>)(AString.ToCharArray())).Where((Func<char, bool>)((char ACharacter) => (new List<dynamic>() {"A", "I", "U", "E", "O"}).Contains(ACharacter.ToString().ToUpper()))).ToList().Count);
        Console.WriteLine(CountVowelsV6("Hello World")); // 3

        dynamic CountVowelsV7 = (Func<string, int>)((string AString) => ((IEnumerable<char>)(AString.ToCharArray())).Where((Func<char, bool>)((char ACharacter) => "aiueoAIUEO".Contains(ACharacter.ToString()))).ToList().Count);
        Console.WriteLine(CountVowelsV7("Hello World")); // 3

        dynamic CountVowelsV8 = (Func<string, int>)((string AString) => ((IEnumerable<char>)(AString.ToCharArray())).Where((Func<char, bool>)((char ACharacter) => "AIUEO".Contains(ACharacter.ToString().ToUpper()))).ToList().Count);
        Console.WriteLine(CountVowelsV8("Hello World")); // 3
    }
}
