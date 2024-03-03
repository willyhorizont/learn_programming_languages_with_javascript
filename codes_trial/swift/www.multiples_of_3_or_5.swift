/*
Source:
    https://www.codewars.com/kata/514b92a657cdc65150000006
Title:
    Multiples of 3 or 5
Description:
    If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
    Finish the solution so that it returns the sum of all the multiples of 3 or 5 below the number passed in.
    Additionally, if the number is negative, return 0.
    Note: If the number is a multiple of both 3 and 5, only count it once.
    Courtesy of https://projecteuler.net/problem=1
*/

func multiplesOf3Or5(_ number: Int) -> Int {
    if (number < 1) {
        return 0
    }
    var sum = 0
    for i in 1...(number - 1) {
        if (((i % 3) == 0) || ((i % 5) == 0)) {
            print(i)
            sum += i
        }
    }
    return sum
}
print(multiplesOf3Or5(10)) // 23