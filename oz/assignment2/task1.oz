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
            raise 'Input is not a string' end
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


    {Exit 0}
end
