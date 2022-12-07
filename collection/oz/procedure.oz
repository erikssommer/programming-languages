functor
import
    Application(exit:Exit)
    System
define

    proc {MultiplyByTwo B ?R}
        R = B * 2
    end

    local R in
        {MultiplyByTwo 2 R}
        {System.show R}
    end 

    {System.show {MultiplyByTwo 4}}

    {Exit 0}
end