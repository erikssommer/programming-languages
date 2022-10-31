% Task 1: Threads
functor
import
    Application(exit:Exit)
    System
define
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

    /*
    b) 
    Q: Explain with your own words how execution proceeds and why the result is as such.
        Would it be possible to have a different sequence printed as output? 
    A: The code executes in a non-deterministic way. The threads are executed in a random order.
        The scheduler picks one among all the ready threads to execute next. 
        It is possible to have a different sequence printed as output, but it is not guaranteed.
        This is largely due to the fact the threads do not have any dependencies on each other.
    */
    
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

    /*
    d) 
    Q: Explain with your own words how execution proceeds and why the result is as such. Would it be possible to have a different sequence printed as output? Explain your answer.
    A: The code is executed in the same way as the code in task a), but now the second thread depends on the first, so it is executed in the same order every time.
        There wil therefor allways be the same sequence printed as output.
    */
    
    {Exit 0}
end