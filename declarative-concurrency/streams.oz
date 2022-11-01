functor
import
    Application(exit:Exit)
    System
define
    % Streams
    % Task 2

    % Method for visualizing streams
    proc {ShowStream List}
        case List of _|Tail then
            {System.show List.1}
            thread {ShowStream Tail} end
        else
            skip 
        end
    end

    % a)
    fun {Enumerate Start End}
        if Start =< End then
            Start|thread {Enumerate Start+1 End} end
        else nil end
    end

    local Res in
        thread Res = {Enumerate 1 5} end
        {ShowStream Res} % prints [1 2 3 4 5]
    end

    {Delay 100} % wait for 100 milliseconds
    
    % b)
    fun {GenerateOdd Start End} Stream in
        if Start =< End then
            Stream = {Enumerate Start End}
            if {Int.isOdd Stream.1} then
                Stream.1|thread {GenerateOdd Stream.1+1 End} end
            else
                thread {GenerateOdd Stream.1+1 End} end
            end
        else nil end
    end

    local Res1 Res2 in
        thread Res1 = {GenerateOdd 1 5} end
        {ShowStream Res1} % prints [1 3 5]
        thread Res2 = {GenerateOdd 4 4} end 
        {ShowStream Res2} % prints nil
    end

    % Task 3
    % a) 
    % fun {ListDivisorsOf Number}

    {Exit 0}
end