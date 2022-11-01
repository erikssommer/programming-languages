% The implemented tasks are able to be run in the standard Emacs environment (Mozart OPI)
declare ShowStream Enumerate GenerateOdd ListDivisorsOf ListPrimesUntil Primes in

{System.showInfo "-------- Threads --------"}
{System.showInfo "Task 1"}

{System.showInfo "a)"}
% a)
local A = 10 B = 20 C = 30 in
    {System.show C} % Prints first

    thread
        {System.show A} % Prints third
        {Delay 100}
        {System.show A * 10} % Prints sixth and last
    end

    thread
        {System.show B} % Prints forth
        {Delay 100}
        {System.show B * 10} % Prints fith
    end

    {System.show C * 100} % Prints second
end

/* 
Output:
    30
    3000
    10
    20
    200
    100
*/

{Delay 100} % Wait for threads to finish

{System.showInfo "b) (Text in code)"}

/*
    b) 
    Q: Explain with your own words how execution proceeds and why the result is as such.
        Would it be possible to have a different sequence printed as output? 
    A: The code executes in a non-deterministic way. The threads are executed in a random order.
        The scheduler picks one among all the ready threads to execute next. 
        It is possible to have a different sequence printed as output, but it is not guaranteed.
        This is largely due to the fact the threads do not have any dependencies on each other.
*/

{System.showInfo "c)"}

% c) Execute the following code in Mozart and observe the results. What sequence of numbers gets printed as output of the Oz environment?
    local A B C in
        thread
            A = 2
            {System.show A} % Prints first
        end
        thread
            B = A * 10
            {System.show B} % Prints second
        end
        
        C=A+B
        {System.show C} % Prints third
    end

    /*
    Output:
        2
        20
        22
     */

{System.showInfo "d) (Text in code)"}
/*
    d) 
    Q: Explain with your own words how execution proceeds and why the result is as such. Would it be possible to have a different sequence printed as output? Explain your answer.
    A: The code is executed in the same way as the code in task a), but now the second thread depends on the first, so it is executed in the same order every time.
        There wil therefor allways be the same sequence printed as output.
*/

{System.showInfo "-------- Streams --------"}
{System.showInfo "Task 2"}
proc {ShowStream List}
    case List of _|Tail then
        {System.show List.1}
        thread {ShowStream Tail} end
    else
        skip 
    end
end

% a)
{System.showInfo "a)"}
fun {Enumerate Start End}
    if Start =< End then
        Start|thread {Enumerate Start+1 End} end
    else nil end
end
local Res in
    thread Res = {Enumerate 1 5} end
    {ShowStream Res} % prints [1 2 3 4 5]
end

{Delay 100} % Wait for threads to finish

% b)
{System.showInfo "b)"}
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

{Delay 100} % Wait for threads to finish

% Task 3
{System.showInfo "Task 3"}
% a)
{System.showInfo "a)"}
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


{Delay 100} % Wait for threads to finish

{System.showInfo "b)"}
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

{Delay 100} % Wait for threads to finish

% Task 4
{System.showInfo "-------- Lazy Evaluation --------"}
{System.showInfo "Task 4"}

% a)
{System.showInfo "a)"}
local Enumerate in
    % generates an infinite stream of numbers, starting from 1.
    fun lazy {Enumerate} Generate in
        fun lazy {Generate N}
            N|thread {Generate N+1} end
        end
        {Generate 1}
    end

    % for testing infinite stream of numbers
    {System.showInfo "Not printing all numbers here, but the function is used in b)"}
    /*
    local Res in
        thread Res = {Enumerate} end
        {ShowStream Res}
    end
    */

    {System.showInfo "b)"}
    fun lazy {Primes} GenPrimes in
        fun lazy {GenPrimes N Stream}
            case Stream of nil then nil
            [] X|Xr then Ys in
                % making sure to start at 2
                if X >= N then
                    thread Ys={Filter Xr fun {$ Y} Y mod X \= 0 end} end
                    X|thread {GenPrimes N Ys} end
                else 
                    % moving to a number equal or larger than 2
                    thread {GenPrimes N Xr} end
                end
            end
        end
        % generating the stream of primes starting from 2
        % primes is a consumer of the stream produced by Enumerate
        {GenPrimes 2 {Enumerate}}
    end
end

% printing infinite stream of primes
local Res in
    thread Res = {Primes} end
    {ShowStream Res}
end