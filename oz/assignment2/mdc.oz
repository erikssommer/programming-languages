functor
import
    Application(exit:Exit)
    System
define
    % importing file containing functions
    % \insert 'list.oz'

    % a)
    fun {Lex Input}
        if{IsString Input} then
            {String.tokens Input & }
        else
            raise "Input is not a string" end
        end
    end

    {System.show {Lex "1 2 + 3 *"}}

    % b)
    fun {Tokenize Lexemes} Token in
        case Lexemes of Head|Tail then
            case Head of "+" then 
                Token = operator(type:plus)
            [] "-" then 
                Token = operator(type:minus)
            [] "*" then 
                Token = operator(type:multiply)
            [] "/" then 
                Token = operator(type:divide)
            [] "p" then
                Token = command(print) % d)
            [] "d" then
                Token = command(duplicate) % e)
            [] "i" then
                Token = command(flip) % f)
            [] "c" then
                Token = command(clear) % g)
            else 
                try
                    Token = number({String.toFloat Head})
                catch Exception then
                    {System.show '** '#Exception#' **'}
                end
            end
                Token | {Tokenize Tail}
            else
                nil
        end
    end 
    
    {System.show {Tokenize ["1" "2" "+" "3" "*"]}}

    % c)
    fun {Interpret Tokens}

        % Define operations
        fun {Plus Num1 Num2} Num1 + Num2 end
        fun {Minus Num1 Num2} Num1 - Num2 end
        fun {Multiply Num1 Num2} Num1 * Num2 end
        fun {Devide Num1 Num2} Num1 / Num2 end

        % Define commands
        fun {Print Stack} {System.show Stack} Stack end
        fun {Duplicate Stack} Stack.1 | Stack end
        fun {Flip Stack} case Stack of number(Head) | Tail then number(~Head) | Tail end end
        fun {Clear List} case List of Head|Rest then if {Length List} == 1 then nil else {Clear Rest} end end end
    
        % Create stack 
        fun {TokensStack Tokens Stack}
            % Check if list of tokens are empty
            case Tokens of nil then
                % Return result at top of stack
                Stack
            % If the current element is a numeral
            [] number(Number) | Tail then
                % The it is pushed onto the stack.
                {TokensStack Tail number(Number) | Stack}
            
            % If the current element is an arithmetic operator
            [] operator(type:Operation) | Tail then
                % Two values are popped from the stack
                case Stack of number(Num1) | number(Num2) | Rest then
                    % The appropriate arithmetic operation is applied, and the result is pushed onto the stack.
                    {TokensStack Tail number({Operations.Operation Num1 Num2}) | Rest}
                else nil end
            % If element is a command
            [] command(Command) | Tail then
                % Perform operation defined in Operations add result to stack
                if Command == 'print' then
                    {TokensStack Tail {Print Stack}}
                elseif Command == 'duplicate' then
                    {TokensStack Tail {Duplicate Stack}}
                elseif Command == 'flip' then
                    {TokensStack Tail {Flip Stack}}
                elseif Command == 'clear' then
                    {TokensStack Tail {Clear Stack}}
                end
            else 
                raise "An error has occurred" end 
            end
        end
    in
        {TokensStack Tokens nil}
    end

    {System.show {Interpret [number(1) number(2) number(3) operator(type:plus)]}}
    % Testing with chained functions 
    {System.show {Interpret {Tokenize {Lex "1 2 3 +"}}}}

    % d)
    % Testing with print command
    {System.show {Interpret {Tokenize {Lex "1 2 p 3 +"}}}}

    % e)
    {System.show {Interpret {Tokenize {Lex "1 2 3 + d"}}}}
    
    % f)
    {System.show {Interpret {Tokenize {Lex "1 2 3 + i"}}}}
    
    % g)
    {System.show {Interpret {Tokenize {Lex "1 2 3 6 8 + c"}}}}

    {Exit 0}
end