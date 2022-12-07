functor
import
    Application(exit:Exit)
    System
define

    % The question mark in front of the output argument R is just to make the definition easier to read,
    % and has no effect on execution
    proc {MultiplyByTwo B ?R}
        R = B * 2
    end

    local R in
        {MultiplyByTwo 2 R}
        {System.show R}
    end 

    {System.show {MultiplyByTwo 4}}

    {Exit 0}
end