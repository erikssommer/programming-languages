functor
import
    Application(exit:Exit)
    System
define
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
            else 
                try
                    Token = number({String.toFloat Head})
                catch Exception then
                    raise "Invalid lexeme"
                end
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
        Operations = operators(
            plus: fun {$ X Y} X + Y end
            minus: fun {$ X Y} X - Y end
            multiply: fun {$ X Y} X * Y end
            divide: fun {$ X Y} X / Y end
        )
    
        % Define commands
        Commands = commands(
            print: fun {$ X} {System.show {List.reverse X}} X end
            duplicate: fun {$ X} X.1 | X end
            flip: fun {$ X} case X of number(Head)|Tail then number(~Head) | Tail end end
            inverse: fun {$ X} case X of number(Head)|Tail then number((1.0/Head)) | Tail end end
        )
    
        % Create stack 
        fun {TokensStack Tokens Stack}
            case Tokens of nil then % Check if list of tokens are empty, if yes, result should be at top of stack
                {List.reverse Stack} % Returns the stack in reverse
    
            [] operator(type:Operation) | Tail then % Check first element for operator
                case Stack of number(Num2) | number(Num1) | Rest then % Pull two numbers from top of stack
                    {TokensStack Tail number({Operations.Operation Num1 Num2}) | Rest} % Perform operation defined in Operations add result to stack
                else nil end
    
            [] command(Command) | Tail then % Check first element for command
                {TokensStack Tail {Commands.Command Stack}} % Perform operation defined in Operations add result to stack

            [] number(Num) | Tail then % Check first element for number
                {TokensStack Tail number(Num) | Stack} % Add number to stack
    
            else 
                raise "An error has occurred" end 
            end
        end
    in
        {TokensStack Tokens nil}
    end

    % Testing with chained functions 
    {System.show {Interpret {Tokenize {Lex "1 2 3 +"}}}}

    {Exit 0}
end
