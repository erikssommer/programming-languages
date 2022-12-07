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

    % Creating list from to
    fun {ListFromTo From To}
        if From > To then nil
        else
            From|{ListFromTo From+1 To}
        end
    end

    % Creating list of even from to
    fun {EvenFromTo From To}
        if From > To then nil
        elseif From mod 2 == 0 then
            From|{EvenFromTo From+1 To}
        else
            {EvenFromTo From+1 To}
        end
    end

    {System.show {CreateList 5}}
    {System.show {ListFromTo 5 11}}
    {System.show {EvenFromTo 0 11}}

    List = {CreateList 5}

    % Printing first element of list
    {System.show List.1}

    {Exit 0}
end