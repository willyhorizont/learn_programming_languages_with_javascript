function fun = createPlusOneFunc

    x = 0; % x is captured
    fun = @inner

    function out = inner(y)
        x = x+y;
        out = x;
    end

end

fun = createPlusOneFunc();
out = fun(1) % Increments captured variable state by 1.
out = fun(2) % Increments captured variable state by 2.