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

    % c)
    {System.show {Drop L 2}}
    {System.show {Drop L 6}}

    % d)
    L2 = [8 7 6]
    {System.show {Append L L2}}

    % e)
    {System.show {Member L 5}} % true
    {System.show {Member L 8}} % false

    {Exit 0}
end