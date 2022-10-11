functor
import
    Application(exit:Exit)
    System
define
    % declare do not work inside functors. Relying on the already present define and local when nessesary

    % Procedural abstraction - the ability to convert any statement into a procedure value.
    
    % Task 1:
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

    % Instantiation - the ability to return procedure values as results from a procedure call.

    % Embedding - the ability to put procedure values in data structures.

    % Tail Recursion - the ability to write recursive procedures without using stack space.

    {Exit 0}
end
