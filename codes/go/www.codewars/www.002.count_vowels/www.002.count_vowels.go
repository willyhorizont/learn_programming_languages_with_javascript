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

func countVowels(aString string) int {
	result := 0
	for _, letter := range strings.Split(aString, "") {
		if (strings.Contains("aiueoAIUEO", letter) == true) {
			result += 1
		}
	}
	return result
}

func main() {
	fmt.Println(countVowels("Hello World")) // 3
}
