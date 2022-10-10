functor
import
    Application(exit:Exit)
    System
define
    % a)
    fun {Max Number1 Number2}
        if Number1 > Number2 then
            Number1
        else
            Number2
        end
    end

    {System.showInfo {Max 4 8}}

    % b)
    proc {PrintGreater Number1 Number2}
        if Number1 > Number2 then
            {System.showInfo Number1}
        else
            {System.showInfo Number2}
        end
    end

    {PrintGreater 4 1}
    {Exit 0}
end