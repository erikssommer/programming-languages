functor
import
    Application(exit:Exit)
    System
define
    % importing file containing functions
    \insert 'list.oz'
    \insert 'mdc.oz'
    
    %Task 1 - mdc
    {System.showInfo "-------- Running Task 1 --------"}

    % a) takes a string as input and returns an array of lexemes as output
    {System.showInfo "\na)"}
    {System.show {Lex "1 2 + 3 *"}}

    %b) puts each lexeme into a record
    {System.showInfo "\nb)"}
    {System.show {Tokenize ["1" "2" "+" "3" "*"]}}

    %c) interprets the list of records from b)
    {System.showInfo "\nc)"}
    {System.show {Interpret [number(1) number(2) number(3) operator(type:plus)]}}
    % Testing with chained functions 
    {System.show {Interpret {Tokenize {Lex "1 2 3 +"}}}}

    % d) prints the current content of the stack
    % Testing with print command
    {System.showInfo "\nd)"}
    {System.show {Interpret {Tokenize {Lex "1 2 p 3 +"}}}}

    % e) duplicates the top element on the stack
    {System.showInfo "\ne)"}
    {System.show {Interpret {Tokenize {Lex "1 2 3 + d"}}}}
    
    % f) flips the sign of the number at the top of the stack
    {System.showInfo "\nf)"}
    {System.show {Interpret {Tokenize {Lex "1 2 3 + i"}}}}
    
    % g) clears the stack
    {System.showInfo "\ng)"}
    {System.show {Interpret {Tokenize {Lex "1 2 3 + c"}}}}

    % Task 2 - Convert postfix notation into an expression tree
    {System.showInfo "\n-------- Running Task 2 --------"}
    {System.showInfo "\na) and b)"}
    {System.show {ExpressionTree [number(2) number(3) operator(type:plus) number(5) operator(type:divide)]}}
    {System.show {ExpressionTree [number(3) number(10) number(9) operator(type:multiply) operator(type:minus) number(7) operator(type:plus)]}}
    {System.show {ExpressionTree {Tokenize {Lex "3 10 9 * - 7 +"}}}}
    {System.show {ExpressionTree {Tokenize {Lex "3"}}}}

    {Exit 0}

end