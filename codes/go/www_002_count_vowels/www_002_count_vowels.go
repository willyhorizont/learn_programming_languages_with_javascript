package main

import (
	"fmt"
	"strings"
)

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

func countVowelsV1(aString string) int {
    result := 0
    for _, aCharacter := range strings.Split(aString, "") {
        if (strings.Contains("aiueoAIUEO", aCharacter) == true) {
            result += 1
        }
    }
    return result
}

func main() {
	fmt.Println(countVowelsV1("Hello World")) // 3

	countVowelsV2 := func(aString string) int {
        result := 0
		for _, aCharacter := range strings.Split(aString, "") {
			if (strings.Contains("aiueoAIUEO", aCharacter) == true) {
				result += 1
			}
		}
		return result
    }
    fmt.Println(countVowelsV2("Hello World")) // 3
}
