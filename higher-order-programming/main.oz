functor
import
    Application(exit:Exit)
    System
define
    % Procedural abstraction - the ability to convert any statement into a procedure value.
    proc {QuadraticEquation A B C ?RealSol ?X1 ?X2}
        if {Number.pow B 2.} - 4. * A * C < 0 then
            RealSol = false
            {System.show "No real solutions"}
        elseif {Number.pow B 2.} - 4 * A * C == 0 then
            X1 = ~B / (2. * A)
            RealSol = true
        else
            X1 = (~B - {Float.sqrt {Number.pow B 2.} - 4. * A * C}) / (2. * A)
            X2 = (~B + {Float.sqrt {Number.pow B 2.} - 4. * A * C}) / (2. * A)
            RealSol = true
        end
    end
    
    local RealSol X1 X2 in
        {QuadraticEquation 1. -3. ~4. RealSol X1 X2}
        {System.show 'RealSol: ' # RealSol}
        {System.show 'x1: ' # X1}
        {System.show 'x2: ' # X2}
    end

    % Genericity - the ability to pass procedure values as argumens to a procedure call.

    % Instantiation - the ability to return procedure values as results from a procedure call.

    % Embedding - the ability to put procedure values in data structures.

    % Tail Recursion - the ability to write recursive procedures without using stack space.
end
