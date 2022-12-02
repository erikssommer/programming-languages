functor
import
    Application(exit:Exit)
    System
define

    % Creating list from Number to 0
    fun {CreateList Number}
        if Number < 0 then nil
        else
            Number|{CreateList Number-1}
        end
    end

    fun {ListFromTo From To}
        if From > To then nil
        else
            From|{ListFromTo From+1 To}
        end
    end

    {System.show {CreateList 5}}
    {System.show {ListFromTo 5 11}}

    {Exit 0}
end