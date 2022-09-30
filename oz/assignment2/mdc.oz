% Task 1: mdc
% a)
% Takes a string as input
fun {Lex Input}
    if{IsString Input} then
        % Returns an array of lexemes as output
        {String.tokens Input & }
    else
        raise "Input is not a string" end
    end
end

% b)
fun {Tokenize Lexemes} Token in
    case Lexemes of Head|Tail then
        % Put each lexeme into a record
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
            % Handling exception if lexeme is a number
            try
                Token = number({String.toFloat Head})
            catch Exception then
                {System.show Exception}
            end
        end
            % Recursively call Tokenize on the tail of the lexemes
            Token | {Tokenize Tail}
        else
            nil
    end
end

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
    fun {Flip Stack} case Stack of Head | Tail then ~Head | Tail end end
    fun {Clear Stack} case Stack of Head | Tail then if {Length Stack} == 1 then nil else {Clear Tail} end end end

    % Create stack 
    fun {TokensStack Tokens Stack}
        % Check if list of tokens are empty
        case Tokens of nil then
            % Return result at top of stack
            Stack
        % If the current element is a numeral
        [] number(Number) | Tail then
            % The it is pushed onto the stack.
            {TokensStack Tail Number | Stack}
        
        % If the current element is an arithmetic operator
        [] operator(type:Operation) | Tail then
            % Two values are popped from the stack
            case Stack of Num1 | Num2 | Rest then
                % The appropriate arithmetic operation is applied, and the result is pushed onto the stack.
                if Operation == 'plus' then
                    {TokensStack Tail {Plus Num1 Num2} | Rest}
                elseif Operation == 'minus' then
                    {TokensStack Tail {Minus Num1 Num2} | Rest}
                elseif Operation == 'multiply' then
                    {TokensStack Tail {Multiply Num1 Num2} | Rest}
                elseif Operation == 'divide' then
                    {TokensStack Tail {Devide Num1 Num2} | Rest}
                else nil end
            else raise "Stack is empty" end
        end

        % If element is a command
        [] command(Command) | Tail then
            % Perform operation and add result to stack
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
    % Calling TokensStack with the appropriate arguments
    {TokensStack Tokens nil}
end

% Task 2 - Convert postfix notation into an expression tree
% b)
fun {ExpressionTree Tokens}
    % a)
    % Create stack 
    fun {ExpressionTreeInternal Tokens ExpressionStack}
        % When encounter a non-operator token in the input list
        case Tokens of number(Number) | Tail then
            % Push operator to the expression stack
            {ExpressionTreeInternal Tail Number | ExpressionStack}
        % When encounter an operator token in the input list
        [] operator(type:Operation) | Tail then
            % Remove two expressions from the expression stack and use them as operands
            case ExpressionStack of Number1 | Number2 | Rest then
                % Push new expression to the expression stack
                {ExpressionTreeInternal {Pop Tokens} Operation(Number1 Number2) | Rest}
            else raise "An error has occurred" end 
            end
            
        % When all the input tokens have been processed, return the element at the top of the expression stack
        [] nil then
            ExpressionStack
        
        else
            {System.show Tokens}
            raise "An error has occurred" end
        end
    end
in
    % Calling ExpressionTreeInternal with the appropriate arguments
    {ExpressionTreeInternal Tokens nil}.1
end