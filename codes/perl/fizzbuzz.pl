use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

print("\n# FizzBuzz(n) in Perl\n");

sub fizzbuzz_v1 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    my $number = 1;
    while (1) {
        if ($result eq "") {
            $result = "$number";
            $number += 1;
            last if $number > $stop_number;
            next;
        }
        if ((($number % 3) == 0) && (($number % 5) == 0)) {
            $result = "$result, FizzBuzz";
            $number += 1;
            last if $number > $stop_number;
            next;
        }
        if (($number % 3) == 0) {
            $result = "$result, Fizz";
            $number += 1;
            last if $number > $stop_number;
            next;
        }
        if (($number % 5) == 0) {
            $result = "$result, Buzz";
            $number += 1;
            last if $number > $stop_number;
            next;
        }
        $result = "$result, $number";
        $number += 1;
        last if $number > $stop_number;
    }
    return $result;
}

sub fizzbuzz_v2 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    my $number = 1;
    while ($number <= $stop_number) {
        if ($result eq "") {
            $result = "$number";
            $number += 1;
            next;
        }
        if ((($number % 3) == 0) && (($number % 5) == 0)) {
            $result = "$result, FizzBuzz";
            $number += 1;
            next;
        }
        if (($number % 3) == 0) {
            $result = "$result, Fizz";
            $number += 1;
            next;
        }
        if (($number % 5) == 0) {
            $result = "$result, Buzz";
            $number += 1;
            next;
        }
        $result = "$result, $number";
        $number += 1;
    }
    return $result;
}

sub fizzbuzz_v3 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    my $number = 1;
    while (1) {
        if ($result eq "") {
            $result = "$number";
        } elsif ((($number % 3) == 0) && (($number % 5) == 0)) {
            $result = "$result, FizzBuzz";
        } elsif (($number % 3) == 0) {
            $result = "$result, Fizz";
        } elsif (($number % 5) == 0) {
            $result = "$result, Buzz";
        } else {
            $result = "$result, $number";
        }
        $number += 1;
        last if $number > $stop_number;
    }
    return $result;
}

sub fizzbuzz_v4 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    my $number = 1;
    while ($number <= $stop_number) {
        if ($result eq "") {
            $result = "$number";
        } elsif ((($number % 3) == 0) && (($number % 5) == 0)) {
            $result = "$result, FizzBuzz";
        } elsif (($number % 3) == 0) {
            $result = "$result, Fizz";
        } elsif (($number % 5) == 0) {
            $result = "$result, Buzz";
        } else {
            $result = "$result, $number";
        }
        $number += 1;
    }
    return $result;
}

sub fizzbuzz_v5 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    my $number = 1;
    while (1) {
        $result = (($result eq "")
            ? "$number"
            : (((($number % 3) == 0) && (($number % 5) == 0))
                ? "$result, FizzBuzz"
                : ((($number % 3) == 0)
                    ? "$result, Fizz"
                    : ((($number % 5) == 0)
                        ? "$result, Buzz"
                        : "$result, $number"
                    )
                )
            )
        );
        $number += 1;
        last if $number > $stop_number;
    }
    return $result;
}

sub fizzbuzz_v6 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    my $number = 1;
    while ($number <= $stop_number) {
        $result = (($result eq "")
            ? "$number"
            : (((($number % 3) == 0) && (($number % 5) == 0))
                ? "$result, FizzBuzz"
                : ((($number % 3) == 0)
                    ? "$result, Fizz"
                    : ((($number % 5) == 0)
                        ? "$result, Buzz"
                        : "$result, $number"
                    )
                )
            )
        );
        $number += 1;
    }
    return $result;
}

sub fizzbuzz_v7 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    my $number = 1;
    while (1) {
        $result = (($result eq "") ? "$number" : (((($number % 3) == 0) && (($number % 5) == 0)) ? "$result, FizzBuzz" : ((($number % 3) == 0) ? "$result, Fizz" : ((($number % 5) == 0) ? "$result, Buzz" : "$result, $number"))));
        $number += 1;
        last if $number > $stop_number;
    }
    return $result;
}

sub fizzbuzz_v8 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    my $number = 1;
    while ($number <= $stop_number) {
        $result = (($result eq "") ? "$number" : (((($number % 3) == 0) && (($number % 5) == 0)) ? "$result, FizzBuzz" : ((($number % 3) == 0) ? "$result, Fizz" : ((($number % 5) == 0) ? "$result, Buzz" : "$result, $number"))));
        $number += 1;
    }
    return $result;
}

sub fizzbuzz_v9 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    for (my $number = 1; $number <= $stop_number; $number += 1) {
        if ($result eq "") {
            $result = "$number";
            next;
        }
        if ((($number % 3) == 0) && (($number % 5) == 0)) {
            $result = "$result, FizzBuzz";
            next;
        }
        if (($number % 3) == 0) {
            $result = "$result, Fizz";
            next;
        }
        if (($number % 5) == 0) {
            $result = "$result, Buzz";
            next;
        }
        $result = "$result, $number";
    }
    return $result;
}

sub fizzbuzz_v10 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    for my $number (1..$stop_number) {
        if ($result eq "") {
            $result = "$number";
            next;
        }
        if ((($number % 3) == 0) && (($number % 5) == 0)) {
            $result = "$result, FizzBuzz";
            next;
        }
        if (($number % 3) == 0) {
            $result = "$result, Fizz";
            next;
        }
        if (($number % 5) == 0) {
            $result = "$result, Buzz";
            next;
        }
        $result = "$result, $number";
    }
    return $result;
}

sub fizzbuzz_v11 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    for (my $number = 1; $number <= $stop_number; $number +=1) {
        if ($result eq "") {
            $result = "$number";
        } elsif ((($number % 3) == 0) && (($number % 5) == 0)) {
            $result = "$result, FizzBuzz";
        } elsif (($number % 3) == 0) {
            $result = "$result, Fizz";
        } elsif (($number % 5) == 0) {
            $result = "$result, Buzz";
        } else {
            $result = "$result, $number";
        }
    }
    return $result;
}

sub fizzbuzz_v12 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    for my $number (1..$stop_number) {
        if ($result eq "") {
            $result = "$number";
        } elsif ((($number % 3) == 0) && (($number % 5) == 0)) {
            $result = "$result, FizzBuzz";
        } elsif (($number % 3) == 0) {
            $result = "$result, Fizz";
        } elsif (($number % 5) == 0) {
            $result = "$result, Buzz";
        } else {
            $result = "$result, $number";
        }
    }
    return $result;
}

sub fizzbuzz_v13 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    for (my $number = 1; $number <= $stop_number; $number +=1) {
        $result = (($result eq "")
            ? "$number"
            : (((($number % 3) == 0) && (($number % 5) == 0))
                ? "$result, FizzBuzz"
                : ((($number % 3) == 0)
                    ? "$result, Fizz"
                    : ((($number % 5) == 0)
                        ? "$result, Buzz"
                        : "$result, $number"
                    )
                )
            )
        );
    }
    return $result;
}

sub fizzbuzz_v14 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    for my $number (1..$stop_number) {
        $result = (($result eq "")
            ? "$number"
            : (((($number % 3) == 0) && (($number % 5) == 0))
                ? "$result, FizzBuzz"
                : ((($number % 3) == 0)
                    ? "$result, Fizz"
                    : ((($number % 5) == 0)
                        ? "$result, Buzz"
                        : "$result, $number"
                    )
                )
            )
        );
    }
    return $result;
}

sub fizzbuzz_v15 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    for (my $number = 1; $number <= $stop_number; $number +=1) {
        $result = (($result eq "") ? "$number" : (((($number % 3) == 0) && (($number % 5) == 0)) ? "$result, FizzBuzz" : ((($number % 3) == 0) ? "$result, Fizz" : ((($number % 5) == 0) ? "$result, Buzz" : "$result, $number"))));
    }
    return $result;
}

sub fizzbuzz_v16 {
    my ($stop_number) = @_;
    return "argument should be a number" if !(looks_like_number($stop_number));
    return "argument should be greater than 0" if ($stop_number < 1);
    my $result = "";
    for my $number (1..$stop_number) {
        $result = (($result eq "") ? "$number" : (((($number % 3) == 0) && (($number % 5) == 0)) ? "$result, FizzBuzz" : ((($number % 3) == 0) ? "$result, Fizz" : ((($number % 5) == 0) ? "$result, Buzz" : "$result, $number"))));
    }
    return $result;
}

print("# using fizzbuzz function \"fizzbuzz_v1\"\n");
print("FizzBuzz(36): " . fizzbuzz_v1(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v2\"\n");
print("FizzBuzz(36): " . fizzbuzz_v2(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v3\"\n");
print("FizzBuzz(36): " . fizzbuzz_v3(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v4\"\n");
print("FizzBuzz(36): " . fizzbuzz_v4(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v5\"\n");
print("FizzBuzz(36): " . fizzbuzz_v5(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v6\"\n");
print("FizzBuzz(36): " . fizzbuzz_v6(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v7\"\n");
print("FizzBuzz(36): " . fizzbuzz_v7(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v8\"\n");
print("FizzBuzz(36): " . fizzbuzz_v8(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v9\"\n");
print("FizzBuzz(36): " . fizzbuzz_v9(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v10\"\n");
print("FizzBuzz(36): " . fizzbuzz_v10(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v11\"\n");
print("FizzBuzz(36): " . fizzbuzz_v11(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v12\"\n");
print("FizzBuzz(36): " . fizzbuzz_v12(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v13\"\n");
print("FizzBuzz(36): " . fizzbuzz_v13(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v14\"\n");
print("FizzBuzz(36): " . fizzbuzz_v14(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v15\"\n");
print("FizzBuzz(36): " . fizzbuzz_v15(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz_v16\"\n");
print("FizzBuzz(36): " . fizzbuzz_v16(36) . "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
