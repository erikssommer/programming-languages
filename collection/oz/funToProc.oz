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
    proc {LengthProc Xs ?Res}
        case Xs of nil then Res = 0
        [] _|Xr then
            local R1 R2 in
                R1 = 1
                {LengthProc Xr R2}
                Res = R1 + R2
            end
        end
    end

    local Res in
        {System.show {LengthFunc [1 2 3]}}
        {LengthProc [1 2 3] Res}
        {System.show Res}
    end

    {Exit 0}
end