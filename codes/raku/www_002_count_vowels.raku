#`<<<
Source:
    https://www.codewars.com/kata/54ff3102c1bad923760001f3
Title:
    Vowel Count
Description:
    Return the number (count) of vowels in the given string.
    We will consider a, e, i, o, u as vowels for this Kata (but not y).
    The input string will only consist of lower case letters and/or spaces.
>>>

sub array-includes-v2($search-element, $an-array) {
    # JavaScript-like Array.includes() function
    for ($an-array.kv) -> $array-item-index, $array-item {
        return True if ($array-item === $search-element);
    }
    return False;
}

sub count-vowels-v1($a-string) { [0, |$a-string.comb()].reduce({ (array-includes-v2($^b, ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"]) ?? ($^a + 1) !! $^a) }) }
print(count-vowels-v1("Hello World"), "\n"); # 3

sub count-vowels-v2($a-string) { [0, |$a-string.comb()].reduce({ (array-includes-v2(uc($^b), ["A", "I", "U", "E", "O"]) ?? ($^a + 1) !! $^a) }) }
print(count-vowels-v2("Hello World"), "\n"); # 3

sub count-vowels-v3($a-string) { $a-string.comb().grep({ array-includes-v2($^a-character, ["a", "i", "u", "e", "o", "A", "I", "U", "E", "O"]) }).elems }
print(count-vowels-v3("Hello World"), "\n"); # 3

sub count-vowels-v4($a-string) { $a-string.comb().grep({ array-includes-v2(uc($^a-character), ["A", "I", "U", "E", "O"]) }).elems }
print(count-vowels-v4("Hello World"), "\n"); # 3
