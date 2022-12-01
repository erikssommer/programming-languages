functor
import
    Application(exit:Exit)
    System
define
    % Recursive length
    fun {LengthRec Xs}
        case Xs of nil then 0
        [] _|Xr then 1 + {LengthRec Xr} end
    end

    % Iterative version
    fun {LengthIter I Ys}
        case Ys of nil then I
        [] _|Yr then {LengthIter I+1 Yr} end
    end

    {System.showInfo {LengthRec 10}}

    {Exit.exit 0}
end