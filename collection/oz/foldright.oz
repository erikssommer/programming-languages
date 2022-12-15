functor
import
    Application(exit:Exit)
    System
define
    fun {FoldRight List Null Transform Combine}
        case List of nil then Null
        [] Head|Tail then
            {Combine {Transform Head}
            {FoldRight Tail Null Transform Combine}}
        end
    end
    
    fun {P X Y} X * Y end
        fun {A L BO I}
            case L of nil then I
            [] H|T then {BO H {A T BO I}}
        end
    end
    
    {System.show {A [2 3 4 5] P 1}}
    {System.show {FoldRight [2 3 4 5] 1 fun {$ X} X end P}}
end