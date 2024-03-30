use strict;
use warnings;

# ? function statement or function declaration

sub get_rectangle_area_v1 {
    my ($rectangle_width, $rectangle_length) = @_;
    return ($rectangle_width * $rectangle_length);
}
# call the function example: get_rectangle_area_v1(7, 5)

sub get_rectangle_area_v2 { my ($rectangle_width, $rectangle_length) = @_; return ($rectangle_width * $rectangle_length); }
# call the function example: get_rectangle_area_v2(7, 5)

# ? function expression

my $get_rectangle_area_v3 = sub {
    my ($rectangle_width, $rectangle_length) = @_;
    return ($rectangle_width * $rectangle_length);
};
# call the function example: $get_rectangle_area_v3->(7, 5)

my $get_rectangle_area_v4 = sub { my ($rectangle_width, $rectangle_length) = @_; return ($rectangle_width * $rectangle_length); };
# call the function example: $get_rectangle_area_v4->(7, 5)

my $get_rectangle_area_v5 = sub { my ($rectangle_width, $rectangle_length) = @_; ($rectangle_width * $rectangle_length) };
# call the function example: $get_rectangle_area_v5->(7, 5)

# ? anonymous function

# sub {
#     my ($rectangle_width, $rectangle_length) = @_;
#     return ($rectangle_width * $rectangle_length);
# }

# sub { my ($rectangle_width, $rectangle_length) = @_; return ($rectangle_width * $rectangle_length); }

# sub { my ($rectangle_width, $rectangle_length) = @_; ($rectangle_width * $rectangle_length) }

# ? Passing functions as arguments to other functions

sub say_hello {
    my ($callback_function_ref) = @_;
    print("hello", "\n");
    $callback_function_ref -> (); # or &$callback_function_ref();
}

sub say_how_are_you {
    print("how are you?", "\n");
}

say_hello(\&say_how_are_you);

say_hello(sub {
    print("how are you?", "\n");
});

say_hello(sub { print("how are you?", "\n") });

# ? Assigning functions to variables or storing them in data structures

my $get_rectangle_area_v3_copy = sub {
    my ($rectangle_width, $rectangle_length) = @_;
    return ($rectangle_width * $rectangle_length);
};

my $get_rectangle_area_v4_copy = sub { my ($rectangle_width, $rectangle_length) = @_; return ($rectangle_width * $rectangle_length); };

my $get_rectangle_area_v5_copy = sub { my ($rectangle_width, $rectangle_length) = @_; ($rectangle_width * $rectangle_length) };

my @my_array_of_get_rectangle_area_functions_v1 = (
    \&get_rectangle_area_v1,
    sub {
        my ($rectangle_width, $rectangle_length) = @_;
        return ($rectangle_width * $rectangle_length);
    },
    sub { my ($rectangle_width, $rectangle_length) = @_; return ($rectangle_width * $rectangle_length); },
    sub { my ($rectangle_width, $rectangle_length) = @_; ($rectangle_width * $rectangle_length) }
);

my $get_rectangle_area_function_v1_result1 = $my_array_of_get_rectangle_area_functions_v1[0](7, 5);
my $get_rectangle_area_function_v1_result2 = $my_array_of_get_rectangle_area_functions_v1[1](7, 5);
my $get_rectangle_area_function_v1_result3 = $my_array_of_get_rectangle_area_functions_v1[2](7, 5);
my $get_rectangle_area_function_v1_result4 = $my_array_of_get_rectangle_area_functions_v1[3](7, 5);

my $my_array_of_get_rectangle_area_functions_v2 = [
    \&get_rectangle_area_v1,
    sub {
        my ($rectangle_width, $rectangle_length) = @_;
        return ($rectangle_width * $rectangle_length);
    },
    sub { my ($rectangle_width, $rectangle_length) = @_; return ($rectangle_width * $rectangle_length); },
    sub { my ($rectangle_width, $rectangle_length) = @_; ($rectangle_width * $rectangle_length) }
];

my $get_rectangle_area_function_v2_result1 = $$my_array_of_get_rectangle_area_functions_v2[0](7, 5);
my $get_rectangle_area_function_v2_result2 = $$my_array_of_get_rectangle_area_functions_v2[1](7, 5);
my $get_rectangle_area_function_v2_result3 = $$my_array_of_get_rectangle_area_functions_v2[2](7, 5);
my $get_rectangle_area_function_v2_result4 = $$my_array_of_get_rectangle_area_functions_v2[3](7, 5);
my $get_rectangle_area_function_v2_result5 = ${$my_array_of_get_rectangle_area_functions_v2}[0](7, 5);
my $get_rectangle_area_function_v2_result6 = ${$my_array_of_get_rectangle_area_functions_v2}[1](7, 5);
my $get_rectangle_area_function_v2_result7 = ${$my_array_of_get_rectangle_area_functions_v2}[2](7, 5);
my $get_rectangle_area_function_v2_result8 = ${$my_array_of_get_rectangle_area_functions_v2}[3](7, 5);
my $get_rectangle_area_function_v2_result9 = $my_array_of_get_rectangle_area_functions_v2->[0](7, 5);
my $get_rectangle_area_function_v2_result10 = $my_array_of_get_rectangle_area_functions_v2->[1](7, 5);
my $get_rectangle_area_function_v2_result11 = $my_array_of_get_rectangle_area_functions_v2->[2](7, 5);
my $get_rectangle_area_function_v2_result12 = $my_array_of_get_rectangle_area_functions_v2->[3](7, 5);

sub exponentiation {
    my ($a, $b) = @_;
    return ($a ** $b);
}

my %simple_calculator_v1 = (
    "exponentiation" => \&exponentiation,
    "addition" => sub {
        my ($a, $b) = @_;
        return ($a + $b);
    },
    "subtraction" => sub { my ($a, $b) = @_; return ($a - $b); },
    "multiplication" => sub { my ($a, $b) = @_; ($a - $b) }
);

my $simple_calculator_v1_result1 = $simple_calculator_v1{"exponentiation"}->(2, 4);
my $simple_calculator_v1_result2 = $simple_calculator_v1{"addition"}->(9, 3);
my $simple_calculator_v1_result3 = $simple_calculator_v1{"subtraction"}->(35, 8);
my $simple_calculator_v1_result4 = $simple_calculator_v1{"multiplication"}->(7, 5);

my $simple_calculator_v2 = {
    "exponentiation" => \&exponentiation,
    "addition" => sub {
        my ($a, $b) = @_;
        return ($a + $b);
    },
    "subtraction" => sub { my ($a, $b) = @_; return ($a - $b); },
    "multiplication" => sub { my ($a, $b) = @_; ($a - $b) }
};

my $simple_calculator_v2_result1 = $$simple_calculator_v2{"exponentiation"}->(2, 4);
my $simple_calculator_v2_result2 = $$simple_calculator_v2{"addition"}->(9, 3);
my $simple_calculator_v2_result3 = $$simple_calculator_v2{"subtraction"}->(35, 8);
my $simple_calculator_v2_result4 = $$simple_calculator_v2{"multiplication"}->(7, 5);
my $simple_calculator_v2_result5 = ${$simple_calculator_v2}{"exponentiation"}->(2, 4);
my $simple_calculator_v2_result6 = ${$simple_calculator_v2}{"addition"}->(9, 3);
my $simple_calculator_v2_result7 = ${$simple_calculator_v2}{"subtraction"}->(35, 8);
my $simple_calculator_v2_result8 = ${$simple_calculator_v2}{"multiplication"}->(7, 5);
my $simple_calculator_v2_result9 = $simple_calculator_v2->{"exponentiation"}->(2, 4);
my $simple_calculator_v2_result10 = $simple_calculator_v2->{"addition"}->(9, 3);
my $simple_calculator_v2_result11 = $simple_calculator_v2->{"subtraction"}->(35, 8);
my $simple_calculator_v2_result12 = $simple_calculator_v2->{"multiplication"}->(7, 5);

# ? Returning functions as values from other functions

sub multiply_v1 {
    my ($a) = @_;
    my $multiply_by = sub {
        my ($b) = @_;
        return ($a * $b);
    };
    return $multiply_by;
}
my $multiply_by2 = multiply_v1(2);
my $multiply_by2_result = $multiply_by2->(10); # 20

sub multiply_v2 {
    my ($a) = @_;
    return sub {
        my ($b) = @_;
        return ($a * $b);
    };
}
my $multiply_by3 = multiply_v2(3);
my $multiply_by3_result = $multiply_by3->(10); # 30

my $multiply_v3 = sub {
    my ($a) = @_;
    my $multiply_by = sub {
        my ($b) = @_;
        return ($a * $b);
    };
    return $multiply_by;
};
my $multiply_by4 = $multiply_v3->(4);
my $multiply_by4_result = $multiply_by4->(10); # 40

my $multiply_v4 = sub {
    my ($a) = @_;
    return sub {
        my ($b) = @_;
        return ($a * $b);
    };
};
my $multiply_by5 = $multiply_v4->(5);
my $multiply_by5_result = $multiply_by5->(10); # 50

my $multiply_v5 = sub { my ($a) = @_; sub { my ($b) = @_; ($a * $b) } };
my $multiply_by6 = $multiply_v5->(6);
my $multiply_by6_result = $multiply_by6->(10); # 60
