import std.stdio;

void main() {
    auto get_rectangle_area_v1(T)(T rectangleWidth, T rectangleLength) {
        return rectangleWidth * rectangleLength;
    }
    auto get_rectangle_area_v2(T)(T rectangleWidth, T rectangleLength) => rectangleWidth * rectangleLength;

    // auto get_rectangle_area_v3 = function (int rectangleWidth, int rectangleLength) {
    //     return rectangleWidth * rectangleLength;
    // };

    // auto get_rectangle_area_v4 = (auto rectangleWidth, auto rectangleLength) {
    //     return rectangleWidth * rectangleLength;
    // };

    // auto get_rectangle_area_v5 = function (auto rectangleWidth, auto rectangleLength) => rectangleWidth * rectangleLength;

    // auto get_rectangle_area_v6 = (auto rectangleWidth, auto rectangleLength) => rectangleWidth * rectangleLength;
    writeln(get_rectangle_area_v1(3, 5));
    writeln(get_rectangle_area_v2(3, 5));
}