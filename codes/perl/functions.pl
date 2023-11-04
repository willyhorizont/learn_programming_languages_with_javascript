use strict;
use warnings;

# ? function statement or function declaration

sub get_rectangle_area_v1 {
    my ($rectangle_width, $rectangle_length) = @_;
    return $rectangle_width * $rectangle_length;
}

sub get_rectangle_area_v2 { my ($rectangle_width, $rectangle_length) = @_; return $rectangle_width * $rectangle_length; }

# ? function expression

my $get_rectangle_area_v3 = sub {
    my ($rectangle_width, $rectangle_length) = @_;
    return $rectangle_width * $rectangle_length;
};

my $get_rectangle_area_v4 = sub { my ($rectangle_width, $rectangle_length) = @_; return $rectangle_width * $rectangle_length; };

# ? anonymous function

# sub {
#     my ($rectangle_width, $rectangle_length) = @_;
#     return $rectangle_width * $rectangle_length;
# };

# sub { my ($rectangle_width, $rectangle_length) = @_; return $rectangle_width * $rectangle_length; };

# ? In Perl, a function is a first-class citizen, which means it supports:
# ? • Passing functions as arguments to other functions
# ? • Assigning functions to variables or storing them in data structures
# ? • Returning functions as values from other functions (closure)

# ? Passing functions as arguments to other functions

sub say_hi {
    my ($do_something2) = @_;
    print("hi", "\n");
    $do_something2 -> ();
}

sub say_how_are_you {
    print("how are you?", "\n");
}

say_hi(\&say_how_are_you);

say_hi(sub {
    print("how are you?", "\n");
});

say_hi(sub { print("how are you?", "\n") });

# ? Assigning functions to variables or storing them in data structures

my $get_rectangle_area_v5 = sub {
    my ($rectangle_width, $rectangle_length) = @_;
    return $rectangle_width * $rectangle_length;
};

my $get_rectangle_area_v6 = sub { my ($rectangle_width, $rectangle_length) = @_; return $rectangle_width * $rectangle_length; };

my @my_array_of_get_rectangle_area_functions = (
    \&get_rectangle_area_v1,
    sub {
        my ($rectangle_width, $rectangle_length) = @_;
        return $rectangle_width * $rectangle_length;
    },
    sub { my ($rectangle_width, $rectangle_length) = @_; return $rectangle_width * $rectangle_length; }
);

my $get_rectangle_area_function1 = $my_array_of_get_rectangle_area_functions[0](3, 5);
my $get_rectangle_area_function2 = $my_array_of_get_rectangle_area_functions[1](3, 5);
my $get_rectangle_area_function3 = $my_array_of_get_rectangle_area_functions[2](3, 5);

sub exponentiation {
    my ($a, $b) = @_;
    return $a ** $b;
}

my $simple_calculator = {
    "exponentiation" => \&exponentiation,
    "addition" => sub {
        my ($a, $b) = @_;
        return $a + $b;
    },
    "subtraction" => sub { my ($a, $b) = @_; return $a - $b; }
};

my $simple_calculator_result1 = $simple_calculator->{"exponentiation"}->(2, 4);
my $simple_calculator_result2 = $simple_calculator->{"addition"}->(3, 4);
my $simple_calculator_result3 = $simple_calculator->{"subtraction"}->(35, 8);

# ? Returning functions as values from other functions (closure)

sub multiply_v1 {
    my ($a) = @_;
    my $multiply_by = sub {
        my ($b) = @_;
        return $a * $b;
    };
    return $multiply_by;
}
my $multiply_by2 = multiply_v1(2);
my $multiply_by2_result = $multiply_by2->(10); # 20

sub multiply_v2 {
    my ($a) = @_;
    return sub {
        my ($b) = @_;
        return $a * $b;
    };
}
my $multiply_by3 = multiply_v2(3);
my $multiply_by3_result = $multiply_by3->(10); # 30

my $multiply_v3 = sub {
    my ($a) = @_;
    my $multiply_by = sub {
        my ($b) = @_;
        return $a * $b;
    };
    return $multiply_by;
};
my $multiply_by4 = $multiply_v3->(4);
my $multiply_by4_result = $multiply_by4->(10); # 40

my $multiply_v4 = sub {
    my ($a) = @_;
    return sub {
        my ($b) = @_;
        return $a * $b;
    };
};
my $multiply_by5 = $multiply_v4->(5);
my $multiply_by5_result = $multiply_by5->(10); # 50
