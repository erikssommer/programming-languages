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
    % produces a stream of all the prime numbers up to the number N. ListDivisorOf must be implemented as a consumer of Enumerate
    fun {ListDivisorsOf Number} Stream DivisorOf in
        if Number == 1 then nil
        else
            Stream = {Enumerate 1 Number}
            fun {DivisorOf Start Number} NewStream in
                if Number mod Start == 0 then
                    Start|thread {DivisorOf Start+1 Number} end
                else
                    thread {DivisorOf Start+1 Number} end
                end
            end
            {DivisorOf Stream.1 Number}
        end
    end

    local Res in
        thread Res = {ListDivisorsOf 10} end
        {ShowStream Res} % prints [1 2 5 10]
    end

    {Exit 0}
end