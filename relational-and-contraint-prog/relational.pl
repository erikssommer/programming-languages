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
plan(Start, Goal, Path, TotalDist) :-
    % Wrapping the plan predicate around help-predicates
    path(Start, Goal, [Start], Q, TotalDist),
    reverse(Q, Path).

% Additional help-predicates when implementing the plan predicate

% Predicate that defines the path between two cabins
path(Start, Goal, P, [Goal|P], TotalDist) :- 
    distance(Start, Goal, TotalDist, 1).

% Predicate that defines a path between two cabins, with a list of visited cabins
path(Start, Goal, Visited, Path, TotalDist) :-
    % Start and Node are connected
    distance(Start, Node, D1, 1),
    % Node is not end        
    Node \== Goal,
    % Node has not been visited
    \+member(Node, Visited),
    % Recursive call with Node as Start
    path(Node, Goal, [Node|Visited], Path, D2),
	TotalDist is D1 + D2.

% Finds the minimal path between two cabins
bestplan(Start, Goal, Path, TotalDist) :-
   	setof([Path, TotalDist], plan(Start, Goal, Path, TotalDist), Set),
    % If empty, no solution
   	Set = [_|_],                  
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