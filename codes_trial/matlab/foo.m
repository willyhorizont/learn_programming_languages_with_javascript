function y = foo()
    x = 10;
    bar();
    y = x;
  
    function bar()
      x = 20;
    end
end

foo()
