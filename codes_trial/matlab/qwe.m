% works in Octave %%%
% sth. must be *before* a (local) function is declared
1; % or "2;" or "1+1;" or whatever

% local function must be declared *before* it is run in Octave
function retval = pluse(input1, input2)
  retval = input1 + input2;
end % or "endfunction"

% Now you can use the local function
pluse(1, 2)

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