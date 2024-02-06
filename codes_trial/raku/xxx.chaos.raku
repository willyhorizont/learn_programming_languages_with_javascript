my $my_favorite_number = 66;
print("my_favorite_number is " ~ $my_favorite_number ~ "\n");
print("my_favorite_number is $my_favorite_number\n");
print("my_favorite_number is {$my_favorite_number}\n");
print("my_favorite_number is {$my_favorite_number + 3}\n");
my $stuff1 = "bag";
print("\$stuff1 type is {$stuff1.^name}\n");
print("\$stuff1 length is {$stuff1.chars}\n");
my $stuff2;
print("\$stuff2 type is {$stuff2.^name}\n");
print("\$stuff1 has value {?$stuff1}\n");
print("\$stuff2 has value {?$stuff2}\n");

my $stuff3 = "purple lambo";
print("\$stuff3 first 3 letters {$stuff3.substr(0, 3)}\n");
print("\$stuff3 first 3 letters {$stuff3.substr: 0, 3}\n");

my $indent1 = "<space>" x 4;
print("{$indent1}\n");

my @arr1 = (1, 2, 3, 4);
print("{@arr1}\n");
print("\@arr1 length is {@arr1.elems}\n");
print("{@arr1[0]}\n");

for (1..5).kv -> $k, $v {
    print("\$k: {$k}, \$v: {$v}\n");
}

my ($arr1a, $arr1b, $arr1c, $arr1d) = @arr1;
print("\$arr1a is {$arr1a}\n");
print("\$arr1b is {$arr1b}\n");
print("\$arr1c is {$arr1c}\n");
print("\$arr1d is {$arr1d}\n");
