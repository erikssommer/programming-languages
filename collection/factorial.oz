functor
import
    Application(exit:Exit)
    System
define
    fun {Factorial Number}
        if Number == 0 then 1
        else Number * {Factorial Number-1} end
    end

    {System.showInfo {Factorial 5}}
    {Exit 0}
end