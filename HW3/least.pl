/*************************************************************************
Name	 : Melita Saldanha
Course	 : CSE 505 - Computing with Logic

Homework : 3
Ques	 : Find the least model for Definite Logic Programs
*************************************************************************/

% Append 2 Lists
append([],L2,L2).
append([X|L1],L2,[X|L3]):-
	append(L1,L2,L3).

% Check if literal is a member of the list
member(X, [X|_]).
member(X, [_|Ys]):-
	member(X,Ys).

% length(L, M) - Length of L is M
length([],0).
length([_|Xs],M):-
	length(Xs,N),
	M is N+1.

% Finds the list L of all propositions in the propositional program P
propositions([], []).
propositions([rule(X, _)|Y], [X|T]) :-
	propositions(Y, T). 

% For the propositional program P, find M2 such that M2 = TP(M1)
tp([], M1, M1).
tp([rule(X, L)|Y], M1, M2) :-
	tp(Y, M1, Temp),
	((checkMembers(L, M1), \+ member(X,Temp)) -> 
		(M2 = [X|Temp], !);
		M2 = Temp
	).

% Check if every literal in the rule is present in the predicate list
checkMembers([], _).
checkMembers([H|T], M1):-
	member(H, M1),
	checkMembers(T, M1).

% For the propositional program P, find the Least Model M
leastmodel(P, M) :-
	leastmodel(P, [], M).

leastmodel(P, M1, M2) :-
	tp(P, M1, Temp),
	(equalLength(M1, Temp) ->
		(M2 = Temp, !);
		leastmodel(P, Temp, M2)
	).

% Check if length of lists are equal
equalLength(M1, Temp) :-
	length(M1, L1),
	length(Temp, L2),
	L1 =:= L2.

/***********************************************************************
OUTPUT:

?- P = [rule(p, [r]), rule(q, [q]), rule(r, [])], propositions(P, L).
P = [rule(p,[r]),rule(q,[q]),rule(r,[])]
L = [p,q,r]
yes

?- P = [rule(p, [r]), rule(q, [q]), rule(r, [])], tp(P, [r], M).
P = [rule(p,[r]),rule(q,[q]),rule(r,[])]
M = [p,r]
yes

?- P = [rule(p, [r]), rule(q, [q]), rule(r, [])], leastmodel(P, M).
P = [rule(p,[r]),rule(q,[q]),rule(r,[])]
M = [p,r]
yes
***********************************************************************/