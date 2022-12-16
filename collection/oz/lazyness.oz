functor
import
    Application(exit:Exit)
    System
define
    fun lazy {R1 S}
        fun {FnX S R}
            case S of nil then R
            [] X|S2 then {FnX S2 X|R}
            end
        end 
    in
        {FnX S nil}
    end

    {System.show {R1 [1 3 5 8]}}
end