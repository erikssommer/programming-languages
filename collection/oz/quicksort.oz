functor
import
    Application(exit:Exit)
    System
define
    fun {Quicksort List Before}
        case List of Pivot|Rest then
            Below#Above = {Split Rest Pivot Before} in 
                {Append {Quicksort Below Before} Pivot|{Quicksort Above Before}}
            else nil
            end
        end
    end

    fun {Split List Pivot Before}
        case List
        of Head|Tail then
           Below#Above = {Split Tail Pivot Before} in
           if {Before Head Pivot} then (Head|Below)#Above
           else Below#(Head|Above) end
        else nil#nil 
        end 
    end
end