parent(albert, bob).
parent(albert, betsy).
parent(albert, bill).

parent(alice, bob).
parent(alice, betsy).
parent(alice, bill).

parent(bob, carl).
parent(bob, charlie).

/*************************
% This will work for parents relation, but not for grandparents
related(X,Y) :-
	parent(X, Y).

?- related(albert, bob).
Yes

?- related(albert,carl).
No 
*************************/

% We require recursion
related(X,Y) :-
	parent(X, Y).
related(X,Y) :-
	parent(X, Z),
	related(Z, Y).