use JSON::Fast;

sub json-stringify-v1($anything) {
    my $json-string = to-json($anything, :pretty(False));
    $json-string ~~ s:g/\,/\, /;
    $json-string ~~ s:g/\:/\: /;
    return $json-string;;
}

my &pretty-json-stringify-v1 = -> $anything { to-json($anything, :pretty(True), :spacing(4)) };

my $pretty-json-stringify-v2 = -> $anything { to-json($anything, :pretty(True), :spacing(4)) };

my $pretty-json-stringify-v3 = sub ($anything) { to-json($anything, :pretty(True), :spacing(4)) };

sub pretty-json-stringify-v4($anything) { to-json($anything, :pretty(True), :spacing(4)) }

sub json-stringify-v2($anything, Bool :$pretty = False) {
    use JSON::Fast;
    return to-json($anything, :pretty(True), :spacing(4)) if ($pretty === True);
    my $json-string = to-json($anything, :pretty(False));
    $json-string ~~ s:g/\,/\, /;
    $json-string ~~ s:g/\:/\: /;
    return $json-string;;
}

my $something;
$something = [1, 2, 3];
print("something: ", json-stringify-v1($something), "\n");
print("something: ", json-stringify-v2($something, :pretty(True)), "\n");
print("something: ", json-stringify-v2($something, :pretty(False)), "\n");
print("something: ", &pretty-json-stringify-v1($something), "\n");
print("something: ", $pretty-json-stringify-v2($something), "\n");
print("something: ", pretty-json-stringify-v4($something), "\n");
$something = {"foo" => "bar"};
print("something: ", json-stringify-v1($something), "\n");
print("something: ", json-stringify-v2($something, :pretty(True)), "\n");
print("something: ", json-stringify-v2($something, :pretty(False)), "\n");
print("something: ", &pretty-json-stringify-v1($something), "\n");
print("something: ", $pretty-json-stringify-v2($something), "\n");
print("something: ", pretty-json-stringify-v4($something), "\n");
