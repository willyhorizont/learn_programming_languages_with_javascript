function asd
    nested1
    nested2
 
    function nested1
       disp('nested 1')
    end
 
    function nested2
       disp('nested 2')
    end

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

    function create_new_game_result = create_new_game(initial_credit)
        current_credit = initial_credit;
        println("initial credit: ", initial_credit);
        function inner()
            current_credit = current_credit - 1;
            if (current_credit == 0)
                println("not enough credit");
            else
                println("playing game, ", current_credit," credit(s) remaining");
            end
        end
        create_new_game_result = @inner
    end
    play_game = create_new_game(3)
    play_game()
    play_game()
    play_game()
end