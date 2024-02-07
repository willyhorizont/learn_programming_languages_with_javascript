use strict;
use warnings;

=begin
Title:
    Abbreviate a Two Word Name
Instructions:
    Write a function to convert a name into initials. This kata strictly takes two words with one space in between them.
    The output should be two capital letters with a dot separating them.
    It should look like this:
    Sam Harris => S.H
    patrick feeney => P.F
=cut

sub abbrev_name {
    my ($complete_name) = @_;
    return join(".", map { my $name = $_; uc(substr($name, 0, 1)) } split(" ", $complete_name));
}
print(abbrev_name("Sam Harris") . "\n");
# S.H
print(abbrev_name("patrick feeney") . "\n");
# P.F