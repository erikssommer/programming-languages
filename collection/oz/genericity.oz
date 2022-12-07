functor
import
    Application(exit:Exit)
    System
define

    fun {ApplyFunction A B Function}
        {Function A B}
    end

    fun {Multiply A B}
        A * B
    end

    {System.show {ApplyFunction 2 3 Multiply}}

    {Exit 0}
end
