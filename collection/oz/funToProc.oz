functor
import
    Application(exit:Exit)
    System
define
    % Function length
    fun {LengthFunc Xs}
        case Xs of nil then 0
        [] _|Xr then 1 + {LengthFunc Xr} end
    end

    % Procedure length
    proc {LengthProc Xs Result}
        case Xs of nil then 
            {System.show Result}
        [] _|Xr then {LengthProc Xr Result+1} end
    end

    {System.show {LengthFunc [1 2 3]}}
    {LengthProc [1 2 3] 0}

    {Exit 0}
end