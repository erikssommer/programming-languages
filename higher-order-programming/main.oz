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

    fun {Length List}
        {RightFold List fun {$ X Y} 1 + Y end 0}
    end

    % d)
    /*
    Q: For the Sum and Lenght operations, would LeftFold (a left-associative fold) and RightFold give different
        results? Can you provide an example of an operation for which the two folds do not produce the same result?
    A: The operations Sum and Length does not depent on right-fold and would work with left-fold because the order of grouping the numbers does not matter for addition. The same holds for multiplication.
        The same can not be said about subtraction and division.
        For example, if we have the list [1 2 3 4] and we want to subtract the numbers in the list from each other, we would get the result -8 with right-fold and -2 with left-fold.
    */

    % e)
    /*
    Q: What is an appropriate value for U when using RightFold to implement the product of list elements?
    A: An appropriate value for U is 1. It will not alter the result or make it 0.
    */

    % Testing the implementation
    {System.show {Sum [0 1 2 3 4]}}
    {System.show {Length [1 2 3 4]}}

    % Instantiation - the ability to return procedure values as results from a procedure call.
    
    % Task 4
    {System.showInfo '\nTask 4'}
    
    % Function takes in three constants
    fun {Quadratic A B C}
        % Returns a function that takes in a value
        fun {Equation X}
            % Returns the result of the quadratic equation
            A * {Number.pow X 2} + B * X + C
        end
    in
        Equation
    end

    % Testing the implementation
    {System.show {{Quadratic 3 2 1} 2}}

    % Embedding - the ability to put procedure values in data structures.

    % Task 5
    {System.showInfo '\nTask 5'}
    
    % generates an infinite list of incrementing integers on demand
    fun {LazyNumberGenerator StartValue}
        % Functional nesting with anonymous function
        StartValue | fun {$} 
            % Infinte call where StartValue increases towards infinity
            {LazyNumberGenerator StartValue + 1} 
        end
    end

    % Testing the implementation
    {System.show {LazyNumberGenerator 0}.1}
    {System.show {{LazyNumberGenerator 0}.2}.1}
    {System.show {{{{{{LazyNumberGenerator 0}.2}.2}.2}.2}.2}.1}

    % b)
    /*
    Q: Give a high-level desciption of your solution and point out any limitations you find relevant.
    A: The main function LazyNumberGenerator takes in a start value as parameter and utilizes functional nesting calling an anonamous function
        that returns a new call to LazyNumberGenerator with the start value increased by 1. This is done infinitely.
        The limitation of this solution is that it does not return a list.
        As the implementation test shows, the function requires a functional call to create the simulated infinate list.
        You can not do regular list operations
    */

    % Tail Recursion - the ability to write recursive procedures without using stack space.

    % Task 6
    {System.showInfo '\nTask 6'}

    % a) Implementatn of tail recursive sum function
    local Sum TailRecursive in
        fun {Sum List}
            % Tail recursive function
            fun {TailRecursive List Sum}
                case List of Head|Tail then
                    {TailRecursive Tail Sum + Head}
                [] nil then
                    Sum
                end
            end
            {TailRecursive List 0}
        end

        % Testing the implementation
        {System.show {Sum [1 2 3 4 5]}}
    end

    % b)
    /*
    Q: Is your Sum function from Task 2 tail recursive? If yes, explain why. If not, implement a tail-recursive version and explain which changes you needed to introduce to make it tail recursive.
    A: The Sum function from Task 2 is not tail recursive since the function counts from the head to the tail.
        The tail recursive version of the function is implemented in the code above, and moves from the back of the tail to the front of the list couning the sum along the way
    */

    % c)
    /*
    Q: What is the benefit of tail recursion in Oz?
    A: The benefit of tail recursion in Oz is that it does not use stack space.
    */

    % d)
    /*
    Q: Do all programming languages that allow recursion benefit from tail recursion? Why/why not?
    A: No, not all programming languages that allow recursion benefit from tail recursion.
        Programming languages have different ways of implementing recursion, and the compiler utalizes special optimizations differently in different language.
    */


    {Exit 0}
end
