function println(varargin)
    result = {};
    for parameterIndex = 1:1:length(varargin)
        if isa(varargin{parameterIndex}, "double")
            result = [result, num2str(varargin{parameterIndex})];
            continue
        end
        if (varargin{parameterIndex} == true)
            result = [result, "true"];
            continue
        end
        if (varargin{parameterIndex} == false)
            result = [result, "false"];
            continue
        end
        result = [result, varargin{parameterIndex}];
    end
    result = [result{:}];
    disp(result);
end

% while loop

i = 1;
while (true)
    if (i == 2)
        i = i + 1;
        if (i > 5) break; end
        continue
    end
    println("while loop v1, i is ", i);
    i = i + 1;
    if (i > 5) break; end
end

i = 1;
while (i <= 5)
    if (i == 2)
        i = i + 1;
        continue
    end
    println("while loop v2, i is ", i);
    i = i + 1;
end

% for loop

for i = 1:1:5 % start:step:stop
    if (i == 2) continue; end
    println("for loop ascending, i is ", i);
end

for i = 5:-1:1 % start:step:stop
    if (i == 2) continue; end
    println("for loop descending, i is ", i);
end
