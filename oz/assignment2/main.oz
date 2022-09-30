functor
import
    Application(exit:Exit)
    System
define
    % importing file containing functions
    \insert 'list.oz'
    \insert 'mdc.oz'
    
    %Task 1
    {System.showInfo "-------- Running Task 1 --------"}

    % a)
    {System.showInfo "\na)"}
    {System.show {Lex "1 2 + 3 *"}}

    %b)
    {System.showInfo "\nb)"}
    {System.show {Tokenize ["1" "2" "+" "3" "*"]}}

    %c)
    {System.showInfo "\nc)"}
    {System.show {Interpret [number(1) number(2) number(3) operator(type:plus)]}}
    % Testing with chained functions 
    {System.show {Interpret {Tokenize {Lex "1 2 3 +"}}}}

    % d)
    % Testing with print command
    {System.showInfo "\nd)"}
    {System.show {Interpret {Tokenize {Lex "1 2 p 3 +"}}}}

    % e)
    {System.showInfo "\ne)"}
    {System.show {Interpret {Tokenize {Lex "1 2 3 + d"}}}}
    
    % f)
    {System.showInfo "\nf)"}
    {System.show {Interpret {Tokenize {Lex "1 2 3 + i"}}}}
    
    % g)
    {System.showInfo "\ng)"}
    {System.show {Interpret {Tokenize {Lex "1 2 3 + c"}}}}

    % Task 2
    {System.showInfo "\n-------- Running Task 2 --------\n"}
    {System.show {ExpressionTree [number(2) number(3) operator(type:plus) number(5) operator(type:divide)]}}
    {System.show {ExpressionTree [number(3) number(10) number(9) operator(type:multiply) operator(type:minus) number(7) operator(type:plus)]}}
    {System.show {ExpressionTree {Tokenize {Lex "3 10 9 * - 7 +"}}}}

end