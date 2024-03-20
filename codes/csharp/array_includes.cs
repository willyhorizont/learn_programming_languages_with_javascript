using System; // Console, Func<>, Action<>, Action
using System.Collections.Generic; // Dictionary<>, List<>, KeyValuePair<>, IEnumerable<>

class Program {
    static void Main(string[] Args) {
        dynamic IsNumeric = (Func<dynamic, bool>)((dynamic Anything) => (Anything is sbyte || Anything is byte || Anything is short || Anything is ushort || Anything is int || Anything is uint || Anything is long || Anything is ulong || Anything is float || Anything is double || Anything is decimal));

        string PrettyArrayOfPrimitives(List<dynamic> AnArrayOfPrimitives) {
            string Result = "[";
            int ArrayItemIndex = 0;
            foreach (dynamic ArrayItem in AnArrayOfPrimitives) {
                if (((ArrayItem is string) == false) && (IsNumeric(ArrayItem) == false) && ((ArrayItem is bool) == false) && (ArrayItem != null)) continue;
                if (ArrayItem is string) Result += $"\"{ArrayItem}\"";
                if (IsNumeric(ArrayItem)) Result += ArrayItem.ToString().Replace(",", ".");
                if (ArrayItem is bool) Result += $"{ArrayItem.ToLower()}";
                if (ArrayItem == null) Result += "null";
                if ((ArrayItemIndex + 1) != AnArrayOfPrimitives.Count) Result += ", ";
                ArrayItemIndex += 1;
            }
            Result += "]";
            return Result;
        }

        Console.WriteLine("\n// JavaScript-like Array.includes() in C#");

        dynamic MyFriends = new List<dynamic>() {"Alisa", "Trivia"};
        Console.WriteLine($"MyFriends: {PrettyArrayOfPrimitives(MyFriends)}");

        dynamic AName;
        dynamic IsMyFriend;

        AName = "Alisa";
        IsMyFriend = MyFriends.Contains(AName);
        Console.WriteLine($"is my friends includes \"{AName}\": {IsMyFriend}");
        // is my friends includes "Alisa": True

        AName = "Trivia";
        IsMyFriend = MyFriends.Contains(AName);
        Console.WriteLine($"is my friends includes \"{AName}\": {IsMyFriend}");
        // is my friends includes "Trivia": True

        AName = "Tony";
        IsMyFriend = MyFriends.Contains(AName);
        Console.WriteLine($"is my friends includes \"{AName}\": {IsMyFriend}");
        // is my friends includes "Tony": False

        AName = "Ezekiel";
        IsMyFriend = MyFriends.Contains(AName);
        Console.WriteLine($"is my friends includes \"{AName}\": {IsMyFriend}");
        // is my friends includes "Ezekiel": False

    }
}
