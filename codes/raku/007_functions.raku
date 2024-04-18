# ? function statement or function declaration

sub get-rectangle-area-v1($rectangle-width, $rectangle-length) {
    return ($rectangle-width * $rectangle-length);
}
# call the function example: get-rectangle-area-v1(7, 5)

sub get-rectangle-area-v2($rectangle-width, $rectangle-length) { ($rectangle-width * $rectangle-length) }
# call the function example: get-rectangle-area-v2(7, 5)

# ? function expression

my $get-rectangle-area-v3 = sub ($rectangle-width, $rectangle-length) {
    return ($rectangle-width * $rectangle-length);
};
# call the function example: $get-rectangle-area-v3(7, 5)

my $get-rectangle-area-v4 = sub ($rectangle-width, $rectangle-length) { ($rectangle-width * $rectangle-length) };
# call the function example: $get-rectangle-area-v4(7, 5)

my &get-rectangle-area-v5 = sub ($rectangle-width, $rectangle-length) {
    return ($rectangle-width * $rectangle-length);
};
# call the function example: &get-rectangle-area-v5(7, 5)

my &get-rectangle-area-v6 = sub ($rectangle-width, $rectangle-length) { ($rectangle-width * $rectangle-length) };
# call the function example: &get-rectangle-area-v6(7, 5)

my $get-rectangle-area-v7 = -> $rectangle-width, $rectangle-length { ($rectangle-width * $rectangle-length) };
# call the function example: $get-rectangle-area-v7(7, 5)

my &get-rectangle-area-v8 = -> $rectangle-width, $rectangle-length { ($rectangle-width * $rectangle-length) };
# call the function example: &get-rectangle-area-v8(7, 5)

# ? anonymous function

#`<<<
sub ($rectangle-width, $rectangle-length) {
    return ($rectangle-width * $rectangle-length);
}
>>>

# sub ($rectangle-width, $rectangle-length) { ($rectangle-width * $rectangle-length) }

# -> $rectangle-width, $rectangle-length { ($rectangle-width * $rectangle-length) }

# ? Passing functions as arguments to other functions

sub say-hello-v1($callback-function) {
    print("hello", "\n");
    $callback-function();
}

sub say-hello-v2(&callback-function) {
    print("hello", "\n");
    &callback-function();
}

sub say-how-are-you() {
    print("how are you?", "\n");
}

say-hello-v1(&say-how-are-you);

say-hello-v2(&say-how-are-you);

say-hello-v1(sub () {
    print("how are you?", "\n");
});

say-hello-v2(sub () {
    print("how are you?", "\n");
});

say-hello-v1(sub () { print("how are you?", "\n") });

say-hello-v2(sub () { print("how are you?", "\n") });

# ? Assigning functions to variables or storing them in data structures

my $get-rectangle-area-v3-copy = sub ($rectangle-width, $rectangle-length) {
    return ($rectangle-width * $rectangle-length);
};

my $get-rectangle-area-v4-copy = sub ($rectangle-width, $rectangle-length) { ($rectangle-width * $rectangle-length) };

my &get-rectangle-area-v5-copy = sub ($rectangle-width, $rectangle-length) {
    return ($rectangle-width * $rectangle-length);
};

my &get-rectangle-area-v6-copy = sub ($rectangle-width, $rectangle-length) { ($rectangle-width * $rectangle-length) };

my $get-rectangle-area-v7-copy = -> $rectangle-width, $rectangle-length { ($rectangle-width * $rectangle-length) };

my &get-rectangle-area-v8-copy = -> $rectangle-width, $rectangle-length { ($rectangle-width * $rectangle-length) };

my @my-array-of-get-rectangle-area-functions-v1 = (
    &get-rectangle-area-v1,
    sub ($rectangle-width, $rectangle-length) {
        return ($rectangle-width * $rectangle-length);
    },
    sub ($rectangle-width, $rectangle-length) { ($rectangle-width * $rectangle-length) },
    -> $rectangle-width, $rectangle-length { ($rectangle-width * $rectangle-length) }
);

my $get-rectangle-area-function-v1-result1 = @my-array-of-get-rectangle-area-functions-v1[0](7, 5);
my $get-rectangle-area-function-v1-result2 = @my-array-of-get-rectangle-area-functions-v1[1](7, 5);
my $get-rectangle-area-function-v1-result3 = @my-array-of-get-rectangle-area-functions-v1[2](7, 5);
my $get-rectangle-area-function-v1-result4 = @my-array-of-get-rectangle-area-functions-v1[3](7, 5);

my $my-array-of-get-rectangle-area-functions-v2 = [
    &get-rectangle-area-v2,
    sub ($rectangle-width, $rectangle-length) {
        return ($rectangle-width * $rectangle-length);
    },
    sub ($rectangle-width, $rectangle-length) { ($rectangle-width * $rectangle-length) },
    -> $rectangle-width, $rectangle-length { ($rectangle-width * $rectangle-length) }
];

my $get-rectangle-area-function-v2-result1 = $my-array-of-get-rectangle-area-functions-v2[0](7, 5);
my $get-rectangle-area-function-v2-result2 = $my-array-of-get-rectangle-area-functions-v2[1](7, 5);
my $get-rectangle-area-function-v2-result3 = $my-array-of-get-rectangle-area-functions-v2[2](7, 5);
my $get-rectangle-area-function-v2-result4 = $my-array-of-get-rectangle-area-functions-v2[3](7, 5);

sub exponentiation($a, $b) {
    return ($a ** $b);
}

my %simple-calculator-v1 = (
    "exponentiation" => &exponentiation,
    "addition" => sub ($a, $b) {
        return ($a + $b);
    },
    "subtraction" => sub ($a, $b) { ($a - $b) },
    "multiplication" => -> $a, $b { ($a * $b) },
);

my $simple-calculator-v1-result1 = %simple-calculator-v1{"exponentiation"}(2, 4);
my $simple-calculator-v1-result2 = %simple-calculator-v1{"addition"}(9, 3);
my $simple-calculator-v1-result3 = %simple-calculator-v1{"subtraction"}(35, 8);
my $simple-calculator-v1-result4 = %simple-calculator-v1{"multiplication"}(7, 5);

my $simple-calculator-v2 = {
    "exponentiation" => &exponentiation,
    "addition" => sub ($a, $b) {
        return ($a + $b);
    },
    "subtraction" => sub ($a, $b) { ($a - $b) },
    "multiplication" => -> $a, $b { ($a * $b) },
};

my $simple-calculator-v2-result1 = $simple-calculator-v2{"exponentiation"}(2, 4);
my $simple-calculator-v2-result2 = $simple-calculator-v2{"addition"}(9, 3);
my $simple-calculator-v2-result3 = $simple-calculator-v2{"subtraction"}(35, 8);
my $simple-calculator-v2-result4 = $simple-calculator-v2{"multiplication"}(7, 5);

my $simple-calculator-v3 = %(
    "exponentiation" => &exponentiation,
    "addition" => sub ($a, $b) {
        return ($a + $b);
    },
    "subtraction" => sub ($a, $b) { ($a - $b) },
    "multiplication" => -> $a, $b { ($a * $b) },
);

my $simple-calculator-v3-result1 = $simple-calculator-v3{"exponentiation"}(2, 4);
my $simple-calculator-v3-result2 = $simple-calculator-v3{"addition"}(9, 3);
my $simple-calculator-v3-result3 = $simple-calculator-v3{"subtraction"}(35, 8);
my $simple-calculator-v3-result4 = $simple-calculator-v3{"multiplication"}(7, 5);

# ? Returning functions as values from other functions

sub multiply-v1($a) {
    my $multiply-by = sub ($b) {
        return ($a * $b);
    };
    return $multiply-by;
}
my $multiply-by2 = multiply-v1(2);
my $multiply-by2-result = $multiply-by2(10); # 20

sub multiply-v2($a) {
    return sub ($b) {
        return ($a * $b);
    };
}
my $multiply-by3 = multiply-v2(3);
my $multiply-by3-result = $multiply-by3(10); # 30

sub multiply-v3($a) {
    return sub ($b) { ($a * $b) };
}
my $multiply-by4 = multiply-v3(4);
my $multiply-by4-result = $multiply-by4(10); # 40

sub multiply-v4($a) {
    return -> $b { ($a * $b) };
}
my $multiply-by5 = multiply-v4(5);
my $multiply-by5-result = $multiply-by5(10); # 50

sub multiply-v5($a) { sub ($b) { ($a * $b) } }
my $multiply-by6 = multiply-v5(6);
my $multiply-by6-result = $multiply-by6(10); # 60

sub multiply-v6($a) { -> $b { ($a * $b) } }
my $multiply-by7 = multiply-v6(7);
my $multiply-by7-result = $multiply-by7(10); # 70

my $multiply-v7 = sub ($a) {
    return sub ($b) {
        return ($a * $b);
    };
}
my $multiply-by8 = $multiply-v7(8);
my $multiply-by8-result = $multiply-by8(10); # 80

my $multiply-v8 = sub ($a) {
    return sub ($b) { ($a * $b) };
}
my $multiply-by9 = $multiply-v8(9);
my $multiply-by9-result = $multiply-by9(10); # 90

my $multiply-v9 = sub ($a) {
    return -> $b { ($a * $b) };
}
my $multiply-by10 = $multiply-v9(10);
my $multiply-by10-result = $multiply-by10(10); # 100

my $multiply-v10 = sub ($a) { sub ($b) { ($a * $b) } }
my $multiply-by11 = $multiply-v10(11);
my $multiply-by11-result = $multiply-by11(10); # 110

my $multiply-v11 = sub ($a) { -> $b { ($a * $b) } }
my $multiply-by12 = $multiply-v11(12);
my $multiply-by12-result = $multiply-by12(10); # 120

my $multiply-v12 = -> $a { -> $b { ($a * $b) } }
my $multiply-by13 = $multiply-v12(13);
my $multiply-by13-result = $multiply-by13(10); # 130
