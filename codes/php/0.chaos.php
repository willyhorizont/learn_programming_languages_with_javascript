<?php

$person = [
    "name" => "John",
    "age" => 30,
    "city" => "New York"
];

// Using list() construct
list("name" => $name, "age" => $age, "city" => $city) = $person;

// Using square bracket syntax
["name" => $name, "age" => $age, "city" => $city] = $person;

// Output the values
echo "Name: $name, Age: $age, City: $city";
