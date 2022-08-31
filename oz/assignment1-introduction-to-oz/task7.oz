functor
import
    Application(exit:Exit)
    System
define
    L = [0 3 5 3 6 1]
    % a)
    fun {Length List}
        case List of Head|Rest then
            1 + {Length Rest}
        else
            0
        end
    end
    {System.showInfo {Length L}}

    % b)
    fun {Take List Count}
        if Count == 0 then
            nil
        else
            if Count >= {Length List} then
                List
            else
                case List of Head|Rest then
                    Head|{Take Rest Count-1}
                end
            end
        end
    end
    {System.show {Take L 4}}
    {System.show {Take L 8}}
    {Exit 0}
end