package main

import (
	"fmt"
	"strings"
)

/*
Title:
    Abbreviate a Two Word Name
Instructions:
    Write a function to convert a name into initials. This kata strictly takes two words with one space in between them.
    The output should be two capital letters with a dot separating them.
    It should look like this:
    Sam Harris => S.H
    patrick feeney => P.F
*/

func AbbrevName(completeName string) string {
	namesSlice := strings.Split(completeName, " ")
	namesSliceNew := []string{}
	for _, name := range namesSlice {
		namesSliceNew = append(namesSliceNew, strings.ToUpper(string(name[0])))
	}
	return strings.Join(namesSliceNew, ".")
}

func main() {
	fmt.Println(AbbrevName("Sam Harris"))
	// S.H
	fmt.Println(AbbrevName("patrick feeney"))
	// P.F
}
