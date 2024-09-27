package main

import (
	"fmt"
	"strings"
)

func main() {
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
	abbreviateName := func(completeName string) string {
		names := strings.Split(completeName, " ")
		namesNew := []string{}
		for _, aName := range names {
			namesNew = append(namesNew, strings.ToUpper(string(aName[0])))
		}
		return strings.Join(namesNew, ".")
	}

    fmt.Println(abbreviateName("Sam Harris"))
    // S.H
    fmt.Println(abbreviateName("patrick feeney"))
    // P.F
}
