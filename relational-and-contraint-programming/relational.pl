:- use_module(library(clpfd)).

% Defines the facts of our problem, that is, the list of cabins that will be used to test your implementation and the distances between them.
distance(c1, c2, 10, 1). distance(c1, c3, 0, 0). distance(c1, c4, 7, 1).
distance(c1, c5, 5, 1). distance(c2, c3, 4, 1). distance(c2, c4, 12, 1).
distance(c2, c5, 20, 1). distance(c3, c4, 0, 0). distance(c3, c5, 0, 0).
distance(c4, c5, 0, 0). distance(c2, c1, 10, 1). distance(c3, c1, 0, 0).
distance(c4, c1, 7, 1). distance(c5, c1, 5, 1). distance(c3, c2, 4, 1).
distance(c4, c2, 12, 1). distance(c5, c2, 20, 1). distance(c4, c3, 0, 0).
distance(c5, c3, 0, 0). distance(c5, c4, 0, 0).

% Predicate that defines a path between two cabins
plan(Start, End, Path, TotalDist) :-
    path(Start, End, [Start], Q, TotalDist),        % Wrapping the plan predicate around help-predicates
    reverse(Q, Path).

% Additional help-predicates when implementing the plan predicate

% Predicate that defines the path between two cabins
path(Start, End, P, [End|P], TotalDist) :- 
    distance(Start, End, TotalDist, 1).

% Predicate that defines a path between two cabins, with a list of visited cabins
path(Start, End, Visited, Path, TotalDist) :-
    distance(Start, Node, D1, 1),   				% Start and Node are connected        
    Node \== End, 								    % Node is not end
    \+member(Node, Visited),						% Node has not been visited
    path(Node, End, [Node|Visited], Path, D2),  	% Recursive call with Node as Start
	TotalDist is D1 + D2.

% Finds the minimal path between two cabins
bestplan(Start, End, Path, TotalDist) :-
   	setof([Path, TotalDist], plan(Start, End, Path, TotalDist), Set),
   	Set = [_|_],                                    % Ff empty, no solution
   	minimal(Set, [Path, TotalDist]).

% Finding the optimal minimum distance between two cabins
minimal([F|R], M) :- min(R, F, M).

% Predicates for finding the minimal path
min([], M, M).
min([_|R], M, Min) :- min(R, M, Min).
min([[P, L]|R], [_, M], Min) :- L < M, !, min(R, [P, L], Min). 

% Testing the implementation with the given query:
plan(c1, c2, Path, TotalDistance).

% Prints the result:

% Path = [c1, c2],
% TotalDistance = 10
% Path = [c1, c4, c2],
% TotalDistance = 19
% Path = [c1, c5, c2],
% TotalDistance = 25