print("\n# Custom Error and Error Handling in Raku", "\n");

sub give-me-respect(Str $argument) {
    # Custom Error
    die("Error: You should give me \"respect\"!") if ($argument ne "respect");
    return "Thank you for giving me \"respect\"!";
}

my $response;

# Error Handling
try {
    $response = give-me-respect("bool!");
    print($response, "\n");
    CATCH {
        default {
            print($_.Str, "\n");
        }
    };
}
print("I'm sorry!", "\n");

# Without Error Handling
$response = give-me-respect("bool!");
# this will never executed
print($response, "\n");
print("I'm sorry!");
