function stringrepeatresult = stringrepeat(astring, count)
    result = "";
    for i = (1:1:count) % (start:step:stop)
        result = strcat(result, astring);
    end
    stringrepeatresult = result;
end

function arrayreduceresult = arrayreduce(callbackfunction, anarray, initialvalue)
    % JavaScript-like Array.reduce() function
    currentresult = initialvalue;
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
        arrayitem = anarray{arrayitemindex};
        currentresult = callbackfunction(currentresult, arrayitem, arrayitemindex, anarray);
    end
    arrayreduceresult = currentresult;
end

function optionalchainingresult = optionalchaining(anything, varargin)
    % JavaScript-like Optional Chaining Operator (?.) function
    % varargin == objectpropertiesarray
    if ((~isstruct(anything) && ~iscell(anything)) || isempty(varargin))
        optionalchainingresult = anything;
        return;
    end
    function arrayreducecallbackresult = arrayreducecallback(currentresult, currentitem, varargin)
        % varargin == (arrayitemindex, anarray)
        if ((isempty(currentresult) && isstruct(anything) && (isstring(currentitem) || ischar(currentitem))) && isfield(anything, currentitem))
            arrayreducecallbackresult = anything.(currentitem);
            return;
        end
        if (isempty(currentresult) && iscell(anything) && isnumeric(currentitem) && (currentitem >= 1) && (numel(anything) > currentitem))
            arrayreducecallbackresult = anything{currentitem};
            return;
        end
        if ((isstruct(currentresult) && (isstring(currentitem) || ischar(currentitem))) && isfield(currentresult, currentitem))
            arrayreducecallbackresult = currentresult.(currentitem);
            return;
        end
        if (iscell(currentresult) && isnumeric(currentitem) && (currentitem >= 1) && (numel(currentresult) > currentitem))
            arrayreducecallbackresult = currentresult{currentitem};
            return;
        end
        arrayreducecallbackresult = {};
    end
    optionalchainingresult = arrayreduce(@arrayreducecallback, varargin, {});
end

function ternaryresult = ternary(truecondition, valueifconditionistrue, valueifconditionisfalse)
    if (islogical(truecondition) && (truecondition == true))
        ternaryresult = valueifconditionistrue;
        return;
    end
    ternaryresult = valueifconditionisfalse;
end

function jsonstringifyresult = jsonstringify(anything, additionalparameter)
    indentlevel = 0;
    function jsonstringifyinnerresult = jsonstringifyinner(anythinginner, prettyinner, indentinner)
        if isempty(anythinginner)
            jsonstringifyinnerresult = "null";
            return;
        end
        if isstring(anythinginner)
            jsonstringifyinnerresult = strcat("""", anythinginner, """");
            return;
        end
        if ischar(anythinginner)
            jsonstringifyinnerresult = strcat("""", anythinginner, """");
            return;
        end
        if isnumeric(anythinginner)
            jsonstringifyinnerresult = num2str(anythinginner);
            return;
        end
        if (islogical(anythinginner) && (anythinginner == true))
            jsonstringifyinnerresult = "true";
            return;
        end
        if (islogical(anythinginner) && (anythinginner == false))
            jsonstringifyinnerresult = "false";
            return;
        end
        if iscell(anythinginner)
            if isempty(anythinginner)
                jsonstringifyinnerresult = "[]";
                return;
            end
            indentlevel = indentlevel + 1;
            result = ternary((pretty == true), strcat("[", sprintf("\n"), stringrepeat(indentinner, indentlevel)), "[");
            for arrayitemindex = (1:1:numel(anythinginner)) % (start:step:stop)
                arrayitem = anythinginner{arrayitemindex};
                result = strcat(result, jsonstringifyinner(arrayitem, prettyinner, indentinner));
                if (arrayitemindex ~= numel(anythinginner))
                    result = ternary((pretty == true), strcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel)), strcat(result, ", "));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), strcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "]"), strcat(result, "]"));
            jsonstringifyinnerresult = result;
            return;
        end
        if isstruct(anythinginner)
            if (numel(fieldnames(anythinginner)) == 0)
                jsonstringifyinnerresult = "{}";
                return;
            end
            indentlevel = indentlevel + 1;
            result = ternary((pretty == true), strcat("{", sprintf("\n"), stringrepeat(indentinner, indentlevel)), "{");
            objectkeys = fieldnames(anythinginner);
            for objectentryindex = (1:1:numel(objectkeys)) % (start:step:stop)
                objectkey = objectkeys{objectentryindex};
                objectvalue = anythinginner.(objectkey);
                result = strcat(result, """", objectkey, """: ", jsonstringifyinner(objectvalue, prettyinner, indentinner));
                if (objectentryindex ~= numel(objectkeys))
                    result = ternary((pretty == true), strcat(result, ",", sprintf("\n"), stringrepeat(indentinner, indentlevel)), strcat(result, ", "));
                end
            end
            indentlevel = indentlevel - 1;
            result = ternary((pretty == true), strcat(result, sprintf("\n"), stringrepeat(indentinner, indentlevel), "}"), strcat(result, "}"));
            jsonstringifyinnerresult = result;
            return;
        end
        jsonstringifyinnerresult = "null";
    end
    pretty = false;
    indent = "    ";
    if isempty(additionalparameter)
        jsonstringifyresult = jsonstringifyinner(anything, true, indent);
        return;
    end
    if isstruct(additionalparameter)
        pretty = optionalchaining(additionalparameter, "pretty");
        indent = optionalchaining(additionalparameter, "indent");
        pretty = ternary(isempty(pretty), false, pretty);
        indent = ternary(isempty(indent), "    ", indent);
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    if (islogical(additionalparameter) && (additionalparameter == true))
        pretty = true;
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    if (islogical(additionalparameter) && (additionalparameter == false))
        pretty = false;
        jsonstringifyresult = jsonstringifyinner(anything, pretty, indent);
        return;
    end
    jsonstringifyresult = jsonstringifyinner(anything, false, indent);
end

function sprint(varargin)
    currentresult = "";
    for parameterindex = (1:1:numel(varargin)) % (start:step:stop)
        parameter = varargin{parameterindex};
        if (iscell(parameter) && (numel(parameter) == 1))
            parameternew = jsonstringify(parameter{1}, false);
            parameternew = strrep(parameternew, """{", "{");
            parameternew = strrep(parameternew, """[", "[");
            parameternew = strrep(parameternew, "}""", "}");
            parameternew = strrep(parameternew, "]""", "]");
            currentresult = strcat(currentresult, parameternew);
            continue;
        end
        if (~isstring(parameter) && ~ischar(parameter))
            error("Non string argument must be wrapped in {}");
            continue;
        end
        currentresult = strcat(currentresult, parameter);
    end
    disp(currentresult);
end

function arrayincludesv1result = arrayincludesv1(searchelement, anarray)
    % JavaScript-like Array.includes() function
    iselementfound = false;
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
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
    for arrayitemindex = (1:1:numel(anarray)) % (start:step:stop)
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

sprint(sprintf("\n"), "% JavaScript-like Array.includes() in Matlab Cell-Array");

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

sprint("% using Matlab Array.includes() built-in function ""find"" and ""cellfun""");

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
