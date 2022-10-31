functor
import
    Application(exit:Exit)
    System
define
    % Streams
    % Task 2
    % a) Implement a function fun {Enumerate Start End} that generates, asynchronously, a stream of numbers from Start until End. Hint: You can use the thread ... end statement inside the definition of the function, to wrap the iterative process that generates the numbers.
    
    fun {Enumerate Start End}
        if Start =< End then
            Start|{Enumerate Start+1 End}
        else nil end
    end

    {System.show {Enumerate 1 5}} % should print [1 2 3 4 5]

    {Exit 0}
end