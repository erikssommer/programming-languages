functor
import
    Application(exit:Exit)
    System
define

    proc {MultiplyByTwo B ?R}
        R = B * 2
    end

    {System.show {MultiplyByTwo 2}}

    {Exit 0}
end