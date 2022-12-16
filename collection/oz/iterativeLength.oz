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
    local fun {Length Xs Count}
        case Xs of nil then Count
        [] _|Xr then
            {Length Xr Count+1}
        end
    end
    in
        fun {LengthIter Xs}
            {Length Xs 0}
        end
    end

    {System.show {LengthRec [1 2 3 4 5]}}
    {System.show {LengthIter [1 2 3 4 5]}}

    {Exit 0}
end