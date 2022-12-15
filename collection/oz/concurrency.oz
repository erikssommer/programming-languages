functor
import
    Application(exit:Exit)
    System
define
    proc {RunLikeCrazy N}
        if N > 0 then
           thread
                {RunLikeCrazy N-1}
                thread {RunLikeCrazy N-2} end
            end
        end
    end
    
    {RunLikeCrazy 2}

    {Exit 0}
end