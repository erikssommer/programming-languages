:- use_module(library(clpfd)).

cabin(nico). 
cabin(kraakli).
cabin(lynhoegen). 
cabin(flaa). 
cabin(morten).

access(fremo). 
access(langlete). 
access(broettem). 
access(lundamo).

trip(fremo,nico,3). 
trip(nico,kraakli,2). 
trip(kraakli,lynhoegen,5). 
trip(nico,lynhoegen,5). 
trip(kraakli,morten,5). 
trip(morten,langlete,4). 
trip(flaa,nico,7). 
trip(lundamo,flaa,2). 
trip(broettem,lynhoegen,4). 
trip(lundamo,kraakli,7).

% and, trips can be walked both ways
trip(X,Y,T) :- trip(Y,X,T).

% use a list as a set representation
% acceptable to use without definition
member(X,[X|_]).
member(X,[_|R]) :- member(X,R).

% nonmembership, and indeed negation as failure
notmember(X, S) :- \+ member(X,S).

% introducing a helper relation with accumulator or visited places
path(From, To) :- path_acc(From, To, _P).

path_acc(From,To,[From,To]) :- trip(From,To,_). 
path_acc(From,To,[From|P]) :- trip(From,Place,_), 
path_acc(Place,To,P), notmember(From, P).

tour(From,To,[From,To],Hours) :- trip(From,To,Hours). 
tour(From,To,[From|P],Hours) :- trip(From,Place,TH), 
tour(Place, To, P, ToH), Hours is TH+ToH.