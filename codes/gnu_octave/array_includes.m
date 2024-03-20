function stringifyresult = stringify(parameter)
    if isempty(parameter)
        stringifyresult = "null";
        return;
    end
    if ischar(parameter)
        stringifyresult = cstrcat("""", parameter, """");
        return;
    end
    if ischar(parameter)
        stringifyresult = cstrcat("""", parameter, """");
        return;
    end
    if isnumeric(parameter)
        stringifyresult = num2str(parameter);
        return;
    end
    if (islogical(parameter) && parameter == true)
        stringifyresult = "true";
        return;
    end
    if (islogical(parameter) && parameter == false)
        stringifyresult = "false";
        return;
    end
    if iscell(parameter)
        if isempty(parameter)
            stringifyresult = "[]";
            return;
        end
        currentresult = "[";
        for arrayitemindex = (1:1:numel(parameter))
            arrayitem = parameter{arrayitemindex};
            currentresult = cstrcat(currentresult, stringify(arrayitem));
            if (arrayitemindex ~= numel(parameter))
                currentresult = cstrcat(currentresult, ", ");
            end
        end
        stringifyresult = cstrcat(currentresult, "]");
        return;
    end
    if isstruct(parameter)
        if (numel(fieldnames(parameter)) == 0)
            stringifyresult = "{}";
            return;
        end
        currentresult = "{";
        objectkeys = fieldnames(parameter);
        for entryindex = (1:1:numel(objectkeys))
            objectkey = objectkeys{entryindex};
            objectvalue = parameter.(objectkey);
            currentresult = cstrcat(currentresult, """", objectkey, """: ", stringify(objectvalue));
            if (entryindex ~= numel(objectkeys))
                currentresult = cstrcat(currentresult, ",");
            end
        end
        stringifyresult = cstrcat(currentresult, "}");
        return;
    end
    stringifyresult = "null";
end

function sprint(varargin)
    currentresult = "";
    for parameterindex = (1:1:numel(varargin))
        parameter = varargin{parameterindex};
        if (iscell(parameter) && (numel(parameter) == 1))
            parameternew = stringify(parameter{1});
            parameternew = strrep(parameternew, """{", "{");
            parameternew = strrep(parameternew, """[", "[");
            parameternew = strrep(parameternew, "}""", "}");
            parameternew = strrep(parameternew, "]""", "]");
            currentresult = cstrcat(currentresult, parameternew);
            continue;
        end
        currentresult = cstrcat(currentresult, parameter);
    end
    disp(currentresult);
end

function arrayincludesv1result = arrayincludesv1(searchelement, anarray)
    % JavaScript-like Array.includes() function
    iselementfound = false;
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        if (isnumeric(arrayitem) && isnumeric(searchelement) && (arrayitem == searchelement))
            iselementfound = true;
            break;
        end
        if strcmp(arrayitem, searchelement)
            iselementfound = true;
            break;
        end
    end
    arrayincludesv1result = iselementfound;
end

function arrayincludesv2result = arrayincludesv2(searchelement, anarray)
    % JavaScript-like Array.includes() function
    for arrayitemindex = (1:1:numel(anarray))
        arrayitem = anarray{arrayitemindex};
        if (isnumeric(arrayitem) && isnumeric(searchelement) && (arrayitem == searchelement))
            arrayincludesv2result = true;
            return;
        end
        if strcmp(arrayitem, searchelement)
            arrayincludesv2result = true;
            return;
        end
    end
    arrayincludesv2result = false;
end

sprint(sprintf("\n"), "% JavaScript-like Array.includes() in GNU Octave Cell-Array");

myfriends = {"Alisa", "Trivia"};
sprint("my friends: ", {myfriends});

sprint("% using JavaScript-like Array.includes() function ""arrayincludesv1""");

aname = "Alisa";
ismyfriend = arrayincludesv1(aname, myfriends);
sprint("is my friends includes ", {aname}, ": ", {ismyfriend});
% is my friends includes "Alisa": true

aname = "Trivia";
ismyfriend = arrayincludesv1(aname, myfriends);
sprint("is my friends includes ", {aname}, ": ", {ismyfriend});
% is my friends includes "Trivia": true

aname = "Tony";
ismyfriend = arrayincludesv1(aname, myfriends);
sprint("is my friends includes ", {aname}, ": ", {ismyfriend});
% is my friends includes "Tony": false

aname = "Ezekiel";
ismyfriend = arrayincludesv1(aname, myfriends);
sprint("is my friends includes ", {aname}, ": ", {ismyfriend});
% is my friends includes "Ezekiel": false

sprint("% using JavaScript-like Array.includes() function ""arrayincludesv2""");

aname = "Alisa";
ismyfriend = arrayincludesv2(aname, myfriends);
sprint("is my friends includes ", {aname}, ": ", {ismyfriend});
% is my friends includes "Alisa": true

aname = "Trivia";
ismyfriend = arrayincludesv2(aname, myfriends);
sprint("is my friends includes ", {aname}, ": ", {ismyfriend});
% is my friends includes "Trivia": true

aname = "Tony";
ismyfriend = arrayincludesv2(aname, myfriends);
sprint("is my friends includes ", {aname}, ": ", {ismyfriend});
% is my friends includes "Tony": false

aname = "Ezekiel";
ismyfriend = arrayincludesv2(aname, myfriends);
sprint("is my friends includes ", {aname}, ": ", {ismyfriend});
% is my friends includes "Ezekiel": false

sprint("% using GNU Octave Array.includes() built-in function ""find"" and ""cellfun""");

aname = "Alisa";
ismyfriend = ~isempty(find(cellfun(@(myfriendname) strcmp(myfriendname, aname), myfriends), 1));
sprint("is my friends includes ", {aname}, ": ", {ismyfriend});
% is my friends includes "Alisa": true

aname = "Trivia";
ismyfriend = ~isempty(find(cellfun(@(myfriendname) strcmp(myfriendname, aname), myfriends), 1));
sprint("is my friends includes ", {aname}, ": ", {ismyfriend});
% is my friends includes "Trivia": true

aname = "Tony";
ismyfriend = ~isempty(find(cellfun(@(myfriendname) strcmp(myfriendname, aname), myfriends), 1));
sprint("is my friends includes ", {aname}, ": ", {ismyfriend});
% is my friends includes "Tony": false

aname = "Ezekiel";
ismyfriend = ~isempty(find(cellfun(@(myfriendname) strcmp(myfriendname, aname), myfriends), 1));
sprint("is my friends includes ", {aname}, ": ", {ismyfriend});
% is my friends includes "Ezekiel": false
