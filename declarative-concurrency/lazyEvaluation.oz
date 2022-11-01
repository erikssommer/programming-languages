% Task 4: Lazy Evaluation
functor
import
    Application(exit:Exit)
    System
define

    % Method for visualizing streams
    proc {ShowStream List}
        case List of _|Tail then
            {System.show List.1}
            thread {ShowStream Tail} end
        else
            skip 
        end
    end

    % a)
    {System.showInfo "Task 4a)"}

    % generates an infinite stream of numbers, starting from 1.
    fun {Enumerate} Generate in
        fun lazy {Generate N}
            N|{Generate N+1}
        end
        {Generate 1}
    end

    /*
    local Res in
        thread Res = {Enumerate} end
        {ShowStream Res}
    end
    */

    {Exit 0}

end