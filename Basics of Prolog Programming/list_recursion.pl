/******************************
append(L1,L2,L3), where L3=L1+L2
First Elem (L1) = First ELem (L3) = H
*******************************/
append2([],L2,L2).
append2([H|T], L2, [H|Temp]) :-
	append2(T, L2, Temp).

append2([a,b,c],[d,e,f],L3).

/*****************************
member(X,L) : If X is a member of L
******************************/
%member2(X, [X|T]).
%member2(X, [H|T]) :-
%	member2(X, T).

% Use _ when variable is not going to be used further
member2(X, [X|_]).
member2(X, [_|T]) :-
	member2(X, T). 

/*****************************
X is a list.
allDiff(X) : Checks if all elements of X are different
******************************/
allDiff([]).
allDiff([H|T]) :-
	not member2(H,T),
	allDiff(T).

/********************************

********************************/
%append2([],L,L).
%appendEle(X, [], [X]).
%appendEle(X, [L], [L|X]).

% split(L,L1,L2)
% Append Atom to a List