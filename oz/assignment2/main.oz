functor
import
    Application(exit:Exit)
    System
define
    % importing file containing functions
    \insert 'list.oz'
    \insert 'mdc.oz'
    
    %Task 1
    % a)
    {System.showInfo "-------- Running Task 1 --------"}
    {System.show {Lex "1 2 + 3 *"}}

    %b)
    {System.show {Tokenize ["1" "2" "+" "3" "*"]}}

    %c)
    {System.show {Interpret [number(1) number(2) number(3) operator(type:plus)]}}
    % Testing with chained functions 
    {System.show {Interpret {Tokenize {Lex "1 2 3 +"}}}}

    % d)
    % Testing with print command
    {System.show {Interpret {Tokenize {Lex "1 2 p 3 +"}}}}

    % e)
    {System.show {Interpret {Tokenize {Lex "1 2 3 + d"}}}}
    
    % f)
    {System.show {Interpret {Tokenize {Lex "1 2 3 + i"}}}}
    
    % g)
    {System.show {Interpret {Tokenize {Lex "1 2 3 6 8 + c"}}}}

    % Task 2
    {System.showInfo "\n-------- Running Task 2 --------"}
    {System.show {ExpressionTree [number(2) number(3) operator(type:plus) number(5) operator(type:divide)]}}
    {System.show {ExpressionTree {Tokenize {Lex "3 10 9 * - 7 +"}}}}

end