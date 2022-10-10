functor
import
    Application(exit:Exit)
    System
define
    % importing file containing functions
    \insert 'List.oz'

    L = [2 4 3]

    % a)
    {System.show {Push L 4}}

    % b)
    {System.show {Peek L}}

    % c)
    {System.show {Pop L}}

    {Exit 0}
end