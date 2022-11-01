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
    {System.showInfo "Task 2a)"}
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
    {System.showInfo "Task 2b)"}
    fun {GenerateOdd Start End} Stream in
        % testing if there is still numbers left to check
        if Start =< End then
            % creating stream of numbers
            Stream = {Enumerate Start End}
            % testing if first number of stream is odd
            if {Int.isOdd Stream.1} then
                % if it is, then we add it to the stream and increment the starting point
                Stream.1|thread {GenerateOdd Stream.1+1 End} end
            else
                % if it is not, then we increment the starting point
                thread {GenerateOdd Stream.1+1 End} end
            end
        % if there is no numbers left to check, then we return nil
        else nil end
    end

    local Res1 Res2 in
        thread Res1 = {GenerateOdd 1 5} end
        {ShowStream Res1} % prints [1 3 5]
        thread Res2 = {GenerateOdd 4 4} end 
        {ShowStream Res2} % prints nil
    end

    {Delay 100} % wait for 100 milliseconds

    % Task 3
    % a) 
    {System.showInfo "Task 3a)"}
    % produces a stream of all the prime numbers up to the number N. ListDivisorOf must be implemented as a consumer of Enumerate
    fun {ListDivisorsOf Number} Stream DivisorOf in
        % base case
        if Number == 1 then nil
        else
            % creating stream of all numbers between 1 and Number
            Stream = {Enumerate 1 Number}
            % function for iterating the stream
            fun {DivisorOf Start Number} NewStream in
                % testing if Start is a divisor of Number
                if Number mod Start == 0 then
                    % if it is, then add it to the stream
                    Start|thread {DivisorOf Start+1 Number} end
                else
                    % if it is not, then skip it and move to next number in stream
                    thread {DivisorOf Start+1 Number} end
                end
            end
            % calling the function with the first number in stream and Number
            {DivisorOf Stream.1 Number}
        end
    end

    local Res in
        thread Res = {ListDivisorsOf 10} end
        {ShowStream Res} % prints [1 2 5 10]
    end

    {Delay 100} % wait for 100 milliseconds

    {System.showInfo "Task 3b)"}

    % b)
    fun {ListPrimesUntil N} PrimeOf in
        % function for iterating the stream
        fun {PrimeOf Stream}
            case Stream of nil then nil 
            [] Head|Tail then InStream in
                if Head =< N then
                    % filtering out nonprimes from streams, until only primes remain
                    thread InStream={Filter Tail fun {$ Y} Y mod Head \= 0 end} end
                else InStream = Tail end
                Head|thread {PrimeOf InStream} end
            end
        end
        % creating streem of all numbers between 2 and N
        {PrimeOf {Enumerate 2 N}}
    end
  
    local Res in
        thread Res = {ListPrimesUntil 10} end
        {ShowStream Res} % prints [2 3 5 7]
    end

    {Exit 0}
end