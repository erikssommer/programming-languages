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
        case Lexemes of H|T then
            case H of "+" then 
                Token = operator(type:plus)
            [] "-" then 
                Token = operator(type:minus)
            [] "*" then 
                Token = operator(type:multiply)
            [] "/" then 
                Token = operator(type:divide)
            else 
                try
                    Token = number({String.toFloat H})
                catch Exception then
                    raise "Invalid lexeme"
                end
            end
            end
                Token | {Tokenize T}
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
            clear: fun {$ X} case X of number(Head)|Tail then number((1.0/Head)) | Tail end end
        )

        % Stack
        fun {TokensStack Tokens Stack}
            case Tokens of nil then
                {List.reverse Stack}
            [] operator(type:operation) | T then
                case Stack of number(Num2) | number(Num1) | Rest then
                    {TokensStack T number({Operations.operation Num1 Num2}) | Rest}
                else
                    nil
                end
            [] command(Command) | T then
                {TokensStack T {Commands.Command Stack}}
            [] number(Number) | T then
                {TokensStack T number(Number) | Stack}
            else
                raise "An error has occurred" end
            end
        end
    in
        {TokensStack Tokens nil}
    end

    {System.show {Interpret {Tokenize {Lex "1 2 3 +"}}}}

    {Exit 0}
end
