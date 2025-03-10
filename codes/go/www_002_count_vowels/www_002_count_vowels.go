package main

import (
	"fmt"
	"strings"
)

func main() {
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
	countVowels := func(anyString string) int {
        result := 0
		for _, anyCharacter := range strings.Split(anyString, "") {
			if (strings.Contains("aiueoAIUEO", anyCharacter) == true) {
				result += 1
			}
		}
		return result
    }
    fmt.Println(countVowels("Hello World")) // 3
}
