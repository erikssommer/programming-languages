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

    {System.show {LengthRec [1 2 3 4 5]}}
    {System.show {LengthIter 0 [1 2 3 4 5]}}

    {Exit 0}
end