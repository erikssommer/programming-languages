functor
import
    Application(exit:Exit)
    System
define
    % importing file containing functions
    \insert 'List.oz'

    L = [2 4 3]
    {System.show {Push L 4}}

    {Exit 0}
end