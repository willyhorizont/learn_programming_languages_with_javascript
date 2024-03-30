use strict;
use warnings;

=begin
Source:
    https://www.codewars.com/kata/54ff3102c1bad923760001f3
Title:
    Vowel Count
Description:
    Return the number (count) of vowels in the given string.
    We will consider a, e, i, o, u as vowels for this Kata (but not y).
    The input string will only consist of lower case letters and/or spaces.
=cut

sub count_vowels {
    my ($a_string) = @_;
    return scalar(@{[grep { (index("aiueoAIUEO", $_) != -1) } split("", $a_string)]});
}
print(count_vowels("Hello World"), "\n"); # 3
