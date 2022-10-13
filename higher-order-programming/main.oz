functor
import
    Application(exit:Exit)
    System
define
    % declare do not work inside functors. Relying on the already present define and local when nessesary

    % Procedural abstraction - the ability to convert any statement into a procedure value.
    
    % Task 1:
    {System.showInfo '\nTask 1'}
    % a)
    % Procedural that solves a quadratic equation.
    proc {QuadraticEquation A B C ?RealSol ?X1 ?X2}
        if {Number.pow B 2.} - 4. * A * C < 0. then
            {System.showInfo "No real solutions"}
            RealSol = false
        elseif {Number.pow B 2.} - 4. * A * C == 0. then
            X1 = ~B / (2. * A)
            RealSol = true
        else
            X1 = (~B - {Float.sqrt {Number.pow B 2.} - 4. * A * C}) / (2. * A)
            X2 = (~B + {Float.sqrt {Number.pow B 2.} - 4. * A * C}) / (2. * A)
            RealSol = true
        end
    end
    
    % b)
    % Testing the procedure
    local RealSol X1 X2 in
        {QuadraticEquation 2. 1. ~1. RealSol X1 X2}
        {System.show 'RealSol: ' #RealSol}
        {System.show 'x1: '#X1}
        {System.show 'x2: '#X2}
    end

    local RealSol X1 X2 in
        {QuadraticEquation 2. 1. 2. RealSol X1 X2}
        {System.show 'RealSol: ' #RealSol}
        {System.show 'x1: '#X1}
        {System.show 'x2: '#X2}
    end

    % c) 
    /*
    Q: Why are procedural abstractions useful?
    A: They are useful because they allow us to create a procedure that can be used in many different situations.
    */

    % d)
    /*
    Q: What is the difference between a procedure and a function?
    A: A procedure is a void function that does not return a value while a function returns a value.
    */
    
    % Genericity - the ability to pass procedure values as argumens to a procedure call.

    % Task 2
    {System.showInfo '\nTask 2'}
    local Sum in
        fun {Sum List}
            case List of Head|Tail then
                Head + {Sum Tail}
            [] nil then
                0
            end
        end
        % Testing implementation
        {System.show {Sum [1 2 3 4 5]}}
        {System.show {Sum [1 2 3 4 5 6 7 8 9 10]}}
    end

    % Task 3
    {System.showInfo '\nTask 3'}
    % a) Implement fun {RightFold List Op U}
    % b) Comment on implementation
    % Define a function that takes a list, function and the neutral elements for the operation
    fun {RightFold List Op U}
        % Looking at the head and tail of the list
        case List of Head|Tail then
            % Applying the function to the head and the result of the function applied to the tail
            {Op Head {RightFold Tail Op U}}
        % If the list is empty
        [] nil then
            % Returning the neutral element
            U
        end
    end

    % c) Implement fun {Length List} and {Sum List} using RightFold.
    fun {Sum List}
        {RightFold List fun {$ X Y} X + Y end 0}
    end

    fun {Lenght List}
        {RightFold List fun {$ X Y} 1 + Y end 0}
    end

    {System.show {Sum [0 1 2 3 4]}}
    {System.show {Length [1 2 3 4]}}

    % Instantiation - the ability to return procedure values as results from a procedure call.

    % Embedding - the ability to put procedure values in data structures.

    % Tail Recursion - the ability to write recursive procedures without using stack space.

    {Exit 0}
end
