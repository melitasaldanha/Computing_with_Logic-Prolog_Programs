/*************************************************************************
Name	 : Melita Saldanha
Course	 : CSE 505 - Computing with Logic

Homework : 4
Ques	 : Stable Models / Answer Sets
*************************************************************************/

% Append 2 Lists
append([],L2,L2).
append([X|L1],L2,[X|L3]):-
	append(L1,L2,L3).

% Check if length of lists are equal
equalLength(M1, Temp) :-
	length(M1, L1),
	length(Temp, L2),
	L1 =:= L2.

% length(L, M) - Length of L is M
length([],0).
length([_|Xs],M):-
	length(Xs,N),
	M is N+1.

% Find subsets
subset([],[]).
subset([X|L],[X|S]) :-
    subset(L,S).
subset(L, [_|S]) :-
    subset(L,S).

% Find Permutations
permute([], []).
permute([X|Xs], Ys) :-
	permute(Xs, Zs),
	delete(X, Ys, Zs).

% Delete an element from a list
delete(X, [X|Ys], Ys).
delete(X, [Y|Ys], [Y|Zs]) :-
	delete(X, Ys, Zs).

% Check if literal is a member of the list
member(X, [X|_]).
member(X, [_|Ys]):-
	member(X,Ys).

% Check if Proposition is Negative
isNeg(not(X), X).

% Find Herbrand Base
propositions([], []).
propositions([rule(X, _)|Y], [X|T]) :-
	propositions(Y, T). 

% Ques 1 - Find tp
tp(P, M1, M2):-
	tp_helper(P, M1, M2).
tp_helper([], _ , []).
tp_helper([rule(H, B) | T], M1, M2):-
	findall(H, (permute(B, K), subset(K, M1)) , Res),
	append(Res, M3, M2),
	tp_helper(T, M1, M3).

% Ques 2 - Find Least Model
leastmodel(P, M) :-
	leastmodel(P, [], M).
leastmodel(P, M1, M2) :-
	copy_term(P, P2),
	tp(P2, M1, Temp),
	(equalLength(M1, Temp) ->
		(M2 = Temp, !);
		(leastmodel(P, Temp, M2))
	).

% Ques 3 - Transformation 
transformation(P, X, Q) :-
	checkNegRight(P, X, Q1),
	propositions(P, HB),
	removeRemNeg(Q1, HB, Q).

% Deleting rules that have negation in the set of atoms
checkNegRight([], _, []) :- !.
checkNegRight([rule(R, L)|Y], X, Q1) :-
	checkNegRight(Y, X, Y1),
	checkMembersForNeg(L, X, Var),
	(
		(Var==true, Q1 = [rule(R, L)|Y1], !); 
		(Var==false, Q1 = Y1)
	).

% Traversing each rule
checkMembersForNeg([], _, true) :- !.
checkMembersForNeg([H|T], X, false) :-
	isNeg(H, V),
	member(V, X), 
	!.
checkMembersForNeg([H|T], X, Var) :-
	checkMembersForNeg(T, X, Var).

% Removing negative atoms from remaining rules
removeRemNeg([], _, []) :- !.
removeRemNeg([rule(R, L)|Y], HB, [rule(R, L1)|Y1]) :-
	checkRight(L, HB, L1),
	removeRemNeg(Y, HB, Y1).

% Traversing each rule
checkRight([], _, []).
checkRight([H|T], HB, Y) :-
	checkRight(T, HB, Y1),
	(
		(isNeg(H, V), member(V, HB), Y = Y1, !);
		Y = [H|Y1]
	).

% Ques 4 - Find if the model is Stable
sm(P, X) :-
	transformation(P, X, Q),
	leastmodel(Q, M),
	sort(X, X1),
	sort(M, M1),
	X1 == M1.

% Ques 5 - Find list of all stable Models
sms(P, L) :-
	propositions(P, HB),
	findall(S, subset(S, HB), Sub),
	traverseSubsets(P, Sub, L).

% Traverse all subsets to check  if it's a stable model
traverseSubsets(_, [], []) :- !.
traverseSubsets(P, [H|T], L) :-
	traverseSubsets(P, T, L1),
	(
		(sm(P, H), L = [H|L1], !);
		L = L1
	).

/*******************************************************************

%%%%%%%%%%%%%%%%%%%%%%%% Ques 1: Find tp %%%%%%%%%%%%%%%%%%%%%%%%%

?- P = [rule(reach(X,Y), [edge(X,Y)]),
rule(reach(X,Y), [edge(X,Z), reach(Z,Y)]),
rule(edge(a,b), []),
rule(edge(b,c), [])],
M1 = [],
tp(P, M1, M2).

P = [rule(reach(_h198,_h216),[edge(_h198,_h216)]),rule(reach(_h198,_h216),[edge(_h198,_h404),reach(_h404,_h216)]),rule(edge(a,b),[]),rule(edge(b,c),[])]
X = _h198
Y = _h216
Z = _h404
M1 = []
M2 = [edge(a,b),edge(b,c)]
yes


?- P = [rule(reach(X,Y), [edge(X,Y)]),
rule(reach(X,Y), [edge(X,Z), reach(Z,Y)]),
rule(edge(a,b), []),
rule(edge(b,c), [])],
M1 = [ edge(a,b), edge(b,c) ],
tp(P, M1, M2).

P = [rule(reach(_h198,_h216),[edge(_h198,_h216)]),rule(reach(_h198,_h216),[edge(_h198,_h404),reach(_h404,_h216)]),rule(edge(a,b),[]),rule(edge(b,c),[])]
X = _h198
Y = _h216
Z = _h404
M1 = [edge(a,b),edge(b,c)]
M2 = [reach(a,b),reach(b,c),edge(a,b),edge(b,c)]
yes


%%%%%%%%%%%%%%%%%%%% Ques 2: Find Least Model %%%%%%%%%%%%%%%%%%%%%%

?- P = [rule(reach(X,Y), [edge(X,Y)]),
rule(reach(X,Y), [edge(X,Z), reach(Z,Y)]),
rule(edge(a,b), []),
rule(edge(b,c), [])],
leastmodel(P, M).

P = [rule(reach(_h198,_h216),[edge(_h198,_h216)]),rule(reach(_h198,_h216),[edge(_h198,_h404),reach(_h404,_h216)]),rule(edge(a,b),[]),rule(edge(b,c),[])]
X = _h198
Y = _h216
Z = _h404
M = [reach(a,b),reach(b,c),reach(a,c),edge(a,b),edge(b,c)]
yes


%%%%%%%%%%%%%% Ques 3: Find Gelfond-Lifschitz transformation %%%%%%%%%%%%%%

?- P = [rule(p, [r,not(s)]),
rule(q, [q]),
rule(r, []),
rule(s, [r])],
X = [],
transformation(P, X, Q).

P = [rule(p,[r,not s]),rule(q,[q]),rule(r,[]),rule(s,[r])]
X = []
Q = [rule(p,[r]),rule(q,[q]),rule(r,[]),rule(s,[r])]
yes


?- P = [rule(p, [r,not(s)]),
rule(q, [q]),
rule(r, []),
rule(s, [r])],
X = [s],
transformation(P, X, Q).

P = [rule(p,[r,not s]),rule(q,[q]),rule(r,[]),rule(s,[r])]
X = [s]
Q = [rule(q,[q]),rule(r,[]),rule(s,[r])]
yes


%%%%%%%%%%%%%%%%%%%%%%% Ques 4: Find if model is stable %%%%%%%%%%%%%%%%%%%%

?- P = [rule(p, [r,not(s)]),
rule(q, [q]),
rule(r, []),
rule(s, [r])],
X = [s],
sm(P, X).

no


?- P = [rule(p, [r,not(s)]),
rule(q, [q]),
rule(r, []),
rule(s, [r])],
X = [r,s],
sm(P, X).

P = [rule(p,[r,not s]),rule(q,[q]),rule(r,[]),rule(s,[r])]
X = [r,s]
yes


%%%%%%%%%%%%%% Ques 5: Find list of all stable Models %%%%%%%%%%%%%%%%%%%

?- P = [rule(p, [r,not(s)]),
rule(q, [q]),
rule(r, []),
rule(s, [r])],
sms(P, L).

P = [rule(p,[r,not s]),rule(q,[q]),rule(r,[]),rule(s,[r])]
L = [[r,s]]
yes

***************************************************************************/