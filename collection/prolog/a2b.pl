:- use_module(library(clpfd)).

a2b([],[]).
a2b([a|L1],[b|L2]) :- a2b(L1,L2).

% Query: ?- a2b([a,a,a],[b,b,b]).
% true

% Query: ?- a2b([a,a],[b,b,b]).
% false