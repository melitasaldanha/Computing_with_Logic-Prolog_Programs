male(bob).

female(ann).
female(jane).

parent(bob, ann).
parent(jane, ann).

% 1. Check if X is the mother of Y:
mother(X,Y) :-
	parent(X,Y),
	female(X).

/*******************
OR
mother(X,Y) :-
	parent(X,Y),
	\+ male(X).
*******************/

% 2. Check if X is the father of Y
father(X,Y) :-
	parent(X,Y),
	male(X).

% 3. Check if X is the grandparent of Y
grandparent(X,Y):-
	parent(X,Z),
	parent(Z,Y).

% 4. Check if X is the grandmother of Y
grandmother(X,Y):-
	grandparent(X,Y),
	female(X).

/***********************
OR
grandmother(X,Y):-
	mother(Z,Y),
	mother(X,Z).
***********************/

% 5. Check if X is the sibling of Y
sibling(X,Y):-
	parent(Z,X),
	parent(Z,Y),
	X \= Y.

% 6. Check if X is the aunt of Y
aunt(X,Y):-
	parent(Z,Y),
	sibling(X,Z),
	female(X).

% 7. Check if X is the cousin of Y
cousin(X,Y):-
	parent(Z,X),
	parent(W,Y),
	sibling(Z,W).

/************************
OR
cousin(X,Y):-
	grandparent(Z,X),
	grandmother(Z,Y),
	\+ sibling(X,Y).
*************************/

% 8. Check if X is the ancestor of Y
ancestor(X,Y):-
	parent(X,Y).
ancestor(X,Y):-
	parent(X,Z),
	ancestor(Z,Y).

% Can use this instead of initializing person(X) at the start
person(X) :-
	parent(X, _);
	parent(_, X).