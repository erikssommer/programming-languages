functor
import
    Application(exit:Exit)
    System
define
    fun {Test A}
        if A > 3 then
            true
        else
            false
        end
    end
    
    {System.show {Test 4}}
    {System.show {Test 1}}

    % Using test to stop counting
    fun {CountUntilTest List}
        case List of nil then
            0
        [] Head|Tail then
            if {Test Head} then
                0
            else
                Head + {CountUntilTest Tail}
            end
        end
    end

    {System.show {CountUntilTest [1 2 3 4 5 6]}}

    {Exit 0}
end