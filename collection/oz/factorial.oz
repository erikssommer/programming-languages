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

    % Keeps the partial result computed so far, more efficient
    fun {FactorialIter N}
        fun {Iterate Iterator Accumulator}
            if Iterator > N then Accumulator
            else {Iterate Iterator+1 Accumulator*Iterator} end
        end 
    in
        {Iterate 2 1}
    end

    {System.showInfo {FactorialIter 5}}

    {Exit 0}
end