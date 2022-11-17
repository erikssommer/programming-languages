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
plan(Cabin1, Cabin2, Path, TotalDistance) :-
    not(Cabin1 = Cabin2),                               % Rule that the path cannot be from a cabin to itself
    path(Cabin1, Cabin2, [Cabin1], Q, TotalDistance),   % Wrapping the plan predicate around help-predicates
    reverse(Q, Path).

% Additional help-predicates when implementing the plan predicate

% Predicate that defines the path between two cabins
path(Cabin1, Cabin2, P, [Cabin2|P], TotalDistance) :- 
    distance(Cabin1, Cabin2, TotalDistance, 1).

% Predicate that defines a path between two cabins, with a list of visited cabins
path(Cabin1, Cabin2, Visited, Path, TotalDistance) :-
    distance(Cabin1, Node, D1, 1),                      % Cabin1 and Node are connected        
    Node \== Cabin2,                                    % Node is not end
    \+member(Node, Visited),                            % Node has not been visited
    path(Node, Cabin2, [Node|Visited], Path, D2),       % Recursive call with Node as Cabin1
	TotalDistance is D1 + D2.

% Finds the minimal path between two cabins
bestplan(Cabin1, Cabin2, Path, TotalDistance) :-
   	setof([Path, TotalDistance], plan(Cabin1, Cabin2, Path, TotalDistance), Set),
   	Set = [_|_],                                        % If empty, no solution                 
   	minimal(Set, [Path, TotalDistance]).

% Finding the optimal minimum distance between two cabins
minimal([F|R], M) :- min(R, F, M).

% Predicates for finding the minimal path
min([], M, M).
min([_|R], M, Min) :- min(R, M, Min).
min([[P, L]|R], [_, M], Min) :- L < M, !, min(R, [P, L], Min). 

% Testing the implementation with the given query:
% plan(c1, c2, Path, TotalDistance).

% Prints the result:

% Path = [c1, c2],
% TotalDistance = 10
% Path = [c1, c4, c2],
% TotalDistance = 19
% Path = [c1, c5, c2],
% TotalDistance = 25