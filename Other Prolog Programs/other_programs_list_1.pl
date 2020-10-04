% 1. reach(node A, node B) - Check if we can reach node B from node A
edge(1,2).
edge(2,3).
edge(2,4).

reach(X,Y) :- edge(X,Y).
reach(X,Y) :-
	edge(X,Z),
	reach(Z,Y).

% 2. member(X,Y) - X is a member of list Y
member(X, [X|_]).
member(X, [_|Ys]):-
	member(X,Ys).

% 3. append(L1,L2,L3) - L3 = L1+L2
append([],L2,L2).
append([X|L1],L2,[X|L3]):-
	append(L1,L2,L3).

% 4. length(L, M) - length(L) = M
length([],0).
length([_|Xs],M):-
	length(Xs,N),
	M is N+1.

% 5. factorial(N, F) - N! = F
factorial(N, F) :-
	(N>0 ->
		(N1 is N-1,
		factorial(N1, F1),
		F is N*F1);
		F = 1
	).

% 6. quicksort(GivenList, SortedList)
quicksort([], []).
quicksort([X|Xs], Y) :-
	partition(X, Xs, L, R),
	quicksort(L, Y1),
	quicksort(R, Y2),
	append(Y1, [X|Y2], Y).

% partition(Pivot, RemainingList, LeftSublist, RightSublist)
partition(P, [], [], []).
partition(P, [X|Xs], [X|L], R) :-
	(X=<P),
	partition(P, Xs, L, R).
partition(P, [X|Xs], L, [X|R]) :-
	X>P,
	partition(P, Xs, L, R).

/***********************************************
OR - Using cut
% 7. quicksort(GivenList, SortedList)
quicksort([], []).
quicksort([X|Xs], Y) :-
	partition(X, Xs, L, R),
	quicksort(L, Y1),
	quicksort(R, Y2),
	append(Y1, [X|Y2], Y).

% partition(Pivot, RemainingList, LeftSublist, RightSublist)
partition(P, [], [], []).
partition(P, [X|Xs], [X|L], R) :-
	(X=<P),
	!,
	partition(P, Xs, L, R).
partition(P, [X|Xs], L, [X|R]) :-
	partition(P, Xs, L, R).
**********************************************/

% 8. delete(Element, GivenList, ListAfterDeleting)
delete(X, [X|Xs], Xs).
delete(X, [Y|Ys], [Y|L]) :-
	delete(X, Ys, L).

% 9. permute(GivenList, All Permutations)
permute([], []).
permute([X|Xs], Ys) :-
	permute(Xs, Zs),
	delete(X, Ys, Zs).