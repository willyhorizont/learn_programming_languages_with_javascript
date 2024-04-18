print("\n# FizzBuzz(n) in Raku", "\n");

sub fizzbuzz-v1(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    my $number = 1;
    while (True) {
        if ($result eq "") {
            $result = "{$number}";
            last if ($number >= $stop-number);
            $number += 1;
            next;
        }
        if ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "{$result}, FizzBuzz";
            last if ($number >= $stop-number);
            $number += 1;
            next;
        }
        if (($number % 3) === 0) {
            $result = "{$result}, Fizz";
            last if ($number >= $stop-number);
            $number += 1;
            next;
        }
        if (($number % 5) === 0) {
            $result = "{$result}, Buzz";
            last if ($number >= $stop-number);
            $number += 1;
            next;
        }
        $result = "{$result}, {$number}";
        last if ($number >= $stop-number);
        $number += 1;
    }
    return $result;
}

sub fizzbuzz-v2(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    my $number = 1;
    loop {
        if ($result eq "") {
            $result = "{$number}";
            last if ($number >= $stop-number);
            $number += 1;
            next;
        }
        if ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "{$result}, FizzBuzz";
            last if ($number >= $stop-number);
            $number += 1;
            next;
        }
        if (($number % 3) === 0) {
            $result = "{$result}, Fizz";
            last if ($number >= $stop-number);
            $number += 1;
            next;
        }
        if (($number % 5) === 0) {
            $result = "{$result}, Buzz";
            last if ($number >= $stop-number);
            $number += 1;
            next;
        }
        $result = "{$result}, {$number}";
        last if ($number >= $stop-number);
        $number += 1;
    }
    return $result;
}

sub fizzbuzz-v3(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    my $number = 1;
    while ($number <= $stop-number) {
        if ($result eq "") {
            $result = "{$number}";
            $number += 1;
            next;
        }
        if ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "{$result}, FizzBuzz";
            $number += 1;
            next;
        }
        if (($number % 3) === 0) {
            $result = "{$result}, Fizz";
            $number += 1;
            next;
        }
        if (($number % 5) === 0) {
            $result = "{$result}, Buzz";
            $number += 1;
            next;
        }
        $result = "{$result}, {$number}";
        $number += 1;
    }
    return $result;
}

sub fizzbuzz-v4(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    my $number = 1;
    while (True) {
        if ($result eq "") {
            $result = "{$number}";
        } elsif ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "{$result}, FizzBuzz";
        } elsif (($number % 3) === 0) {
            $result = "{$result}, Fizz";
        } elsif (($number % 5) === 0) {
            $result = "{$result}, Buzz";
        } else {
            $result = "{$result}, {$number}";
        }
        last if ($number >= $stop-number);
        $number += 1;
    }
    return $result;
}

sub fizzbuzz-v5(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    my $number = 1;
    loop {
        if ($result eq "") {
            $result = "{$number}";
        } elsif ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "{$result}, FizzBuzz";
        } elsif (($number % 3) === 0) {
            $result = "{$result}, Fizz";
        } elsif (($number % 5) === 0) {
            $result = "{$result}, Buzz";
        } else {
            $result = "{$result}, {$number}";
        }
        last if ($number >= $stop-number);
        $number += 1;
    }
    return $result;
}

sub fizzbuzz-v6(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    my $number = 1;
    while ($number <= $stop-number) {
        if ($result eq "") {
            $result = "{$number}";
        } elsif ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "{$result}, FizzBuzz";
        } elsif (($number % 3) === 0) {
            $result = "{$result}, Fizz";
        } elsif (($number % 5) === 0) {
            $result = "{$result}, Buzz";
        } else {
            $result = "{$result}, {$number}";
        }
        $number += 1;
    }
    return $result;
}

sub fizzbuzz-v7(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    my $number = 1;
    while (True) {
        $result = (($result eq "")
            ?? "{$number}"
            !! (((($number % 3) === 0) && (($number % 5) === 0))
                ?? "{$result}, FizzBuzz"
                !! ((($number % 3) === 0)
                    ?? "{$result}, Fizz"
                    !! ((($number % 5) === 0)
                        ?? "{$result}, Buzz"
                        !! "{$result}, {$number}"
                    )
                )
            )
        );
        last if ($number >= $stop-number);
        $number += 1;
    }
    return $result;
}

sub fizzbuzz-v8(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    my $number = 1;
    loop {
        $result = (($result eq "")
            ?? "{$number}"
            !! (((($number % 3) === 0) && (($number % 5) === 0))
                ?? "{$result}, FizzBuzz"
                !! ((($number % 3) === 0)
                    ?? "{$result}, Fizz"
                    !! ((($number % 5) === 0)
                        ?? "{$result}, Buzz"
                        !! "{$result}, {$number}"
                    )
                )
            )
        );
        last if ($number >= $stop-number);
        $number += 1;
    }
    return $result;
}

sub fizzbuzz-v9(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    my $number = 1;
    while ($number <= $stop-number) {
        $result = (($result eq "")
            ?? "{$number}"
            !! (((($number % 3) === 0) && (($number % 5) === 0))
                ?? "{$result}, FizzBuzz"
                !! ((($number % 3) === 0)
                    ?? "{$result}, Fizz"
                    !! ((($number % 5) === 0)
                        ?? "{$result}, Buzz"
                        !! "{$result}, {$number}"
                    )
                )
            )
        );
        $number += 1;
    }
    return $result;
}

sub fizzbuzz-v10(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    my $number = 1;
    while (True) {
        $result = (($result eq "") ?? "{$number}" !! (((($number % 3) === 0) && (($number % 5) === 0)) ?? "{$result}, FizzBuzz" !! ((($number % 3) === 0) ?? "{$result}, Fizz" !! ((($number % 5) === 0) ?? "{$result}, Buzz" !! "{$result}, {$number}"))));
        last if ($number >= $stop-number);
        $number += 1;
    }
    return $result;
}

sub fizzbuzz-v11(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    my $number = 1;
    loop {
        $result = (($result eq "") ?? "{$number}" !! (((($number % 3) === 0) && (($number % 5) === 0)) ?? "{$result}, FizzBuzz" !! ((($number % 3) === 0) ?? "{$result}, Fizz" !! ((($number % 5) === 0) ?? "{$result}, Buzz" !! "{$result}, {$number}"))));
        last if ($number >= $stop-number);
        $number += 1;
    }
    return $result;
}

sub fizzbuzz-v12(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    my $number = 1;
    while ($number <= $stop-number) {
        $result = (($result eq "") ?? "{$number}" !! (((($number % 3) === 0) && (($number % 5) === 0)) ?? "{$result}, FizzBuzz" !! ((($number % 3) === 0) ?? "{$result}, Fizz" !! ((($number % 5) === 0) ?? "{$result}, Buzz" !! "{$result}, {$number}"))));
        $number += 1;
    }
    return $result;
}

sub fizzbuzz-v13(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    loop (my $number = 1; $number <= $stop-number; $number += 1) {
        if ($result eq "") {
            $result = "{$number}";
            next;
        }
        if ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "{$result}, FizzBuzz";
            next;
        }
        if (($number % 3) === 0) {
            $result = "{$result}, Fizz";
            next;
        }
        if (($number % 5) === 0) {
            $result = "{$result}, Buzz";
            next;
        }
        $result = "{$result}, {$number}";
    }
    return $result;
}

sub fizzbuzz-v14(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    for (1...$stop-number) -> $number {
        if ($result eq "") {
            $result = "{$number}";
            next;
        }
        if ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "{$result}, FizzBuzz";
            next;
        }
        if (($number % 3) === 0) {
            $result = "{$result}, Fizz";
            next;
        }
        if (($number % 5) === 0) {
            $result = "{$result}, Buzz";
            next;
        }
        $result = "{$result}, {$number}";
    }
    return $result;
}

sub fizzbuzz-v15(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    loop (my $number = 1; $number <= $stop-number; $number +=1) {
        if ($result eq "") {
            $result = "{$number}";
        } elsif ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "{$result}, FizzBuzz";
        } elsif (($number % 3) === 0) {
            $result = "{$result}, Fizz";
        } elsif (($number % 5) === 0) {
            $result = "{$result}, Buzz";
        } else {
            $result = "{$result}, {$number}";
        }
    }
    return $result;
}

sub fizzbuzz-v16(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    for (1...$stop-number) -> $number {
        if ($result eq "") {
            $result = "{$number}";
        } elsif ((($number % 3) === 0) && (($number % 5) === 0)) {
            $result = "{$result}, FizzBuzz";
        } elsif (($number % 3) === 0) {
            $result = "{$result}, Fizz";
        } elsif (($number % 5) === 0) {
            $result = "{$result}, Buzz";
        } else {
            $result = "{$result}, {$number}";
        }
    }
    return $result;
}

sub fizzbuzz-v17(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    loop (my $number = 1; $number <= $stop-number; $number +=1) {
        $result = (($result eq "")
            ?? "{$number}"
            !! (((($number % 3) === 0) && (($number % 5) === 0))
                ?? "{$result}, FizzBuzz"
                !! ((($number % 3) === 0)
                    ?? "{$result}, Fizz"
                    !! ((($number % 5) === 0)
                        ?? "{$result}, Buzz"
                        !! "{$result}, {$number}"
                    )
                )
            )
        );
    }
    return $result;
}

sub fizzbuzz-v18(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    for (1...$stop-number) -> $number {
        $result = (($result eq "")
            ?? "{$number}"
            !! (((($number % 3) === 0) && (($number % 5) === 0))
                ?? "{$result}, FizzBuzz"
                !! ((($number % 3) === 0)
                    ?? "{$result}, Fizz"
                    !! ((($number % 5) === 0)
                        ?? "{$result}, Buzz"
                        !! "{$result}, {$number}"
                    )
                )
            )
        );
    }
    return $result;
}

sub fizzbuzz-v19(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    loop (my $number = 1; $number <= $stop-number; $number +=1) {
        $result = (($result eq "") ?? "{$number}" !! (((($number % 3) === 0) && (($number % 5) === 0)) ?? "{$result}, FizzBuzz" !! ((($number % 3) === 0) ?? "{$result}, Fizz" !! ((($number % 5) === 0) ?? "{$result}, Buzz" !! "{$result}, {$number}"))));
    }
    return $result;
}

sub fizzbuzz-v20(Int $stop-number) {
    die("Argument should be > 0") if ($stop-number < 1);
    my $result = "";
    for (1...$stop-number) -> $number {
        $result = (($result eq "") ?? "{$number}" !! (((($number % 3) === 0) && (($number % 5) === 0)) ?? "{$result}, FizzBuzz" !! ((($number % 3) === 0) ?? "{$result}, Fizz" !! ((($number % 5) === 0) ?? "{$result}, Buzz" !! "{$result}, {$number}"))));
    }
    return $result;
}

print("# using fizzbuzz function \"fizzbuzz-v1\"\n");
print("FizzBuzz(36): ", fizzbuzz-v1(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v2\"\n");
print("FizzBuzz(36): ", fizzbuzz-v2(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v3\"\n");
print("FizzBuzz(36): ", fizzbuzz-v3(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v4\"\n");
print("FizzBuzz(36): ", fizzbuzz-v4(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v5\"\n");
print("FizzBuzz(36): ", fizzbuzz-v5(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v6\"\n");
print("FizzBuzz(36): ", fizzbuzz-v6(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v7\"\n");
print("FizzBuzz(36): ", fizzbuzz-v7(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v8\"\n");
print("FizzBuzz(36): ", fizzbuzz-v8(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v9\"\n");
print("FizzBuzz(36): ", fizzbuzz-v9(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v10\"\n");
print("FizzBuzz(36): ", fizzbuzz-v10(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v11\"\n");
print("FizzBuzz(36): ", fizzbuzz-v11(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v12\"\n");
print("FizzBuzz(36): ", fizzbuzz-v12(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v13\"\n");
print("FizzBuzz(36): ", fizzbuzz-v13(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v14\"\n");
print("FizzBuzz(36): ", fizzbuzz-v14(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v15\"\n");
print("FizzBuzz(36): ", fizzbuzz-v15(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v16\"\n");
print("FizzBuzz(36): ", fizzbuzz-v16(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v17\"\n");
print("FizzBuzz(36): ", fizzbuzz-v17(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v18\"\n");
print("FizzBuzz(36): ", fizzbuzz-v18(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v19\"\n");
print("FizzBuzz(36): ", fizzbuzz-v19(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz

print("# using fizzbuzz function \"fizzbuzz-v20\"\n");
print("FizzBuzz(36): ", fizzbuzz-v20(36), "\n");
# FizzBuzz(36): 1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, FizzBuzz, 31, 32, Fizz, 34, Buzz, Fizz
