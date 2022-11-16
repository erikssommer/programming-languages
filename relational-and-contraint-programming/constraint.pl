:- use_module(library(clpfd)). % Prolog library for Constraint Logic Programming.

% A small prolog predicate that takes a list of coins as input.
% The predicate accepts a payment sum and a list of coin(Count,Value,Limit).


payment(0, []).
payment(Amount, [coin(Count,Value,Limit)|Tail]) :-
    Count in 0..Limit,
    payment(Remaining, Tail),
    Amount #= Count * Value + Remaining.

% Testing the predicate
payment(25, [coin(Ones,1,11),coin(Fives,5,4),coin(Tens,10,3),coin(Twenties,20,2)]).

payment(25, [coin(Ones,1,11),coin(Fives,5,4),coin(Tens,10,3),coin(Twenties,20,2)]), 
label([Ones, Fives, Tens, Twenties]).