functor
import
    Application(exit:Exit)
    System
define
    % importing file containing functions
    \insert 'List.oz'

    % Declaring list
    L = [0 3 5 3 6 1]

    % a)
    {System.showInfo {Length L}}

    % b)
    {System.show {Take L 4}}
    {System.show {Take L 8}}

    {Exit 0}
end