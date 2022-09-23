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

    

    {Exit 0}
end
