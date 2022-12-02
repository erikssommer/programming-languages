functor
import
    Application(exit:Exit)
    System
define

    fun {CreateList Number}
        if Number < 0 then nil
        else
            Number|{CreateList Number-1}
        end
    end

    {System.show {CreateList 5}}

    {Exit 0}
end