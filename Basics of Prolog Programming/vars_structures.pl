male(albert).
male(bob).
male(bill).
male(carl).
male(charlie).
male(dan).
male(edward).

female(alice).
female(betsy).
female(diana).

parent(albert, bob).
parent(albert, betsy).
parent(albert, bill).

parent(alice, bob).
parent(alice, betsy).
parent(alice, bill).

parent(bob, carl).
parent(bob, charlie).

/******************************
?- parent(X, bob)
X = albert;
X = alice

% AND(,) condition:
?- parent(X, bob), female(X).
X = alice

% Find grandparents of Carl:
?- parent(X, Carl), parent(Y, X).
X = bob, Y = albert;
X = bob, Y = alice

% Find alberts grandchildren:
?- parent(albert, X), parent(X, Y).
X = bob, Y = carl;
X = bob, Y = charlie
******************************/

% Create custom predicate:
get_grandchild :-
	parent(albert, X),
	parent(X, Y),
	write('Grandchild of Albert is '),
	write(Y), nl.

% Get parent - finding X in cms
get_parent(X) :-
	parent(X, carl),
	parent(X, charlie).

grandparent(X, Y) :-
	parent(X, Z),
	parent(Z, Y).

% Can have predicates with same name but accepting different values
what_grade(5) :-
	write('Go to kindergarden').
what_grade(6) :-
	write('Go to Grade 1').
% ****** Format function not working in XSB ******
what_grade(X) :-
	Grade is X-5,
	format("X is ~q",[Grade]).


owns(albert, pet(cat, olive)).
customer(sally, smith, 120.55).

/***********************
customer(sally, _, Bal).
Bal = 120.55
************************/

get_cust_bal(FName, LName) :-
	customer(FName, LName, Bal),
	write(Bal).

% Find if 2 points give a vertical or horizontal line
vertical(line(point(X,Y1), point(X,Y2))).
horizontal(line(point(X1,Y), point(X2,Y))).