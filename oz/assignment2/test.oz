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

fun {Tokenize Lexemes}
    Commands = ["p" "d" "i" "c"]
    Operators = ["+" "-" "*" "/"]
 in
    {Map Lexemes
     fun {$ Lexeme}
        if {Member Lexeme Commands} then
           command({String.toAtom Lexeme})
        elseif {Member Lexeme Operators} then
           operator(type:{String.toAtom Lexeme})
        else
           try number({String.toInt Lexeme})
           catch _ then raise "invalid lexeme ’"#Lexeme#"’" end
           end
        end
    end}
end 

fun {Tokenize Lexemes}
    Commands = ['p' 'd' 'i' 'c']
    Operators = ['+' '-' '*' '/']
 in
    {Map Lexemes
     fun {$ Lexeme}
        {System.show {String.toAtom Lexeme} == '1'}
        if {Member Lexeme Commands} then
            if {{String.toAtom Lexeme} == 'p'} then
                command(print)
            elseif {{String.toAtom Lexeme} == 'd'} then
                command(duplicate)
            elseif {{String.toAtom Lexeme} == 'i'} then
                command(flip)
            elseif {{String.toAtom Lexeme} == 'c'} then
                command(clear)
            else raise "Unknown command" end
            end
        elseif {Member Lexeme Operators} then
            if {{String.toAtom Lexeme} == '+'} then
                operator(type:plus)
            elseif {{String.toAtom Lexeme} == '-'} then
                operator(type:minus)
            elseif {{String.toAtom Lexeme} == '*'} then
                operator(type:multiply)
            elseif {{String.toAtom Lexeme} == '/'} then
                operator(type:devide)
            else raise "Unknown operation" end
            end
        else 
            try
                number({String.toFloat Lexeme})
            catch Exception then
                {System.show '** '#Exception#' **'}
            end
        end
    end}
end 