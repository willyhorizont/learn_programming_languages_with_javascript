<?php

$item1 = "something";
echo "item1: ", $item1, "\n";
// original $item1 can't be mutated, because $item1 passed by value
(function () use ($item1) {
    $item1 = "anything";
    echo "item1: ", $item1, "\n";
})();
echo "item1: ", $item1, "\n";

$item2 = "something";
echo "item2: ", $item2, "\n";
// original $item2 can be mutated, because $item2 passed by reference
(function () use (&$item2) {
    $item2 = "anything";
    echo "item2: ", $item2, "\n";
})();
echo "item2: ", $item2, "\n";

$item3 = "something";
echo "item3: ", $item3, "\n";
// original $item3 can be mutated, because $item3 passed by reference
(function () {
    global $item3;
    $item3 = "anything";
    echo "item3: ", $item3, "\n";
})();
echo "item3: ", $item3, "\n";
