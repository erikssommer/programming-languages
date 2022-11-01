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
    fun lazy {Enumerate} Generate in
        fun lazy {Generate N}
            N|thread {Generate N+1} end
        end
        {Generate 1}
    end

    % for testing infinite stream of numbers
    /*
    local Res in
        thread Res = {Enumerate} end
        {ShowStream Res}
    end
    */

    fun lazy {Primes} GenPrimes in
        fun lazy {GenPrimes N Stream}
            case Stream of nil then nil
            [] X|Xr then Ys in
                % making sure to start at 2
                if X >= N then
                    thread Ys={Filter Xr fun {$ Y} Y mod X \= 0 end} end
                    X|thread {GenPrimes N Ys} end
                else 
                    % moving to a number equal or larger than 2
                    thread {GenPrimes N Xr} end
                end
            end
        end
        % generating the stream of primes starting from 2
        % primes is a consumer of the stream produced by Enumerate
        {GenPrimes 2 {Enumerate}}
    end

    % printing infinite stream of primes
    local Res in
        thread Res = {Primes} end
        {ShowStream Res}
    end

    {Exit 0}

end