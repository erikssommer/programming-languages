% Task 1: Threads
functor
import
    Application(exit:Exit)
    System
define
    % a)
    local A = 10 B = 20 C = 30 in
        {System.show C} % Printed first

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

        {System.show C * 100} % Printed second
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

    % b) 
    % Q: Explain with your own words how execution proceeds and why the result is as such. Would it be possible to have a different sequence printed as output? 
    % A: The code executes in a non-deterministic way. The threads are executed in a random order. The scheduler picks one among all the ready threads to execute next. It is possible to have a different sequence printed as output, but it is not guaranteed.
    
    % c) Execute the following code in Mozart and observe the results. What sequence of numbers gets printed as output of the Oz environment?
    local A B C in
        thread
            A = 2
            {System.show A}
        end
        thread
            B = A * 10
            {System.show B}
        end
        
        C=A+B
        {System.show C}
    end

    /*
    Output:
        2
        20
        22
     */
    

    {Exit 0}
end