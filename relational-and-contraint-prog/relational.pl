:- use_module(library(clpfd)).

% Defines the facts of our problem, that is, the list of cabins that will be used to test your implementation and the distances between them.
distance(c1, c2, 10, 1). distance(c1, c3, 0, 0). distance(c1, c4, 7, 1).
distance(c1, c5, 5, 1). distance(c2, c3, 4, 1). distance(c2, c4, 12, 1).
distance(c2, c5, 20, 1). distance(c3, c4, 0, 0). distance(c3, c5, 0, 0).
distance(c4, c5, 0, 0). distance(c2, c1, 10, 1). distance(c3, c1, 0, 0).
distance(c4, c1, 7, 1). distance(c5, c1, 5, 1). distance(c3, c2, 4, 1).
distance(c4, c2, 12, 1). distance(c5, c2, 20, 1). distance(c4, c3, 0, 0).
distance(c5, c3, 0, 0). distance(c5, c4, 0, 0).

% Task 2.1: Create a planner
% Predicate that defines a path between two cabins
plan(Cabin1, Cabin2, Path, TotalDistance) :-
    not(Cabin1 = Cabin2),                                      % Rule that the path cannot be from a cabin to itself
    path(Cabin1, Cabin2, [Cabin1], Queue, TotalDistance),          % Wrapping the plan predicate around help-predicates
    reverse(Queue, Path).

% Additional help-predicates when implementing the plan predicate

% Predicate that defines the path between two cabins
path(Cabin1, Cabin2, Past, [Cabin2|Past], TotalDistance) :- 
    distance(Cabin1, Cabin2, TotalDistance, 1).

% Predicate that defines a path between two cabins, with a list of visited cabins
path(Cabin1, Cabin2, Visited, Path, TotalDistance) :-
    distance(Cabin1, Curr, Distance1, 1),                      % Cabin1 and Curr are connected        
    not(Curr = Cabin2),                                        % Curr is not end
    \+member(Curr, Visited),                                   % Curr has not been visited
    path(Curr, Cabin2, [Curr|Visited], Path, Distance2),       % Recursive call with Curr as Cabin1
	TotalDistance is Distance1 + Distance2.                    % Add the distance between Cabin1 and Curr to the total distance

% Testing the implementation with the given query:
% plan(c1, c2, Path, TotalDistance).

% Prints the result:

% Path = [c1, c2],
% TotalDistance = 10
% Path = [c1, c4, c2],
% TotalDistance = 19
% Path = [c1, c5, c2],
% TotalDistance = 25

% Task 2.2: Create the planner for the shortest path
% Finds the minimal path between two cabins
bestplan(Cabin1, Cabin2, Path, Distance) :-
   	setof([Path, Distance], plan(Cabin1, Cabin2, Path, Distance), Set),
   	Set = [_|_],                                               % If empty, no solution                 
   	minimal(Set, [Path, Distance]).

% Finding the optimal minimum distance between two cabins
minimal([Head|Tail], PathDistance) :- min(Tail, Head, PathDistance).

% Predicates for finding the minimal path
min([], PathDistance, PathDistance).
min([_|Tail], PathDistance, Min) :- min(Tail, PathDistance, Min).
min([[CurrPath, CurrDistance]|Tail], [_, PathDistance], Min) :- 
    CurrPath < PathDistance, % Test
    !, % Blocks backtracking for all branches above it that may have alternatives, increases efficiency 
    min(Tail, [CurrPath, CurrDistance], Min). 

% Testing the implementation with the given query:
% bestplan(c1, c2, Path, Distance).

% Prints the result:
% Distance = 10,
% Path = [c1, c2]