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

    {Exit 0}
end